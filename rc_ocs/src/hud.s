SIZE_OF_CHAR_BITMAP     EQU 6

TIMETXT:                dc.b 0,0,0,0,0,0

; Routine to print some text on HUD
; - a0.l address of the string to print
; - d1.l x offset on hid where to print
; - d2.l y offset of hud where to print
; - d7.w length of the screen
PRINT_STRING_ON_HUD:
    ; get the starting point where to print into a1
    lea                 DASHBOARD_DATA_1,a1
    cmp.w #10,d1
    beq.s okd1
    tst.w d1
    beq.s okd1
     ;   DEBUG 1234
    nop
    ;move.w #$1,RACE_STATUS
okd1:
    adda.l              d1,a1
    adda.l              d2,a1

    moveq               #0,d0
    subq                #1,d7
start_string_iteration:

    ; take the charater and multiply by <size of each character in bytes> to find the offset if the bitmap in memory
    moveq               #0,d0
    move.b              (a0)+,d0
    muls.w              #SIZE_OF_CHAR_BITMAP,d0
    lea                 TIMER_FONTS_SMALL(PC),a3
    adda.l              d0,a3 ; a3 now holds the address of the bitmap to print on HUD

    moveq               #SIZE_OF_CHAR_BITMAP-1,d6
    moveq               #0,d5

start_string_iteration2
    move.b              (a3)+,(a1,d5.w)
    add.w               #40,d5
    dbra                d6,start_string_iteration2

    addq                #1,a1
    dbra                d7,start_string_iteration
    rts

UPDATE_TIMER:
    movem.l             a0/a1/d0/d7,-(sp)
    move.l              a0,a2

    ; increase time
	addi.w              #1,TIME_OFFSET(a0)

    ; convert to text
    STORECARPROPERTY    TIME_OFFSET,d1
    lea                 TIMETXT(pc),a0
    jsr                 dec2txt ; after this call buffer will be 01 02 03 04 05

    ; Print the timer of the car - start
    lea                 TIMETXT(pc),a0 ; string to print
    moveq               #5,d7 ; length of the string

    ; x offset in bytes of where to print
    ;add offset on x according to car id
    moveq.l #0,d1
    STORECARPROPERTY    CAR_ID_OFFSET,d1
    cmp.w #1,d1
    bls.s buono
    move.w #$FF,RACE_STATUS
    DEBUG 1111
buono:
    muls.w              #80/8,d1
    move.l              #40,d2 ; y offset in bytes of where to print
    jsr                 PRINT_STRING_ON_HUD
    ; Print the timer of the car - end

    movem.l             (sp)+,a0/a1/d0/d7
    rts

UPDATE_BEST_TIMER:
    movem.l             a0/a1/d0/d1/d2/d7,-(sp)
    move.l              a0,a2

    ; convert to text
    STORECARPROPERTY    BEST_TIME_OFFSET,d1
    lea                 TIMETXT(pc),a0
    jsr                 dec2txt

    ; Print the best timer of the car - start
    lea                 TIMETXT(pc),a0 ; string to print
    moveq               #5,d7 ; length of the string

    ; x offset in bytes of where to print
    ;add offset on x according to car id
    moveq.l             #0,d1
    STORECARPROPERTY    CAR_ID_OFFSET,d1
    cmp.w #1,d1
    bls.s buono2
    move.w #$FF,RACE_STATUS
    DEBUG 2222
buono2:
    muls.w              #80/8,d1
    move.l              #(1+8)*40,d2 ; y offset in bytes of where to print
    jsr                 PRINT_STRING_ON_HUD
    ; Print the best timer of the car - end
    movem.l             (sp)+,a0/a1/d0/d1/d2/d7
    rts

LAPTXT: dc.b 0,0,0,0,0,0
UPDATE_LAP_COUNTER_HUD:
    movem.l             a0/a1/d0/d1/d2/d7,-(sp)
    move.l              a0,a2

    ; convert to text
    STORECARPROPERTY    LAP_COUNTER_OFFSET,d1
    lea                 LAPTXT(pc),a0
    jsr                 dec2txt

    ; Print the car lap number - start
    lea                 4+LAPTXT(pc),a0 ; string to print
    moveq               #1,d7 ; length of the string

    ; x offset in bytes of where to print
    ;add offset on x according to car id
    moveq.l             #0,d1
    STORECARPROPERTY    CAR_ID_OFFSET,d1
    cmp.w #1,d1
    bls.s buono3
    move.w #$FF,RACE_STATUS
    DEBUG 3333
buono3:
    muls.w              #80/8,d1
    addq.w              #7,d1
    move.l              #(1+0)*40,d2 ; y offset in bytes of where to print
    jsr                 PRINT_STRING_ON_HUD
    ; Print the car lap number - end

    movem.l             (sp)+,a0/a1/d0/d1/d2/d7
    rts


TIMER_FONTS:
TIMER_FONT_0:
    dc.b %11111111
    dc.b %10000001
    dc.b %10000001
    dc.b %10000001
    dc.b %10000001
    dc.b %10000001
    dc.b %10000001
    dc.b %11111111

TIMER_FONT_1:
    dc.b %00011000
    dc.b %00011000
    dc.b %00011000
    dc.b %00011000
    dc.b %00011000
    dc.b %00011000
    dc.b %00011000
    dc.b %00011000

TIMER_FONT_2:
    dc.b %11111111
    dc.b %00000011
    dc.b %00000011
    dc.b %00000110
    dc.b %00001100
    dc.b %00011000
    dc.b %00110000
    dc.b %11111111

TIMER_FONT_3:
    dc.b %11111111
    dc.b %00000011
    dc.b %00000011
    dc.b %00111111
    dc.b %00000011
    dc.b %00000011
    dc.b %00000011
    dc.b %11111111

TIMER_FONT_4:
    dc.b %11000000
    dc.b %11000000
    dc.b %11000000
    dc.b %11000011
    dc.b %11000011
    dc.b %11111111
    dc.b %00000011
    dc.b %00000011

TIMER_FONT_5:
    dc.b %11111111
    dc.b %11000000
    dc.b %11000000
    dc.b %11000000
    dc.b %11111111
    dc.b %00000011
    dc.b %00000011
    dc.b %11111111

TIMER_FONT_6:
    dc.b %11111111
    dc.b %11000000
    dc.b %11000000
    dc.b %11000000
    dc.b %11000000
    dc.b %11000011
    dc.b %11000011
    dc.b %11111111

TIMER_FONT_7:
    dc.b %11111111
    dc.b %00000011
    dc.b %00000110
    dc.b %00001100
    dc.b %00011000
    dc.b %00110000
    dc.b %01100000
    dc.b %11000000

TIMER_FONT_8:
    dc.b %11111111
    dc.b %11000011
    dc.b %11000011
    dc.b %11111111
    dc.b %11000011
    dc.b %11000011
    dc.b %11000011
    dc.b %11111111

TIMER_FONT_9:
    dc.b %11111111
    dc.b %11000011
    dc.b %11000011
    dc.b %11111111
    dc.b %00000011
    dc.b %00000011
    dc.b %00000011
    dc.b %11111111

TIMER_FONTS_SMALL:
    dc.b %11111110
    dc.b %10000010
    dc.b %10000010
    dc.b %10000010
    dc.b %10000010
    dc.b %11111110

    dc.b %00010000
    dc.b %00010000
    dc.b %00010000
    dc.b %00010000
    dc.b %00010000
    dc.b %00010000

    dc.b %11111110
    dc.b %00000010
    dc.b %00001100
    dc.b %00011000
    dc.b %00110000
    dc.b %11111110

    dc.b %11111110
    dc.b %00000010
    dc.b %00111110
    dc.b %00000010
    dc.b %00000010
    dc.b %11111110

    dc.b %11000000
    dc.b %11000000
    dc.b %11000010
    dc.b %11111110
    dc.b %00000010
    dc.b %00000010

    dc.b %11111110
    dc.b %11000000
    dc.b %11000000
    dc.b %11111110
    dc.b %00000011
    dc.b %11111110

    dc.b %11111110
    dc.b %11000000
    dc.b %11000000
    dc.b %11000010
    dc.b %11000010
    dc.b %11111110

    dc.b %11111110
    dc.b %00000010
    dc.b %00001100
    dc.b %00011000
    dc.b %00110000
    dc.b %11000000

    dc.b %11111110
    dc.b %11000010
    dc.b %11111110
    dc.b %11000010
    dc.b %11000010
    dc.b %11111110

    dc.b %11111110
    dc.b %11000010
    dc.b %11111110
    dc.b %00000010
    dc.b %00000010
    dc.b %11111110
