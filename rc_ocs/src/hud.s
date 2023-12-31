HUD_BEST_TIME_ROW_1 equ %0000010000000000
HUD_BEST_TIME_ROW_2 equ %0000111000000000
HUD_BEST_TIME_ROW_3 equ %0000010000000000
HUD_BEST_TIME_ROW_4 equ %0000000000000000
HUD_BEST_TIME_ROW_5 equ %0000000000000000

HUD_BEST_LEADER_ROW_0 equ %0000010000000000
HUD_BEST_LEADER_ROW_1 equ %0001101100000000
HUD_BEST_LEADER_ROW_2 equ %0001000100000000
HUD_BEST_LEADER_ROW_3 equ %0001101100000000
HUD_BEST_LEADER_ROW_4 equ %0000010000000000
HUD_BEST_LEADER_ROW_5 equ %0000000000000000

HUD_WINNER_ROW_M_1 equ %0000111000000000
HUD_WINNER_ROW_0 equ   %0001101100000000
HUD_WINNER_ROW_1 equ   %0010000010000000
HUD_WINNER_ROW_2 equ   %0010000010000000
HUD_WINNER_ROW_3 equ   %0010000010000000
HUD_WINNER_ROW_4 equ   %0001101100000000
HUD_WINNER_ROW_5 equ   %0000111000000000

HUD_INDICATOR_ROW_1_COLOR equ $666
HUD_INDICATOR_ROW_2_COLOR equ $FFF
HUD_INDICATOR_ROW_3_COLOR equ $666

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
; - d1.l x offset on hud where to print
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
    ;STORECARPROPERTY    TIME_OFFSET,d1

    ;lea                 TIMETXT(pc),a0
    ;jsr                 dec2txt ; after this call buffer will be 01 02 03 04 05
    ;move.l              TIME_OFFSET_STR(a2),a0
    ;bsr.w               TXT_INCR

    ; Print the timer of the car - start
    ;lea                 TIMETXT(pc),a0 ; string to print

    move.l              TIME_OFFSET_STR(a2),a0
    ;moveq               #6,d7 ; length of the string

    moveq #0,d1
    moveq #0,d2
    STORECARPROPERTY    HUD_POSITION_X,d1
    STORECARPROPERTY    HUD_POSITION_Y,d2
    ;jsr                 PRINT_STRING_ON_HUD
    bsr.w               INCREMENT_AND_PRINT_CAR_TIMER
    ; Print the timer of the car - end
update_timer_end:
    movem.l             (sp)+,a0/a1/d0/d7
    rts

UPDATE_BEST_TIMER:
    movem.l             a0/a1/d0/d1/d2/d7,-(sp)

    ; delete former best lap car
    move.l              RACE_BEST_LAP_CAR_PTR,a1
    cmp.l               #0,a1
    beq.s               noformerbestlapleader
    exg                 a1,a2
    STORECARPROPERTY    HUD_POSITION_X,d1
    lea                 DASHBOARD_DATA_2,a0
    add.w               d1,a0
    eori.w              #HUD_BEST_TIME_ROW_1,2+(40*6)(a0)
    eori.w              #HUD_BEST_TIME_ROW_2,2+(40*7)(a0)
    eori.w              #HUD_BEST_TIME_ROW_3,2+(40*8)(a0)
    eori.w              #HUD_BEST_TIME_ROW_4,2+(40*9)(a0)
    eori.w              #HUD_BEST_TIME_ROW_5,2+(40*10)(a0)

    ori.w               #HUD_BEST_TIME_ROW_1,256*40+2+(40*6)(a0)
    ori.w               #HUD_BEST_TIME_ROW_2,256*40+2+(40*7)(a0)
    ori.w               #HUD_BEST_TIME_ROW_3,256*40+2+(40*8)(a0)
    ori.w               #HUD_BEST_TIME_ROW_4,256*40+2+(40*9)(a0)
    ori.w               #HUD_BEST_TIME_ROW_5,256*40+2+(40*10)(a0)
    exg                 a1,a2
noformerbestlapleader:


    STORECARPROPERTY    HUD_POSITION_X,d1
    lea                 DASHBOARD_DATA_2,a0
    add.w               d1,a0
    ori.w               #HUD_BEST_TIME_ROW_1,2+(40*6)(a0)
    ori.w               #HUD_BEST_TIME_ROW_2,2+(40*7)(a0)
    ori.w               #HUD_BEST_TIME_ROW_3,2+(40*8)(a0)
    ori.w               #HUD_BEST_TIME_ROW_4,2+(40*9)(a0)
    ori.w               #HUD_BEST_TIME_ROW_5,2+(40*10)(a0)

    eori.w               #HUD_BEST_TIME_ROW_1,256*40+2+(40*6)(a0)
    eori.w               #HUD_BEST_TIME_ROW_2,256*40+2+(40*7)(a0)
    eori.w               #HUD_BEST_TIME_ROW_3,256*40+2+(40*8)(a0)
    eori.w               #HUD_BEST_TIME_ROW_4,256*40+2+(40*9)(a0)
    eori.w               #HUD_BEST_TIME_ROW_5,256*40+2+(40*10)(a0)

    movem.l             (sp)+,a0/a1/d0/d1/d2/d7                 
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
MAX_LAP: dc.w 0
LAPS_TABLE:
    dc.l 0                                  ; 0
    dc.l %10000000000000000000000000000000  ; 1
    dc.l %11000000000000000000000000000000  ; 2
    dc.l %11100000000000000000000000000000  ; 3
    dc.l %11110000000000000000000000000000  ; 4
    dc.l %11111000000000000000000000000000  ; 5
    dc.l %11111100000000000000000000000000  ; 6
    dc.l %11111110000000000000000000000000  ; 7
    dc.l %11111111000000000000000000000000  ; 8
    dc.l %11111111100000000000000000000000  ; 9
    dc.l %11111111110000000000000000000000  ; 10
    dc.l %11111111111000000000000000000000  ; 11
    dc.l %11111111111100000000000000000000  ; 12
    dc.l %11111111111110000000000000000000  ; 13
    dc.l %11111111111111000000000000000000  ; 14
    dc.l %11111111111111100000000000000000  ; 15
    dc.l %11111111111111110000000000000000  ; 16
    dc.l %11111111111111111000000000000000  ; 17
    dc.l %11111111111111111100000000000000  ; 18
    dc.l %11111111111111111110000000000000  ; 19
    dc.l %11111111111111111111000000000000  ; 20
    dc.l %11111111111111111111100000000000  ; 21
    dc.l %11111111111111111111110000000000  ; 22
    dc.l %11111111111111111111111000000000  ; 23
    dc.l %11111111111111111111111100000000  ; 24
    dc.l %11111111111111111111111110000000  ; 25
    dc.l %11111111111111111111111111000000  ; 26
    dc.l %11111111111111111111111111100000  ; 27
    dc.l %11111111111111111111111111110000  ; 28
    dc.l %11111111111111111111111111111000  ; 29
    dc.l %11111111111111111111111111111100  ; 30
    dc.l %11111111111111111111111111111110  ; 31
    dc.l %11111111111111111111111111111111  ; 32

UPDATE_LAP_COUNTER_HUD:
    movem.l             a0/a1/d0/d1/d2/d3/d4,-(sp)
    STORECARPROPERTY    LAP_COUNTER_OFFSET,d0
    cmp.w               MAX_LAP,d0
    bls.s               noupdatemaxlap
    
    move.w              d0,MAX_LAP
    move.w              MAX_LAP(PC),d0
    subq                #1,d0
    beq.s               skip_update_leading_leader
    bsr.w               UPDATE_LEADING_LEADER
skip_update_leading_leader:
    moveq               #0,d1
    move.w              LAP_RACE,d2
    subq                #1,d2
    moveq               #0,d3
    moveq               #64,d4

    jsr                 MAP
    lsl                 #2,d4

    ;IF_1_LESS_2_U_S      #32*4,d4,lapindicatorrightpart
    cmp.w                #32*4,d4
    bhi.s                lapindicatorrightpart

    lea                 LAPS_TABLE(PC),a0

    move.l              0(a0,d4.w),d0
    andi.l              #$7FFFFFFF,d0

    ;lea                 DASHBOARD_DATA_1+40*6-8,a1
    ;move.l              0(a0,d4.w),(a1)

    lea                 DASHBOARD_DATA_1+40*7-8,a1
    move.l              d0,(a1)

    lea                 DASHBOARD_DATA_1+40*8-8,a1
    move.l              d0,(a1)

    lea                 DASHBOARD_DATA_1+40*9-8,a1
    move.l              d0,(a1)

    ;lea                 DASHBOARD_DATA_1+40*10-8,a1
    ;move.l              0(a0,d4.w),(a1)
noupdatemaxlap:
    movem.l             (sp)+,a0/a1/d0/d1/d2/d3/d4
    rts

lapindicatorrightpart:
    subi.w              #32*4,d4
    lea                 LAPS_TABLE(PC),a0

    move.l              0(a0,d4.w),d0
    ori.l               #$1,d0
    bclr                #1,d0

    ;lea                 DASHBOARD_DATA_1+40*6-8,a1
    ;move.l              #$FFFFFFFF,(a1)+
    ;move.l              0(a0,d4.w),(a1)

    lea                 DASHBOARD_DATA_1+40*7-8,a1
    move.l              #$7FFFFFFF,(a1)+
    move.l              d0,(a1)

    lea                 DASHBOARD_DATA_1+40*8-8,a1
    move.l              #$7FFFFFFF,(a1)+
    move.l              d0,(a1)

    lea                 DASHBOARD_DATA_1+40*9-8,a1
    move.l              #$7FFFFFFF,(a1)+
    move.l              d0,(a1)

    ;lea                 DASHBOARD_DATA_1+40*10-8,a1
    ;move.l              #$FFFFFFFF,(a1)+
    ;move.l              0(a0,d4.w),(a1)

    movem.l             (sp)+,a0/a1/d0/d1/d2/d3/d4
    rts

UPDATE_LEADING_LEADER:
    movem.l             a0/a1/d0/d1/d2/d3/d4,-(sp)
    addi.w              #1,MOVER_LEADING_LAPS(a2)
    tst.l               RACE_LEADING_LEADER_PTR
    beq.w               draw_leading_leader_icon ; first lap
    move.l              RACE_LEADING_LEADER_PTR,a0

    ; same car, we dont need to update the already existing leading leder
    cmpa.l              a0,a2
    beq.w               hud_do_not_update_leading_leader
    STORECARPROPERTY    MOVER_LEADING_LAPS,d0
    move.w              MOVER_LEADING_LAPS(a0),d1

    IF_1_GREATER_2_W_U  d0,d1,hud_do_not_update_leading_leader,s
    move.w              HUD_POSITION_X(a0),d1
    lea                 DASHBOARD_DATA_1,a0
    add.w               d1,a0

    ori.w               #HUD_BEST_LEADER_ROW_0,2*256*40+2+(40*5)(a0)
    ori.w               #HUD_BEST_LEADER_ROW_1,2*256*40+2+(40*6)(a0)
    ori.w               #HUD_BEST_LEADER_ROW_2,2*256*40+2+(40*7)(a0)
    ori.w               #HUD_BEST_LEADER_ROW_3,2*256*40+2+(40*8)(a0)
    ori.w               #HUD_BEST_LEADER_ROW_4,2*256*40+2+(40*9)(a0)
    ori.w               #HUD_BEST_LEADER_ROW_5,2*256*40+2+(40*10)(a0)

    eori.w               #HUD_BEST_LEADER_ROW_0,1*256*40+2+(40*5)(a0)
    eori.w               #HUD_BEST_LEADER_ROW_1,1*256*40+2+(40*6)(a0)
    eori.w               #HUD_BEST_LEADER_ROW_2,1*256*40+2+(40*7)(a0)
    eori.w               #HUD_BEST_LEADER_ROW_3,1*256*40+2+(40*8)(a0)
    eori.w               #HUD_BEST_LEADER_ROW_4,1*256*40+2+(40*9)(a0)
    eori.w               #HUD_BEST_LEADER_ROW_5,1*256*40+2+(40*10)(a0)

    eori.w               #HUD_BEST_LEADER_ROW_0,0*256*40+2+(40*5)(a0)
    eori.w               #HUD_BEST_LEADER_ROW_1,0*256*40+2+(40*6)(a0)
    eori.w               #HUD_BEST_LEADER_ROW_2,0*256*40+2+(40*7)(a0)
    eori.w               #HUD_BEST_LEADER_ROW_3,0*256*40+2+(40*8)(a0)
    eori.w               #HUD_BEST_LEADER_ROW_4,0*256*40+2+(40*9)(a0)
    eori.w               #HUD_BEST_LEADER_ROW_5,0*256*40+2+(40*10)(a0)

    bra.s               draw_leading_leader_icon

hud_do_not_update_leading_leader:
    movem.l             (sp)+,a0/a1/d0/d1/d2/d3/d4
    rts
draw_leading_leader_icon:
    move.l              a2,RACE_LEADING_LEADER_PTR
    STORECARPROPERTY    HUD_POSITION_X,d1
    lea                 DASHBOARD_DATA_1,a0
    add.w               d1,a0
    ;eori.w              #HUD_BEST_TIME_ROW_1,2+(40*6)(a0)
    ;eori.w              #HUD_BEST_TIME_ROW_2,2+(40*7)(a0)
    ;eori.w              #HUD_BEST_TIME_ROW_3,2+(40*8)(a0)
    ;eori.w              #HUD_BEST_TIME_ROW_4,2+(40*9)(a0)
    ;eori.w              #HUD_BEST_TIME_ROW_5,2+(40*10)(a0)


    eori.w               #HUD_BEST_LEADER_ROW_0,2*256*40+2+(40*5)(a0)
    eori.w               #HUD_BEST_LEADER_ROW_1,2*256*40+2+(40*6)(a0)
    eori.w               #HUD_BEST_LEADER_ROW_2,2*256*40+2+(40*7)(a0)
    eori.w               #HUD_BEST_LEADER_ROW_3,2*256*40+2+(40*8)(a0)
    eori.w               #HUD_BEST_LEADER_ROW_4,2*256*40+2+(40*9)(a0)
    eori.w               #HUD_BEST_LEADER_ROW_5,2*256*40+2+(40*10)(a0)

    ori.w               #HUD_BEST_LEADER_ROW_0,1*256*40+2+(40*5)(a0)
    ori.w               #HUD_BEST_LEADER_ROW_1,1*256*40+2+(40*6)(a0)
    ori.w               #HUD_BEST_LEADER_ROW_2,1*256*40+2+(40*7)(a0)
    ori.w               #HUD_BEST_LEADER_ROW_3,1*256*40+2+(40*8)(a0)
    ori.w               #HUD_BEST_LEADER_ROW_4,1*256*40+2+(40*9)(a0)
    ori.w               #HUD_BEST_LEADER_ROW_5,1*256*40+2+(40*10)(a0)

    ori.w               #HUD_BEST_LEADER_ROW_0,0*256*40+2+(40*5)(a0)
    ori.w               #HUD_BEST_LEADER_ROW_1,0*256*40+2+(40*6)(a0)
    ori.w               #HUD_BEST_LEADER_ROW_2,0*256*40+2+(40*7)(a0)
    ori.w               #HUD_BEST_LEADER_ROW_3,0*256*40+2+(40*8)(a0)
    ori.w               #HUD_BEST_LEADER_ROW_4,0*256*40+2+(40*9)(a0)
    ori.w               #HUD_BEST_LEADER_ROW_5,0*256*40+2+(40*10)(a0)

    movem.l             (sp)+,a0/a1/d0/d1/d2/d3/d4
    rts

UPDATE_WINNER:
    movem.l             a0/d1,-(sp)
    move.w              HUD_POSITION_X(a0),d1
    lea                 DASHBOARD_DATA_1,a0
    add.w               d1,a0
    ori                 #HUD_WINNER_ROW_M_1,2+(40*4)(a0)
    ori.w               #HUD_WINNER_ROW_0,2+(40*5)(a0)
    ori.w               #HUD_WINNER_ROW_1,2+(40*6)(a0)
    ori.w               #HUD_WINNER_ROW_2,2+(40*7)(a0)
    ori.w               #HUD_WINNER_ROW_3,2+(40*8)(a0)
    ori.w               #HUD_WINNER_ROW_4,2+(40*9)(a0)
    ori.w               #HUD_WINNER_ROW_5,2+(40*10)(a0)

    ori                 #HUD_WINNER_ROW_M_1,256*40+2+(40*4)(a0)
    ori.w               #HUD_WINNER_ROW_0,256*40+2+(40*5)(a0)
    ori.w               #HUD_WINNER_ROW_1,256*40+2+(40*6)(a0)
    ori.w               #HUD_WINNER_ROW_2,256*40+2+(40*7)(a0)
    ori.w               #HUD_WINNER_ROW_3,256*40+2+(40*8)(a0)
    ori.w               #HUD_WINNER_ROW_4,256*40+2+(40*9)(a0)
    ori.w               #HUD_WINNER_ROW_5,256*40+2+(40*10)(a0)
    movem.l             (sp)+,a0/d1
    rts


; increment and prints the string part of the timer for a car
; d1 - x position where to print
; d2 - y position where to print
; a0 - address of the string to print
INCREMENT_AND_PRINT_CAR_TIMER_MUL_TAB:
    dc.b 0*SIZE_OF_CHAR_BITMAP*3
    dc.b 1*SIZE_OF_CHAR_BITMAP*3
    dc.b 2*SIZE_OF_CHAR_BITMAP*3
    dc.b 3*SIZE_OF_CHAR_BITMAP*3
    dc.b 4*SIZE_OF_CHAR_BITMAP*3
    dc.b 5*SIZE_OF_CHAR_BITMAP*3
    dc.b 6*SIZE_OF_CHAR_BITMAP*3
    dc.b 7*SIZE_OF_CHAR_BITMAP*3
    dc.b 8*SIZE_OF_CHAR_BITMAP*3
    dc.b 9*SIZE_OF_CHAR_BITMAP*3
    even

INCREMENT_AND_PRINT_CAR_TIMER_TXT: dc.b 0,0,0,1
INCREMENT_AND_PRINT_CAR_TIMER:
    movem.l a1/a3/a4/a5/d0/d4,-(sp)
    lea                    INCREMENT_AND_PRINT_CAR_TIMER_MUL_TAB(PC),a5

    ;move.l #$99,(a0)

    ; fetch the current timer of the car
    move.l a0,a1
    addq #4,a1
    lea 4+INCREMENT_AND_PRINT_CAR_TIMER_TXT(PC),a3

    ; clean extend bit
    MOVE #$04,CCR

    ; do decimal add
    abcd -(a3),-(a1)
    abcd -(a3),-(a1)
    abcd -(a3),-(a1)

    movem.l                (sp)+,a1/a3/a4/a5/d0/d4
    rts

    ;fetch result into d0
    move.l (a0),d0

    ; make a copy into d4, will use it later
    move.l                 d0,d4

    ; take the lower nibble
    andi.w                 #$f,d0

    ; load font
    move.b                 (a5,d0.w),d0
    lea                    TIMER_FONTS_SMALL(PC),a1
    adda.w                 d0,a1

    ; load bitplane where to copy
    lea                    DASHBOARD_DATA_1,a3
    adda.w                 d1,a3
    adda.w                 d2,a3
    move.l                 a3,a4
    addq                   #5,a3

    ; write font into bitplane
    move.b                 7(a1),40*256(a3) ; write first raw second bitplane
    move.b                 14(a1),40*256*2(a3) ; write first raw third bitplane
    move.b                 (a1)+,(a3) ; write first raw first bitplane
    adda.w                 #40,a3

    move.b                 7(a1),40*256(a3) ; write second raw second bitplane
    move.b                 14(a1),40*256*2(a3) ; write second raw third bitplane
    move.b                 (a1)+,(a3) ; write secon raw first bitplane
    adda.w                 #40,a3

    move.b                 7(a1),40*256(a3) ; write third raw second bitplane
    move.b                 14(a1),40*256*2(a3) ; write third raw third bitplane
    move.b                 (a1)+,40(a3) ; write third raw first bitplane
    adda.w                 #40,a3

    move.b                 7(a1),40*256(a3) ; write fourth raw second bitplane
    move.b                 14(a1),40*256*2(a3) ; write fourth raw third bitplane
    move.b                 (a1)+,(a3) ; write fourth raw first bitplane
    adda.w                 #40,a3

    move.b                 7(a1),40*256(a3) ; write fifth raw second bitplane
    move.b                 14(a1),40*256*2(a3) ; write fifth raw third bitplane
    move.b                 (a1)+,(a3) ; write fifth raw first bitplane
    adda.w                 #40,a3

    move.b                 7(a1),40*256(a3) ; write sixth raw second bitplane
    move.b                 14(a1),40*256*2(a3) ; write sixth raw third bitplane
    move.b                 (a1)+,(a3) ; write sixth raw first bitplane
    adda.w                 #40,a3

    move.b                 7(a1),40*256(a3) ; write seventh raw second bitplane
    move.b                 14(a1),40*256*2(a3) ; write seventh raw first bitplane
    move.b                 (a1),(a3) ; write seventh raw first bitplane

    move.l                 a4,a3
    addq                   #4,a3

    move.l                 d4,d0
    lsr.w                  #4,d0
    andi.w                 #$F,d0
    ; load font

    move.b                 (a5,d0.w),d0

    lea                    TIMER_FONTS_SMALL(PC),a1
    adda.w                 d0,a1

    ; write font into bitplane
    move.b                 7(a1),40*256(a3) ; write first raw second bitplane
    move.b                 14(a1),40*256*2(a3) ; write first raw third bitplane
    move.b                 (a1)+,(a3) ; write first raw first bitplane
    adda.w                 #40,a3

    move.b                 7(a1),40*256(a3) ; write second raw second bitplane
    move.b                 14(a1),40*256*2(a3) ; write second raw third bitplane
    move.b                 (a1)+,(a3) ; write secon raw first bitplane
    adda.w                 #40,a3

    move.b                 7(a1),40*256(a3) ; write third raw second bitplane
    move.b                 14(a1),40*256*2(a3) ; write third raw third bitplane
    move.b                 (a1)+,40(a3) ; write third raw first bitplane
    adda.w                 #40,a3

    move.b                 7(a1),40*256(a3) ; write fourth raw second bitplane
    move.b                 14(a1),40*256*2(a3) ; write fourth raw third bitplane
    move.b                 (a1)+,(a3) ; write fourth raw first bitplane
    adda.w                 #40,a3

    move.b                 7(a1),40*256(a3) ; write fifth raw second bitplane
    move.b                 14(a1),40*256*2(a3) ; write fifth raw third bitplane
    move.b                 (a1)+,(a3) ; write fifth raw first bitplane
    adda.w                 #40,a3

    move.b                 7(a1),40*256(a3) ; write sixth raw second bitplane
    move.b                 14(a1),40*256*2(a3) ; write sixth raw third bitplane
    move.b                 (a1)+,(a3) ; write sixth raw first bitplane
    adda.w                 #40,a3

    move.b                 7(a1),40*256(a3) ; write seventh raw second bitplane
    move.b                 14(a1),40*256*2(a3) ; write seventh raw first bitplane
    move.b                 (a1),(a3) ; write seventh raw first bitplane






    move.l                 a4,a3
    addq                   #3,a3

    move.l                 d4,d0
    lsr.w                  #8,d0
    andi.l                 #$F,d0

    move.b                 (a5,d0.w),d0

    ; load font
    lea                    TIMER_FONTS_SMALL(PC),a1
    adda.w                 d0,a1

    ; write font into bitplane
    move.b                 7(a1),40*256(a3) ; write first raw second bitplane
    move.b                 14(a1),40*256*2(a3) ; write first raw third bitplane
    move.b                 (a1)+,(a3) ; write first raw first bitplane
    adda.w                 #40,a3

    move.b                 7(a1),40*256(a3) ; write second raw second bitplane
    move.b                 14(a1),40*256*2(a3) ; write second raw third bitplane
    move.b                 (a1)+,(a3) ; write secon raw first bitplane
    adda.w                 #40,a3

    move.b                 7(a1),40*256(a3) ; write third raw second bitplane
    move.b                 14(a1),40*256*2(a3) ; write third raw third bitplane
    move.b                 (a1)+,40(a3) ; write third raw first bitplane
    adda.w                 #40,a3

    move.b                 7(a1),40*256(a3) ; write fourth raw second bitplane
    move.b                 14(a1),40*256*2(a3) ; write fourth raw third bitplane
    move.b                 (a1)+,(a3) ; write fourth raw first bitplane
    adda.w                 #40,a3

    move.b                 7(a1),40*256(a3) ; write fifth raw second bitplane
    move.b                 14(a1),40*256*2(a3) ; write fifth raw third bitplane
    move.b                 (a1)+,(a3) ; write fifth raw first bitplane
    adda.w                 #40,a3

    move.b                 7(a1),40*256(a3) ; write sixth raw second bitplane
    move.b                 14(a1),40*256*2(a3) ; write sixth raw third bitplane
    move.b                 (a1)+,(a3) ; write sixth raw first bitplane
    adda.w                 #40,a3

    move.b                 7(a1),40*256(a3) ; write seventh raw second bitplane
    move.b                 14(a1),40*256*2(a3) ; write seventh raw first bitplane
    move.b                 (a1),(a3) ; write seventh raw first bitplane










    move.l                 a4,a3
    addq                   #2,a3

    move.l                 d4,d0
    rol.w                  #4,d0
    andi.l                 #$F,d0

    move.b                 (a5,d0.w),d0

    ; load font
    lea                    TIMER_FONTS_SMALL(PC),a1
    adda.w                 d0,a1

    ; write font into bitplane
    move.b                 7(a1),40*256(a3) ; write first raw second bitplane
    move.b                 14(a1),40*256*2(a3) ; write first raw third bitplane
    move.b                 (a1)+,(a3) ; write first raw first bitplane
    adda.w                 #40,a3

    move.b                 7(a1),40*256(a3) ; write second raw second bitplane
    move.b                 14(a1),40*256*2(a3) ; write second raw third bitplane
    move.b                 (a1)+,(a3) ; write secon raw first bitplane
    adda.w                 #40,a3

    move.b                 7(a1),40*256(a3) ; write third raw second bitplane
    move.b                 14(a1),40*256*2(a3) ; write third raw third bitplane
    move.b                 (a1)+,40(a3) ; write third raw first bitplane
    adda.w                 #40,a3

    move.b                 7(a1),40*256(a3) ; write fourth raw second bitplane
    move.b                 14(a1),40*256*2(a3) ; write fourth raw third bitplane
    move.b                 (a1)+,(a3) ; write fourth raw first bitplane
    adda.w                 #40,a3

    move.b                 7(a1),40*256(a3) ; write fifth raw second bitplane
    move.b                 14(a1),40*256*2(a3) ; write fifth raw third bitplane
    move.b                 (a1)+,(a3) ; write fifth raw first bitplane
    adda.w                 #40,a3

    move.b                 7(a1),40*256(a3) ; write sixth raw second bitplane
    move.b                 14(a1),40*256*2(a3) ; write sixth raw third bitplane
    move.b                 (a1)+,(a3) ; write sixth raw first bitplane
    adda.w                 #40,a3

    move.b                 7(a1),40*256(a3) ; write seventh raw second bitplane
    move.b                 14(a1),40*256*2(a3) ; write seventh raw first bitplane
    move.b                 (a1),(a3) ; write seventh raw first bitplane






    move.l                 a4,a3
    addq                   #1,a3

    move.l                 d4,d0
    swap                   d0
    andi.l                 #$F,d0
    move.b                 (a5,d0.w),d0
    ; load font
    lea                    TIMER_FONTS_SMALL(PC),a1
    adda.w                 d0,a1

    ; write font into bitplane
    move.b                 7(a1),40*256(a3) ; write first raw second bitplane
    move.b                 14(a1),40*256*2(a3) ; write first raw third bitplane
    move.b                 (a1)+,(a3) ; write first raw first bitplane
    adda.w                 #40,a3

    move.b                 7(a1),40*256(a3) ; write second raw second bitplane
    move.b                 14(a1),40*256*2(a3) ; write second raw third bitplane
    move.b                 (a1)+,(a3) ; write secon raw first bitplane
    adda.w                 #40,a3

    move.b                 7(a1),40*256(a3) ; write third raw second bitplane
    move.b                 14(a1),40*256*2(a3) ; write third raw third bitplane
    move.b                 (a1)+,40(a3) ; write third raw first bitplane
    adda.w                 #40,a3

    move.b                 7(a1),40*256(a3) ; write fourth raw second bitplane
    move.b                 14(a1),40*256*2(a3) ; write fourth raw third bitplane
    move.b                 (a1)+,(a3) ; write fourth raw first bitplane
    adda.w                 #40,a3

    move.b                 7(a1),40*256(a3) ; write fifth raw second bitplane
    move.b                 14(a1),40*256*2(a3) ; write fifth raw third bitplane
    move.b                 (a1)+,(a3) ; write fifth raw first bitplane
    adda.w                 #40,a3

    move.b                 7(a1),40*256(a3) ; write sixth raw second bitplane
    move.b                 14(a1),40*256*2(a3) ; write sixth raw third bitplane
    move.b                 (a1)+,(a3) ; write sixth raw first bitplane
    adda.w                 #40,a3

    move.b                 7(a1),40*256(a3) ; write seventh raw second bitplane
    move.b                 14(a1),40*256*2(a3) ; write seventh raw first bitplane
    move.b                 (a1),(a3) ; write seventh raw first bitplane





    move.l                 a4,a3

    move.l                 d4,d0
    swap                   d0
    lsr.w                  #4,d0
    andi.l                 #$F,d0
    move.b                 (a5,d0.w),d0

    ; load font
    lea                    TIMER_FONTS_SMALL(PC),a1
    adda.w                 d0,a1

    ; write font into bitplane
    move.b                 7(a1),40*256(a3) ; write first raw second bitplane
    move.b                 14(a1),40*256*2(a3) ; write first raw third bitplane
    move.b                 (a1)+,(a3) ; write first raw first bitplane
    adda.w                 #40,a3

    move.b                 7(a1),40*256(a3) ; write second raw second bitplane
    move.b                 14(a1),40*256*2(a3) ; write second raw third bitplane
    move.b                 (a1)+,(a3) ; write secon raw first bitplane
    adda.w                 #40,a3

    move.b                 7(a1),40*256(a3) ; write third raw second bitplane
    move.b                 14(a1),40*256*2(a3) ; write third raw third bitplane
    move.b                 (a1)+,40(a3) ; write third raw first bitplane
    adda.w                 #40,a3

    move.b                 7(a1),40*256(a3) ; write fourth raw second bitplane
    move.b                 14(a1),40*256*2(a3) ; write fourth raw third bitplane
    move.b                 (a1)+,(a3) ; write fourth raw first bitplane
    adda.w                 #40,a3

    move.b                 7(a1),40*256(a3) ; write fifth raw second bitplane
    move.b                 14(a1),40*256*2(a3) ; write fifth raw third bitplane
    move.b                 (a1)+,(a3) ; write fifth raw first bitplane
    adda.w                 #40,a3

    move.b                 7(a1),40*256(a3) ; write sixth raw second bitplane
    move.b                 14(a1),40*256*2(a3) ; write sixth raw third bitplane
    move.b                 (a1)+,(a3) ; write sixth raw first bitplane
    adda.w                 #40,a3

    move.b                 7(a1),40*256(a3) ; write seventh raw second bitplane
    move.b                 14(a1),40*256*2(a3) ; write seventh raw first bitplane
    move.b                 (a1),(a3) ; write seventh raw first bitplane

    movem.l                (sp)+,a1/a3/a4/a5/d0/d4
    rts