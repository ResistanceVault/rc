KEYBOARD_ARROWS:
    ;rts
    moveq   #0,d0
	tst.b	KEY_ARROW_RIGHT		; if ARROW RIGHT is pressed go to right
	BEQ.S	NODESTRA_KARROWS
	bset 	#0,d0
	BRA.S	CHECK_Y_KARROWS
NODESTRA_KARROWS:
	tst.b	KEY_ARROW_LEFT		; if ARROW LEFT is pressed go to left
	BEQ.S	CHECK_Y_KARROWS
	bset	#1,d0
CHECK_Y_KARROWS:
	tst.b	KEY_ARROW_UP
	BEQ.S	NOALTO_KARROWS ; if ARROW IP is pressed go to up
	bset 	#2,d0	; se si sposta lo sprite
	BRA.S	ENDKEYBOARD_ARROWS
NOALTO_KARROWS:
	tst.b	KEY_ARROW_DOWN		; if ARROW DOWN is pressed go to down
	BEQ.S	ENDKEYBOARD_ARROWS	; se no finisci
	bset	#3,d0	; se si sposta lo sprite
ENDKEYBOARD_ARROWS:
	RTS