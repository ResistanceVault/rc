; Manage inputs from the player
; inputs are on d0 as following:
; - bit 0 : left is pressed
; - bit 1 : right is pressed
; - bit 2 : throttle is pressed
; - bit 3 : brake is pressed
; - a0 must point to the car object
MANAGE_INPUT:
    movem.l a0/d7,-(sp)
    move.l a0,a2

    ; manage acceleration
    move.w #0,MOVER_IS_ACCELERATING_OFFSET(a0)
    btst #2,d0
    beq.s manage_input_no_acceleration
    move.w #1,MOVER_IS_ACCELERATING_OFFSET(a0)
manage_input_no_acceleration:

    ; manage braking
    move.w #0,MOVER_IS_BRAKING_OFFSET(a0)
    btst #3,d0
    beq.s manage_input_no_brake
    move.w #1,MOVER_IS_BRAKING_OFFSET(a0)
manage_input_no_brake:

    ; if right is pressed steer direction += steering angle
    btst #0,d0
    beq.s manage_input_noright
    move.w MOVER_STEERING_ANGLE_OFFSET(a0),d1

    ; If we are on ice , maxvelocity /= 2
    tst.w              MOVER_IS_ON_ICE(a0)
    beq.s              nodoublesteer1
    lsl.w              #1,d1
nodoublesteer1:

    add.w  d1,MOVER_STEER_DIRECTION_OFFSET(a0)
manage_input_noright:

    ; if left is pressed steer direction -= steering angle
    btst #1,d0
    beq.s manage_input_noleft
    move.w MOVER_STEERING_ANGLE_OFFSET(a0),d1

    ; If we are on ice , maxvelocity /= 2
    tst.w              MOVER_IS_ON_ICE(a0)
    beq.s              nodoublesteer2
    lsl.w              #1,d1
nodoublesteer2

    sub.w  d1,MOVER_STEER_DIRECTION_OFFSET(a0)
manage_input_noleft:

    ; if steer_direction is negative add 360
    move.w MOVER_STEER_DIRECTION_OFFSET(a0),d0
    btst #15,MOVER_STEER_DIRECTION_OFFSET(a0)
    beq.s manage_input_direction_positive
    addi.w #360,MOVER_STEER_DIRECTION_OFFSET(a0)
manage_input_direction_positive:

    ; if steer direction is >= 360 subtract 360
    cmpi.w  #360,MOVER_STEER_DIRECTION_OFFSET(a0)
    blt.s manage_input_direction_ok
    subi.w #360,MOVER_STEER_DIRECTION_OFFSET(a0)
manage_input_direction_ok:

    ; Update direction vector
    move.w  MOVER_STEER_DIRECTION_OFFSET(a0),d7
	SETCARPROPERTYADDR MOVER_FORWARD_VECTOR_OFFSET,a0
	CREATE2DVECTORFROMANGLE
    move.w (a0),d7
	asr.w #11-DECIMAL_SHIFT,d7
	move.w d7,(a0)
	move.w 2(a0),d7
	asr.w #11-DECIMAL_SHIFT,d7
	move.w d7,2(a0)

    ;IFD DEBUG
    ;DV #80,#20,(a0),#1
    ;ENDC

    suba.w  #MOVER_FORWARD_VECTOR_OFFSET,a0

    movem.l (sp)+,a0/d7
    rts