; Accellerate routine
; Change velocity according to the accelleration vector
; Car pointer in a0

ACCELERATE_VECTOR_1: dc.l 0

ACCELERATE:
    movem.l a0/d7,-(sp)
    move.l a0,a2

    ; if the car is not accellerating just exit (rts)
    tst.w MOVER_IS_ACCELERATING_OFFSET(a0)
    beq.s accellerate_end

    ; the new accelleration is given by the
    ; forward vector multipled by engine power / 128
    move.l a0,a1
    adda.w #MOVER_ACCELERATION_OFFSET,a1
    move.l MOVER_FORWARD_VECTOR_OFFSET(a2),(a1)
    move.w MOVER_ENGINE_POWER_OFFSET(a2),d7
    lsr.w #7,d7 ; divide by 128
    lea ACCELERATE_VECTOR_1,a0
    move.w d7,(a0)
    move.w d7,2(a0)
    MUL2DVECTOR

    ; add accelleration to velocity
    ; a0 is already set
    move.l a2,a1
    adda.w #MOVER_VELOCITY_OFFSET,a1
    ADD2DVECTOR
    
accellerate_end:
    movem.l (sp)+,a0/d7 
    rts