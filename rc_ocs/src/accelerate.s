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

    ; Update direction vector
    ; Load the direction where the car is pointing (in degrees) into d7
    STORECARPROPERTY MOVER_STEER_DIRECTION_OFFSET,d7

    ; Create a normalized vector in Q4,12 format into the acceleration vector
    SETCARPROPERTYADDR MOVER_ACCELERATION_OFFSET,a0
	CREATE2DVECTORFROMANGLE

    NORMALIZEVECTOR MOVER_ENGINE_POWER_OFFSET(a2),(a0)

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