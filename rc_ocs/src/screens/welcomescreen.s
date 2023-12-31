ENTRIES_PTR: dc.l ENTRY_1
ENTRIES:
ENTRY_1:
    dc.l TXT1
    dc.w 9
    dc.w 1
    dc.l ACTION_CAR
    dc.w 0 ; car id
    dc.w 3 ; car bit

ENTRY_2:
    dc.l TXT2
    dc.w 9
    dc.w 3
    dc.l ACTION_CAR
    dc.w 1 ; car id
    dc.w 2 ; car bit

ENTRY_3:
    dc.l TXT3
    dc.w 9
    dc.w 5
    dc.l ACTION_CAR
    dc.w 2 ; car id
    dc.w 1 ; car bit

ENTRY_4:
    dc.l TXT4
    dc.w 9
    dc.w 7
    dc.l ACTION_CAR
    dc.w 3 ; car id
    dc.w 0 ; car bit

ENTRY_5:
    dc.l TXTSOUND_SFX
    dc.w 1
    dc.w 9
    dc.l ACTION_SOUND
    dc.w 0
    dc.w 0

ENTRY_6:
    dc.l TXT_TRACK
    dc.w 1
    dc.w 11
    dc.l ACTION_SELECT_TRACK
    dc.w 0
    dc.w 0

ENTRY_7:
    dc.l TXTSTART
    dc.w 1
    dc.w 13
    dc.l ACTION_START_RACE
    dc.w 0
    dc.w 0

ENTRY_8:
    dc.l TXT_RETURN_TO_OS
    dc.w 1
    dc.w 15
    dc.l ACTION_RETURN_TO_OS
    dc.w 0
    dc.w 0

ENTRY_9:
    dc.l 0
    dc.w 0
    dc.w 0
    dc.l 0
    dc.w 0
    dc.w 0
ENTRY_END:


ENTRY_SIZE EQU 16

INPUTLIST:
    dc.l READJOY1
    dc.l KEYBOARD_WASD
    dc.l KEYBOARD_IJKL
    dc.l KEYBOARD_ARROWS
    dc.l READJOY0
    dc.l READJOY2
    dc.l READJOY3
    dc.l KEYBOARD_NUMPAD
    dc.l OFF
    dc.l 0
INPUTLIST_END:

INPUTLIST_DESCRIPTION:
    dc.l TXT1
    dc.l TXT2
    dc.l TXT3
    dc.l TXT4
    dc.l TXT5
    dc.l TXT6
    dc.l TXT7
    dc.l TXT8
    dc.l TXT_OFF
    dc.l 0

INPUTLIST_ONOFF:
    dc.l 1
    dc.l 1
    dc.l 1
    dc.l 1
    dc.l 1
    dc.l 1
    dc.l 1
    dc.l 1
    dc.l 0
    dc.l 0

KEYBOARD_OPTION_DOWN EQU KEY_ARROW_DOWN
KEYBOARD_OPTION_UP EQU KEY_ARROW_UP
KEYBOARD_OPTION_FIRE EQU KEY_ENTER

;KEYBOARD_OPTION_UP EQU KEY_I
;KEYBOARD_OPTION_DOWN EQU KEY_M
;KEYBOARD_OPTION_FIRE EQU KEY_K

JOY1FIREPRESSED: dc.w 0
KEYBOARDFIREPRESSED: dc.w 0
JOY1DOWNPRESSED: dc.w 0
KEYDOWNPRESSED: dc.w 0
JOY1UPPRESSED: dc.w 0
KEYUPPRESSED: dc.w 0
START_RACE_FLAG: dc.w 0

welcomescreen:
    ; clean bitplanes
    jsr CLEAN_BITPLANES

    ; fire must not be pressed to continue
    btst				#7,$bfe001	; joy fire pressed?
    beq.s               welcomescreen

    ; clear sprites pointers
    move.w #0,Sprite0pointers+2
    move.w #0,Sprite0pointers+6
    move.w #0,Sprite1pointers+2
    move.w #0,Sprite1pointers+6
    move.w #0,Sprite2pointers+2
    move.w #0,Sprite2pointers+6
    move.w #0,Sprite3pointers+2
    move.w #0,Sprite3pointers+6
    move.w #0,Sprite4pointers+2
    move.w #0,Sprite4pointers+6
    move.w #0,Sprite5pointers+2
    move.w #0,Sprite5pointers+6
    move.w #0,Sprite6pointers+2
    move.w #0,Sprite6pointers+6
    move.w #0,Sprite7pointers+2
    move.w #0,Sprite7pointers+6

      
    ; reset a5
    lea                 $dff000,a5

    ;reset race flag in case we are returning here after the race
    move.w              #0,START_RACE_FLAG

    ; Init tiles bitplanes
    move.l              #SCREEN_0,d0
    lea                 BPLPTR1_WELCOME,a1
    bsr.w               POINTINCOPPERLIST_FUNCT

    move.l              #SCREEN_1,d0
    lea                 BPLPTR2_WELCOME,a1
    bsr.w               POINTINCOPPERLIST_FUNCT

    move.l              #SCREEN_00,d0
    lea                 BPLPTR3_WELCOME,a1
    bsr.w               POINTINCOPPERLIST_FUNCT

    move.l              #SCREEN_11,d0
    lea                 BPLPTR4_WELCOME,a1
    bsr.w               POINTINCOPPERLIST_FUNCT

    move.w 	   			#DMASET,d1
    MOVE.W				d1,$96(a5)		; DMACON - enable bitplane, copper, sprites and audio (optional).
    move.w              #$000F,$dff096

    IFD                 COLOR
    tst.w               LOAD_NEXT_TRACK_FLAG
    beq.s               no_load_next_track
    addi.w              #1,TRACK_NUMBER
    move.w              #1,TRACK_OPEN_FILE
    jsr                 LOAD_TRACK
    bsr.w               PRINT_TRACK_NAME
no_load_next_track:
    ENDC

	move.w				COLORS_FONTS_SMALL+2,COPCOLOR_WELCOME_1+2
	move.w				COLORS_FONTS_SMALL+4,COPCOLOR_WELCOME_2+2
	move.w				COLORS_FONTS_SMALL+6,COPCOLOR_WELCOME_3+2
	move.w				COLORS_FONTS_SMALL+8,COPCOLOR_WELCOME_4+2
	move.w				COLORS_FONTS_SMALL+10,COPCOLOR_WELCOME_5+2
	move.w				COLORS_FONTS_SMALL+12,COPCOLOR_WELCOME_6+2
	move.w				COLORS_FONTS_SMALL+14,COPCOLOR_WELCOME_7+2

	; copperlist setup
	move.l				#COPPERLIST_WELCOME,$80(a5)	; Copperlist point
	move.w				d0,$88(a5)			; Copperlist start
	move.w				#0,$1fc(a5)			; AGA disable
	move.w				#$c00,$106(a5)		; AGA disable
	move.w				#$11,$10c(a5)		; AGA disable

	move.w 				#$C008,$dff09a ; intena, enable interrupt lvl 2

    lea                 CAR1_TXT,a1
    moveq               #1,d0
    moveq               #1,d1
    bsr.w               printstring

    lea                 CAR2_TXT,a1
    moveq               #1,d0
    moveq               #3,d1
    bsr.w               printstring

    lea                 CAR3_TXT,a1
    moveq               #1,d0
    moveq               #5,d1
    bsr.w               printstring

    lea                 CAR4_TXT,a1
    moveq               #1,d0
    moveq               #7,d1
    bsr.w               printstring

    move.b              #$40,CURSOR+1
    move.l              #CURSOR,d0
    lea       		    Sprite0Welcomepointers,a1
    jsr       		    POINTINCOPPERLIST_FUNCT

mousewelcome:
    cmpi.b  			#$ff,$dff006    ; Linea 255?
    bne.s   			mousewelcome

    lea                 ENTRIES(PC),a4
starentries:
    move.l              (a4),a1
    move.l              a1,d0
    tst.l               d0
    beq.s               endentries
    moveq               #0,d0
    moveq               #0,d1
    move.w              4(a4),d0
    move.w              6(a4),d1
    bsr.w               printstring
    adda.l              #ENTRY_SIZE,a4
    bra.s               starentries
endentries:

    jsr                 READJOY1_WELCOME

    ;manage keyboard down with numpad 2
    tst.b	            KEYBOARD_OPTION_DOWN
    beq.s               endtestkeydown
    tst.w               KEYDOWNPRESSED
    bne.s               endtestkeydown
    move.l              ENTRIES_PTR,a0
    adda.l              #ENTRY_SIZE,a0
    tst.l               (a0)
    bne.s               keydownpressed_no_reset
    lea                 ENTRY_END-ENTRY_SIZE-ENTRY_SIZE,a0
keydownpressed_no_reset:
    move.l              a0,ENTRIES_PTR
    move.w              #1,KEYDOWNPRESSED
 endtestkeydown:
    tst.b	            KEYBOARD_OPTION_DOWN
    bne.s               keydownpressed_no_release
    move.w              #0,KEYDOWNPRESSED
keydownpressed_no_release:

testjoydown:
    btst	            #3,d0
    beq.s               welcome_no_down
    tst.w               JOY1DOWNPRESSED
    bne.s               welcome_no_down
manageoptiondown:
    move.l              ENTRIES_PTR,a0
    adda.l              #ENTRY_SIZE,a0
    tst.l               (a0)
    bne.s               joy1downpressed_no_reset
    lea                 ENTRY_END-ENTRY_SIZE-ENTRY_SIZE,a0
joy1downpressed_no_reset
    move.l              a0,ENTRIES_PTR
    move.w              #1,JOY1DOWNPRESSED
welcome_no_down:

    btst	            #3,d0
    bne.s               joy1downpressed_no_release
    move.w              #0,JOY1DOWNPRESSED
joy1downpressed_no_release:

    ;manage keyboard up with numpad 8
    tst.b	            KEYBOARD_OPTION_UP
    beq.s               endtestkeyup
    tst.w               KEYUPPRESSED
    bne.s               endtestkeyup
    move.l              ENTRIES_PTR,a0
    suba.l              #ENTRY_SIZE,a0
    cmp.l               #ENTRIES,a0
    bhi.s               keyuppressed_no_reset
    lea                 ENTRIES,a0
keyuppressed_no_reset:
    move.l              a0,ENTRIES_PTR
    move.w              #1,KEYUPPRESSED
endtestkeyup:
    tst.b	            KEYBOARD_OPTION_UP
    bne.s               keyuppressed_no_release
    move.w              #0,KEYUPPRESSED
keyuppressed_no_release:

    ;manage joy up
    btst	            #2,d0
    beq.s               welcome_no_up
    tst.w               JOY1UPPRESSED
    bne.s               welcome_no_up
    move.l              ENTRIES_PTR,a0
    suba.l              #ENTRY_SIZE,a0
    cmp.l               #ENTRIES,a0
    bhi.s               joy1uppressed_no_reset
    lea                 ENTRIES,a0
joy1uppressed_no_reset:
    move.l              a0,ENTRIES_PTR
    move.w              #1,JOY1UPPRESSED
welcome_no_up:

    btst	            #2,d0
    bne.s               joy1uppressed_no_release
    move.w              #0,JOY1UPPRESSED
joy1uppressed_no_release:

    ; move sprite
    ; get Y position of the entry
    move.b              #0,3+CURSOR
    move.l              ENTRIES_PTR,a0
    move.w              6(a0),d1
    muls                #16,d1
    add.w               #$2b,d1
    ;BVC.s               nounder255start
    btst                #8,d1
    beq.s               nounder255start
    bset.b              #2,3+CURSOR
    bset.b              #1,3+CURSOR
nounder255start:
    move.b              d1,CURSOR
    add.w               #16,d1
    move.b              d1,CURSOR+2

    btst                #8,d1
    beq.s               cursor_y_vstopset
    bset.b              #1,3+CURSOR
    bra.s               cursor_y_end
cursor_y_vstopset:
    bclr.b              #1,3+CURSOR
cursor_y_end:

    ;keyboard fire pressed ?
    tst.b	            KEYBOARD_OPTION_FIRE
    beq.s               nokeyboardaction
    tst.w               KEYBOARDFIREPRESSED
    bne.s               nokeyboardaction
    move.l              ENTRIES_PTR,a0
    move.l              8(a0),a1
    jsr                 (a1)
    move.w              #1,KEYBOARDFIREPRESSED
nokeyboardaction:
    tst.b	            KEYBOARD_OPTION_FIRE
    bne.s               keyboardaction_noreset
    move.w              #0,KEYBOARDFIREPRESSED
keyboardaction_noreset:

    btst				#7,$bfe001	; joy fire pressed?
	bne.w				noaction
    tst.w               JOY1FIREPRESSED
    bne.s               noaction
    move.w              #1,JOY1FIREPRESSED
    move.l              ENTRIES_PTR,a0
    move.l              8(a0),a1
    jsr                 (a1)
noaction:
    btst				#7,$bfe001	; joy fire pressed?
	beq.w				joy1firenotpressed
    move.w              #0,JOY1FIREPRESSED
joy1firenotpressed:

waitwelcome:
    cmpi.b  			#$ff,$dff006    ; linea 255?
    beq.s   			waitwelcome

    tst.w               START_RACE_FLAG
    bne.s               welcomescreen_end

    btst				#6,$bfe001	; mouse premuto?
	bne.w				mousewelcome

welcomescreen_end:
    rts

CAR1_TXT:
    dc.b                "CAR 1",255
    even

CAR2_TXT:
    dc.b                "CAR 2",255
    even

CAR3_TXT:
    dc.b                "CAR 3",255
    even

CAR4_TXT:
    dc.b                "CAR 4",255
    even

TXT1:
    dc.b                "JOY PORT 1",255
    even

TXT2:
    dc.b                "KEY WASD  ",255
    even

TXT3:
    dc.b                "KEY IJKL  ",255
    even

TXT4:
    dc.b                "KEY ARROWS",255
    even

TXT5:
    dc.b                "JOY PORT 0",255
    even

TXT6:
    dc.b                "JOY PORT 2",255
    even

TXT7:
    dc.b                "JOY PORT 3",255
    even

TXT8:
    dc.b                "KEY NUMPAD",255
    even

TXT_OFF:
    dc.b                "OFF       ",255
    even

TXTSOUND_SFX:
    dc.b                "SOUND   SFX",255
    even

TXTSOUND_OFF:
    dc.b                "SOUND   OFF",255
    even

TXTSTART:
    dc.b                "START",255
    even

TXT_RETURN_TO_OS:
    dc.b                "EXIT TO OS",255
    even

TXT_TRACK:
    dc.b                "NEXT               ",255
    even

printstring:
    moveq               #0,d6
    move.b              (a1)+,d6
    cmp.w               #$FF,d6
    beq.s               printstringend
    sub.w               #32,d6
    muls.w              #2*16*3,d6

    lea                 BIGFONTS,a0
    adda.l              d6,a0
    bsr.s               printbigfont
    addq                #1,d0
    bra.s               printstring

printstringend:
    rts

printbigfont:
    movem.l             a0/a1/a2/a3/d0/d1,-(sp)
    lea                 SCREEN_0,a1
    lea                 SCREEN_1,a2
    lea                 SCREEN_00,a3

    lsl.w               #1,d0
    adda.w              d0,a1
    adda.w              d0,a2
    adda.w              d0,a3

    mulu.w              #40*16,d1
    adda.w              d1,a1
    adda.w              d1,a2
    adda.w              d1,a3


    moveq               #16-1,d7
bigfontcycle:
    move.b              (a0),(a1)
    move.b              1(a0),1(a1)

    move.b              2*16*1(a0),(a2)
    move.b              1+2*16*1(a0),1(a2)

    move.b              2*16*2(a0),(a3)
    move.b              1+2*16*2(a0),1(a3)

    addq                #2,a0
    adda.l              #40,a1
    adda.l              #40,a2
    adda.l              #40,a3

    dbra                d7,bigfontcycle
    movem.l             (sp)+,a0/a1/a2/a3/d0/d1
    rts

ACTION_START_RACE:
    move.w              #1,START_RACE_FLAG
    clr.w               LOAD_NEXT_TRACK_FLAG

    ; Cars init
    jsr 	SET_CAR1_START_STATUS
    jsr 	SET_CAR2_START_STATUS
    jsr 	SET_CAR3_START_STATUS
    jsr 	SET_CAR4_START_STATUS

    ; wait until fire is released
waitstartrace:
    btst				#7,$bfe001	; joy fire pressed?
    beq.s               waitstartrace
    rts

ACTION_SOUND:
    tst.w               PLAY_SOUND
    beq.s               turn_sound_on
    move.l              #TXTSOUND_OFF,(a0)
    move.w              #0,PLAY_SOUND
    rts
turn_sound_on:
    move.w              #1,PLAY_SOUND
    move.l              #TXTSOUND_SFX,(a0)
    rts

; Handle controller rotation for a car
ACTION_CAR:

    move.l              a5,-(sp)

    ;first get the get param id, should be 0 for fist car, 1 for the second and so on
    move.w              12(a0),d0

    ; the the mover offset
    muls.w              #MOVER_SIZE,d0
    lea                 MOVERS,a1
    add.l               d0,a1

    ; now get the routine input address
    move.l              INPUT_ROUTINE_OFFSET(a1),a2

    ;search in lookup table
    lea                 INPUTLIST(PC),a3
    lea                 INPUTLIST_DESCRIPTION(PC),a6
    lea                 INPUTLIST_ONOFF(PC),a5
inputloop:
    move.l              (a3),a4
    cmpa.l              a2,a4
    bne.s               nextinputroutine

    tst.l               4(a6)
    bne.s               notendofinputlist
    move.l              INPUTLIST_DESCRIPTION,(a0)
    move.l              INPUTLIST,INPUT_ROUTINE_OFFSET(a1)

    bsr.w               disable_enable_car_first
    move.l              (sp)+,a5
    rts
notendofinputlist:
    move.l              4(a6),(a0)
    move.l              4(a3),INPUT_ROUTINE_OFFSET(a1)
    bsr.w               disable_enable_car
    move.l              (sp)+,a5
    rts

    move.l              (sp)+,a5
    rts
nextinputroutine:

    addq                #4,a3
    addq                #4,a6
    addq                #4,a5
    bra.s               inputloop

    move.l              (sp)+,a5
    rts

disable_enable_car_first:
    move.l              d6,-(sp)
    moveq               #0,d6
    move.w              14(a0),d6
    lea                 INPUTLIST_ONOFF,a5
    tst.l               (a5)
    beq.s               disablecar_first
    bset                d6,CARS_IN_PLAY+1
    move.l              (sp)+,d6
    rts
disablecar_first:
    bclr                d6,CARS_IN_PLAY+1
    move.l              (sp)+,d6
    rts

disable_enable_car:
    move.l              d6,-(sp)
    moveq               #0,d6
    move.w              14(a0),d6
    tst.l               4(a5)
    beq.s               disablecar

    bset                d6,CARS_IN_PLAY+1
    move.l              (sp)+,d6

    rts

disablecar:
    bclr                d6,CARS_IN_PLAY+1
    move.l              (sp)+,d6
    rts

ACTION_RETURN_TO_OS:
    move.w              #1,EXIT_TO_OS_FLAG
    move.w              #1,START_RACE_FLAG
    rts

OFF:
    rts

ACTION_SELECT_TRACK:
    IFD COLOR
    move.w #1,SET_TRACK_SELECT_BITPLANE
    jsr SCREEN_TRACK_SELECT
    move.l				#COPPERLIST_WELCOME,$dff080	; Copperlist point
	move.w				d0,$dff088			; Copperlist start
    ENDC
    rts

CLEAN_BITPLANES:
    move.w #(40*256/4)-1,d7
    lea SCREEN_0,a0
    lea SCREEN_1,a1
    lea SCREEN_00,a2
    lea SCREEN_11,a3
cleanitplanesloop:
    clr.l (a0)+
    clr.l (a1)+
    clr.l (a2)+
    clr.l (a3)+
    dbra d7,cleanitplanesloop
    rts

    IFD                 COLOR
;PRINT_TRACK_NAME2:
;    moveq               #20-1,d7
;    lea                 TRACK_FILENAME+7,a0
;    lea                 TXT_TRACK+6,a1
;startprinttrackloop2:
;    cmp.b               #46,(a0)
;    beq.s               endprinttrack
;    move.b              (a0)+,(a1)+
;    bra.s               startprinttrackloop
;endprinttrack2:
;    move.b              #255,(a1)
;    rts



PRINT_TRACK_NAME:
    moveq               #20-7-1,d7
    moveq               #0,d6
    lea                 TRACK_FILENAME+7,a0
    lea                 TXT_TRACK+6,a1
startprinttrackloop:

    tst.b               (a0)
    bne.s               noprintendtrackloop2
    moveq               #1,d6
noprintendtrackloop2:

    cmp.b               #46,(a0)
    bne.s               noprintendtrackloop
    moveq               #1,d6
noprintendtrackloop:

    tst.w               d6
    beq.s               printtrackcopychar
    move.b              #32,(a1)+
    bra.s               printtracknextiteration
printtrackcopychar:
    move.b              (a0)+,(a1)+
printtracknextiteration:
    dbra                d7,startprinttrackloop
    move.b              #255,(a1)
    rts
    ENDC