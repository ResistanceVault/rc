; friction routine: if both throttle and brake are NOT pressed
; the car must slow down anyway because we are sort of simulating
; earth gravity which is pressing the car on the ground.
; This must be represented with the velocity vector loosing some magnitude
; each frame. We will use friction factor to determine how much
; speed we lose.

FRICTION_VECTOR: dc.l 0

APPLY_FRICTION:

    tst.w   MOVER_IS_ACCELERATING_OFFSET(a0)
    bne.w   end_apply_friction

    tst.w   MOVER_IS_BRAKING_OFFSET(a0)
    bne.w   end_apply_friction

    movem.l a0/d7,-(sp)
    move.l  a2,a0

    ; friction vector = velocity vector * -1
    ; we need this to have the vector pointing to the opposite direction
    lea     FRICTION_VECTOR(PC),a0
    move.l  MOVER_VELOCITY_OFFSET(a2),(a0)
    neg.w   (a0)
    neg.w   2(a0)

    ;FRICTION_VECTOR now holds the opposite direction of VELOCITY VECTOR
    ; we must scale it according to friction factor
    move.w  MOVER_FRICTION_COEFFICIENT_OFFSET(a2),d7
    jsr     SET2DMAGNITUDE_Q4_12_TABLE_LOOKUP

    IFD DEBUG
    DV_DIV #20,#64,(a0),#4
    ENDC

    ; put velocity into a1
    SETCARPROPERTYADDR MOVER_VELOCITY_OFFSET,a1 ; a1 now points to the velocity vector

    ; a0 is set to friction vector
    ; a1 is set to car velocity vector
    ADD2DVECTOR

    movem.l (sp)+,a0/d7
end_apply_friction:
    rts
