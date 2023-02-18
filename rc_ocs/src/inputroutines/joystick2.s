READJOY2:
	moveq   #0,d0
    move.b  $bfe101,d3
	BTST	#3,D3		    ; right?
	bne.S	NODESTRA_JOY2	; if 1 right is 
	bset 	#0,d0	        ; set right bit
	BRA.S	CHECK_Y_JOY2	; go to Y check
NODESTRA_JOY2:
	BTST	#2,D3		    ; left ?
	bne.S	CHECK_Y_JOY2    ; if 1 left is unpressed
	bset	#1,d0	        ; set left bit

CHECK_Y_JOY2:
    btst    #0,d3           ; up?
	bne.S	NOALTO_JOY2		; if 1 up is unpressed
	bset 	#2,d0	        ; set up bit
	BRA.S	ENDJOYST_JOY2   ; dont need anything more, exit
NOALTO_JOY2:
	BTST.l	#1,D3		    ; down?
	bne.S	ENDJOYST_JOY2	; dont need anything more, exit
	bset	#3,d0	        ; set down bit
ENDJOYST_JOY2:

	btst    #2,$bfd000	    ; fire pressed?
	bne.s				JOY2_NOFIREPRESSED
	bset 				#2,d0
JOY2_NOFIREPRESSED:
	RTS