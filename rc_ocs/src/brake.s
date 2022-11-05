; brake routine
; if the car is braking it must slow down according to brake coefficient
BRAKE_VECTOR: dc.l 0
BRAKE:
    tst.w MOVER_IS_BRAKING_OFFSET(a0)
    beq.s end_brake


    move.w #$0f0,$dff180

    movem.l a0/d7,-(sp)
    move.l a2,a0

    ; brake vector = velocity vector * -1
    lea BRAKE_VECTOR(PC),a1
    move.l MOVER_VELOCITY_OFFSET(a0),(a1)
    neg.w (a1)
    neg.w 2(a1)

    ;BRAKE_VECTOR now holds the opposite direction of VELOCITY VECTOR
    ; we must scale it according to brake factor
    move.l a1,a0
    move.w MOVER_BRAKE_COEFFICIENT_OFFSET(a2),d7
    jsr SET2DMAGNITUDE

    ; put velocity into a1
    move.l a2,a1
    adda.w #MOVER_VELOCITY_OFFSET,a1 ; a2 now points to the velocity vector

    ; a0 is set to brake vector
    ; a1 is set to car velocity vector
    ADD2DVECTOR

    movem.l (sp)+,a0/d7 
end_brake:
    rts