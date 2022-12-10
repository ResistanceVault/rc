CAR_SPRITE_DEGREES EQU 180

CAR_SPRITES_LIST:
    dc.l             CAR_0
    dc.l             CAR_180
    dc.l             CAR_0

; Routine to point the correct sprite into copperlist
; Input: a0 base address of the car
CREATE_CAR_SPRITE:
    movem.l          a0/a1/d7,-(sp)
    movea.l          a0,a2

    ; Load the direction where the car is pointing (in degrees) into d7
    STORECARPROPERTY MOVER_STEER_DIRECTION_OFFSET,d7

    ; add CAR_SPRITE_DEGREES/2
    add.w            #CAR_SPRITE_DEGREES/2,d7

    ; divide by SPRITE_DEGREES, after that we have the sprite id into d7
    divu.w           #CAR_SPRITE_DEGREES,d7

    ; Point the car frame address
    lea              CAR_SPRITES_LIST(PC),a1
    lsl.w            #2,d7
    adda.w           d7,a1

    move.l    	     (a1),d0
  	lea       		   Sprite0pointers,a1
  	jsr       		   POINTINCOPPERLIST_FUNCT

    movem.l          (sp)+,a0/a1/d7
    rts