; Manage inputs from the player
; inputs are on d0 as following:
; - bit 0 : left is pressed
; - bit 1 : right is pressed
; - bit 2 : throttle is pressed
; - bit 3 : brake is pressed
; - a0 must point to the car object
MANAGE_INPUT:
    ; if left is pressed steer direction -= steering angle
    btst #0,d0
    beq.s manage_input_noleft
    move.w MOVER_STEERING_ANGLE_OFFSET(a0),d1
    sub.w  d1,MOVER_STEER_DIRECTION_OFFSET(a0)
manage_input_noleft:

     ; if right is pressed steer direction += steering angle
    btst #1,d0
    beq.s manage_input_noright
    move.w MOVER_STEERING_ANGLE_OFFSET(a0),d1
    add.w  d1,MOVER_STEER_DIRECTION_OFFSET(a0)
manage_input_noright:

    ; if steer_direction is negative add 360
    btst #15,MOVER_STEER_DIRECTION_OFFSET(a0)
    beq.s manage_input_direction_positive
    addi #360,MOVER_STEER_DIRECTION_OFFSET(a0)
manage_input_direction_positive:

    ; Update direction vector
    move.w  MOVER_STEER_DIRECTION_OFFSET(a0),d7
	adda.w  #MOVER_FORWARD_VECTOR_OFFSET,a0
	CREATE2DVECTORFROMANGLE
    suba.w  #MOVER_FORWARD_VECTOR_OFFSET,a0

    ; manage acceleration
    btst #3,d0
    move.w #0,MOVER_IS_ACCELERATING_OFFSET(a0)
    beq.s manage_input_no_acceleration
    move.w #1,MOVER_IS_ACCELERATING_OFFSET(a0)
manage_input_no_acceleration:

    ; manage braking
    btst #4,d0
    move.w #0,MOVER_IS_BRAKING_OFFSET(a0)
    beq.s manage_input_no_brake
    move.w #1,MOVER_IS_BRAKING_OFFSET(a0)
manage_input_no_brake:
    rts