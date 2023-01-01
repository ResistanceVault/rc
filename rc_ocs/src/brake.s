; brake routine
; if the car is braking it must slow down according to brake coefficient
BRAKE_VECTOR: dc.l 0
BRAKE:
    tst.w               MOVER_IS_BRAKING_OFFSET(a0)
    beq.s               end_brake

    movem.l             a0/d7,-(sp)
    move.l              a2,a0

    ; brake vector = velocity vector * -1
    lea                 BRAKE_VECTOR(PC),a0
    move.l              MOVER_VELOCITY_OFFSET(a2),(a0)
    neg.w               (a0)
    neg.w               2(a0)

    ;BRAKE_VECTOR now holds the opposite direction of VELOCITY VECTOR
    ; we must scale it according to brake factor

    ; set magnitude of brake vector according to the car brake coefficient
    STORECARPROPERTY    MOVER_BRAKE_COEFFICIENT_OFFSET,d7
    jsr                 SET2DMAGNITUDE_Q4_12_TABLE_LOOKUP

    IFD DEBUG
    DV_DIV              #20,#64,(a0),#4
    ENDC

    ; put velocity into a1
    SETCARPROPERTYADDR  MOVER_VELOCITY_OFFSET,a1 ; a1 now points to the velocity vector

    ; a0 is set to brake vector
    ; a1 is set to car velocity vector
    ADD2DVECTOR

    movem.l             (sp)+,a0/d7
end_brake:
    rts