; this routine check if car pointed in a0 collides with
; car pointed in a1
DISTANCE_BETWEEN_CENTERS: dc.l 0
SEPARATION_VECTOR:      dc.l 0
CHECK_COLLISIONS_WITH_OTHER_CAR:
    movea.l             a0,a2
    movea.l             a1,a3

    ; distance vector between 2 cars
    adda.l              #MOVER_POSITION_OFFSET,a0
    adda.l              #MOVER_POSITION_OFFSET,a1
    SUB2DVECTORSTATIC   DISTANCE_BETWEEN_CENTERS

    movea.l             a2,a0
    movea.l             a3,a1

    ; get absolute values for the vector
    ABS_WORD            DISTANCE_BETWEEN_CENTERS ; absolute x distance
    ABS_WORD            DISTANCE_BETWEEN_CENTERS+2 ; absolute y distance

    ; get half width for car 1 + half width of car 2
    ;let shw = this.wheel_base/2 + othercar.wheel_base/2;
    move.w              MOVER_WHEEL_BASE_OFFSET(a2),d0
    move.w              MOVER_WHEEL_BASE_OFFSET(a3),d1
    add.w               d1,d0
    lsl.w               #6,d0

    ; half height sum
    ;let shh = this.wheel_base/2 + othercar.wheel_base/2;
    move.w              MOVER_WIDTH_DIV_2_OFFSET(a2),d2
    move.w              MOVER_WIDTH_DIV_2_OFFSET(a2),d3
    add.w               d3,d2
    lsl.w               #6,d2

    ; if abs X value of distance vector is < then sum of half width of the 2 cars 
    ; I am sure they are not colliding, in this case just branch to car not collision
    ;move.w          #$0,$dff180
    cmp.w               DISTANCE_BETWEEN_CENTERS,d0
    bls.w               nocarcollision

    ; if abs Y value of distance vector is < then sum of half height of the 2 cars 
    ; I am sure they are not colliding, in this case just branch to car not collision
    cmp.w               DISTANCE_BETWEEN_CENTERS+2,d2
    bls.w               nocarcollision

    ; if we are here, it means car pointed in a0 is colliding with car in a1 (and car a1 is colliding with car in a0)
    ; we must now resove the collision

    ; sx = sum of car widths / 2 - x absolute distance (which is on d0) ==> result in d1
    move.w              d0,d1
    sub.w               DISTANCE_BETWEEN_CENTERS,d1 ; d1 = sx

    ; sy = sum of car heights / 2 - y absolute distance (which is on d2) ==> result in d3
    move.w              d2,d3
    sub.w               DISTANCE_BETWEEN_CENTERS+2,d3 ; d3 = sy

    ; compare sx with sy, if sx is smaller, reset
    cmp.w               d1,d3
    ble.s               sxgreaterthansy
    moveq               #0,d3
    bra.s               correctsign
sxgreaterthansy:
    moveq               #0,d1
correctsign:
    move.w              MOVER_X_POSITION_OFFSET(a3),d4
    cmp.w               MOVER_X_POSITION_OFFSET(a2),d4
    ble.s               nochangexsign
    neg.w               d1
nochangexsign:
    move.w              MOVER_Y_POSITION_OFFSET(a3),d4
    cmp.w               MOVER_Y_POSITION_OFFSET(a2),d4
    ble.s               nochangeysign
    neg.w               d3
nochangeysign
    ;move.w #$FFFF,$dff180

    ; add separation vector to car position
    lea                 SEPARATION_VECTOR(PC),a0
    move.w              d1,(a0)
    move.w              d3,2(a0)
    SETCARPROPERTYADDR  MOVER_POSITION_OFFSET,a1
    ADD2DVECTOR

    move.w              MOVER_X_VELOCITY_OFFSET(a2),d1
    move.w              MOVER_Y_VELOCITY_OFFSET(a2),d3

    asr.w               #1,d1
    asr.w               #1,d3

    add.w               d1,MOVER_X_VELOCITY_OFFSET(a3)
    add.w               d3,MOVER_Y_VELOCITY_OFFSET(a3)

    sub.w               d1,MOVER_X_VELOCITY_OFFSET(a2)
    sub.w               d3,MOVER_Y_VELOCITY_OFFSET(a2)

nocarcollision:

    movea.l             a2,a0
    movea.l             a3,a1
    rts