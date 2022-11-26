; Accelerate routine
; Change velocity according to the acceleration vector
; acceleration vector is scaled according to engine power
; and takes direction from forward vector
; Car pointer must be in a0

ACCELERATE:

    ; if the car is not accellerating just exit (rts)
    tst.w MOVER_IS_ACCELERATING_OFFSET(a0)
    bne.s do_acceleration
    rts
do_acceleration:

    movem.l a0/d7,-(sp)
    movea.l a0,a2

    ;move.w #$FFF,$dff180

    ; the new acceleration is given by the
    ; forward vector multipled by engine power
    ;  this.accelleration = this.forward_vector.copy();
    ;SETCARPROPERTYADDR MOVER_ACCELERATION_OFFSET,a1 ; a1 is now acceleration
    ;move.l MOVER_FORWARD_VECTOR_OFFSET(a2),(a1) ; copy forward vector into acceleration vector
    
    ; point a0 to engine power, ready for multiplication
    ;SETCARPROPERTYADDR MOVER_ENGINE_POWER_OFFSET,a0

    ; ready for multiplication
    ; a0 = engine_power
    ; a1 = car acceleration vector (here it's a copy of forward vector)
    ;MUL2DVECTOR1X2
    ;move.w (a1),d7
    ;asr.w #5,d7
    ;move.w d7,(a1)
    ;move.w 2(a1),d7
    ;asr.w #5,d7
    ;move.w d7,2(a1)
    ;move.w              MOVER_ENGINE_POWER_OFFSET(a2),d7
    ;SETCARPROPERTYADDR  MOVER_ACCELERATION_OFFSET,a0
    ;jsr                 SET2DMAGNITUDE_Q10_6_TABLE_LOOKUP

    ; Update direction vector
    move.w  MOVER_STEER_DIRECTION_OFFSET(a0),d7
	SETCARPROPERTYADDR MOVER_ACCELERATION_OFFSET,a0
	CREATE2DVECTORFROMANGLE
    move.w (a0),d7
	asr.w #8,d7
    asr.w #1,d7
	move.w d7,(a0)
	move.w 2(a0),d7
	asr.w #8,d7
    asr.w #1,d7
	move.w d7,2(a0)

    ; now the acceleration vector is scaled according to the engine power
    IFD DEBUG
    DV                  #160,#20,(a0),#1 ; prima fila centrale
    ENDC

    ; add accelleration to velocity
    SETCARPROPERTYADDR MOVER_ACCELERATION_OFFSET,a0  ; a0 now points to the acceleration vector
    SETCARPROPERTYADDR MOVER_VELOCITY_OFFSET,a1             ; a1 now points to the velocity vector

    ; a0 is set to car acceleration vector*engine_power
    ; a1 is set to car velocity vector
    BTST    #2,$dff016
    bne.s alessiosalta
    DEBUG 7777
    ADD2DVECTOR
    move.w MOVER_MAX_SPEED_OFFSET(a2),d7
    DEBUG 8888
    bra.s alessiofine
alessiosalta:
    ADD2DVECTOR
alessiofine:

    IFD DEBUG
    DV #240,#20,(a1),#1
    ENDC
    
accellerate_end:
    movem.l (sp)+,a0/d7
    rts