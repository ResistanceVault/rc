; Accelerate routine
; Change velocity according to the acceleration vector
; acceleration vector is scaled according to engine power
; and takes direction from forward vector
; Car pointer must be in a0

ACCELERATE:
    movem.l a0/d7,-(sp)
    movea.l a0,a2

    ; if the car is not accellerating just exit (rts)
    tst.w MOVER_IS_ACCELERATING_OFFSET(a0)
    beq.w accellerate_end

    move.w #$FFF,$dff180

    ; the new acceleration is given by the
    ; forward vector multipled by engine power
    ;  this.accelleration = this.forward_vector.copy();
    movea.l a0,a1
    adda.w #MOVER_ACCELERATION_OFFSET,a1 ; a1 is now acceleration
    move.l MOVER_FORWARD_VECTOR_OFFSET(a2),(a1) ; copy forward vector into acceleration vector
    
    ; point a0 to engine power, ready for multiplication
    adda.w #MOVER_ENGINE_POWER_OFFSET,a0

    ; ready for multiplication
    ; a0 = engine_power
    ; a1 = car acceleration vector (here it's a copy of forward vector)
    MUL2DVECTOR1X2

    ; now the acceleration vector is scaled according to the engine power

    ; normalize resulting vector
    move.w (a1),d0
    asr.w #6,d0
    move.w d0,(a1)
    move.w 2(a1),d0
    asr.w #6,d0
    move.w d0,2(a1)

    IFD DEBUG
    DV #100,#20,(a1)
    ENDC

    ; add accelleration to velocity
    movea.l a1,a0 ; a0 now points to the acceleration vector
    movea.l a2,a1
    adda.w #MOVER_VELOCITY_OFFSET,a1 ; a2 now points to the velocity vector

    ; a0 is set to car accelleration vector*engine_power
    ; a1 is set to car velocity vector
    ADD2DVECTOR

    ; a0 is set to forward vector
    move.l a2,a0
    adda.w #MOVER_FORWARD_VECTOR_OFFSET,a0
    move.w (a0),d0
    move.w 2(a0),d1
    ;asr.w #7,d0
    ;asr.w #7,d1
    move.w d0,FRICTION_VECTOR
    move.w d1,FRICTION_VECTOR+2
    lea FRICTION_VECTOR,a0
    move.w #%111000,d7
    jsr SET2DMAGNITUDE_Q10_6_TABLE_LOOKUP
    ; a1 is set to car velocity vector
    ADD2DVECTOR
    
accellerate_end:
    movem.l (sp)+,a0/d7 
    rts