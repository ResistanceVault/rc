; this routine calculates the wheel positions
; for the car pointed in a0 according to its
; position and wheel base value

WHEEL_VECTOR_1:
    dc.l 0
WHEEL_VECTOR_2:
    dc.l 0
WHEEL_VECTOR_3:
    dc.l 0
WHEEL_VECTOR_4:
    dc.l 0
WHEEL_VECTOR_5:
    dc.l 0
WHEEL_DISTANCE:
    dc.w 2

CALCULATE_WHEEL_POSITIONS:
    ; save car address into a2
    move.l              a0,a2

    ; step 1 - get the vector representing the distance from the center
    ; up to a generic wheel according to forward vector and wheel base

    ; wheel distance / 2 in a0 (scalar)
    lea                 WHEEL_VECTOR_1(PC),a0
    STORECARPROPERTY    MOVER_WHEEL_BASE_OFFSET,d0
    lsr.w               #1,d0
    move.w              d0,(a0)

    ; forward vector copy in a1
    lea                 WHEEL_VECTOR_2(PC),a1
    move.l              MOVER_FORWARD_VECTOR_OFFSET(a2),(a1)

    MUL2DVECTOR1X2

    ; step 2 - get the coordinate of the back wheel
    SETCARPROPERTYADDR  MOVER_BACK_WHEEL_VECTOR_OFFSET,a0
    move.l              MOVER_POSITION_OFFSET(a2),(a0)
    lea                 WHEEL_VECTOR_2(PC),a1
    SUB2DVECTORSTATIC   WHEEL_VECTOR_1
    move.l              WHEEL_VECTOR_1,(a0)
    ; step 2.1 - get the coordinate of the back left and right wheel
    STORECARPROPERTY    MOVER_STEER_DIRECTION_OFFSET,d7
    addi.w              #90,d7
    IF_1_LESS_2_W_U #360,d7,wheel_no_overflow,s
    subi.w              #360,d7
wheel_no_overflow:
    lea                 WHEEL_VECTOR_3(PC),a0
    CREATE2DVECTORFROMANGLE
    move.w              (a0),d7
	asr.w               #11-DECIMAL_SHIFT,d7
	move.w              d7,(a0)
	move.w              2(a0),d7
	asr.w               #11-DECIMAL_SHIFT,d7
	move.w              d7,2(a0)

    ; scale the magnitude of the new vector
    lea                 WHEEL_DISTANCE(PC),a0
    lea                 WHEEL_VECTOR_3(PC),a1
    MUL2DVECTOR1X2
    move.l              (a1),WHEEL_VECTOR_5

    ; add to back wheel vector
    SETCARPROPERTYADDR  MOVER_BACK_LEFT_CORNER_OFFSET,a1
    move.l              MOVER_BACK_WHEEL_VECTOR_OFFSET(a2),(a1)
    lea                 WHEEL_VECTOR_3(PC),a0
    ADD2DVECTOR

    ; sub to back wheel vector
    move.l              MOVER_BACK_WHEEL_VECTOR_OFFSET(a2),WHEEL_VECTOR_4
    lea                 WHEEL_VECTOR_4(PC),a0
    lea                 WHEEL_VECTOR_3(PC),a1
    SUB2DVECTOR
    move.l              (a1),MOVER_BACK_RIGHT_CORNER_OFFSET(a2)

    ; step 3 - get the coordinate of the front wheel
    SETCARPROPERTYADDR  MOVER_FRONT_WHEEL_VECTOR_OFFSET,a0
    move.l              MOVER_POSITION_OFFSET(a2),(a0)
    lea                 WHEEL_VECTOR_2(PC),a1
    ADD2DVECTORSTATIC   WHEEL_VECTOR_1
    move.l              WHEEL_VECTOR_1,(a0)

    ; step 3.1 - get the coordinate of the front left and right wheel
    ; add to front wheel vector
    SETCARPROPERTYADDR  MOVER_FRONT_LEFT_CORNER_OFFSET,a1
    move.l              MOVER_FRONT_WHEEL_VECTOR_OFFSET(a2),(a1)
    lea                 WHEEL_VECTOR_5(PC),a0
    ADD2DVECTOR

    ; sub to front wheel vector
    move.l              MOVER_FRONT_WHEEL_VECTOR_OFFSET(a2),WHEEL_VECTOR_4
    lea                 WHEEL_VECTOR_4(PC),a0
    lea                 WHEEL_VECTOR_5(PC),a1
    SUB2DVECTOR
    move.l              (a1),MOVER_FRONT_RIGHT_CORNER_OFFSET(a2)

    ; start screech printing if screech option is enabled
    tst.w   SCREECH_OPTION
    beq.w   noscreech

    SETCARPROPERTYADDR MOVER_HEADING_OFFSET,a0
    bsr.w   MY_ANGLE_Q10_6
    ;DEBUG 7653

    sub.w #360,d0
    ABS_WORD d0
    ;DEBUG 7654

    STORECARPROPERTY MOVER_STEER_DIRECTION_OFFSET,d1
    sub.w #360,d1
    ABS_WORD d1
    sub.w   d1,d0
    ABS_WORD d0
    ;DEBUG 7655

    ;if (angleseparation > 60) then screech else noscreech
    ;if (60 < angleseparation) then screech
    IF_1_LESS_2_W_U #60,d0,noscreech,s

    IF_1_GREATER_2_W_U #300,d0,noscreech,s


    IF_1_LESS_EQ_2_W_U  #CAR1_MAX_SPEED/2,MOVER_HEADING_MAGNITUDE(a2),noscreech,s

    ;print rear left wheel
    SETCARPROPERTYADDR  MOVER_BACK_LEFT_CORNER_OFFSET,a0
    bsr.s               PRINT_SCREECH

    ;print rear left wheel
    SETCARPROPERTYADDR  MOVER_BACK_RIGHT_CORNER_OFFSET,a0
    bsr.s               PRINT_SCREECH

    ;print front left wheel
    ;SETCARPROPERTYADDR  MOVER_FRONT_LEFT_CORNER_OFFSET,a0
    ;bsr.s               PRINT_SCREECH

    ;print front right wheel
    ;SETCARPROPERTYADDR  MOVER_FRONT_RIGHT_CORNER_OFFSET,a0
    ;bsr.s               PRINT_SCREECH
noscreech:

    rts

PRINT_SCREECH:
    move.w              (a0)+,d0
    move.w              (a0),d1
    lsr.w               #DECIMAL_SHIFT,d0
    lsr.w               #DECIMAL_SHIFT,d1
    move.w              d0,d2 ; save for later
    move.w              d1,d4 ; save for later

    ; screech must be on asphalt
    bsr.w               GET_MAP_PIXEL_DATA
    andi.w              #$000F,d0
    tst.w               d0
    bne.s               noprintscreech
    move.w              d2,d0 ; restore
    move.w              d4,d1 ; restore

    lea                 TRACK_DATA_1,a0 ; track bitplane 0 into a0

    ; get y offset
    mulu.w              #40,d1
    adda.l              d1,a0

    ; find the correct byte in x coordinate
    move.w              d0,d2 ; save for later 
    lsr.w               #3,d0
    adda.w              d0,a0

    ;find the correct bit
    not.w               d2
    bclr                d2,(a0)
    bclr                d2,1*40*256(a0)
    bclr                d2,2*40*256(a0)
    bclr                d2,3*40*256(a0)
    adda.l              #4*40*256,a0
    bclr                d2,(a0)
noprintscreech:

    rts

MY_ANGLE_Q10_6:
    STORECARPROPERTY    MOVER_HEADING_MAGNITUDE,d1
    beq.s               MY_ANGLE_Q10_6_END
    lsr.w               #6,d1 ; heading mag is on Q4,12, must be normalized to Q10,6

    ; dot product is simply the x of V1
    move.w (a0),d0
    bmi.s MY_ANGLE_Q10_6_NEG
    ; mult by 64
    ext.l d0
    lsl.l #6,d0

    move.w 2(a0),d2
    bmi.s .fourthquadrant  
    
    divu d1,d0
    
    lea ACOS_Q10_16(PC),a1
    move.b 0(a1,d0.w),d0
    ext.w d0
    rts
    
    
.fourthquadrant:
    divu d1,d0
    
    lea ACOS_Q10_16(PC),a1
    move.b 0(a1,d0.w),d0
    ext.w d0

    move.w d0,d1
    move.w #360,d0
    sub.w d1,d0

    rts
    
MY_ANGLE_Q10_6_NEG:
     ; mult by 64
    neg.w d0
    ext.l d0
    lsl.l #6,d0
    divu d1,d0
    
    lea ACOS_Q10_16(PC),a1
    move.b 0(a1,d0.w),d0
    ext.w d0
    move.w d0,d1
    addi.w #180,d0
    
    move.w 2(a0),d2
    bmi.s .nothirdquadrant
    
    sub.w d1,d0
    sub.w d1,d0
    
.nothirdquadrant:
MY_ANGLE_Q10_6_END:
    rts

ACOS_Q10_16:
        dc.b %01011010 ; index: 0 ; degrees: 90
        dc.b %01011001 ; index: 1 ; degrees: 89
        dc.b %01011000 ; index: 2 ; degrees: 88
        dc.b %01010111 ; index: 3 ; degrees: 87
        dc.b %01010110 ; index: 4 ; degrees: 86
        dc.b %01010101 ; index: 5 ; degrees: 85
        dc.b %01010100 ; index: 6 ; degrees: 84
        dc.b %01010011 ; index: 7 ; degrees: 83
        dc.b %01010010 ; index: 8 ; degrees: 82
        dc.b %01010001 ; index: 9 ; degrees: 81
        dc.b %01010001 ; index: 10 ; degrees: 81
        dc.b %01010000 ; index: 11 ; degrees: 80
        dc.b %01001111 ; index: 12 ; degrees: 79
        dc.b %01001110 ; index: 13 ; degrees: 78
        dc.b %01001101 ; index: 14 ; degrees: 77
        dc.b %01001100 ; index: 15 ; degrees: 76
        dc.b %01001011 ; index: 16 ; degrees: 75
        dc.b %01001010 ; index: 17 ; degrees: 74
        dc.b %01001001 ; index: 18 ; degrees: 73
        dc.b %01001000 ; index: 19 ; degrees: 72
        dc.b %01000111 ; index: 20 ; degrees: 71
        dc.b %01000110 ; index: 21 ; degrees: 70
        dc.b %01000101 ; index: 22 ; degrees: 69
        dc.b %01000100 ; index: 23 ; degrees: 68
        dc.b %01000011 ; index: 24 ; degrees: 67
        dc.b %01000011 ; index: 25 ; degrees: 67
        dc.b %01000010 ; index: 26 ; degrees: 66
        dc.b %01000001 ; index: 27 ; degrees: 65
        dc.b %01000000 ; index: 28 ; degrees: 64
        dc.b %00111111 ; index: 29 ; degrees: 63
        dc.b %00111110 ; index: 30 ; degrees: 62
        dc.b %00111101 ; index: 31 ; degrees: 61
        dc.b %00111100 ; index: 32 ; degrees: 60
        dc.b %00111010 ; index: 33 ; degrees: 58
        dc.b %00111001 ; index: 34 ; degrees: 57
        dc.b %00111000 ; index: 35 ; degrees: 56
        dc.b %00110111 ; index: 36 ; degrees: 55
        dc.b %00110110 ; index: 37 ; degrees: 54
        dc.b %00110101 ; index: 38 ; degrees: 53
        dc.b %00110100 ; index: 39 ; degrees: 52
        dc.b %00110011 ; index: 40 ; degrees: 51
        dc.b %00110010 ; index: 41 ; degrees: 50
        dc.b %00110000 ; index: 42 ; degrees: 48
        dc.b %00101111 ; index: 43 ; degrees: 47
        dc.b %00101110 ; index: 44 ; degrees: 46
        dc.b %00101101 ; index: 45 ; degrees: 45
        dc.b %00101100 ; index: 46 ; degrees: 44
        dc.b %00101010 ; index: 47 ; degrees: 42
        dc.b %00101001 ; index: 48 ; degrees: 41
        dc.b %00101000 ; index: 49 ; degrees: 40
        dc.b %00100110 ; index: 50 ; degrees: 38
        dc.b %00100101 ; index: 51 ; degrees: 37
        dc.b %00100011 ; index: 52 ; degrees: 35
        dc.b %00100010 ; index: 53 ; degrees: 34
        dc.b %00100000 ; index: 54 ; degrees: 32
        dc.b %00011110 ; index: 55 ; degrees: 30
        dc.b %00011100 ; index: 56 ; degrees: 28
        dc.b %00011011 ; index: 57 ; degrees: 27
        dc.b %00011001 ; index: 58 ; degrees: 25
        dc.b %00010110 ; index: 59 ; degrees: 22
        dc.b %00010100 ; index: 60 ; degrees: 20
        dc.b %00010001 ; index: 61 ; degrees: 17
        dc.b %00001110 ; index: 62 ; degrees: 14
        dc.b %00000111 ; index 63
