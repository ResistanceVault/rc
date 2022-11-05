MOVE:
    movem.l d0/d1/d7/a0,-(sp)
    move.l a0,a2

    ; Limit the velocity to max speed of the car
    move.w MOVER_MAX_SPEED_OFFSET(a2),d7
    adda.w #MOVER_VELOCITY_OFFSET,a0
    jsr LIMIT2DVECTOR

    ; Add velocity to position
    move.l a2,a0
    move.l a2,a1
    adda.w #MOVER_VELOCITY_OFFSET,a0
    adda.w #MOVER_POSITION_OFFSET,a1
    ADD2DVECTOR

    ; Calculate new wheel position according to new position
    move.l a2,a0
    bsr.w CALCULATE_WHEEL_POSITIONS

    movem.l (sp)+,d0/d1/d7/a0
    rts