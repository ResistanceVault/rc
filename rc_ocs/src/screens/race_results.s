RACE_RESULTS_SCREEN:
    ; clean bitplanes
    jsr CLEAN_BITPLANES

    ; clear sprites pointers
    move.w #0,Sprite0Welcomepointers+2
    move.w #0,Sprite0Welcomepointers+6

    ; if fire is still pressed wait for release
    btst				#7,$bfe001	; joy fire pressed?
    bne.s               firenotpressed_ok
firenotpressed_loop:
    btst				#7,$bfe001	; joy fire pressed?
    beq.s               firenotpressed_loop
firenotpressed_ok:

    ; reset a5
    lea                 $dff000,a5

    ;reset race flag in case we are returning here after the race
    move.w              #1,LOAD_NEXT_TRACK_FLAG

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

    lea                 WINNER_TXT,a1
    moveq               #1,d0
    moveq               #1,d1
    bsr.w               printstring

    move.l              ARRIVAL_ORDER,a1
    move.w              CAR_ID_OFFSET(a1),d0
    addi.w              #$31,d0
    move.b              d0,VALUE_TXT+4
    lea                 VALUE_TXT,a1
    moveq               #11,d0
    moveq               #1,d1
    bsr.w               printstring

    ;DEBUG 1111
    move.l              ARRIVAL_ORDER+4,a1
    tst.l               (a1)
    beq.w               firetocontinue_results
    lea                 SECOND_PLACE_TXT,a1
    moveq               #1,d0
    moveq               #3,d1
    bsr.w               printstring
    move.l              ARRIVAL_ORDER+4,a1
    move.w              CAR_ID_OFFSET(a1),d0
    addi.w              #$31,d0
    move.b              d0,VALUE_TXT+4
    lea                 VALUE_TXT,a1
    moveq               #11,d0
    moveq               #3,d1
    bsr.w               printstring

    move.l              ARRIVAL_ORDER+8,a1
    tst.l               (a1)
    beq.s               firetocontinue_results
    lea                 THIRD_PLACE_TXT,a1
    moveq               #1,d0
    moveq               #5,d1
    bsr.w               printstring
    move.l              ARRIVAL_ORDER+8,a1
    move.w              CAR_ID_OFFSET(a1),d0
    addi.w              #$31,d0
    move.b              d0,VALUE_TXT+4
    lea                 VALUE_TXT,a1
    moveq               #11,d0
    moveq               #5,d1
    bsr.w               printstring

    move.l              ARRIVAL_ORDER+12,a1
    tst.l               (a1)
    beq.s               firetocontinue_results
    lea                 FOURTH_PLACE_TXT,a1
    moveq               #1,d0
    moveq               #7,d1
    bsr.w               printstring
    move.l              ARRIVAL_ORDER+12,a1
    move.w              CAR_ID_OFFSET(a1),d0
    addi.w              #$31,d0
    move.b              d0,VALUE_TXT+4
    lea                 VALUE_TXT,a1
    moveq               #11,d0
    moveq               #7,d1
    bsr.w               printstring

firetocontinue_results:
    lea                 FIRE_TO_CONTINUE_TXT,a1
    moveq               #1,d0
    moveq               #11,d1
    bsr.w               printstring

mouseraceresults:
    cmpi.b  			#$ff,$dff006    ; Linea 255?
    bne.s   			mouseraceresults

waitraceresults:
    cmpi.b  			#$ff,$dff006    ; linea 255?
    beq.s   			waitraceresults

    btst				#7,$bfe001	; joy fire pressed?
    beq.w				welcomescreen_start
    bra.w 				mouseraceresults

WINNER_TXT:
    dc.b                "1ST PLACE",255
    even
SECOND_PLACE_TXT:
    dc.b                "2ND PLACE",255
    even
THIRD_PLACE_TXT:
    dc.b                "3RD PLACE",255
    even
FOURTH_PLACE_TXT:
    dc.b                "4RD PLACE",255
    even
FIRE_TO_CONTINUE_TXT:
    dc.b                "FIRE TO CONTINUE",255
    even
VALUE_TXT:
    dc.b "CAR     ",255
    even