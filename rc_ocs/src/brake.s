; brake routine
; if the car is braking it must slow down according to brake coefficient
BRAKE_VECTOR: dc.l 0
BRAKE:
    tst.w MOVER_IS_BRAKING_OFFSET(a0)
    beq.s end_brake    

    movem.l a0/d7,-(sp)
    move.l a2,a0

    ; brake vector = velocity vector * -1
    lea BRAKE_VECTOR(PC),a0
    move.w MOVER_X_VELOCITY_OFFSET(a2),d0
    move.w MOVER_Y_VELOCITY_OFFSET(a2),d1
    neg.w  d0
    neg.w  d1
    

    ;BRAKE_VECTOR now holds the opposite direction of VELOCITY VECTOR
    ; we must scale it according to brake factor
    lea BRAKE_VECTOR,a0
    move.w d0,(a0)
    move.w d1,2(a0)

    move.w               #%100000000,d7
    jsr SET2DMAGNITUDE_Q4_12_TABLE_LOOKUP

    IFD DEBUG
    DV_DIV #20,#64,(a0),#4
    ENDC
    
    ; put velocity into a1
    SETCARPROPERTYADDR MOVER_VELOCITY_OFFSET,a1 ; a2 now points to the velocity vector

    ; a0 is set to brake vector
    ; a1 is set to car velocity vector
    ADD2DVECTOR

    movem.l (sp)+,a0/d7 
end_brake:
    rts