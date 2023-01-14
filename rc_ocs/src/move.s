; ***** Move routine ****
; This routine updates the car position according to the velocity vector
; The wheel positions also will be updated
; Address register a0 must hold the CAR base address

MOVE:
    movem.l             d0/d1/d7/a0,-(sp)
    move.l              a0,a2

    ; Copy velocity into heading vector
    move.l              MOVER_VELOCITY_OFFSET(a2),MOVER_HEADING_OFFSET(a2)

    ; Play sample at frequency relative to car speed
    IFD SOUND
    tst.w               PLAY_SOUND
	beq.s               nosound2
    SETCARPROPERTYADDR  MOVER_HEADING_OFFSET,a0
    GET2DMAGNITUDE_Q4_12_TABLE_LOOKUP
    move.w              #$FFFF,d1
    lsl.w               #2,d0
    sub.w               d0,d1
    move.l 		        AUDIO_CHANNEL_ADDRESS_OFFSET(a2),a1
    move.w              d1,6(a1)
nosound2:
    ENDC

    ;Velocity is Q4,12 format but POSITION is Q16,6 format - normalize HEADING
    SETCARPROPERTYADDR  MOVER_HEADING_OFFSET,a0
    NORMALIZEVECTOR     #6,(a0)

    ; If debug mode show the velocity vector at the center of the screen
    IFD DEBUG
    SETCARPROPERTYADDR  MOVER_HEADING_OFFSET,a0
    DV                  #WIDTH/2,#HEIGHT/2,(a0),#1
    ENDC

    ; Save old position into previous position
    move.l              MOVER_POSITION_OFFSET(a2),MOVER_PREVIOUS_POSITION_OFFSET(a2)

    ; Add velocity to position
    SETCARPROPERTYADDR  MOVER_HEADING_OFFSET,a0
    SETCARPROPERTYADDR  MOVER_POSITION_OFFSET,a1
    ADD2DVECTOR

    ; Calculate new wheel position according to new position
    move.l              a2,a0
    bsr.w               CALCULATE_WHEEL_POSITIONS

    movem.l             (sp)+,d0/d1/d7/a0
    rts