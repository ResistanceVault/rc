INVERT_VELOCITY MACRO
    tst.w MOVER_IS_COLLIDING_OFFSET(a0)
    bne.s .mover_already_colliding
    neg.w MOVER_\1_VELOCITY_OFFSET(a0)
    move.w #1,MOVER_IS_COLLIDING_OFFSET(a0)
    move.w #$f00,$dff180
.mover_already_colliding
    bra.w check_collision_exit
    ENDM

CHECK_COLLISIONS:
    movem.l d0/d1,-(sp)
    ; START OF FRONT WHEEL

    ; save position of the front wheel of mover object into data registers
    move.w MOVER_FRONT_WHEEL_X_VECTOR_OFFSET(a0),d0
    move.w MOVER_FRONT_WHEEL_Y_VECTOR_OFFSET(a0),d1

    ; if x position is negative invert x velocity
    btst #15,d0
    beq.s check_collision_front_x_not_negative
    INVERT_VELOCITY X
check_collision_front_x_not_negative:

    ; if x position is >= WIDTH OF THE SCREEN invert x velocity
    cmpi.w #WIDTH*64,d0
    blt.s check_collision_front_x_not_greater
    INVERT_VELOCITY X
check_collision_front_x_not_greater:

    ; if y position is negative invert y velocity
    btst #15,d1
    beq.s check_collision_front_y_not_negative
    INVERT_VELOCITY Y
check_collision_front_y_not_negative:

    ; if y position is greather than screen HEIGHT invert y velocity
    cmpi.w #HEIGHT*64,d1
    blt.s check_collision_front_y_not_greater
    INVERT_VELOCITY Y
check_collision_front_y_not_greater:

    ; START OF BACK WHEEL

    ; save position of the front wheel of mover object into data registers
    move.w MOVER_BACK_WHEEL_X_VECTOR_OFFSET(a0),d0
    move.w MOVER_BACK_WHEEL_Y_VECTOR_OFFSET(a0),d1

    ; if x position is negative invert velocity
    btst #15,d0
    beq.s check_collision_back_x_not_negative
    INVERT_VELOCITY X
check_collision_back_x_not_negative:

    ; if x position is >= WIDTH OF THE SCREEN invert x velocity
    cmpi.w #WIDTH*64,d0
    blt.s check_collision_back_x_not_greater
    INVERT_VELOCITY X
check_collision_back_x_not_greater:

    ; if y position is negative invert y velocity
    btst #15,d1
    beq.s check_collision_back_y_not_negative
    INVERT_VELOCITY Y
check_collision_back_y_not_negative:

    ; if y position is greather than screen HEIGHT invert y velocity
    cmpi.w #HEIGHT*64,d1
    blt.s check_collision_back_y_not_greater
    INVERT_VELOCITY Y
check_collision_back_y_not_greater:

    ; if i get here it means it's not colliding
    move.w #0,MOVER_IS_COLLIDING_OFFSET(a0)
    move.w #$000,$dff180
check_collision_exit:
    movem.l (sp)+,d0/d1
    rts
