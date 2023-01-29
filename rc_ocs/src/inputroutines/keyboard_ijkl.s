KEYBOARD_IJKL:
    moveq   #0,d0
	tst.b	KEY_L		; if L is pressed go to right
	BEQ.S	NODESTRA_KIJKL
	bset 	#0,d0
	BRA.S	CHECK_Y_KIJKL
NODESTRA_KIJKL:
	tst.b	KEY_J		; if J is pressed go to left
	BEQ.S	CHECK_Y_KIJKL
	bset	#1,d0
CHECK_Y_KIJKL:
	tst.b	KEY_I
	BEQ.S	NOALTO_KIJKL ; if I is pressed go to up
	bset 	#2,d0	; se si sposta lo sprite
	BRA.S	ENDKEYBOARD_IJKL
NOALTO_KIJKL:
	tst.b	KEY_K		; if K is pressed go to down
	BEQ.S	ENDKEYBOARD_IJKL	; se no finisci
	bset	#3,d0	; se si sposta lo sprite
ENDKEYBOARD_IJKL:
	RTS