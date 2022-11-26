DIFF_VECTOR: dc.l 0
DIFF_VECTOR2: dc.l 0
MOVE_MAG: dc.w 0
MOVE:
    movem.l d0/d1/d7/a0,-(sp)
    move.l a0,a2

    IFD LOL
    ; drifting vector 1: direction of the vector with magnitude relative to velocity
    ;let heading_vector = this.forward_vector.copy();
    ;DEBUG 1230
    move.l MOVER_FORWARD_VECTOR_OFFSET(a2),MOVER_HEADING_OFFSET(a2)
    ;heading_vector.mult(this.velocity.mag() / 1); // drift adjust
    adda.w #MOVER_VELOCITY_OFFSET,a0
    GET2DMAGNITUDE_Q10_6_TABLE_LOOKUP

    ; d0 now holds the magnitude of velocity, set it into MOVE_MAG
    lea MOVE_MAG(PC),a0
    move.w d0,(a0)

    ; a0 is the magnitude scalar value
    ; a1 must be the heading vector
    move.l a2,a1
    adda.w #MOVER_HEADING_OFFSET,a1
    ; MULIPLY (Scale forward vector according to the velocity)
    MUL2DVECTOR1X2
    ; normalize
    move.w (a1),d0
    asr.w #6,d0
    move.w d0,(a1)+
    move.w (a1),d0
    asr.w #6,d0
    move.w d0,(a1)+

    ;let diff_vector = heading_vector.copy();
    move.l MOVER_HEADING_OFFSET(a2),DIFF_VECTOR

    ; sub - diff_vector.sub(this.velocity);
    ; diffvector2 = diffvector - velocityvector
    lea DIFF_VECTOR,a0
    move.l a2,a1
    adda.w #MOVER_VELOCITY_OFFSET,a1
        ;DEBUG 6666

    SUB2DVECTORSTATIC DIFF_VECTOR2
    lea DIFF_VECTOR2,a0
    ;DEBUG 6666

    ; diff_vector.div(256);
    ; normalize
    move.w (a0),d0
    asr.w #3,d0
    move.w d0,(a0)+
    move.w (a0),d0
    asr.w #3,d0
    move.w d0,(a0)+

    ; add diff vector 2 velocity
    lea DIFF_VECTOR2,a0
    move.l a2,a1
    adda.w #MOVER_VELOCITY_OFFSET,a1
    ;DEBUG 7777
    ADD2DVECTOR
    ;DEBUG 7778

    ENDC
    ; Limit the velocity to max speed of the car
    move.w MOVER_MAX_SPEED_OFFSET(a2),d7
    SETCARPROPERTYADDR MOVER_VELOCITY_OFFSET,a0
    jsr LIMIT2DVECTOR
    
    IFD DEBUG
    DV #WIDTH/2,#HEIGHT/2,(a0),#1
    ENDC
    ;DEBUG 9999

    ; Add velocity to position
    SETCARPROPERTYADDR MOVER_VELOCITY_OFFSET,a0
    SETCARPROPERTYADDR MOVER_POSITION_OFFSET,a1
    ADD2DVECTOR

    ; Calculate new wheel position according to new position
    move.l a2,a0
    bsr.w CALCULATE_WHEEL_POSITIONS

    movem.l (sp)+,d0/d1/d7/a0
    rts