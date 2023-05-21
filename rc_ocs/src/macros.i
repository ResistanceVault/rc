; Macro to store addr of a car property into an address register
; Usage : SETCARPROPERTYADDR,offset addr_register
; Example: SETCARPROPERTYADDR MOVER_ACCELERATION_VECTOR_OFFSET,a0
SETCARPROPERTYADDR MACRO
	movea.l		a2,\2
	adda.w		#\1,\2
	ENDM

; Macro to store a word from a car property into a data register
; Usage : STORECARPROPERTY,data_register
; Example : STORECARPROPERTY MOVER_STEER_DIRECTION_OFFSET,d7
STORECARPROPERTY MACRO
	move.w  \1(a2),\2
	ENDM

; Macro to normalize vector (d6 and d7 will be trashed)
; Usage : NORMALIZEVECTOR shifts,addr
; Example : NORMALIZEVECTOR #9,(a0)
NORMALIZEVECTOR MACRO
    move.w \1,d6
    move.w \2,d7
	asr.w d6,d7
	move.w d7,\2
	move.w 2\2,d7
	asr.w d6,d7
	move.w d7,2\2
    ENDM

MEMCPY4 MACRO
	move.l #\3,d7
	subq   #1,d7
	lea \1,a0
	lea \2,a1
.1\@
	move.l (a0)+,(a1)+
	dbra d7,.1\@
	ENDM

BZERO4 MACRO
	move.l #\2,d7
	subq   #1,d7
	lea \1,a0
.1\@
	clr.l (a0)+
	dbra d7,.1\@
	ENDM