CHECK_MAP:
    movem.l          a0/a1/d7,-(sp)
    move.l           a0,a2
    moveq            #0,d7

    ; Compute car coords
    STORECARPROPERTY MOVER_X_POSITION_OFFSET,d0
    STORECARPROPERTY MOVER_Y_POSITION_OFFSET,d1
    lsr.w            #DECIMAL_SHIFT,d0
    asr.w            #DECIMAL_SHIFT,d1

    DEBUG 1111
    bsr.w            GET_MAP_PIXEL_DATA
    bsr.w            SET_CAR_BEHAVIOUR
    tst.w            d0
    beq.s            end_check_track
    addq             #1,d7

    ; front wheel
    STORECARPROPERTY MOVER_FRONT_WHEEL_X_VECTOR_OFFSET,d0
    STORECARPROPERTY MOVER_FRONT_WHEEL_Y_VECTOR_OFFSET,d1
    lsr.w            #DECIMAL_SHIFT,d0
    asr.w            #DECIMAL_SHIFT,d1
    bsr.w            GET_MAP_PIXEL_DATA
    bsr.w            SET_CAR_BEHAVIOUR
    tst.w            d0
    beq.s            end_check_track
    addq             #1,d7

    ; back wheel
    STORECARPROPERTY MOVER_BACK_WHEEL_X_VECTOR_OFFSET,d0
    STORECARPROPERTY MOVER_BACK_WHEEL_Y_VECTOR_OFFSET,d1
    lsr.w            #DECIMAL_SHIFT,d0
    asr.w            #DECIMAL_SHIFT,d1
    bsr.w            GET_MAP_PIXEL_DATA
    bsr.w            SET_CAR_BEHAVIOUR
    tst.w            d0
    beq.s            end_check_track
    addq             #1,d7
end_check_track:

    cmpi.w           #3,d7
    bne.s            dontresetcolliding
    move.w           #0,MOVER_IS_COLLIDING_OFFSET(a2)
dontresetcolliding:

    movem.l          (sp)+,a0/a1/d7
    rts

;0000 0000 blocker
;0001 0001 zone 1 road
;0001 0002 zone 1 grass (slow)
;0001 0003 zone 1 ice (slippery)
GET_MAP_PIXEL_DATA:
     ; Load map metadata memory address
    lea              TRACK_METADATA,a1
    muls             #320,d1
    andi.l           #$0000FFFF,d0
    add.l            d0,d1
    adda.l           d1,a1
    move.b           (a1),d0
    rts

; tests d0 for the behaviour to apply
; if after routine call d0 is zero sto processing next wheel
SET_CAR_BEHAVIOUR:
    tst.b            d0
    bne.s            track_walkable
    move.w           #$fff,$dff180

    move.l           MOVER_PREVIOUS_POSITION_OFFSET(a2),MOVER_POSITION_OFFSET(a2)
    tst.w            MOVER_IS_COLLIDING_OFFSET(a2)
    bne.s            set_car_behaviour_end_checks
    neg.w            MOVER_X_VELOCITY_OFFSET(a2)
    neg.w            MOVER_Y_VELOCITY_OFFSET(a2)
    move.w           #1,MOVER_IS_COLLIDING_OFFSET(a2)
set_car_behaviour_end_checks:

    moveq            #0,d0
    rts
track_walkable:
    move.w           #$000,$dff180
    moveq            #1,d0
    rts