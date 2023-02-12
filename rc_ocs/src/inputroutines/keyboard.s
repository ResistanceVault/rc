*****************************************************************************
*	ROUTINE IN INTERRUPT $68 (livello 2) - gestione TASTIERA
*****************************************************************************

;03	PORTS	2 ($68)	Input/Output Porte e timers, connesso alla linea INT2

MioInt68KeyB:	; $68
	movem.l d0/a0,-(sp)	; salva i registri usati nello stack
	lea	$dff000,a0	; reg. custom per offset

	MOVE.B	$BFED01,D0	; Ciaa icr - in d0 (leggendo l'icr causiamo
				; anche il suo azzeramento, per cui l'int e'
				; "disdetto" come in intreq).
	BTST.l	#7,D0	; bit IR, (interrupt cia autorizzato), azzerato?
	BEQ.w	NonKey	; se si, esci
	BTST.l	#3,D0	; bit SP, (interrupt della tastiera), azzerato?
	BEQ.s	NonKey	; se si, esci

	MOVE.W	$1C(A0),D0	; INTENAR in d0
	BTST.l	#14,D0		; Bit Master di abilitazione azzerato?
	BEQ.s	NonKey		; Se si, interrupt non attivi!
	AND.W	$1E(A0),D0	; INREQR - in d1 rimangono settati solo i bit
				; che sono settati sia in INTENA che in INTREQ
				; in modo da essere sicuri che l'interrupt
				; avvenuto fosse abilitato.
	btst.l	#3,d0		; INTREQR - PORTS?
	beq.w	NonKey		; Se no, allora esci!

; Dopo i controlli, se siamo qua significa che dobbiamo prendere il carattere!

    move.b $bfec00,d0

	moveq	#0,d0
	move.b	$bfec01,d0	; CIAA sdr (serial data register - connesso
				; alla tastiera - contiene il byte inviato dal
				; chip della tastiera) LEGGIAMO IL CHAR!
    btst #0,d0
	lea KEYBOARD_KEYS(PC),a0
    bne.s keynotreleased
    ; if we are here the key is released
	not.b d0
    lsr.b #1,d0
	move.b #$00,(a0,d0.w)
	bra.s send_key_confirmation

	; if we are here the key is pressed
keynotreleased:

    not.b d0
    lsr.b #1,d0
	move.b #$FF,(a0,d0.w)

	;bsr.s	convertichar	; Converti in ASCII il carattere
send_key_confirmation:
; Ora dobbiamo comunicare alla tastiera che abbiamo preso il dato!
	lea	$dff000,a0	; reg. custom per offset
	bset.b	#6,$bfee01	; CIAA cra - sp ($bfec01) output, in modo da
				; abbassare la linea KDAT per confermare che
				; abbiamo ricevuto il carattere.

	st.b	$bfec01		; $FF in $bfec01 - ue'! ho ricevuto il dato!

; Qua dobbiamo mettere una routine che aspetti 90 microsecondi perche' la
; linea KDAT deve stare bassa abbastanza tempo per essere "capita" da tutti
; i tipi di tastiere. Si possono, per esempio, aspettare 3 o 4 linee raster.

	moveq	#4-1,d0	; Numero di linee da aspettare = 4 (in pratica 3 piu'
			; la frazione in cui siamo nel momento di inizio)
	swap    d0
waitlines:
	move.b	6(a0),d0	; $dff006 - linea verticale attuale in d1
stepline:
	cmp.b	6(a0),d0	; siamo sempre alla stessa linea?
	beq.s	stepline	; se si aspetta
	swap 	d0
	dbra	d0,waitlines	; linea "aspettata", aspetta d0-1 linee

; Ora che abbiamo atteso, possiamo riportare $bfec01 in modo input...

	bclr.b	#6,$bfee01	; CIAA cra - sp (bfec01) input nuovamente.

NonKey:		; 3210
	move.w	#%1000,$9c(a0)	; INTREQ togli richiesta, int eseguito!
	movem.l (sp)+,d0/a0	; ripristina i registri dallo stack
	rte

KEYBOARD_KEYS:

	KEY_TILDE: 			dc.b 0 		;0x0
	KEY_1: 				dc.b 0 		;0x01
	KEY_2: 				dc.b 0 		;0x02
	KEY_3: 				dc.b 0 		;0x03
	KEY_4: 				dc.b 0 		;0x04
	KEY_5: 				dc.b 0 		;0x05
	KEY_6: 				dc.b 0 		;0x06
	KEY_7: 				dc.b 0 		;0x07
	KEY_8: 				dc.b 0 		;0x08
	KEY_9: 				dc.b 0 		;0x09

	KEY_0: 				dc.b 0 		;0x0A
	KEY_MINUS: 			dc.b 0 		;0x0B
	KEY_PLUS: 			dc.b 0 		;0xC
	KEY_BACKSLASH: 		dc.b 0 		;0xD
	KEY_UNKNOWN: 		dc.b 0 		;0xE
	KEY_NUMPAD_0: 		dc.b 0 		;0xF
	KEY_Q: 				dc.b 0 		;0x10
	KEY_W: 				dc.b 0 		;0x11
	KEY_E: 				dc.b 0 		;0x12
	KEY_R: 				dc.b 0 		;0x13

	KEY_T: 				dc.b 0 		;0x14
	KEY_Y: 				dc.b 0 		;0x15
	KEY_U: 				dc.b 0 		;0x16
	KEY_I: 				dc.b 0 		;0x17
	KEY_O: 				dc.b 0 		;0x18
	KEY_P: 				dc.b 0 		;0x19
	KEY_SQUARE_OPEN:	dc.b 0 		;0x1A
	KEY_SQUARE_CLOSE:	dc.b 0 		;0x1B
	KEY_UNKNOWN_2: 		dc.b 0 		;0x1C
	KEY_NUMPAD_1: 		dc.b 0 		;0x1D

	KEY_NUMPAD_2: 		dc.b 0 		;0x1E
	KEY_NUMPAD_3: 		dc.b 0 		;0x1F
	KEY_A:		 		dc.b 0 		;0x20
	KEY_S:		 		dc.b 0 		;0x21
	KEY_D:		 		dc.b 0 		;0x22
	KEY_F:		 		dc.b 0 		;0x23
	KEY_G:		 		dc.b 0 		;0x24
	KEY_H:		 		dc.b 0 		;0x25
	KEY_J:		 		dc.b 0 		;0x26
	KEY_K:		 		dc.b 0 		;0x27
	KEY_L:		 		dc.b 0 		;0x28

	KEY_SEMICOL:		dc.b 0 		;0x29
	KEY_DOUBLEQUOT:		dc.b 0 		;0x2A
	KEY_UACC:		 	dc.b 0 		;0x2B
	KEY_UNKNOWN_3: 		dc.b 0 		;0x2C
	KEY_NUMPAD_4: 		dc.b 0 		;0x2D
	KEY_NUMPAD_5: 		dc.b 0 		;0x2E
	KEY_NUMPAD_6: 		dc.b 0 		;0x2F
	KEY_ANGLE_BRACKET:	dc.b 0 		;0x30
	KEY_Z:		 		dc.b 0 		;0x31
	KEY_X:		 		dc.b 0 		;0x32

	KEY_C:		 		dc.b 0 		;0x33
	KEY_V:		 		dc.b 0 		;0x34
	KEY_B:		 		dc.b 0 		;0x35
	KEY_N:		 		dc.b 0 		;0x36
	KEY_M:		 		dc.b 0 		;0x37
	KEY_COMMA:		 	dc.b 0 		;0x38
	KEY_DOT:		 	dc.b 0 		;0x39
	KEY_DASH:		 	dc.b 0 		;0x3A
	KEY_UNKNOWN_4:		dc.b 0 		;0x3B
	KEY_UNKNOWN_5:		dc.b 0 		;0x3C

	KEY_NUMPAD_7: 		dc.b 0 		;0x3D
	KEY_NUMPAD_8: 		dc.b 0 		;0x3E
	KEY_NUMPAD_9: 		dc.b 0 		;0x3F
	KEY_SPACE:			dc.b 0 		;0x40
	KEY_BACKSPACE:		dc.b 0 		;0x41
	KEY_TAB:			dc.b 0 		;0x42
	KEY_NUMPAD_ENTER:	dc.b 0 		;0x43
	KEY_ENTER:			dc.b 0 		;0x44
	KEY_ESC:			dc.b 0 		;0x45
	KEY_DEL:			dc.b 0 		;0x46

	KEY_UNKNOWN_7:		dc.b 0 		;0x47
	KEY_UNKNOWN_8:		dc.b 0 		;0x48
	KEY_UNKNOWN_9:		dc.b 0 		;0x49
	KEY_UNKNOWN_10:		dc.b 0 		;0x4A
	KEY_UNKNOWN_11:		dc.b 0 		;0x4B
	KEY_ARROW_UP:		dc.b 0 		;0x4C
	KEY_ARROW_DOWN:		dc.b 0 		;0x4D
	KEY_ARROW_RIGHT:	dc.b 0 		;0x4E
	KEY_ARROW_LEFT:		dc.b 0 		;0x4F
	KEY_F1:				dc.b 0 		;0x50

	dcb.b				73,0

	EVEN