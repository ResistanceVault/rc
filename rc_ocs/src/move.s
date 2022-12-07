; ***** Move routine ****
; This routine updates the car position according to the velocity vector
; The wheel positions also will be updated
; Address register a0 must hold the CAR base address

MOVE:
    movem.l d0/d1/d7/a0,-(sp)
    move.l a0,a2

    ; Copy velocity into heading vector
    move.l MOVER_VELOCITY_OFFSET(a2),MOVER_HEADING_OFFSET(a2)

    ;Velocity is Q4,12 format but POSITION is Q16,6 format - normalize HEADING
    SETCARPROPERTYADDR MOVER_HEADING_OFFSET,a0
    NORMALIZEVECTOR #6,(a0)

    ; If debug mode show the velocity vector at the center of the screen
    IFD DEBUG
    SETCARPROPERTYADDR MOVER_HEADING_OFFSET,a0
    DV #WIDTH/2,#HEIGHT/2,(a0),#1
    ENDC

    ; Add velocity to position
    SETCARPROPERTYADDR MOVER_HEADING_OFFSET,a0
    SETCARPROPERTYADDR MOVER_POSITION_OFFSET,a1
    ADD2DVECTOR

    ; Calculate new wheel position according to new position
    move.l a2,a0
    bsr.w CALCULATE_WHEEL_POSITIONS

    movem.l (sp)+,d0/d1/d7/a0
    rts