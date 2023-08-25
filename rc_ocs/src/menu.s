MENU_SET_CALLBACK_BEFORE_LOOP MACRO
    move.l \1,MENU_CALLBACK_BEFORE_LOOP_FUNCT
    ENDM
ENABLE_LOADING_SCREEN MACRO
    move.w #1,LOADING_SCREEN_FLAG
    ENDM
CLEAR_PROGRESS_BAR MACRO
    clr.w               LOADINGBARPROGRESS
    clr.w               SHR_PREV_PROG
    lea                 LOADING_SCREEN_BPL_0+200*40,a0
    moveq               #320/4-1,d7
.clearprogress\@:
    clr.l               (a0)+
    dbra                d7,.clearprogress\@
    ENDM
CLEAR_PROGRESS_BAR_F
    movem.l d0/d7-a0/a6,-(sp)
    CLEAR_PROGRESS_BAR
    movem.l (sp)+,d0/d7-a0/a6
    rts
FADE_SPEED                  EQU     3 ; how many frames do I wait before changing color?
CURSOR_CLEARING             EQU     5 ; how many pixel between the cursor and the text?
CURSOR_CLEARING_STR         EQU     1 ;

; Struct describing an entry
                            rsset   0
menu_EntryX                 rs.w    1
menu_EntryY                 rs.w    1
menu_DescPtr                rs.l    1
menu_FunctPtr               rs.l    1
menu_FunctArgsPtr           rs.l    1
menu_FontWidthPx            rs.w    1
menu_FontHeightPx           rs.w    1
menu_SIZEOF                 rs.b    0

; Struct describing a text
                            rsset   0
txt_EntryX                  rs.w    1
txt_EntryY                  rs.w    1
txt_DescPtr                 rs.l    1
txt_FontWidthPx             rs.w    1
txt_FontHeightPx            rs.w    1
txt_SIZEOF                  rs.b    0

CURSORSTR:                  dc.b    '>',$FF
MENUSCREEN_OLD_SELECTED_ENTRY:
                            dc.l    0

MENUSCREEN_IMAGE:           dc.l    0
MENUSCREEN_IMAGE_SIZE:      dc.l    0
MENUSCREEN_ENTRIES:         dc.l    0
TXTSCREEN_ENTRIES:          dc.l    0

MENUSCREEN_SELECTED_ENTRY:  dc.l    0

MAIN_JOY1_UP_PRESSED:       dc.b    0
MAIN_JOY1_DOWN_PRESSED:     dc.b    0
MAIN_JOY1_FIRE_1_PRESSED:   dc.b    0
MAIN_JOY1_FIRE_2_PRESSED:   dc.b    0

MAIN_WASD_UP_PRESSED:       dc.b    0
MAIN_WASD_DOWN_PRESSED:     dc.b    0
MAIN_WASD_FIRE_1_PRESSED:   dc.b    0
MAIN_WASD_FIRE_2_PRESSED:   dc.b    0

MAIN_ARROWS_UP_PRESSED:     dc.b    0
MAIN_ARROWS_DOWN_PRESSED:   dc.b    0
MAIN_ARROWS_FIRE_1_PRESSED: dc.b    0
MAIN_ARROWS_FIRE_2_PRESSED: dc.b    0

MAIN_IJKL_UP_PRESSED:       dc.b    0
MAIN_IJKL_DOWN_PRESSED:     dc.b    0
MAIN_IJKL_FIRE_1_PRESSED:   dc.b    0
MAIN_IJKL_FIRE_2_PRESSED:   dc.b    0


MAIN_EXIT:                  dc.w    0

FADE_SPEED_COUNTER:         dc.w    FADE_SPEED

MENU_CALLBACK_BEFORE_LOOP_FUNCT:
                            dc.l    0

MENU_INPUT_FUNCT_LIST:
    dc.l READJOY1_WELCOME
    dc.l KEYBOARD_WASD_WELCOME
    dc.l KEYBOARD_ARROWS
    dc.l KEYBOARD_IJKL
    dc.l 0

MENUSCREEN:
    movem.l             a0-a6/d0-d7,-(sp)

    clr.l               MENUSCREEN_OLD_SELECTED_ENTRY

    ; Init tiles bitplanes
    move.l              #PHAZELOGO,d0
    lea                 BPLPTR1_MAIN,a1
    bsr.w               POINTINCOPPERLIST_FUNCT

    move.l              #PHAZELOGO+10240,d0
    lea                 BPLPTR2_MAIN,a1
    bsr.w               POINTINCOPPERLIST_FUNCT

    move.l              #PHAZELOGO+20480,d0
    lea                 BPLPTR3_MAIN,a1
    bsr.w               POINTINCOPPERLIST_FUNCT

    move.l              #PHAZELOGO+30720,d0
    lea                 BPLPTR4_MAIN,a1
    bsr.w               POINTINCOPPERLIST_FUNCT

    move.l              #PHAZELOGO+40960,d0
    lea                 BPLPTR5_MAIN,a1
    bsr.w               POINTINCOPPERLIST_FUNCT

    move.w 	   			#DMASET,d1
    lea                 $dff000,a5
    MOVE.W				d1,$96(a5)		; DMACON - enable bitplane, copper, sprites and audio (optional).

    ; copperlist setup
    ;move.l				#COPPERLIST_MAIN,$80(a5)	; Copperlist point
    ;move.w				d0,$88(a5)			; Copperlist start
    ;move.w				#0,$1fc(a5)			; AGA disable
    ;move.w				#$c00,$106(a5)		; AGA disable
    ;move.w				#$11,$10c(a5)		; AGA disable

    move.l              execBase,a6

	MOVE.L	            #$7FFF7FFF,$9A(A5)	; INTERRUPTS & INTREQS DISABLE

    tst.l               MENUSCREEN_IMAGE_SIZE
    beq.w               .menu_nofile

	bsr.w               PreparaLoad
    moveq	            #50,d1		; wait 50 frames
	bsr.w	            AspettaBlanks

    moveq               #10,d0
    bsr.w               PRINTLOADINGBAR

    move.l              dosBase,a6
    move.l              #MODE_OLDFILE,d2
    move.l	            MENUSCREEN_IMAGE,d1
    jsr                 _LVOOpen(a6)
    move.l	            d0,fd

    ; first bitplane
    move.l              fd,d1
    move.l              #SCREEN_0,d2
    move.l              MENUSCREEN_IMAGE_SIZE,d3
    jsr                 _LVORead(a6)

    ; close the file
	move.l	            fd,d1				; result = LVOClose(handle[d1])
    jsr                 _LVOClose(a6)

    moveq               #20,d0
    bsr.w               PRINTLOADINGBAR

    move.l	            #150,d1 ; wait 150 frames
	bsr.w	            AspettaBlanks

    bsr.w               DopoLoad
    move.w 				#$C008,$dff09a ; intena, enable interrupt lvl 2

    ; decompress stage start
    moveq               #0,d0
    lea                 SCREEN_0,a0
    lea                 PHAZELOGO,a1
    move.l              #SHR_PROGRESS,a2
    move.l              #0,a3
    moveq               #0,d2
    moveq               #1,d7
    jsr                 ShrinklerDecompress

    moveq               #90,d0
    bsr.w               PRINTLOADINGBAR

    ; set car cursor colors
    ;move.w              #$d73,MAIN_PALETTE_16
    ;move.w              #$333,MAIN_PALETTE_17
    ;move.w              #$921,MAIN_PALETTE_18
    ;move.w              #$ccc,MAIN_PALETTE_19

.menu_nofile:
    tst.l               MENUSCREEN_IMAGE_SIZE
    bne.s               .menu_noclear
    BZERO4              PHAZELOGO,40*256*5/4
.menu_noclear:

    MEMCPY4				MAIN_PALETTE,MAIN_PALETTE2,64/4
    moveq               #99,d0
    bsr.w               PRINTLOADINGBAR

    ; set font color into the colors table - START
    moveq               #7-1,d7
    lea                 COLORS_FONTS_SMALL+2,a0
    lea                 MAIN_PALETTE_25,a1
    lea                 MAIN_PALETTE2_25,a2
mainfontcolorloop:
    move.w (a0),(a2)+
    move.w (a0)+,(a1)+
    dbra d7,mainfontcolorloop
    ; set font color into the colors table - END

    ; save image for rewriting/refreshing
    lea                 PHAZELOGO+40*256*0,a0
    lea                 PHAZELOGO+40*256*1,a1
    lea                 PHAZELOGO+40*256*2,a2

    lea                 SCREEN_0,a3
    lea                 SCREEN_1,a4
    lea                 SCREEN_00,a5
    move.w              #40*256/4-1,d7
.savemenuimageloopstart
    move.l              (a0)+,(a3)+
    move.l              (a1)+,(a4)+
    move.l              (a2)+,(a5)+
    dbra                d7,.savemenuimageloopstart

    lea                 PHAZELOGO+40*256*3,a0
    lea                 SCREEN_11,a1
    move.w              #40*256/4-1,d7
.savemenuimageloopstart2
    move.l              (a0)+,(a1)+
    dbra                d7,.savemenuimageloopstart2

    ; draw txt - START
    move.l              TXTSCREEN_ENTRIES(PC),a6
menutxtloop:
    tst.l                txt_DescPtr(a6)
    beq.s                menutxtloopend
    move.w               txt_EntryX(a6),d0
    move.w               txt_EntryY(a6),d1
    move.l               txt_DescPtr(a6),a1

    ; check if small fonts here
    cmp.w                #8,txt_FontWidthPx(a6)
    bne.s                printbigfonts
    bsr.w                printstringhigh_small
    bra.s                next_txt_entry_please
printbigfonts:
    bsr.w                printstringhigh
next_txt_entry_please:
    adda.l               #txt_SIZEOF,a6
    bra.s                menutxtloop
menutxtloopend:
    ; draw txt - END

    move.l               MENUSCREEN_ENTRIES(PC),a6
menuloop:
    tst.l                menu_DescPtr(a6)
    beq.s                setcursormain

    ; set the cursor if entry is selcted
    ;cmp.l                MENU_MAIN_CURRENTLY_SELECTED,a6
    ;bne.s                entry_not_currently_selected

    ;bsr.w                set_cursor_sprite_position
;entry_not_currently_selected:
    move.w               menu_EntryX(a6),d0
    move.w               menu_EntryY(a6),d1
    move.l               menu_DescPtr(a6),a1
    cmp.w                #8,menu_FontWidthPx(a6)
    bne.s                printbigfonts_entry
    bsr.w                printstringhigh_small
    bra.s                next_entry_please
printbigfonts_entry:
    bsr.w                printstringhigh
next_entry_please:

    adda.l               #menu_SIZEOF,a6
    bra.s                menuloop

setcursormain:
    ;move.l               #CURSOR,d0
    ;lea       		     Sprite0Mainpointers,a1
    ;jsr       		     POINTINCOPPERLIST_FUNCT

; execute callback before loop
    tst.l               MENU_CALLBACK_BEFORE_LOOP_FUNCT
    beq.s               .menu_no_callback_before_loop
    move.l              MENU_CALLBACK_BEFORE_LOOP_FUNCT(PC),A0
    jsr                 (a0)
.menu_no_callback_before_loop

    ; copperlist setup
    move.l				#COPPERLIST_MAIN,$dff080	; Copperlist point
    move.w				d0,$dff088			; Copperlist start
    move.w				#0,$dff1fc			; AGA disable
    move.w				#$c00,$dff106		; AGA disable
    move.w				#$11,$dff10c		; AGA disable

mousemain:
    cmpi.b  			#$ff,$dff006    ; Linea 255?
    bne.s   			mousemain

waitmain:
    cmpi.b  			#$ff,$dff006    ; linea 255?
    beq.s   			waitmain

    subi.w              #1,FADE_SPEED_COUNTER
    bne.s               nomainfadein
    bsr.w               MAIN_FadeIn2
    bsr.w               MAIN_FadeIn
    move.w              #FADE_SPEED,FADE_SPEED_COUNTER
nomainfadein:

    lea                 MENU_INPUT_FUNCT_LIST(PC),a3
    lea                 MAIN_JOY1_UP_PRESSED-1,a6
menu_input_list_loop_start:
    tst.l               (a3)
    beq.s               menu_input_list_loop_end

    move.l              (a3),a4
    jsr                 (a4)

    ; check if up has been pressed
    moveq               #2,d1
    addq                #1,a6
    move.l              #move_cursor_down,a1
    bsr.w               input_cmd_key_release

    ; check if down has been pressed
    moveq               #3,d1
    addq                #1,a6
    move.l              #move_cursor_up,a1
    bsr.w               input_cmd_key_release

    ; check if fire has been pressed
    moveq               #4,d1
    addq                #1,a6
    move.l              MENUSCREEN_SELECTED_ENTRY,a1
    move.l              menu_FunctPtr(a1),a1
    bsr.w               input_cmd_key_release

    ;move.l              a6,-(sp)
    ;move.l              MENUSCREEN_SELECTED_ENTRY(PC),a6
    ;bsr.w               set_cursor_sprite_position
    ;move.l              (sp)+,a6

    bsr.w               set_cursor_string_position

    addq                #4,a3
    addq                #1,a6
    bra.s               menu_input_list_loop_start

menu_input_list_loop_end:

    tst.w               MAIN_EXIT
    beq.w               mousemain
    clr.w               MAIN_EXIT

    move.w              #FADE_SPEED,FADE_SPEED_COUNTER

mousemain2:
    cmpi.b  			#$ff,$dff006    ; Linea 255?
    bne.s   			mousemain2

waitmain2:
    cmpi.b  			#$ff,$dff006    ; linea 255?
    beq.s   			waitmain2

    subi.w              #1,FADE_SPEED_COUNTER
    bne.s               nomainfadeout
    bsr.w               MAIN_FadeOut2
    bsr.w               MAIN_FadeOut
    move.w              #FADE_SPEED,FADE_SPEED_COUNTER
nomainfadeout:
    tst.w	            MAIN_FaseDelFade	; abbiamo superato l'ultima fase? (16)?
	beq.s	            exitmainscreen
    bra.s               mousemain2

exitmainscreen:
    clr.l               MENU_CALLBACK_BEFORE_LOOP_FUNCT
    tst.w               LOADING_SCREEN_FLAG
    beq.s               menuend
    moveq               #1,d0
    CLEAR_PROGRESS_BAR
    bsr.w               PRINTLOADINGBAR
    bsr.w               LOADING_SCREEN
menuend:
    clr.w               LOADING_SCREEN_FLAG
    movem.l             (sp)+,a0-a6/d0-d7
    rts

LOADING_SCREEN_FLAG: dc.w 0

printstringhigh_small:
    moveq               #0,d6
    move.b              (a1)+,d6
    cmp.w               #$FF,d6
    beq.s               printstringendhigh_small
    sub.w               #32,d6

    bsr.w               drawhole_small
    muls.w              #1*7*3,d6

    lea                 SMALLFONTS,a0
    adda.l              d6,a0
    bsr.w               printbigfonthigh_small
    addq                #1,d0
    bra.s               printstringhigh_small

printstringendhigh_small:
    rts

drawhole_small:
    movem.l             d0/d1/d6/a0-a5,-(sp)
    mulu.w              #40*7,d1
    add.w               d1,d0

    muls.w              #1*7*1,d6

    ; draw the hole
    lea                 SMALLFONTS_REVERSE_MASK,a0
    adda.l              d6,a0
    ;move.w              (a0),d5
    lea                 PHAZELOGO,a1
    lea                 PHAZELOGO+10240,a2
    lea                 PHAZELOGO+10240*2,a3
    lea                 PHAZELOGO+10240*3,a4
    lea                 PHAZELOGO+10240*4,a5

    adda.w              d0,a1
    adda.w              d0,a2
    adda.w              d0,a3
    adda.w              d0,a4
    adda.w              d0,a5

    moveq               #7-1,d6
.holestartscanlineloop_small:
    move.b              (a0)+,d5

    and.b               d5,(a1)
    and.b               d5,(a2)
    and.b               d5,(a3)

    not.w               d5

    or.b                d5,(a4)
    or.b                d5,(a5)

    adda.l              #40,a1
    adda.l              #40,a2
    adda.l              #40,a3
    adda.l              #40,a4
    adda.l              #40,a5

    dbra                d6,.holestartscanlineloop_small
    movem.l             (sp)+,d0/d1/d6/a0-a5
    rts

printbigfonthigh_small:
    movem.l             a0/a1/a2/a3/d0/d1,-(sp)
    lea                 PHAZELOGO,a1
    lea                 PHAZELOGO+10240,a2
    lea                 PHAZELOGO+20480,a3

    ;lsl.w               #1,d0
    adda.w              d0,a1
    adda.w              d0,a2
    adda.w              d0,a3

    mulu.w              #40*7,d1
    adda.w              d1,a1
    adda.w              d1,a2
    adda.w              d1,a3

    moveq               #7-1,d7
bigfontcyclehigh_small:
    move.b              (a0),d2
    or.b                d2,(a1)

    move.b              1*7*1(a0),d2
    or.b                d2,(a2)

    move.b              1*7*2(a0),d2
    or.b                d2,(a3)

    addq                #1,a0
    adda.l              #40,a1
    adda.l              #40,a2
    adda.l              #40,a3

    dbra                d7,bigfontcyclehigh_small
    movem.l             (sp)+,a0/a1/a2/a3/d0/d1
    rts

printstringhigh:
    moveq               #0,d6
    move.b              (a1)+,d6
    cmp.w               #$FF,d6
    beq.s               printstringendhigh
    sub.w               #32,d6

    bsr.w               drawhole
    muls.w              #2*16*3,d6

    lea                 BIGFONTS,a0
    adda.l              d6,a0
    bsr.w               printbigfonthigh
    addq                #1,d0
    bra.s               printstringhigh

printstringendhigh:
    rts

drawhole:
    movem.l             d0/d1/d6/a1,-(sp)
    lsl.w               #1,d0
    mulu.w              #40*16,d1
    add.w               d1,d0

    muls.w              #2*16*1,d6

    ; draw the hole
    lea                 BIGFONTS_REVERSE_MASK,a0
    adda.l              d6,a0
    ;move.w              (a0),d5
    lea                 PHAZELOGO,a1
    lea                 PHAZELOGO+10240,a2
    lea                 PHAZELOGO+10240*2,a3
    lea                 PHAZELOGO+10240*3,a4
    lea                 PHAZELOGO+10240*4,a5

    adda.w              d0,a1
    adda.w              d0,a2
    adda.w              d0,a3
    adda.w              d0,a4
    adda.w              d0,a5

    moveq               #16-1,d6
.holestartscanlineloop:
    move.w              (a0)+,d5

    rol.w               #8,d5
    and.b               d5,(a1)
    rol.w               #8,d5
    and.b               d5,1(a1)

    rol.w               #8,d5
    and.b               d5,(a2)
    rol.w               #8,d5
    and.b               d5,1(a2)

    rol.w               #8,d5
    and.b               d5,(a3)
    rol.w               #8,d5
    and.b               d5,1(a3)

    not.w               d5

    rol.w               #8,d5
    or.b                d5,(a4)
    rol.w               #8,d5
    or.b                d5,1(a4)

    rol.w               #8,d5
    or.b                d5,(a5)
    rol.w               #8,d5
    or.b                d5,1(a5)

    adda.l              #40,a1
    adda.l              #40,a2
    adda.l              #40,a3
    adda.l              #40,a4
    adda.l              #40,a5

    dbra                d6,.holestartscanlineloop
    movem.l             (sp)+,d0/d1/d6/a1
    rts

printbigfonthigh:
    movem.l             a0/a1/a2/a3/d0/d1,-(sp)
    lea                 PHAZELOGO,a1
    lea                 PHAZELOGO+10240,a2
    lea                 PHAZELOGO+20480,a3

    lsl.w               #1,d0
    adda.w              d0,a1
    adda.w              d0,a2
    adda.w              d0,a3

    mulu.w              #40*16,d1
    adda.w              d1,a1
    adda.w              d1,a2
    adda.w              d1,a3

    moveq               #16-1,d7
bigfontcyclehigh:
    move.w              (a0),d2
    ror.w               #8,d2
    or.b                d2,(a1)
    ror.w               #8,d2
    or.b                d2,1(a1)

    move.w              2*16*1(a0),d2
    ror.w               #8,d2
    or.b                d2,(a2)
    ror.w               #8,d2
    or.b                d2,1(a2)

    move.w              2*16*2(a0),d2
    ror.w               #8,d2
    or.b                d2,(a3)
    ror.w               #8,d2
    or.b                d2,1(a3)

    addq                #2,a0
    adda.l              #40,a1
    adda.l              #40,a2
    adda.l              #40,a3

    dbra                d7,bigfontcyclehigh
    movem.l             (sp)+,a0/a1/a2/a3/d0/d1
    rts

set_cursor_string_position:
    movem.l             d0-d7/a0-a6,-(sp)
    move.l              MENUSCREEN_SELECTED_ENTRY(PC),a6
    cmp.l               MENUSCREEN_OLD_SELECTED_ENTRY,a6
    bne.s               .updatecursor
    movem.l             (sp)+,d0-d7/a0-a6
    rts
.updatecursor:

    ; delete old cursor
    tst.l               MENUSCREEN_OLD_SELECTED_ENTRY
    beq.s               .nodeleteoldcursor
    ;move.l              a6,a2
    move.l              MENUSCREEN_OLD_SELECTED_ENTRY(PC),a6
    move.w              menu_EntryX(a6),d0
    subq                #CURSOR_CLEARING_STR,d0
    move.w              menu_EntryY(a6),d1
    lea                 CURSORSTR(PC),a1
    cmp.w               #8,menu_FontWidthPx(a6)
    bne.s               .clearbig
    bsr.w               restorebackground_small
    ;bsr.w               printstringhigh_small
    ; move.l             a6,a2
    bra.s               .nodeleteoldcursor
.clearbig:
    bsr.w               restorebackground_big
    ;bsr.w               printstringhigh
    ;move.l              a6,a2
.nodeleteoldcursor:
    move.l              MENUSCREEN_SELECTED_ENTRY(PC),a6
    move.l              a6,MENUSCREEN_OLD_SELECTED_ENTRY
    move.w              menu_EntryX(a6),d0
    subq                #CURSOR_CLEARING_STR,d0
    move.w              menu_EntryY(a6),d1
    lea                 CURSORSTR(PC),a1
    cmp.w               #8,menu_FontWidthPx(a6)
    bne.s               set_cursor_string_position_no_small
    bsr.w               restorebackground_small
    bsr.w               printstringhigh_small
    movem.l             (sp)+,d0-d7/a0-a6
    rts
set_cursor_string_position_no_small:
    bsr.w                restorebackground_big
    bsr.w                printstringhigh
    movem.l              (sp)+,d0-d7/a0-a6
    rts

set_cursor_sprite_position:
    move.l d2,-(sp)
    ; set up cursor X position
    move.w               menu_EntryX(a6),d0
    muls                 menu_FontWidthPx(a6),d0
    move.w               d0,d1 ; d1 holds the least sig bit to determine if the number is odd or even
    lsr.w                #1,d0
    ;move.w               menu_FontWidthPx(a6),d2
    ;lsr.w                d2,d0
    add.w                #60,d0
    sub.w                #CURSOR_CLEARING,d0
    btst                 #0,d1
    beq.s                car_no_odd_x_main
    bset                 #0,3+CURSOR
    bra.s                car_place_coords_main
car_no_odd_x_main:
    bclr                 #0,3+CURSOR
car_place_coords_main:
    move.b               d0,1+CURSOR

    ; set up cursor Y position
    move.b               #0,3+CURSOR
    move.w               menu_EntryY(a6),d1
    muls                 menu_FontHeightPx(a6),d1
    ;add.w                #$2b,d1
    add.w                #SPRITES_VSTART-5,d1
    ;center sprite vertically to the text
    move.w               menu_FontHeightPx(a6),d2
    subq                 #7,d2
    lsr.w                #1,d2
    add.w                d2,d1

    btst                 #8,d1
    beq.s                nounder255_main
    bset.b               #2,3+CURSOR
    bset.b               #1,3+CURSOR
nounder255_main:
    move.b               d1,CURSOR
    add.w                #16,d1
    move.b               d1,CURSOR+2
    btst                 #8,d1
    beq.s                cursor_y_vstopset_main
    bset.b               #1,3+CURSOR
    bra.s                cursor_y_end_main
cursor_y_vstopset_main:
    bclr.b              #1,3+CURSOR
cursor_y_end_main:
    move.l (sp)+,d2
    rts

; read input and wait for release before issuing the action
input_cmd_key_release:
    btst                d1,d0
    beq.s               main_noaltopremuto
    tst.b               (a6)
    bne.s               main_noaltopremuto2
    move.b              #1,(a6)
    jsr                 (a1)
    bra.s               main_noaltopremuto2
main_noaltopremuto:
    clr.b               (a6)
main_noaltopremuto2:
    rts

move_cursor_down:
    move.l              a0,-(sp)
    move.l              MENUSCREEN_SELECTED_ENTRY,a0
    suba.l              #menu_SIZEOF,a0
    cmp.l               MENUSCREEN_ENTRIES,a0
    bcs.s               main_no_previous_entry
    sub.l               #menu_SIZEOF,MENUSCREEN_SELECTED_ENTRY
main_no_previous_entry:
    move.l              (sp)+,a0
    rts

move_cursor_up:
    move.l              a0,-(sp)
    move.l              MENUSCREEN_SELECTED_ENTRY,a0
    adda.l              #menu_SIZEOF,a0
    tst.l               menu_DescPtr(a0)
    beq.s               main_no_previous_entry_2
    add.l               #menu_SIZEOF,MENUSCREEN_SELECTED_ENTRY
main_no_previous_entry_2:
    move.l              (sp)+,a0
    rts

MAIN_FaseDelFade:		; fase attuale del fade (0-16)
	dc.w	0

MAIN_FadeOut:
	tst.w	MAIN_FaseDelFade	; abbiamo superato l'ultima fase? (16)?
	beq.s	MAIN_FinitoOut
	subq.w	#1,MAIN_FaseDelFade	; sistema per la prossima volta la fase da fare
	moveq	#0,d0
	move.w	MAIN_FaseDelFade(PC),d0
	moveq	#32-1,d7		; D7 = Numero di colori
	lea     MAIN_PALETTE,a0	; A0 = indirizzo tabella dei colori
					; della figura da "dissolvere"
	lea	    COPCOLOR_MAIN_0+2,a1		; A1 = indirizzo colori in copperlist
					; da notare che parte dal COLOR1 e
					; non dal color0, in quanto il color0
					; e'=$000 e cosi' rimane.
	bsr.s	MAIN_Fade
	rts
MAIN_FinitoOut:
	rts

MAIN_FadeOut2:
	tst.w	MAIN_FaseDelFade
	beq.s	MAIN_FinitoOut2
	;subq.w	#1,MAIN_FaseDelFade	; sistema per la prossima volta la fase da fare
	moveq	#0,d0
	move.w	MAIN_FaseDelFade(PC),d0
    subq #1,d0
	moveq	#32-1,d7		; D7 = Numero di colori
	lea     MAIN_PALETTE2,a0	; A0 = indirizzo tabella dei colori
					
	lea	    COPCOLOR2_MAIN_0+2,a1		; A1 = indirizzo colori in copperlist
				
	bsr.s	MAIN_Fade
	rts
MAIN_FinitoOut2:
	rts

MAIN_FadeIn:
	cmp.w	#17,MAIN_FaseDelFade
	beq.s	MAIN_FinitoFadeIn
	moveq	#0,d0
	move.w	MAIN_FaseDelFade(PC),d0
	moveq	#32-1,d7		; D7 = Numero di colori
	lea	    MAIN_PALETTE,a0	; A0 = indirizzo tabella dei colori
					; della figura da "dissolvere"
	lea	    COPCOLOR_MAIN_0+2,a1		; A1 = indirizzo colori in copperlist
					; da notare che parte dal COLOR1 e
					; non dal color0, in quanto il color0
					; e'=$000 e cosi' rimane.
	bsr.s	MAIN_Fade
	addq.w	#1,MAIN_FaseDelFade	; sistema per la prossima volta la fase da fare
	rts
MAIN_FinitoFadeIn:
	;move.l  #MAIN_FadeOut,MAIN_PHAZE_FUNCT_ADDR
	rts

MAIN_FadeIn2:
	cmp.w	#17,MAIN_FaseDelFade
	beq.s	MAIN_FinitoFadeIn2
	moveq	#0,d0
	move.w	MAIN_FaseDelFade(PC),d0
	moveq	#32-1,d7		; D7 = Numero di colori
	lea	    MAIN_PALETTE2,a0	; A0 = indirizzo tabella dei colori
					
	lea	    COPCOLOR2_MAIN_0+2,a1		; A1 = indirizzo colori in copperlist

	bsr.s	MAIN_Fade
	rts
MAIN_FinitoFadeIn2:
	rts

*****************************************************************************
*		Routine per Fade In/Out da e verso il NERO (versione 2)	    *
* Input:								    *
*									    *
* d7 = Numero colori-1							    *
* a0 = Indirizzo tabella con i colori della figura			    *
* a1 = Indirizzo primo colore in copperlist				    *
* d0 = Momento del fade, multiplier - per esempio con d0=0 lo schermo	    *
*	e' bianco totalmente, con d0=8 siamo a meta' fade e con d0=16	    *
*	siamo ai colori pieni; dunque ci sono 17 fasi, dalla 0 alla 16.	    *
*	Per fare un fade IN, dal bianco al colore, si deve dare a ogni	    *
*	chiamata alla routine un valore di d0 crescente da 0 a 16	    *
*	Per un fade OUT, si dovra' partire da d0=16 fino a d0=0		    *
*									    *
*  Il procedimento di FADE e' quello di moltiplicare ogni componente R,G,B  *
*  del colore per un Multiplier, che va da 0 per il NERO (x*0=0), a 16 per  *
*  i colori normali, dato che poi il colore viene diviso per 16,	    *
*  moltiplicare un colore per 16 e ridividerlo non fa che lasciarlo uguale. *
*									    *
*****************************************************************************

;	   .      .-~\
;	  / `-'\.'    `- :
;	  |    /          `._
;	  |   |   .-.        {
;	   \  |   `-'         `.
;	 .  \ |                /
;	~-.`. \|            .-~_
;	  `.\-.\       .-~      \
;	    `-'/~~ -.~          /
;	  .-~/|`-._ /~~-.~ -- ~
;	 /  |  \    ~- . _\

MAIN_Fade:
;	Calcola la componente BLU

	MOVE.W	(A0),D4		; Metti il colore dalla tabella colori in d4
	AND.W	#$00f,D4	; Seleziona solo la componente blu ($RGB->$00B)
	MULU.W	D0,D4		; Moltiplica per la fase del fade (0-16)
	ASR.W	#4,D4		; shift 4 BITS a destra, ossia divisione per 16
	AND.W	#$00f,D4	; Seleziona solo la componente BLU
	MOVE.W	D4,D5		; Salva la componente BLU in d5

;	Calcola la componente VERDE (GREEN)

	MOVE.W	(A0),D4		; Metti il colore dalla tabella colori in d4
	AND.W	#$0f0,D4	; Selez. solo la componente verde ($RGB->$0G0)
	MULU.W	D0,D4		; Moltiplica per la fase del fade (0-16)
	ASR.W	#4,D4		; shift 4 BITS a destra, ossia divisione per 16
	AND.W	#$0f0,D4	; Seleziona solo la componente VERDE
	OR.W	D4,D5		; Salva la comp.verde assieme a quella BLU

;	Calcola la componente ROSSA (RED)

	MOVE.W	(A0)+,D4	; leggi il colore dalla tabella
				; e fai puntare a0 al prossimo col.
	AND.W	#$f00,D4	; Selez. solo la componente rossa ($RGB->$R00)
	MULU.W	D0,D4		; Moltiplica per la fase del fade (0-16)
	ASR.W	#4,D4		; shift 4 BITS a destra, ossia divisione per 16
	AND.W	#$f00,D4	; Selez. solo la componente rossa ($RGB->$R00)
	OR.W	D4,D5		; Salva la c. ROSSA assieme alla BLU e VERDE

	MOVE.W	D5,(A1)		; E metti il colore $0RGB finale in copperlist
	addq.w	#4,a1		; prossimo colore in copperlist
	DBRA	D7,MAIN_Fade		; fai tutti i colori
	rts


LOADING_SCREEN:
    move.l              #LOADING_SCREEN_BPL_0,d0
    lea                 BPLPTR1_LOADING,a1
    bsr.w               POINTINCOPPERLIST_FUNCT

    move.l              #LOADING_SCREEN_BPL_1,d0
    lea                 BPLPTR2_LOADING,a1
    bsr.w               POINTINCOPPERLIST_FUNCT

    move.l              #LOADING_SCREEN_BPL_2,d0
    lea                 BPLPTR3_LOADING,a1
    bsr.w               POINTINCOPPERLIST_FUNCT

.loop
    move.l	$dff004,d0
	and.l	#$1ff00,d0
	cmp.l	#303<<8,d0
	bne.b	.loop

    ; copperlist setup
    move.l				#COPPERLIST_LOADING,$dff080	; Copperlist point
    move.w				d0,$dff088			; Copperlist start

loadingdelay1:
    cmpi.b  			#$ff,$dff006    ; Linea 255?
    bne.s   			loadingdelay1

loadingdeay2:
    cmpi.b  			#$ff,$dff006    ; linea 255?
    beq.s   			loadingdeay2



    ;bra.s               loadingdelay1

    rts

LOADINGBARPROGRESS:     dc.w 0
PRINTLOADINGBAR:
    movem.l             d0-d7/a0-a6,-(sp)
    ;move.w             #127,d0
    move.w              #0,d1
    move.w              #100,d2
    moveq               #0,d3
    move.w              #320,d4
    jsr                 MAP

    ; print bar
    subq                #1,d4
    
    cmp.w               #-1,d4
    beq.s               printloadingbarend
    sub.w               LOADINGBARPROGRESS,d4
    cmp.w               #-1,d4
    beq.s               printloadingbarend
    BETWEEN_UWORD       d4,#0,#320,d1
    tst.b               d1
    bne.s               printloadingbarend
    DEBUG 8786

printloadingbarloop:
    DEBUG 8787
    jsr                 POINT_PROGRESS
    addi.w              #1,LOADINGBARPROGRESS

    dbra                d4,printloadingbarloop
printloadingbarend:
    movem.l             (sp)+,d0-d7/a0-a6
    rts

POINT_PROGRESS:
    lea                 LOADING_SCREEN_BPL_0+200*40,a0
    move.w              LOADINGBARPROGRESS(PC),d6
    lsr.w               #3,d6
    adda.w              d6,a0

    move.w              LOADINGBARPROGRESS(PC),d6
    not.b               d6
    bset                d6,(a0)
    rts

SHR_PROGRESS:
    movem.l             d0-d7/a0-a6,-(sp)
    lsr.w               #2,d0
    ;move.w d0,d7
    ;move.w             #127,d0
    move.w              #0,d1
    move.w              #51264/4,d2
    moveq               #0,d3
    move.w              #70-1,d4
    jsr                 MAP

    ; update progress bar
    move.w              d4,d0
    addi.w              #20,d0

    cmp.w               SHR_PREV_PROG,d0
    beq.s               shr_noupd
        ;DEBUG 5432

    ;cmp.w               LOADINGBARPROGRESS,d0
    ;beq.s               shr_noupd
    move.w              d0,SHR_PREV_PROG
    bsr.w               PRINTLOADINGBAR

shr_noupd:

    movem.l             (sp)+,d0-d7/a0-a6
    rts

SHR_PREV_PROG: dc.w 0