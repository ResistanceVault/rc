SIZE_OF_CHAR_BITMAP     EQU 7
TIMER_FONTS_SMALL:
    incbin "assets/fonts/small/0.raw"
    incbin "assets/fonts/small/1.raw"
    incbin "assets/fonts/small/2.raw"
    incbin "assets/fonts/small/3.raw"
    incbin "assets/fonts/small/4.raw"
    incbin "assets/fonts/small/5.raw"
    incbin "assets/fonts/small/6.raw"
    incbin "assets/fonts/small/7.raw"
    incbin "assets/fonts/small/8.raw"
    incbin "assets/fonts/small/9.raw"

COLORS_FONTS_SMALL:
    incbin "assets/fonts/small/colors.plt"

TIMETXT:                dc.b 0,0,0,0,0,0

; Routine to print some text on HUD
; - a0.l address of the string to print
; - d1.l x offset on hid where to print
; - d2.l y offset of hud where to print
; - d7.w length of the screen
PRINT_STRING_ON_HUD:
    ; get the starting point where to print into a1
    lea                 DASHBOARD_DATA_1,a1
    adda.l              d1,a1
    adda.l              d2,a1

    moveq               #0,d0
    subq                #1,d7
start_string_iteration:

    ; take the charater and multiply by <size of each character in bytes> to find the offset if the bitmap in memory
    moveq               #0,d0
    move.b              (a0)+,d0
    muls.w              #SIZE_OF_CHAR_BITMAP*3,d0
    lea                 TIMER_FONTS_SMALL(PC),a3
    adda.l              d0,a3 ; a3 now holds the address of the bitmap to print on HUD

    moveq               #SIZE_OF_CHAR_BITMAP-1,d6
    moveq               #0,d5

start_string_iteration2
    move.l a1,a4
    adda.l              #40*256,a4;
    move.b              SIZE_OF_CHAR_BITMAP(a3),(a4,d5.w)
    adda.l              #40*256,a4;
    move.b              SIZE_OF_CHAR_BITMAP*2(a3),(a4,d5.w)
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

    ;lea                 TIMETXT(pc),a0
    ;jsr                 dec2txt ; after this call buffer will be 01 02 03 04 05
    move.l              TIME_OFFSET_STR(a2),a0
    bsr.w               TXT_INCR

    ; Print the timer of the car - start
    ;lea                 TIMETXT(pc),a0 ; string to print

    move.l              TIME_OFFSET_STR(a2),a0
    moveq               #6,d7 ; length of the string

    moveq #0,d1
    moveq #0,d2
    STORECARPROPERTY    HUD_POSITION_X,d1
    STORECARPROPERTY    HUD_POSITION_Y,d2
    jsr                 PRINT_STRING_ON_HUD
    ; Print the timer of the car - end
update_timer_end:
    movem.l             (sp)+,a0/a1/d0/d7
    rts

UPDATE_BEST_TIMER:
    rts ; disable to make space to more car
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
    ; skip car 5
    cmp.w #4,d1
    bne.s no_car_5_2
    move.w #7,d1
    move.l              #(1+8)*40,d2 ; y offset in bytes of where to print
    bra.s               print_string_exception2
no_car_5_2:

    muls.w              #80/8,d1
    addq.w              #7,d1
    move.l              #(1+0)*40,d2 ; y offset in bytes of where to print
print_string_exception2:
    jsr                 PRINT_STRING_ON_HUD
    ; Print the car lap number - end

    movem.l             (sp)+,a0/a1/d0/d1/d2/d7
    rts

TXT_INCR:
    move.l a1,-(sp)
    move.l a0,a1
    addq #5,a1

txt_incr_start:
    cmpi.b #$9,(a1) ; is it 9?
    beq txt_incr_change_scale

    addi.b #1,(a1)
    move.l (sp)+,a1
    rts
txt_incr_change_scale:
    move.b #$0,(a1)
    subq   #1,a1
    bra  txt_incr_start