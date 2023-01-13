KEYBOARD_WASD:
    moveq   #0,d0
	tst.b	KEY_D		; if D is pressed go to right
	BEQ.S	NODESTRA_KWASD
	bset 	#0,d0
	BRA.S	CHECK_Y_KWASD
NODESTRA_KWASD:
	tst.b	KEY_A		; if A is pressed go to left
	BEQ.S	CHECK_Y_KWASD
	bset	#1,d0
CHECK_Y_KWASD:
	tst.b	KEY_W
	BEQ.S	NOALTO_KWASD ; if W is pressed go to up
	bset 	#2,d0	; se si sposta lo sprite
	BRA.S	ENDKEYBOARD_WASD
NOALTO_KWASD:
	tst.b	KEY_S		; if S is pressed go to down
	BEQ.S	ENDKEYBOARD_WASD	; se no finisci
	bset	#3,d0	; se si sposta lo sprite
ENDKEYBOARD_WASD:
	RTS