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
    
    ; Create a vector with engine power on both X and Y
    ; and point it into a0 ready for multiplication
    move.w MOVER_ENGINE_POWER_OFFSET(a2),d7
    lsr.w #7,d7 ; divide by 128
    lea ACCELERATE_VECTOR_1,a0
    move.w d7,(a0)
    move.w d7,2(a0)

    ; ready for multiplication
    ; a0 = V(engine_power/128,engine_power/128)
    ; a1 = car accelleration vector (here it's a copy of forward vector)
    DEBUG 1112
    MUL2DVECTOR

    ; normalize resulting vector
    move.w (a1),d0
    asr.w #6,d0
    move.w d0,(a1)
    move.w 2(a1),d0
    asr.w #6,d0
    move.w d0,2(a1)

    ; add accelleration to velocity
    move.l a1,a0
    move.l a2,a1
    adda.w #MOVER_VELOCITY_OFFSET,a1

    ; a0 is set to car accelleration vector*engine_power/128
    ; a1 is set to car velocity vector
    ADD2DVECTOR
    
accellerate_end:
    movem.l (sp)+,a0/d7 
    rts