PHAZE_TIME equ 13

INTROSCREEN:
    ; Init tiles bitplanes
    move.l              #PHAZELOGO,d0
    lea                 BPLPTR1_INTRO,a1
    bsr.w               POINTINCOPPERLIST_FUNCT

    move.l              #PHAZELOGO+10240,d0
    lea                 BPLPTR2_INTRO,a1
    bsr.w               POINTINCOPPERLIST_FUNCT

    move.l              #PHAZELOGO+20480,d0
    lea                 BPLPTR3_INTRO,a1
    bsr.w               POINTINCOPPERLIST_FUNCT

    move.w 	   			#DMASET,d1
    MOVE.W				d1,$96(a5)		; DMACON - enable bitplane, copper, sprites and audio (optional).

	; copperlist setup
    lea                 $dff000,a5
	move.l				#COPPERLIST_INTRO,$80(a5)	; Copperlist point
	move.w				d0,$88(a5)			; Copperlist start
	move.w				#0,$1fc(a5)			; AGA disable
	move.w				#$c00,$106(a5)		; AGA disable
	move.w				#$11,$10c(a5)		; AGA disable

mouseintro:
    cmpi.b  			#$ff,$dff006    ; Linea 255?
    bne.s   			mouseintro

	tst.w				PHAZE_EXIT
	bne.s				endofintro

    subi.w              #1,PHAZE_TIME_INTERVAL
    bne.s               waitintro
    ;bsr.w               FadeIn
    move.l              PHAZE_FUNCT_ADDR,a0
    jsr                 (a0)
    move.w              #PHAZE_TIME,PHAZE_TIME_INTERVAL

waitintro:
    cmpi.b  			#$ff,$dff006    ; linea 255?
    beq.s   			waitintro

    bra.s               mouseintro
endofintro:
    rts

PHAZE_TIME_INTERVAL: dc.w PHAZE_TIME
PHAZE_FUNCT_ADDR: dc.l FadeIn
PHAZE_EXIT:dc.w 0

FaseDelFade:		; fase attuale del fade (0-16)
	dc.w	0

FadeOut:
	tst.w	FaseDelFade	; abbiamo superato l'ultima fase? (16)?
	beq.s	FinitoOut
	subq.w	#1,FaseDelFade	; sistema per la prossima volta la fase da fare
	moveq	#0,d0
	move.w	FaseDelFade(PC),d0
	moveq	#7-1,d7		; D7 = Numero di colori
	lea	PHAZELOGO_PALETTE+2,a0	; A0 = indirizzo tabella dei colori
					; della figura da "dissolvere"
	lea	COPCOLOR_INTRO_0+6,a1		; A1 = indirizzo colori in copperlist
					; da notare che parte dal COLOR1 e
					; non dal color0, in quanto il color0
					; e'=$000 e cosi' rimane.
	bsr.s	Fade
	rts
FinitoOut:
	move.w #1,PHAZE_EXIT
	rts

FadeIn:
	cmp.w	#17,FaseDelFade
	beq.s	FinitoFadeIn
	moveq	#0,d0
	move.w	FaseDelFade(PC),d0
	moveq	#7-1,d7		; D7 = Numero di colori
	lea	PHAZELOGO_PALETTE+2,a0	; A0 = indirizzo tabella dei colori
					; della figura da "dissolvere"
	lea	COPCOLOR_INTRO_0+6,a1		; A1 = indirizzo colori in copperlist
					; da notare che parte dal COLOR1 e
					; non dal color0, in quanto il color0
					; e'=$000 e cosi' rimane.
	bsr.s	Fade
	addq.w	#1,FaseDelFade	; sistema per la prossima volta la fase da fare
	rts
FinitoFadeIn:
	move.l  #FadeOut,PHAZE_FUNCT_ADDR
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

Fade:
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
	DBRA	D7,Fade		; fai tutti i colori
	rts
