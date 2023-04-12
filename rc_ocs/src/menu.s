                    rsset   0
menu_EntryX         rs.w    1
menu_EntryY         rs.w    1
menu_DescPtr        rs.l    1
menu_FunctPtr       rs.l    1
menu_SIZEOF         rs.b    0

MENUSCREEN_IMAGE: dc.l  0
MENUSCREEN_ENTRIES: dc.l 0

MENUSCREEN_SELECTED_ENTRY: dc.l 0

MAIN_JOY1_UP_PRESSED: dc.b 0
MAIN_JOY1_DOWN_PRESSED: dc.b 0
MAIN_JOY1_FIRE_1_PRESSED: dc.b 0
MAIN_JOY1_FIRE_2_PRESSED: dc.b 0

MAIN_EXIT: dc.w 0

MENUSCREEN:

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
	move.l				#COPPERLIST_MAIN,$80(a5)	; Copperlist point
	move.w				d0,$88(a5)			; Copperlist start
	move.w				#0,$1fc(a5)			; AGA disable
	move.w				#$c00,$106(a5)		; AGA disable
	move.w				#$11,$10c(a5)		; AGA disable

    move.l              execBase,a6

	MOVE.L	            #$7FFF7FFF,$9A(A5)	; INTERRUPTS & INTREQS DISABLE

	bsr.w               PreparaLoad
    moveq	            #50,d1		; wait 50 frames
	bsr.w	            AspettaBlanks

    move.l              dosBase,a6
    move.l              #MODE_OLDFILE,d2
    move.l	            MENUSCREEN_IMAGE,d1
    jsr                 _LVOOpen(a6)
    move.l	            d0,fd

    ; first bitplane
    move.l              fd,d1
    move.l              #PHAZELOGO,d2
    move.l              #40*256*5,d3
    jsr                 _LVORead(a6)

    moveq               #16-1,d7
    move.l              #COPCOLOR_MAIN_0+2,d2
menucolorloop:
    move.l              fd,d1
    move.l              #2,d3
    jsr                 _LVORead(a6)

    addq                #4,d2
    dbra                d7,menucolorloop

    ; close the file
	move.l	            fd,d1				; result = LVOClose(handle[d1])
    jsr                 _LVOClose(a6)

    move.l	            #150,d1 ; wait 150 frames
	bsr.w	            AspettaBlanks

    bsr.w               DopoLoad

    move.w				COLORS_FONTS_SMALL+2,COPCOLOR_MAIN_25+2
	move.w				COLORS_FONTS_SMALL+4,COPCOLOR_MAIN_26+2
	move.w				COLORS_FONTS_SMALL+6,COPCOLOR_MAIN_27+2
	move.w				COLORS_FONTS_SMALL+8,COPCOLOR_MAIN_28+2
	move.w				COLORS_FONTS_SMALL+10,COPCOLOR_MAIN_29+2
	move.w				COLORS_FONTS_SMALL+12,COPCOLOR_MAIN_30+2
	move.w				COLORS_FONTS_SMALL+14,COPCOLOR_MAIN_31+2

    move.l               MENUSCREEN_ENTRIES,a6
menuloop:
    tst.l                menu_DescPtr(a6)
    beq.s                setcursormain

    ; set the cursor if entry is selcted
    cmp.l                MENU_MAIN_CURRENTLY_SELECTED,a6
    bne.s                entry_not_currently_selected

    bsr.w                set_cursor_sprite_position
entry_not_currently_selected:
    move.w               menu_EntryX(a6),d0
    move.w               menu_EntryY(a6),d1
    move.l               menu_DescPtr(a6),a1
    bsr.w                printstringhigh

    adda.l               #menu_SIZEOF,a6
    bra.s                menuloop

setcursormain:
    move.l               #CURSOR,d0
    lea       		     Sprite0Mainpointers,a1
    jsr       		     POINTINCOPPERLIST_FUNCT

mousemain:
    cmpi.b  			#$ff,$dff006    ; Linea 255?
    bne.s   			mousemain

waitmain:
    cmpi.b  			#$ff,$dff006    ; linea 255?
    beq.s   			waitmain

    jsr                 READJOY1_WELCOME

    ; check if up has been pressed
    moveq               #2,d1
    lea                 MAIN_JOY1_UP_PRESSED(PC),a6
    move.l              #move_cursor_down,a1
    bsr.w               input_cmd_key_release

    ; check if down has been pressed
    moveq               #3,d1
    lea                 MAIN_JOY1_DOWN_PRESSED(PC),a6
    move.l              #move_cursor_up,a1
    bsr.w               input_cmd_key_release

    ; check if fire has been pressed
    moveq               #4,d1
    lea                 MAIN_JOY1_FIRE_1_PRESSED(PC),a6
    move.l              MENUSCREEN_SELECTED_ENTRY,a1
    move.l              menu_FunctPtr(a1),a1
    bsr.w               input_cmd_key_release

    move.l              MENUSCREEN_SELECTED_ENTRY(PC),a6
    bsr.w               set_cursor_sprite_position

    ;btst				#7,$bfe001	; joy fire pressed?
	;beq.s				exitmainscreen
    tst.w               MAIN_EXIT
    beq.s               mousemain
    clr.w               MAIN_EXIT
exitmainscreen:
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
    move.w              (a0),d5
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


set_cursor_sprite_position:
    ; set up cursor X position
    move.w               menu_EntryX(a6),d0
    muls                 #16,d0
    move.w               d0,d1 ; d1 holds the least sig bit to determine if the number is odd or even
    lsr.w                #1,d0
    add.w                #60,d0
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
    muls                 #16,d1
    add.w                #$2b,d1
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