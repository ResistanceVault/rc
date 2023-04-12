READJOY1_WELCOME:
    moveq   #0,d0
	MOVE.w	$dff00c,D3	; JOY1DAT
	BTST.l	#1,D3		; il bit 1 ci dice se si va a destra
	BEQ.S	NODESTRA_WELCOME	; se vale zero non si va a destra
	bset 	#0,d0	; se vale 1 sposta a di un pixel lo sprite
	BRA.S	CHECK_Y_WELCOME		; vai al controllo della Y
NODESTRA_WELCOME:
	BTST.l	#9,D3		; il bit 9 ci dice se si va a sinistra
	BEQ.S	CHECK_Y_WELCOME		; se vale zero non si va a sinistra
	bset	#1,d0	    ; se vale 1 sposta lo sprite
CHECK_Y_WELCOME:
	MOVE.w	D3,D2		; copia il valore del registro
	LSR.w	#1,D2		; fa scorrere i bit di un posto verso destra 
	EOR.w	D2,D3		; esegue l'or esclusivo. Ora possiamo testare
	BTST.l	#8,D3		; testiamo se va in alto
	BEQ.S	NOALTO_WELCOME		; se no controlla se va in basso
	bset 	#2,d0	; se si sposta lo sprite
	BRA.S	ENDJOYST_WELCOME
NOALTO_WELCOME:
	BTST.l	#0,D3		; testiamo se va in basso
	BEQ.S	ENDJOYST_WELCOME	; se no finisci
	bset	#3,d0	; se si sposta lo sprite
ENDJOYST_WELCOME:
	btst				#7,$bfe001	; fire pressed?
	bne.w				JOY1_NOFIREPRESSED_WELCOME
	bset 				#4,d0
JOY1_NOFIREPRESSED_WELCOME:
	RTS