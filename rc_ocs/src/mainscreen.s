MAINSCREEN:

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

    move.l  execBase,a6

	MOVE.L	#$7FFF7FFF,$9A(A5)	; INTERRUPTS & INTREQS DISABLE

	bsr.w PreparaLoad
    moveq	#50,d1		; num. di frames da aspettare
	bsr.w	AspettaBlanks	; aspetta 5 frames

    move.l  dosBase,a6
    move.l  #MODE_OLDFILE,d2
    move.l	#MAIN_FILENAME,d1
    jsr     _LVOOpen(a6)
    move.l	d0,fd

    ; first bitplane
    move.l fd,d1
    move.l #PHAZELOGO,d2
    move.l #40*256*5,d3
    jsr     _LVORead(a6)

    moveq #16-1,d7
    move.l #COPCOLOR_MAIN_0+2,d2
maincolorloop:
    move.l fd,d1
    move.l #2,d3
    jsr     _LVORead(a6)

    addq #4,d2
    dbra d7,maincolorloop

    ; close the file
	move.l	fd,d1				; result = LVOClose(handle[d1])
    jsr     _LVOClose(a6)

    move.l	#150,d1		; num. di frames da aspettare
	bsr.w	AspettaBlanks	; aspetta 5 frames

    bsr.w DopoLoad

    move.w				COLORS_FONTS_SMALL+2,COPCOLOR_MAIN_25+2
	move.w				COLORS_FONTS_SMALL+4,COPCOLOR_MAIN_26+2
	move.w				COLORS_FONTS_SMALL+6,COPCOLOR_MAIN_27+2
	move.w				COLORS_FONTS_SMALL+8,COPCOLOR_MAIN_28+2
	move.w				COLORS_FONTS_SMALL+10,COPCOLOR_MAIN_29+2
	move.w				COLORS_FONTS_SMALL+12,COPCOLOR_MAIN_30+2
	move.w				COLORS_FONTS_SMALL+14,COPCOLOR_MAIN_31+2

    lea                 START_GAME_TXT,a1
    moveq               #5,d0
    moveq               #7,d1
    bsr.w               printstringhigh

    lea                 EXIT_TO_OS_TXT,a1
    moveq               #5,d0
    moveq               #9,d1
    bsr.w               printstringhigh

mousemain:
    cmpi.b  			#$ff,$dff006    ; Linea 255?
    bne.s   			mousemain

waitmain:
    cmpi.b  			#$ff,$dff006    ; linea 255?
    beq.s   			waitmain

    btst				#7,$bfe001	; joy fire pressed?
	beq.s				exitmainscreen

    bra.s               mousemain
exitmainscreen:
    rts
MAIN_FILENAME:
    dc.b    "main.data",0
    even
START_GAME_TXT:
    dc.b "START GAME",$FF
    even

EXIT_TO_OS_TXT:
    dc.b "EXIT TO OS",$FF
    even


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
