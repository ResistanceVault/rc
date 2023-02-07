SPRITES_VSTART		   EQU  $2C
CAR_SPRITE_DEGREES     EQU 15

; Routine to point the correct sprite into copperlist
; Input: a0 base address of the car
CREATE_CAR_SPRITE:
    movem.l          a0/a1/d7,-(sp)
    movea.l          a0,a2

    ; Load the direction where the car is pointing (in degrees) into d7
    STORECARPROPERTY MOVER_STEER_DIRECTION_OFFSET,d7

    tst.w d7
    beq.s alessio
    DEBUG 1234
alessio:

    ; add CAR_SPRITE_DEGREES/2
    add.w            #CAR_SPRITE_DEGREES/2,d7

    ; divide by SPRITE_DEGREES, after that we have the sprite id into d7
    divu.w           #CAR_SPRITE_DEGREES,d7

    ; Point the car frame address
    SETCARPROPERTYADDR CAR_SPRITES_LIST_OFFSET,a1
    lsl.w            #2,d7
    adda.w           d7,a1

    ; compute X position
    move.l    	     (a1),a0
    STORECARPROPERTY MOVER_X_POSITION_OFFSET,d0
    STORECARPROPERTY MOVER_Y_POSITION_OFFSET,d1
    lsr.w            #DECIMAL_SHIFT,d0
    move.w           d0,d7 ; d7 holds the least sig bit to determine if the number is odd or even
    lsr.w            #1,d0
    asr.w            #DECIMAL_SHIFT,d1
    add.w            #60,d0
    add.w            #36,d1

    btst             #0,d7
    beq.s            car_no_odd_x
    bset             #0,3(a0)
    bra.s            car_place_coords
car_no_odd_x:
    bclr             #0,3(a0)
car_place_coords:
    move.b           d0,1(a0)
    move.b           d1,(a0)

    btst             #8,d1
    beq.s            car_y_vstartset
    bset.b           #2,3(a0)
    bra.s            car_y_gotovstop
car_y_vstartset:
    bclr.b           #2,3(a0)

car_y_gotovstop:
    add.w            #16,d1
    move.b           d1,2(a0)

    btst             #8,d1
    beq.s            car_y_vstopset
    bset.b           #1,3(a0)
    bra.s            car_y_end
car_y_vstopset:
    bclr.b           #1,3(a0)
car_y_end:

    move.l    	     (a1),d0
  	;lea       		 Sprite0pointers,a1
  	;SETCARPROPERTYADDR  CAR_SPRITE_POINTER_OFFSET,a1
    move.l           CAR_SPRITE_POINTER_OFFSET(a2),a1
    jsr       		 POINTINCOPPERLIST_FUNCT

    movem.l          (sp)+,a0/a1/d7
    rts