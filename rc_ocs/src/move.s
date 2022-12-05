DIFF_VECTOR: dc.l 0
DIFF_VECTOR2: dc.l 0
MOVE_MAG: dc.w 0
MOVE:
    movem.l d0/d1/d7/a0,-(sp)
    move.l a0,a2

    
    ; Limit the velocity to max speed of the car
    ;move.w MOVER_MAX_SPEED_OFFSET(a2),d7
    ;SETCARPROPERTYADDR MOVER_VELOCITY_OFFSET,a0
    ;jsr LIMIT2DVECTOR
    
    
    move.l MOVER_VELOCITY_OFFSET(a2),ALESSIO1

    lea ALESSIO1,a0
    NORMALIZEVECTOR #6,(a0)
    
   ; move.w MOVER_MAX_SPEED_OFFSET(a2),d7
   ; lea ALESSIO1,a0
   ; jsr LIMIT2DVECTOR

    IFD DEBUG
    lea ALESSIO1,a0
    DV #WIDTH/2,#HEIGHT/2,(a0),#1
    ENDC
    ;DEBUG 9999


    ; Add velocity to position
    lea ALESSIO1,a0
    SETCARPROPERTYADDR MOVER_POSITION_OFFSET,a1
    ADD2DVECTOR

    ; Calculate new wheel position according to new position
    move.l a2,a0
    bsr.w CALCULATE_WHEEL_POSITIONS

    movem.l (sp)+,d0/d1/d7/a0
    rts

ALESSIO1: dc.l 0