CPU_ANGLE_TRESHOLD EQU 15

MOVER_POSITION_NORMALIZED:
MOVER_POSITION_NORMALIZED_X:
    dc.w 0
MOVER_POSITION_NORMALIZED_Y:
    dc.w 0

MOVER_DIRECTION_TO_DESTINATION:
MOVER_DIRECTION_TO_DESTINATION_X:
    dc.w 0
MOVER_DIRECTION_TO_DESTINATION_Y:
    dc.w 0

CPUCONTROL:
    move.l a0,a2

    SETCARPROPERTYADDR MOVER_HOTSPOT_CPU_PTR,a5

    lea MOVER_POSITION_NORMALIZED(PC),a3

    ; take X current position and normalize (get rid of decimal part)
    STORECARPROPERTY  MOVER_X_POSITION_OFFSET,d0
    ;DEBUG 9998
    moveq             #0,d6
    ;move.w            d0,d6 ; save for later
    lsr.w             #DECIMAL_SHIFT,d0
    move.w            d0,(a3)

    ; take Y current position and normalize (get rid of decimal part)
    STORECARPROPERTY  MOVER_Y_POSITION_OFFSET,d0
    ;DEBUG 9999
    lsr.w             #DECIMAL_SHIFT,d0
    move.w            d0,2(a3)

    ;lea               MOVER_DESTINATION(PC),a0
    move.l            (a5),a0
    lea               MOVER_POSITION_NORMALIZED(PC),a1
    SUB2DVECTORSTATIC MOVER_DIRECTION_TO_DESTINATION

    ; find MOVER_DIRECTION_TO_DESTINATION angle with vector V(1,0)
    ; the formula is ACOS( MOVER_DIRECTION_TO_DESTINATION / mag(MOVER_DIRECTION_TO_DESTINATION))

    ; lets start finding the magnitude, the formula is sqrt(x*x+y*y)
    lea               MOVER_DIRECTION_TO_DESTINATION(PC),a4
    move.w            (a4),d0
    move.w d0,d6;save for later
    asl.w             #DECIMAL_SHIFT,d6
    btst #15,d6
    beq.s .noneg
    neg.w d6
.noneg:
    muls.w            d0,d0
    move.w            2(a4),d1
    muls.w            d1,d1
    add.l             d1,d0
    ;DEBUG 9997
    SQRT_Q16_0
    ; here d1.w holds the magnitude

    ; if the magnitude is < to TRESHOLD then it means we are very close to the destination, we can assume
    ; we reached it and go to the next point
    cmpi.w #12,d1
    bcc.s .destinationnotreached
    ;DEBUG 8888
    moveq #0,d0
    ;bset #3,d0
    move.l (a5),a0
    cmpi.l #$FFFFFFFF,4(a0)
    bne.s .notendoftrack
    ;DEBUG 8889

    ;bset #3,d0
    move.l #MOVER_DESTINATION,(a5)

    move.l            a2,a0
    rts

.notendoftrack:
    ;DEBUG 8887
    add.l #4,(a5)
    move.l            a2,a0
    rts

.destinationnotreached:

    ;DEBUG 9996
    divu.w            d1,d6

    lea               ACOS_Q9_7(PC),a0
    moveq             #0,d0
    move.b            (a0,d6.w),d0


    ; compare Y position, if destination is on the bottom invert angle
    ;move.w            MOVER_DESTINATION_Y(PC),d6
    move.l            (a5),a0
    move.w            2(a0),d6
    cmp.w             MOVER_POSITION_NORMALIZED_Y,d6
    bls.s             .noinverseangle
    move.w            d0,d5
    neg.w             d0
    add.w             #360,d0

    ; compare X position, if destination is on the left decrease by 90
    ;move.w            MOVER_DESTINATION_X(PC),d6
    move.w            (a0),d6
    cmp.w             MOVER_POSITION_NORMALIZED_X,d6
    bgt.s             .nominus90
    ;DEBUG 5454
    subi.w            #180,d0
    add.w             d5,d0
    add.w             d5,d0
.nominus90:
    bra.s .calculatecardegrees


.noinverseangle:
    ; compare X position, if destination is on the left increase by 180
    ;move.w            MOVER_DESTINATION_X(PC),d6
    move.w            (a0),d6
    cmp.w             MOVER_POSITION_NORMALIZED_X,d6
    bgt.s             .noadd90
    neg.w             d0
    addi.w            #180,d0
.noadd90:






.calculatecardegrees:

    STORECARPROPERTY MOVER_STEER_DIRECTION_OFFSET,d1
    move.w           d1,d6
    move.w           #180,d5
    sub.w            d6,d5
    add.w            d5,d1
    add.w            d5,d1

    ; d0.w now holds the angle of the distance vector!!!!
    ; d1.w now hold the angle of the car
        ;DEBUG 0001


    ; take abs(d0-d1 and put into d2)
    move.w           d0,d2
    sub.w            d1,d2
    bpl.s            .donotchange
    neg.w            d2
.donotchange

    ; if Apos <= Ac jump
    cmp.w           d0,d1
    bcc.s           .aposless
    cmpi.w           #180,d2
    bls.s            .clockwise
    bra.s            .counterclockwise

.aposless:

    ; check abs(angle) if < 180
    ;DEBUG 1111
    cmpi.w           #180,d2
    bls.s            .counterclockwise
    ;bra.s            .counterclockwise

.clockwise:
    ;DEBUG 2222
    moveq #2,d0
    bra.s .calculateaccelerationbrake

.counterclockwise:
    ;DEBUG 3333
    moveq #1,d0

    ; now we have to figure out if we want to rotate clockwise on counterclockweise
.calculateaccelerationbrake:
    ;DEBUG 4444
    bset              #2,d0 ; always accelerate

    ; brake if the angle is too steep
    BETWEEN_UWORD   d2,#CPU_ANGLE_TRESHOLD,#360-CPU_ANGLE_TRESHOLD,d1
    tst.b d1
    bne.s .donotbrake
    ;cmpi.w           #CPU_ANGLE_TRESHOLD,d2
    ;bls.s           .donotbrake
    ;DEBUG 7777
    STORECARPROPERTY MOVER_HEADING_MAGNITUDE,d1
    cmpi.w           #$04FF,d1
    bls.s           .donotbrake

    bset #3,d0
    bclr #2,d0
.donotbrake

    tst.w             MOVER_IS_COLLIDING_OFFSET(a2)
    beq.s             .notcolliding
    
    STORECARPROPERTY    MOVER_CPU_CONSECUTIVE_COLLISIONS,d1
    addq #1,d1
    cmpi.w              #100,d1
    bls.s               .donotenterinrecovery
    ;DEBUG 4321
    move.l (a5),a0
    move.w (a0),d1
    lsl.w #DECIMAL_SHIFT,d1
    move.w d1,MOVER_X_POSITION_OFFSET(a2)
    move.w 2(a0),d1
    lsl.w #DECIMAL_SHIFT,d1
    move.w d1,MOVER_Y_POSITION_OFFSET(a2)

    ;sub.l #4,(a5)
    ;moveq #0,d1
.donotenterinrecovery
    move.w              d1,MOVER_CPU_CONSECUTIVE_COLLISIONS(a2)

    move.l            a2,a0
    rts
.notcolliding:
    move.w            #0,MOVER_CPU_CONSECUTIVE_COLLISIONS(a2)
    move.l            a2,a0
    rts


SETCPURECOVERYMODE:

    rts

;#include <stdio.h>
;#include <math.h>"""
;
;
;#define BYTE_TO_BINARY_PATTERN "%c%c%c%c%c%c%c%c"
;#define BYTE_TO_BINARY(byte)  \
;  ((byte) & 0x80 ? '1' : '0'), \
;  ((byte) & 0x40 ? '1' : '0'), \
;  ((byte) & 0x20 ? '1' : '0'), \
;  ((byte) & 0x10 ? '1' : '0'), \
;  ((byte) & 0x08 ? '1' : '0'), \
;  ((byte) & 0x04 ? '1' : '0'), \
;  ((byte) & 0x02 ? '1' : '0'), \
;  ((byte) & 0x01 ? '1' : '0') 
;  
;int main()
;{
;    const double PI =  3.1415926;
;    
;    for (unsigned char i=0;i<=(unsigned char)128;i++)
;    {
;        double x = 0;
;        if ((i) & 0x40) x+=0.5;
;        if ((i) & 0x20) x+=0.5/2;
;        if ((i) & 0x10)  x+=0.5/2/2;
;        if ((i) & 0x8)  x+=0.5/2/2/2;
;        if ((i) & 0x4)  x+=0.5/2/2/2/2;
;        if ((i) & 0x2)  x+=0.5/2/2/2/2/2;
;        if ((i) & 0x1)  x+=0.5/2/2/2/2/2/2;
        
;        char result = (char)(acos(x)*180/PI);
        
;        printf("dc.b "BYTE_TO_BINARY_PATTERN" ; index: "BYTE_TO_BINARY_PATTERN" ; number argument %f degrees: %hhd\n", BYTE_TO_BINARY(result),BYTE_TO_BINARY(i),x,result);
;        
;        if (i==255) break;
;
;    }
;   
;
;    return 0;
;}

ACOS_Q9_7:
    dc.b %01011010 ; index: 00000000 ; number argument 0.000000 degrees: 90
    dc.b %01011001 ; index: 00000001 ; number argument 0.007812 degrees: 89
    dc.b %01011001 ; index: 00000010 ; number argument 0.015625 degrees: 89
    dc.b %01011000 ; index: 00000011 ; number argument 0.023438 degrees: 88
    dc.b %01011000 ; index: 00000100 ; number argument 0.031250 degrees: 88
    dc.b %01010111 ; index: 00000101 ; number argument 0.039062 degrees: 87
    dc.b %01010111 ; index: 00000110 ; number argument 0.046875 degrees: 87
    dc.b %01010110 ; index: 00000111 ; number argument 0.054688 degrees: 86
    dc.b %01010110 ; index: 00001000 ; number argument 0.062500 degrees: 86
    dc.b %01010101 ; index: 00001001 ; number argument 0.070312 degrees: 85
    dc.b %01010101 ; index: 00001010 ; number argument 0.078125 degrees: 85
    dc.b %01010101 ; index: 00001011 ; number argument 0.085938 degrees: 85
    dc.b %01010100 ; index: 00001100 ; number argument 0.093750 degrees: 84
    dc.b %01010100 ; index: 00001101 ; number argument 0.101562 degrees: 84
    dc.b %01010011 ; index: 00001110 ; number argument 0.109375 degrees: 83
    dc.b %01010011 ; index: 00001111 ; number argument 0.117188 degrees: 83
    dc.b %01010010 ; index: 00010000 ; number argument 0.125000 degrees: 82
    dc.b %01010010 ; index: 00010001 ; number argument 0.132812 degrees: 82
    dc.b %01010001 ; index: 00010010 ; number argument 0.140625 degrees: 81
    dc.b %01010001 ; index: 00010011 ; number argument 0.148438 degrees: 81
    dc.b %01010001 ; index: 00010100 ; number argument 0.156250 degrees: 81
    dc.b %01010000 ; index: 00010101 ; number argument 0.164062 degrees: 80
    dc.b %01010000 ; index: 00010110 ; number argument 0.171875 degrees: 80
    dc.b %01001111 ; index: 00010111 ; number argument 0.179688 degrees: 79
    dc.b %01001111 ; index: 00011000 ; number argument 0.187500 degrees: 79
    dc.b %01001110 ; index: 00011001 ; number argument 0.195312 degrees: 78
    dc.b %01001110 ; index: 00011010 ; number argument 0.203125 degrees: 78
    dc.b %01001101 ; index: 00011011 ; number argument 0.210938 degrees: 77
    dc.b %01001101 ; index: 00011100 ; number argument 0.218750 degrees: 77
    dc.b %01001100 ; index: 00011101 ; number argument 0.226562 degrees: 76
    dc.b %01001100 ; index: 00011110 ; number argument 0.234375 degrees: 76
    dc.b %01001011 ; index: 00011111 ; number argument 0.242188 degrees: 75
    dc.b %01001011 ; index: 00100000 ; number argument 0.250000 degrees: 75
    dc.b %01001011 ; index: 00100001 ; number argument 0.257812 degrees: 75
    dc.b %01001010 ; index: 00100010 ; number argument 0.265625 degrees: 74
    dc.b %01001010 ; index: 00100011 ; number argument 0.273438 degrees: 74
    dc.b %01001001 ; index: 00100100 ; number argument 0.281250 degrees: 73
    dc.b %01001001 ; index: 00100101 ; number argument 0.289062 degrees: 73
    dc.b %01001000 ; index: 00100110 ; number argument 0.296875 degrees: 72
    dc.b %01001000 ; index: 00100111 ; number argument 0.304688 degrees: 72
    dc.b %01000111 ; index: 00101000 ; number argument 0.312500 degrees: 71
    dc.b %01000111 ; index: 00101001 ; number argument 0.320312 degrees: 71
    dc.b %01000110 ; index: 00101010 ; number argument 0.328125 degrees: 70
    dc.b %01000110 ; index: 00101011 ; number argument 0.335938 degrees: 70
    dc.b %01000101 ; index: 00101100 ; number argument 0.343750 degrees: 69
    dc.b %01000101 ; index: 00101101 ; number argument 0.351562 degrees: 69
    dc.b %01000100 ; index: 00101110 ; number argument 0.359375 degrees: 68
    dc.b %01000100 ; index: 00101111 ; number argument 0.367188 degrees: 68
    dc.b %01000011 ; index: 00110000 ; number argument 0.375000 degrees: 67
    dc.b %01000011 ; index: 00110001 ; number argument 0.382812 degrees: 67
    dc.b %01000011 ; index: 00110010 ; number argument 0.390625 degrees: 67
    dc.b %01000010 ; index: 00110011 ; number argument 0.398438 degrees: 66
    dc.b %01000010 ; index: 00110100 ; number argument 0.406250 degrees: 66
    dc.b %01000001 ; index: 00110101 ; number argument 0.414062 degrees: 65
    dc.b %01000001 ; index: 00110110 ; number argument 0.421875 degrees: 65
    dc.b %01000000 ; index: 00110111 ; number argument 0.429688 degrees: 64
    dc.b %01000000 ; index: 00111000 ; number argument 0.437500 degrees: 64
    dc.b %00111111 ; index: 00111001 ; number argument 0.445312 degrees: 63
    dc.b %00111111 ; index: 00111010 ; number argument 0.453125 degrees: 63
    dc.b %00111110 ; index: 00111011 ; number argument 0.460938 degrees: 62
    dc.b %00111110 ; index: 00111100 ; number argument 0.468750 degrees: 62
    dc.b %00111101 ; index: 00111101 ; number argument 0.476562 degrees: 61
    dc.b %00111101 ; index: 00111110 ; number argument 0.484375 degrees: 61
    dc.b %00111100 ; index: 00111111 ; number argument 0.492188 degrees: 60
    dc.b %00111100 ; index: 01000000 ; number argument 0.500000 degrees: 60
    dc.b %00111011 ; index: 01000001 ; number argument 0.507812 degrees: 59
    dc.b %00111010 ; index: 01000010 ; number argument 0.515625 degrees: 58
    dc.b %00111010 ; index: 01000011 ; number argument 0.523438 degrees: 58
    dc.b %00111001 ; index: 01000100 ; number argument 0.531250 degrees: 57
    dc.b %00111001 ; index: 01000101 ; number argument 0.539062 degrees: 57
    dc.b %00111000 ; index: 01000110 ; number argument 0.546875 degrees: 56
    dc.b %00111000 ; index: 01000111 ; number argument 0.554688 degrees: 56
    dc.b %00110111 ; index: 01001000 ; number argument 0.562500 degrees: 55
    dc.b %00110111 ; index: 01001001 ; number argument 0.570312 degrees: 55
    dc.b %00110110 ; index: 01001010 ; number argument 0.578125 degrees: 54
    dc.b %00110110 ; index: 01001011 ; number argument 0.585938 degrees: 54
    dc.b %00110101 ; index: 01001100 ; number argument 0.593750 degrees: 53
    dc.b %00110101 ; index: 01001101 ; number argument 0.601562 degrees: 53
    dc.b %00110100 ; index: 01001110 ; number argument 0.609375 degrees: 52
    dc.b %00110011 ; index: 01001111 ; number argument 0.617188 degrees: 51
    dc.b %00110011 ; index: 01010000 ; number argument 0.625000 degrees: 51
    dc.b %00110010 ; index: 01010001 ; number argument 0.632812 degrees: 50
    dc.b %00110010 ; index: 01010010 ; number argument 0.640625 degrees: 50
    dc.b %00110001 ; index: 01010011 ; number argument 0.648438 degrees: 49
    dc.b %00110000 ; index: 01010100 ; number argument 0.656250 degrees: 48
    dc.b %00110000 ; index: 01010101 ; number argument 0.664062 degrees: 48
    dc.b %00101111 ; index: 01010110 ; number argument 0.671875 degrees: 47
    dc.b %00101111 ; index: 01010111 ; number argument 0.679688 degrees: 47
    dc.b %00101110 ; index: 01011000 ; number argument 0.687500 degrees: 46
    dc.b %00101101 ; index: 01011001 ; number argument 0.695312 degrees: 45
    dc.b %00101101 ; index: 01011010 ; number argument 0.703125 degrees: 45
    dc.b %00101100 ; index: 01011011 ; number argument 0.710938 degrees: 44
    dc.b %00101100 ; index: 01011100 ; number argument 0.718750 degrees: 44
    dc.b %00101011 ; index: 01011101 ; number argument 0.726562 degrees: 43
    dc.b %00101010 ; index: 01011110 ; number argument 0.734375 degrees: 42
    dc.b %00101010 ; index: 01011111 ; number argument 0.742188 degrees: 42
    dc.b %00101001 ; index: 01100000 ; number argument 0.750000 degrees: 41
    dc.b %00101000 ; index: 01100001 ; number argument 0.757812 degrees: 40
    dc.b %00101000 ; index: 01100010 ; number argument 0.765625 degrees: 40
    dc.b %00100111 ; index: 01100011 ; number argument 0.773438 degrees: 39
    dc.b %00100110 ; index: 01100100 ; number argument 0.781250 degrees: 38
    dc.b %00100101 ; index: 01100101 ; number argument 0.789062 degrees: 37
    dc.b %00100101 ; index: 01100110 ; number argument 0.796875 degrees: 37
    dc.b %00100100 ; index: 01100111 ; number argument 0.804688 degrees: 36
    dc.b %00100011 ; index: 01101000 ; number argument 0.812500 degrees: 35
    dc.b %00100010 ; index: 01101001 ; number argument 0.820312 degrees: 34
    dc.b %00100010 ; index: 01101010 ; number argument 0.828125 degrees: 34
    dc.b %00100001 ; index: 01101011 ; number argument 0.835938 degrees: 33
    dc.b %00100000 ; index: 01101100 ; number argument 0.843750 degrees: 32
    dc.b %00011111 ; index: 01101101 ; number argument 0.851562 degrees: 31
    dc.b %00011110 ; index: 01101110 ; number argument 0.859375 degrees: 30
    dc.b %00011101 ; index: 01101111 ; number argument 0.867188 degrees: 29
    dc.b %00011100 ; index: 01110000 ; number argument 0.875000 degrees: 28
    dc.b %00011100 ; index: 01110001 ; number argument 0.882812 degrees: 28
    dc.b %00011011 ; index: 01110010 ; number argument 0.890625 degrees: 27
    dc.b %00011010 ; index: 01110011 ; number argument 0.898438 degrees: 26
    dc.b %00011001 ; index: 01110100 ; number argument 0.906250 degrees: 25
    dc.b %00010111 ; index: 01110101 ; number argument 0.914062 degrees: 23
    dc.b %00010110 ; index: 01110110 ; number argument 0.921875 degrees: 22
    dc.b %00010101 ; index: 01110111 ; number argument 0.929688 degrees: 21
    dc.b %00010100 ; index: 01111000 ; number argument 0.937500 degrees: 20
    dc.b %00010011 ; index: 01111001 ; number argument 0.945312 degrees: 19
    dc.b %00010001 ; index: 01111010 ; number argument 0.953125 degrees: 17
    dc.b %00010000 ; index: 01111011 ; number argument 0.960938 degrees: 16
    dc.b %00001110 ; index: 01111100 ; number argument 0.968750 degrees: 14
    dc.b %00001100 ; index: 01111101 ; number argument 0.976562 degrees: 12
    dc.b %00001010 ; index: 01111110 ; number argument 0.984375 degrees: 10
    dc.b %00000111 ; index: 01111111 ; number argument 0.992188 degrees: 7
    dc.b %00000000 ; index: 10000000 ; number argument 0.000000 degrees: 0
    even