CHECK_MAP:
    movem.l          a0/a1/d7,-(sp)
    move.l           a0,a2
    moveq            #0,d7

    ; Compute car coords
    STORECARPROPERTY MOVER_X_POSITION_OFFSET,d0
    STORECARPROPERTY MOVER_Y_POSITION_OFFSET,d1
    lsr.w            #DECIMAL_SHIFT,d0
    asr.w            #DECIMAL_SHIFT,d1

    bsr.w            GET_MAP_PIXEL_DATA

    ; set flags relative to terrain
    bsr.w            SET_TERRAIN_FLAGS

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
    move.w           d0,CAR_FRONT_WHEEL_TRACK_PIXEL_DATA_OFFSET(a2) ; save information about where the front wheel is in the map
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
    bne.w            dontresetcolliding

    ; if we are here it means the front wheel, the rear wheel and the back wheel position are on a walkable space
    ; in this case we reset MOVER_IS_COLLIDING_OFFSET
    move.w           #0,MOVER_IS_COLLIDING_OFFSET(a2)

    ; detect the zone of the car
    ; copy d0 which holds the zone in the upper nibble of the least significant byte into d1 then shift to the right
    ; for 4 position to move data from high nibble to low nibble
    STORECARPROPERTY CAR_FRONT_WHEEL_TRACK_PIXEL_DATA_OFFSET,d0

    ; put red intensity according to this value for debug
    move.w d0,d1
    andi.w #$00F0,d1
    lsl.w #4,d1
    move.w d1,$dff180

    ; check if next zone has been reached
    move.w d0,d1
    andi.w #$00F0,d1
    lsr.w #4,d1
    cmp.w CAR_NEXT_ZONE_OFFSET(a2),d1
    bne.s no_next_zone_update
    move.w CAR_NEXT_ZONE_OFFSET(a2),d2

    ; here manage next zone update
    addi.w #1,CAR_NEXT_ZONE_OFFSET(a2)

    cmpi.w #2,CAR_NEXT_ZONE_OFFSET(a2)
    bne.s lap_not_completed
    ; start managing lap completed
    
    ; update best lap timer if not first lap
    tst.w LAP_COUNTER_OFFSET(a2)
    beq.s noupdatebesttime
    move.w TIME_OFFSET(a2),d0
    cmp.w BEST_TIME_OFFSET(a2),d0
    bcc.s noupdatebesttime
    move.w d0,BEST_TIME_OFFSET(a2)
    jsr UPDATE_BEST_TIMER
noupdatebesttime:
    ; reset timer
    move.w #0,TIME_OFFSET(a2)

    ; increase lap counter
    addi.w #1,LAP_COUNTER_OFFSET(a2)
    jsr UPDATE_LAP_COUNTER_HID
    cmp.w #5,LAP_COUNTER_OFFSET(a2)
    bne.s lap_not_completed
    move.w #1,RACE_STATUS
lap_not_completed:

    ; if next zone is last zone reset to 1 to start another lap
    moveq #0,d1
    move.w TRACK_START_PIXEL_DATA,d1
    lsr.w #4,d1
    move.w CAR_NEXT_ZONE_OFFSET(a2),d2
    cmp.w CAR_NEXT_ZONE_OFFSET(a2),d1
    bne.s no_next_zone_update
    ; I reach this part only when entering LAST zone
    move.w #1,CAR_NEXT_ZONE_OFFSET(a2)
    ;DEBUG 1111
no_next_zone_update:

dontresetcolliding:

    movem.l          (sp)+,a0/a1/d7
    rts

;0000 0000 blocker
;0001 0000 zone 1 road
;0001 0001 zone 1 grass (slow)
;0001 0002 zone 1 ice (slippery)
;0010 0000 zone 1 road
;0010 0001 zone 1 grass (slow)
;0010 0002 zone 1 ice (slippery)
;....
;1111 0000 zone 15 road
;1111 0001 zone 15 grass (slow)
;1111 0002 zone 15 ice (slippery)
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
; if after routine call d0 is zero I am processing next wheel
SET_CAR_BEHAVIOUR:
    tst.b            d0
    bne.s            track_walkable

    ; manage a car hitting an obstacle
    move.w           #$fff,$dff180
    move.l           MOVER_PREVIOUS_POSITION_OFFSET(a2),MOVER_POSITION_OFFSET(a2)
    tst.w            MOVER_IS_COLLIDING_OFFSET(a2)
    bne.s            set_car_behaviour_end_checks

    ;neg.w            MOVER_X_VELOCITY_OFFSET(a2)
    ;neg.w            MOVER_Y_VELOCITY_OFFSET(a2)
    ;move.w MOVER_X_VELOCITY_OFFSET(a2),d0
    ;move.w MOVER_Y_VELOCITY_OFFSET(a2),d1
    ;asr.w #1,d0
    ;asr.w #1,d1
    ;move.w d0,MOVER_X_VELOCITY_OFFSET(a2)
    ;move.w d1,MOVER_Y_VELOCITY_OFFSET(a2)
    ;asr.w            #1,MOVER_X_VELOCITY_OFFSET(a2)

    SETCARPROPERTYADDR MOVER_BOUNCE_WALL_OFFSET,a0
    SETCARPROPERTYADDR MOVER_VELOCITY_OFFSET,a1
    MUL2DVECTOR1X2_Q4_12
    move.w           #1,MOVER_IS_COLLIDING_OFFSET(a2)
set_car_behaviour_end_checks:

    moveq            #0,d0
    rts
track_walkable:
    moveq            #1,d0
    rts

SET_TERRAIN_FLAGS:
    move.l           d0,d1
    andi.b           #%00001111,d1 ; i keep only the lower part of the nibble
    ;DEBUG 4567
    cmpi.b           #1,d1      ; check if we are on grass
    bne.s            set_terrain_flags_no_grass
    move.w           #1,MOVER_IS_ON_GRASS(a2)
    move.w           #0,MOVER_IS_ON_ICE(a2)
    move.w #$00F0,$dff180
    rts
set_terrain_flags_no_grass:
    cmpi.b           #2,d1      ; check if we are on ice
    bne.s            set_terrain_flags_no_ice
    move.w           #1,MOVER_IS_ON_ICE(a2)
    move.w           #0,MOVER_IS_ON_GRASS(a2)
    move.w #$0fff,$dff180
    rts
set_terrain_flags_no_ice:

    ; is we are here it mens no grass an no ice , the default is road
    move.w           #0,MOVER_IS_ON_ICE(a2)
    move.w           #0,MOVER_IS_ON_GRASS(a2)
    move.w #$0000,$dff180
    rts