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

mousemain:
    cmpi.b  			#$ff,$dff006    ; Linea 255?
    bne.s   			mousemain

waitmain:
    cmpi.b  			#$ff,$dff006    ; linea 255?
    beq.s   			waitmain

    bra.s               mousemain
    rts
MAIN_FILENAME:
     dc.b    "main.data",0
     even

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

    dbra                d7,bigfontcyclehigh
    movem.l             (sp)+,a0/a1/a2/a3/d0/d1
    rts
