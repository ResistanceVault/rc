; This routine just draws the car pointed in a0
; into the screen according to its position.
; Wheel positions must be already calculated
DISPLAY:

    ; save a0 - point routine trashes it
    move.l a0,a2

    ; Front wheel
    STROKE #1
    move.w MOVER_FRONT_WHEEL_X_VECTOR_OFFSET(a2),d0
    move.w MOVER_FRONT_WHEEL_Y_VECTOR_OFFSET(a2),d1

    lsr.w #DECIMAL_SHIFT,d0
    asr.w #DECIMAL_SHIFT,d1
    jsr POINT

    ; Back wheel
    STROKE #2
    move.w MOVER_BACK_WHEEL_X_VECTOR_OFFSET(a2),d0
    move.w MOVER_BACK_WHEEL_Y_VECTOR_OFFSET(a2),d1
    lsr.w #DECIMAL_SHIFT,d0
    asr.w #DECIMAL_SHIFT,d1
    jsr POINT

    ; Car position
    STROKE #3
    move.w MOVER_X_POSITION_OFFSET(a2),d0
    move.w MOVER_Y_POSITION_OFFSET(a2),d1
    lsr.w #DECIMAL_SHIFT,d0
    asr.w #DECIMAL_SHIFT,d1
    jsr POINT

    ; restore old a0
    move.l a2,a0
    IFND DEBUG
    jsr CREATE_CAR_SPRITE
    ENDC
    rts