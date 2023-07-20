; ***** Move routine ****
; This routine updates the car position according to the velocity vector
; The wheel positions also will be updated
; Address register a0 must hold the CAR base address

MOVE:
    movem.l             d0/d1/d7/a0,-(sp)
    move.l              a0,a2

    ; Copy velocity into heading vector
    move.l              MOVER_VELOCITY_OFFSET(a2),MOVER_HEADING_OFFSET(a2)

    SETCARPROPERTYADDR  MOVER_HEADING_OFFSET,a0
    GET2DMAGNITUDE_Q4_12_TABLE_LOOKUP
    move.w              d0,MOVER_HEADING_MAGNITUDE(a2)

    ; Play sample at frequency relative to car speed
    IFD SOUND
    tst.w               PLAY_SOUND
	beq.s               nosound2

    
    ; get teammate ptr
    SETCARPROPERTYADDR  MOVER_TEAMMATE_CAR_PTR,a0
    move.l              (a0),a0


    ; get heading magnitude of teammate
    move.w              MOVER_HEADING_MAGNITUDE(a0),d1

    ; now whe have heading magnitude of the processing car into d0 and the same value for the teammate into d1
    ; process only if d0 >= d1
    IF_1_GREATER_EQ_2_W_U d0,d1,nosound2,s
                DEBUG 8888



    ; scale to the audio range
    moveq #0,d1
    move.w #CAR1_MAX_SPEED,d2
    move.w #0,d3
    move.w #200,d4
    jsr MAP
        DEBUG 9999
           
    STORECARPROPERTY    MOVER_SAMPLE_RATE,d1
    sub.w               d4,d1
    move.l 		        AUDIO_CHANNEL_ADDRESS_OFFSET(a2),a1
    move.w              d1,6(a1) ; set sample rate

    ; set volume
    move.w              MOVER_HEADING_MAGNITUDE(a2),d0
    add.w               MOVER_HEADING_MAGNITUDE(a0),d0

    moveq #0,d1
    move.w #CAR1_MAX_SPEED*2,d2
    move.w #10,d3
    move.w #64,d4
    jsr MAP

     DEBUG 1111

    move.w              d4,8(a1) ; set volume




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