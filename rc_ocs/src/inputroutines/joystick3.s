READJOY3:
	moveq   #0,d0
    move.b  $bfe101,d3
	BTST	#7,D3		    ; right?
	bne.S	NODESTRA_JOY3	; if 1 right is unpressed
	bset 	#0,d0	        ; set right bit
	BRA.S	CHECK_Y_JOY3	; go to Y check
NODESTRA_JOY3:
	BTST	#6,D3		    ; left ?
	bne.S	CHECK_Y_JOY3    ; if 1 left is unpressed
	bset	#1,d0	        ; set left bit

CHECK_Y_JOY3:
    btst    #4,d3           ; up?
	bne.S	NOALTO_JOY3		; if 1 up is unpressed
	bset 	#2,d0	        ; set up bit
	BRA.S	ENDJOYST_JOY3   ; dont need anything more, exit
NOALTO_JOY3:
	BTST.l	#5,D3		    ; down?
	bne.S	ENDJOYST_JOY3	; dont need anything more, exit
	bset	#3,d0	        ; set down bit
ENDJOYST_JOY3:

	btst    #0,$bfd000	    ; fire pressed?
	bne.s				JOY3_NOFIREPRESSED
	bset 				#2,d0
JOY3_NOFIREPRESSED:
	RTS