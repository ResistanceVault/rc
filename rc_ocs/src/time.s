TIMETXT: dc.b 0,0,0,0,0,0
UPDATE_TIMER:
    movem.l             a0/a1/d0/d7,-(sp)
    move.l              a0,a2

    ; increase time
	addi.w #1,TIME_OFFSET(a0)

    ; convert to text
    STORECARPROPERTY    TIME_OFFSET,d1
    lea TIMETXT(pc),a0
    jsr dec2txt ; after this call buffer will be 01 02 03 04 05

    moveq  #0,d0
    move.b TIMETXT+4,d0
    lsl.w #3,d0
    lea TIMER_FONTS(PC),a0
    adda.w d0,a0

    lea DASHBOARD_DATA_1+5,a1
    move.b (a0)+,(a1)
    move.b (a0)+,40(a1)
    move.b (a0)+,80(a1)
    move.b (a0)+,120(a1)
    move.b (a0)+,160(a1)
    move.b (a0)+,200(a1)
    move.b (a0)+,240(a1)
    move.b (a0)+,280(a1)

    moveq  #0,d0
    move.b TIMETXT+3,d0
    lsl.w #3,d0
    lea TIMER_FONTS(PC),a0
    adda.w d0,a0
    lea DASHBOARD_DATA_1+4,a1
    move.b (a0)+,(a1)
    move.b (a0)+,40(a1)
    move.b (a0)+,80(a1)
    move.b (a0)+,120(a1)
    move.b (a0)+,160(a1)
    move.b (a0)+,200(a1)
    move.b (a0)+,240(a1)
    move.b (a0)+,280(a1)

    moveq  #0,d0
    move.b TIMETXT+2,d0
    lsl.w #3,d0
    lea TIMER_FONTS(PC),a0
    adda.w d0,a0
    lea DASHBOARD_DATA_1+3,a1
    move.b (a0)+,(a1)
    move.b (a0)+,40(a1)
    move.b (a0)+,80(a1)
    move.b (a0)+,120(a1)
    move.b (a0)+,160(a1)
    move.b (a0)+,200(a1)
    move.b (a0)+,240(a1)
    move.b (a0)+,280(a1)

    moveq  #0,d0
    move.b TIMETXT+1,d0
    lsl.w #3,d0
    lea TIMER_FONTS(PC),a0
    adda.w d0,a0
    lea DASHBOARD_DATA_1+2,a1
    move.b (a0)+,(a1)
    move.b (a0)+,40(a1)
    move.b (a0)+,80(a1)
    move.b (a0)+,120(a1)
    move.b (a0)+,160(a1)
    move.b (a0)+,200(a1)
    move.b (a0)+,240(a1)
    move.b (a0)+,280(a1)

    movem.l             (sp)+,a0/a1/d0/d7
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


UPDATE_BEST_TIMER:
    movem.l             a0/a1/d0/d7,-(sp)
    move.l              a0,a2

    ; convert to text
    STORECARPROPERTY    BEST_TIME_OFFSET,d1
    lea TIMETXT(pc),a0
    jsr dec2txt ; after this call buffer will be 01 02 03 04 05

    moveq  #0,d0
    move.b TIMETXT+4,d0
    lsl.w #3,d0
    lea TIMER_FONTS(PC),a0
    adda.w d0,a0

    lea DASHBOARD_DATA_1+13,a1
    move.b (a0)+,(a1)
    move.b (a0)+,40(a1)
    move.b (a0)+,80(a1)
    move.b (a0)+,120(a1)
    move.b (a0)+,160(a1)
    move.b (a0)+,200(a1)
    move.b (a0)+,240(a1)
    move.b (a0)+,280(a1)

    moveq  #0,d0
    move.b TIMETXT+3,d0
    lsl.w #3,d0
    lea TIMER_FONTS(PC),a0
    adda.w d0,a0
    lea DASHBOARD_DATA_1+12,a1
    move.b (a0)+,(a1)
    move.b (a0)+,40(a1)
    move.b (a0)+,80(a1)
    move.b (a0)+,120(a1)
    move.b (a0)+,160(a1)
    move.b (a0)+,200(a1)
    move.b (a0)+,240(a1)
    move.b (a0)+,280(a1)

    moveq  #0,d0
    move.b TIMETXT+2,d0
    lsl.w #3,d0
    lea TIMER_FONTS(PC),a0
    adda.w d0,a0
    lea DASHBOARD_DATA_1+11,a1
    move.b (a0)+,(a1)
    move.b (a0)+,40(a1)
    move.b (a0)+,80(a1)
    move.b (a0)+,120(a1)
    move.b (a0)+,160(a1)
    move.b (a0)+,200(a1)
    move.b (a0)+,240(a1)
    move.b (a0)+,280(a1)

    moveq  #0,d0
    move.b TIMETXT+1,d0
    lsl.w #3,d0
    lea TIMER_FONTS(PC),a0
    adda.w d0,a0
    lea DASHBOARD_DATA_1+10,a1
    move.b (a0)+,(a1)
    move.b (a0)+,40(a1)
    move.b (a0)+,80(a1)
    move.b (a0)+,120(a1)
    move.b (a0)+,160(a1)
    move.b (a0)+,200(a1)
    move.b (a0)+,240(a1)
    move.b (a0)+,280(a1)

    movem.l             (sp)+,a0/a1/d0/d7
    rts
LAPTXT: dc.b 0,0,0,0,0,0
UPDATE_LAP_COUNTER_HID:

    movem.l             a0/a1/d0/d1/d7,-(sp)
    move.l              a0,a2

    ; convert to text
    STORECARPROPERTY    LAP_COUNTER_OFFSET,d1
    lea                 LAPTXT(pc),a0
    jsr                 dec2txt

    moveq               #0,d0
    move.b              LAPTXT+4,d0
    lsl.w               #3,d0
    lea                 TIMER_FONTS(PC),a0
    adda.w d0,a0
    lea                 DASHBOARD_DATA_1+20,a1
    move.b              (a0)+,(a1)
    move.b              (a0)+,40(a1)
    move.b              (a0)+,80(a1)
    move.b              (a0)+,120(a1)
    move.b              (a0)+,160(a1)
    move.b              (a0)+,200(a1)
    move.b              (a0)+,240(a1)
    move.b              (a0)+,280(a1)

    movem.l             (sp)+,a0/a1/d0/d1/d7
    rts
