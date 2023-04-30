RESULT_COLUMN_0_X   EQU 0
RESULT_COLUMN_1_X   EQU 5
RESULT_COLUMN_2_X   EQU 19
RESULT_COLUMN_3_X   EQU 34

RESULT_COLUMN_0_Y   EQU 2
RESULT_COLUMN_1_Y   EQU 4
RESULT_COLUMN_2_Y   EQU 6
RESULT_COLUMN_3_Y   EQU 8
RESULT_COLUMN_4_Y   EQU 10
RESULT_COLUMN_5_Y   EQU 12
RESULT_COLUMN_6_Y   EQU 14
RESULT_COLUMN_7_Y   EQU 16

RESULT_FILENAME:
    dc.b "raceresult.data",0
    even

EXIT_TO_NEXT_RACE:
    dc.b "NEXT RACE",$FF
    even

TXT_RESULT_FIRST_PLACE:
    dc.b "1ST",$FF
TXT_RESULT_FIRST_PLACE_NAME:
    dc.b "CAR  ",$FF
TXT_RESULT_SECOND_PLACE:
    dc.b "2ND",$FF
TXT_RESULT_SECOND_PLACE_NAME:
    dc.b "CAR  ",$FF
TXT_RESULT_THIRD_PLACE:
    dc.b "3RD",$FF
TXT_RESULT_THIRD_PLACE_NAME:
    dc.b "CAR  ",$FF
TXT_RESULT_FOURTH_PLACE:
    dc.b "4TH",$FF
TXT_RESULT_FOURTH_PLACE_NAME:
    dc.b "CAR  ",$FF
TXT_RESULT_FIFTH_PLACE:
    dc.b "5TH",$FF
TXT_RESULT_FIFTH_PLACE_NAME:
    dc.b "CAR  ",$FF
TXT_RESULT_SIXTH_PLACE:
    dc.b "6TH",$FF
TXT_RESULT_SIXTH_PLACE_NAME:
    dc.b "CAR  ",$FF
TXT_RESULT_SEVENTH_PLACE:
    dc.b "7TH",$FF
TXT_RESULT_SEVENTH_PLACE_NAME:
    dc.b "CAR  ",$FF
TXT_RESULT_EIGHTH_PLACE:
    dc.b "8TH",$FF
TXT_RESULT_EIGHTH_PLACE_NAME:
    dc.b "CAR  ",$FF

TXT_CAR_1_TIME_TXT:
    dc.b "000000",$FF
    even
TXT_CAR_2_TIME_TXT:
    dc.b "000000",$FF
    even
TXT_CAR_3_TIME_TXT:
    dc.b "000000",$FF
    even
TXT_CAR_4_TIME_TXT:
    dc.b "000000",$FF
    even
TXT_CAR_5_TIME_TXT:
    dc.b "000000",$FF
    even
TXT_CAR_6_TIME_TXT:
    dc.b "000000",$FF
    even
TXT_CAR_7_TIME_TXT:
    dc.b "000000",$FF
    even
TXT_CAR_8_TIME_TXT:
    dc.b "000000",$FF
    even

EXIT_TO_NEXT_RACE_FUNCTION:
    move.w  #1,MAIN_EXIT
    rts

RESULT_MENU_MAIN:

    dc.w 5,11
    dc.l EXIT_TO_NEXT_RACE
    dc.l EXIT_TO_NEXT_RACE_FUNCTION
    dc.l 0
    dc.w 16
    dc.w 16

    dc.w 0,0
    dc.l 0
    dc.l 0
    dc.l 0
    dc.w 0
    dc.w 0

TXT_RESULT:
    dc.w 1,1
    dc.l TXT_RESULT_FIRST_PLACE
    dc.w 8,7

    dc.w 13,1
    dc.l TXT_RESULT_FIRST_PLACE_NAME
    dc.w 8,7

    dc.w 22,1
    dc.l TXT_RESULT_FIRST_PLACE_NAME
    dc.w 8,7

    dc.w 34,1
    dc.l TXT_CAR_1_TIME_TXT
    dc.w 8,7

    dc.w 1,3
    dc.l TXT_RESULT_SECOND_PLACE
    dc.w 8,7

    dc.w 13,3
    dc.l TXT_RESULT_SECOND_PLACE_NAME
    dc.w 8,7

    dc.w 22,3
    dc.l TXT_RESULT_SECOND_PLACE_NAME
    dc.w 8,7

    dc.w 34,3
    dc.l TXT_CAR_2_TIME_TXT
    dc.w 8,7

    dc.w 1,5
    dc.l TXT_RESULT_THIRD_PLACE
    dc.w 8,7

    dc.w 13,5
    dc.l TXT_RESULT_THIRD_PLACE_NAME
    dc.w 8,7

    dc.w 22,5
    dc.l TXT_RESULT_THIRD_PLACE_NAME
    dc.w 8,7

    dc.w 34,5
    dc.l TXT_CAR_3_TIME_TXT
    dc.w 8,7

    dc.w 1,7
    dc.l TXT_RESULT_FOURTH_PLACE
    dc.w 8,7

    dc.w 13,7
    dc.l TXT_RESULT_FOURTH_PLACE_NAME
    dc.w 8,7

    dc.w 22,7
    dc.l TXT_RESULT_FOURTH_PLACE_NAME
    dc.w 8,7

    dc.w 34,7
    dc.l TXT_CAR_4_TIME_TXT
    dc.w 8,7

    dc.w 1,9
    dc.l TXT_RESULT_FIFTH_PLACE
    dc.w 8,7

    dc.w 13,9
    dc.l TXT_RESULT_FIFTH_PLACE_NAME
    dc.w 8,7

    dc.w 22,9
    dc.l TXT_RESULT_FIFTH_PLACE_NAME
    dc.w 8,7

    dc.w 34,9
    dc.l TXT_CAR_5_TIME_TXT
    dc.w 8,7

    dc.w 1,11
    dc.l TXT_RESULT_SIXTH_PLACE
    dc.w 8,7

    dc.w 13,11
    dc.l TXT_RESULT_SIXTH_PLACE_NAME
    dc.w 8,7

    dc.w 22,11
    dc.l TXT_RESULT_SIXTH_PLACE_NAME
    dc.w 8,7

    dc.w 34,11
    dc.l TXT_CAR_6_TIME_TXT
    dc.w 8,7

    dc.w 1,13
    dc.l TXT_RESULT_SEVENTH_PLACE
    dc.w 8,7

    dc.w 13,13
    dc.l TXT_RESULT_SEVENTH_PLACE_NAME
    dc.w 8,7

    dc.w 22,13
    dc.l TXT_RESULT_SEVENTH_PLACE_NAME
    dc.w 8,7

    dc.w 34,13
    dc.l TXT_CAR_7_TIME_TXT
    dc.w 8,7

    dc.w 1,15
    dc.l TXT_RESULT_EIGHTH_PLACE
    dc.w 8,7

    dc.w 13,15
    dc.l TXT_RESULT_EIGHTH_PLACE_NAME
    dc.w 8,7

    dc.w 22,15
    dc.l TXT_RESULT_EIGHTH_PLACE_NAME
    dc.w 8,7

    dc.w 34,15
    dc.l TXT_CAR_8_TIME_TXT
    dc.w 8,7

    dc.w 0,0
    dc.l 0
    dc.w 0,7

MENU_RESULTS_CURRENTLY_SELECTED:
    dc.l    RESULT_MENU_MAIN

RESULTSCREEN:

    DISABLE_AUDIO_DMA

    ;reset race flag in case we are returning here after the race
    move.w              #0,START_RACE_FLAG
    move.w              #1,LOAD_NEXT_TRACK_FLAG

    ; clean all txt first
    moveq               #MAX_CARS-1,d7
    lea                 TXT_RESULT(PC),a0
resultscreen_cleanloop:
    clr.l               (a0)+
    clr.l               (a0)+
    clr.l               (a0)+
    clr.l               (a0)+
    dbra                d7,resultscreen_cleanloop

    ; prepare txt according to the arrival order
    lea                 TXT_RESULT(PC),a0

    ; first place
    move.l              ARRIVAL_ORDER,a1
    tst.l               (a1)
    beq.w               result_draw_menu
    move.w              #RESULT_COLUMN_0_X,(a0)+
    move.w              #RESULT_COLUMN_0_Y,(a0)+
    move.l              #TXT_RESULT_FIRST_PLACE,(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

    move.w              #RESULT_COLUMN_1_X,(a0)+
    move.w              #RESULT_COLUMN_0_Y,(a0)+
    move.l              MOVER_PLAYER_NAME_ADDR(a1),(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

    move.w              #RESULT_COLUMN_2_X,(a0)+
    move.w              #RESULT_COLUMN_0_Y,(a0)+
    move.l              MOVER_PLAYER_TEAM_ADDR(a1),(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

    move.w              #RESULT_COLUMN_3_X,(a0)+
    move.w              #RESULT_COLUMN_0_Y,(a0)+
    lea                 TXT_CAR_1_TIME_TXT(PC),a2
    bsr.w               NIBBLE_TO_BYTE
    move.l              #TXT_CAR_1_TIME_TXT,(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

    ; second place
    move.l              ARRIVAL_ORDER+4,a1
    tst.l               (a1)
    beq.w               result_draw_menu

    move.w              #RESULT_COLUMN_0_X,(a0)+
    move.w              #RESULT_COLUMN_1_Y,(a0)+
    move.l              #TXT_RESULT_SECOND_PLACE,(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

    move.w              #RESULT_COLUMN_1_X,(a0)+
    move.w              #RESULT_COLUMN_1_Y,(a0)+
    move.l              MOVER_PLAYER_NAME_ADDR(a1),(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

    move.w              #RESULT_COLUMN_2_X,(a0)+
    move.w              #RESULT_COLUMN_1_Y,(a0)+
    move.l              MOVER_PLAYER_TEAM_ADDR(a1),(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

    move.w              #RESULT_COLUMN_3_X,(a0)+
    move.w              #RESULT_COLUMN_1_Y,(a0)+
    lea                 TXT_CAR_2_TIME_TXT(PC),a2
    bsr.w               NIBBLE_TO_BYTE
    move.l              #TXT_CAR_2_TIME_TXT,(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

    ; third place
    move.l              ARRIVAL_ORDER+8,a1
    tst.l               (a1)
    beq.w               result_draw_menu

    move.w              #RESULT_COLUMN_0_X,(a0)+
    move.w              #RESULT_COLUMN_2_Y,(a0)+
    move.l              #TXT_RESULT_THIRD_PLACE,(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

    move.w              #RESULT_COLUMN_1_X,(a0)+
    move.w              #RESULT_COLUMN_2_Y,(a0)+
    move.l              MOVER_PLAYER_NAME_ADDR(a1),(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

    move.w              #RESULT_COLUMN_2_X,(a0)+
    move.w              #RESULT_COLUMN_2_Y,(a0)+
    move.l              MOVER_PLAYER_TEAM_ADDR(a1),(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

    move.w              #RESULT_COLUMN_3_X,(a0)+
    move.w              #RESULT_COLUMN_2_Y,(a0)+
    lea                 TXT_CAR_3_TIME_TXT(PC),a2
    bsr.w               NIBBLE_TO_BYTE
    move.l              #TXT_CAR_3_TIME_TXT,(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

    ; fourth place
    move.l              ARRIVAL_ORDER+12,a1
    tst.l               (a1)
    beq.w               result_draw_menu

    move.w              #RESULT_COLUMN_0_X,(a0)+
    move.w              #RESULT_COLUMN_3_Y,(a0)+
    move.l              #TXT_RESULT_FOURTH_PLACE,(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

    move.w              #RESULT_COLUMN_1_X,(a0)+
    move.w              #RESULT_COLUMN_3_Y,(a0)+
    move.l              MOVER_PLAYER_NAME_ADDR(a1),(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

    move.w              #RESULT_COLUMN_2_X,(a0)+
    move.w              #RESULT_COLUMN_3_Y,(a0)+
    move.l              MOVER_PLAYER_TEAM_ADDR(a1),(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

    move.w              #RESULT_COLUMN_3_X,(a0)+
    move.w              #RESULT_COLUMN_3_Y,(a0)+
    lea                 TXT_CAR_4_TIME_TXT(PC),a2
    bsr.w               NIBBLE_TO_BYTE
    move.l              #TXT_CAR_4_TIME_TXT,(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

    ; fifth place
    move.l              ARRIVAL_ORDER+16,a1
    tst.l               (a1)
    beq.w               result_draw_menu

    move.w              #RESULT_COLUMN_0_X,(a0)+
    move.w              #RESULT_COLUMN_4_Y,(a0)+
    move.l              #TXT_RESULT_FIFTH_PLACE,(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

    move.w              #RESULT_COLUMN_1_X,(a0)+
    move.w              #RESULT_COLUMN_4_Y,(a0)+
    move.l              MOVER_PLAYER_NAME_ADDR(a1),(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

    move.w              #RESULT_COLUMN_2_X,(a0)+
    move.w              #RESULT_COLUMN_4_Y,(a0)+
    move.l              MOVER_PLAYER_TEAM_ADDR(a1),(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

    move.w              #RESULT_COLUMN_3_X,(a0)+
    move.w              #RESULT_COLUMN_4_Y,(a0)+
    lea                 TXT_CAR_5_TIME_TXT(PC),a2
    bsr.w               NIBBLE_TO_BYTE
    move.l              #TXT_CAR_5_TIME_TXT,(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

     ; sixth place
    move.l              ARRIVAL_ORDER+20,a1
    tst.l               (a1)
    beq.w               result_draw_menu

    move.w              #RESULT_COLUMN_0_X,(a0)+
    move.w              #RESULT_COLUMN_5_Y,(a0)+
    move.l              #TXT_RESULT_SIXTH_PLACE,(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

    move.w              #RESULT_COLUMN_1_X,(a0)+
    move.w              #RESULT_COLUMN_5_Y,(a0)+
    move.l              MOVER_PLAYER_NAME_ADDR(a1),(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

    move.w              #RESULT_COLUMN_2_X,(a0)+
    move.w              #RESULT_COLUMN_5_Y,(a0)+
    move.l              MOVER_PLAYER_TEAM_ADDR(a1),(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

    move.w              #RESULT_COLUMN_3_X,(a0)+
    move.w              #RESULT_COLUMN_5_Y,(a0)+
    lea                 TXT_CAR_6_TIME_TXT(PC),a2
    bsr.w               NIBBLE_TO_BYTE
    move.l              #TXT_CAR_6_TIME_TXT,(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

     ; seventh place
    move.l              ARRIVAL_ORDER+24,a1
    tst.l               (a1)
    beq.w               result_draw_menu

    move.w              #RESULT_COLUMN_0_X,(a0)+
    move.w              #RESULT_COLUMN_6_Y,(a0)+
    move.l              #TXT_RESULT_SEVENTH_PLACE,(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

    move.w              #RESULT_COLUMN_1_X,(a0)+
    move.w              #RESULT_COLUMN_6_Y,(a0)+
    move.l              MOVER_PLAYER_NAME_ADDR(a1),(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

    move.w              #RESULT_COLUMN_2_X,(a0)+
    move.w              #RESULT_COLUMN_6_Y,(a0)+
    move.l              MOVER_PLAYER_TEAM_ADDR(a1),(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

    move.w              #RESULT_COLUMN_3_X,(a0)+
    move.w              #RESULT_COLUMN_6_Y,(a0)+
    lea                 TXT_CAR_7_TIME_TXT(PC),a2
    bsr.w               NIBBLE_TO_BYTE
    move.l              #TXT_CAR_7_TIME_TXT,(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

     ; eight place
    move.l              ARRIVAL_ORDER+28,a1
    tst.l               (a1)
    beq.w               result_draw_menu

    move.w              #RESULT_COLUMN_0_X,(a0)+
    move.w              #RESULT_COLUMN_7_Y,(a0)+
    move.l              #TXT_RESULT_EIGHTH_PLACE,(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

    move.w              #RESULT_COLUMN_1_X,(a0)+
    move.w              #RESULT_COLUMN_7_Y,(a0)+
    move.l              MOVER_PLAYER_NAME_ADDR(a1),(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

    move.w              #RESULT_COLUMN_2_X,(a0)+
    move.w              #RESULT_COLUMN_7_Y,(a0)+
    move.l              MOVER_PLAYER_TEAM_ADDR(a1),(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

    move.w              #RESULT_COLUMN_3_X,(a0)+
    move.w              #RESULT_COLUMN_7_Y,(a0)+
    lea                 TXT_CAR_8_TIME_TXT(PC),a2
    bsr.w               NIBBLE_TO_BYTE
    move.l              #TXT_CAR_8_TIME_TXT,(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

result_draw_menu:
    ; draw menu
    move.l              #RESULT_FILENAME,MENUSCREEN_IMAGE        ; set background image file here
    move.l              #RESULT_MENU_MAIN,MENUSCREEN_ENTRIES     ; point "entry" data structure
    move.l              #TXT_RESULT,TXTSCREEN_ENTRIES            ; point "txt" data structure
    move.l              MENU_RESULTS_CURRENTLY_SELECTED,MENUSCREEN_SELECTED_ENTRY ; where the cursor is at the beginning?
    jsr                 MENUSCREEN
    rts

NIBBLE_TO_BYTE:
    movem.l a0/a2/d0,-(sp)
    move.l              TIME_OFFSET_STR(a1),a0
    
    move.b              3(a0),d0
    andi.w              #$F,d0
    add.w               #$30,d0
    move.b              d0,5(a2)

    move.b              3(a0),d0
    lsr.b               #4,d0
    andi.w               #$F,d0
    add.w               #$30,d0
    move.b              d0,4(a2)

    move.b              2(a0),d0
    andi.w              #$F,d0
    add.w               #$30,d0
    move.b              d0,3(a2)

    move.b              2(a0),d0
    lsr.b               #4,d0
    andi.w               #$F,d0
    add.w               #$30,d0
    move.b              d0,2(a2)

    move.b              1(a0),d0
    andi.w              #$F,d0
    add.w               #$30,d0
    move.b              d0,1(a2)

    move.b              1(a0),d0
    lsr.b               #4,d0
    andi.w               #$F,d0
    add.w               #$30,d0
    move.b              d0,(a2)

    movem.l (sp)+,a0/a2/d0
    rts