INVERT_VELOCITY MACRO
    tst.w MOVER_IS_COLLIDING_OFFSET(a0)
    bne.s .mover_already_colliding
    neg.w MOVER_\1_VELOCITY_OFFSET(a0)
    move.w #1,MOVER_IS_COLLIDING_OFFSET(a0)
    move.w #$f00,$dff180
    moveq #1,d7
.mover_already_colliding
    ;bra.w check_collision_exit
    ENDM

CHECK_COLLISION_POINT:

    ; if x position is negative invert x velocity
    ;btst #15,d0
    ;beq.s check_collision_front_x_not_negative
    ;INVERT_VELOCITY X
    ;bra.w CHECK_COLLISION_POINT_END
;check_collision_front_x_not_negative:

    ; if x position is > WIDTH invert x velocity
    cmpi.w #WIDTH,d0
    bls.s check_collision_front_x_not_greater
    INVERT_VELOCITY X
    bra.w CHECK_COLLISION_POINT_END
check_collision_front_x_not_greater:

    cmpi.w #HEIGHT,d1
    bls.s check_collision_front_y_not_greater
    INVERT_VELOCITY Y
    bra.w CHECK_COLLISION_POINT_END
check_collision_front_y_not_greater:

CHECK_COLLISION_POINT_END:
    rts


CHECK_COLLISIONS:
    movem.l d0/d1,-(sp)

    moveq #0,d7  ; we will use this register to detect if the velocity has been reverted

    ; START OF FRONT WHEEL
    ; save position of the front wheel of mover object into data register
    ; and check if inside screen
    move.w MOVER_FRONT_WHEEL_X_VECTOR_OFFSET(a0),d0
    move.w MOVER_FRONT_WHEEL_Y_VECTOR_OFFSET(a0),d1
    lsr.w #DECIMAL_SHIFT,d0
    lsr.w #DECIMAL_SHIFT,d1
    bsr.w  CHECK_COLLISION_POINT
    tst.w  d7
    bne.w  check_collision_exit

    IFD COLLISIONS_STRICT
    move.w MOVER_BACK_WHEEL_X_VECTOR_OFFSET(a0),d0
    move.w MOVER_BACK_WHEEL_Y_VECTOR_OFFSET(a0),d1
    lsr.w #DECIMAL_SHIFT,d0
    lsr.w #DECIMAL_SHIFT,d1
    bsr.w  CHECK_COLLISION_POINT
    tst.w  d7
    bne.w  check_collision_exit
    ENDC

    ;move.w MOVER_FRONT_WHEEL_Y_VECTOR_OFFSET(a0),d0
    ;bsr.w  CHECK_COLLISION_POINT

    IFD LOL
    ; if x position is negative invert x velocity
    btst #15,d0
    beq.s check_collision_front_x_not_negative
    INVERT_VELOCITY X
check_collision_front_x_not_negative:

    ; if x position is >= WIDTH OF THE SCREEN invert x velocity
    cmpi.w #WIDTH*DECIMAL_MULTIPLIER,d0
    blt.s check_collision_front_x_not_greater
    ;INVERT_VELOCITY X
    nop
check_collision_front_x_not_greater:

    ; if y position is negative invert y velocity
    btst #15,d1
    beq.s check_collision_front_y_not_negative
    INVERT_VELOCITY Y
check_collision_front_y_not_negative:

    ; if y position is greather than screen HEIGHT invert y velocity
    cmpi.w #HEIGHT*DECIMAL_MULTIPLIER,d1
    bge.s check_collision_front_y_not_greater
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
    cmpi.w #WIDTH*DECIMAL_MULTIPLIER,d0
    bge.s check_collision_back_x_not_greater
    INVERT_VELOCITY X
check_collision_back_x_not_greater:

    ; if y position is negative invert y velocity
    btst #15,d1
    beq.s check_collision_back_y_not_negative
    INVERT_VELOCITY Y
check_collision_back_y_not_negative:

    ; if y position is greater than screen HEIGHT invert y velocity
    cmpi.w #HEIGHT*DECIMAL_MULTIPLIER,d1
    bge.s check_collision_back_y_not_greater
    INVERT_VELOCITY Y
    nop
check_collision_back_y_not_greater:
    ENDC


    ; if i get here it means it's not colliding
    move.w #0,MOVER_IS_COLLIDING_OFFSET(a0)
    move.w #$000,$dff180
check_collision_exit:
    movem.l (sp)+,d0/d1
    rts
