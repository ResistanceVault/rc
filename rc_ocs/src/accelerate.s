; Accelerate routine
; Change velocity according to the acceleration vector
; Acceleration vector is scaled according to engine power
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

    SETCARPROPERTYADDR MOVER_ENGINE_POWER_OFFSET,a0
    SETCARPROPERTYADDR MOVER_ACCELERATION_OFFSET,a1
    DIV2DVECTOR1X2

    ; now the acceleration vector is scaled according to the engine power
    IFD DEBUG
    DV                  #160,#20,(a1),#1
    ENDC

    ; add accelleration to velocity
    SETCARPROPERTYADDR MOVER_ACCELERATION_OFFSET,a0  ; a0 now points to the acceleration vector
    SETCARPROPERTYADDR MOVER_VELOCITY_OFFSET,a1      ; a1 now points to the velocity vector

    ; a0 is set to car acceleration vector*engine_power
    ; a1 is set to car velocity vector
    ADD2DVECTOR

    SETCARPROPERTYADDR MOVER_VELOCITY_OFFSET,a0
    STORECARPROPERTY MOVER_MAX_SPEED_OFFSET,d7
    jsr LIMIT2DVECTOR

accellerate_end:
    movem.l (sp)+,a0/d7
    rts

