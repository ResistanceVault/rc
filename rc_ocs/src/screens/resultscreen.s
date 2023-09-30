RESULT_COLUMN_0_X   EQU 1
RESULT_COLUMN_1_X   EQU 6
RESULT_COLUMN_2_X   EQU 19
RESULT_COLUMN_3_X   EQU 33

RESULT_COLUMN_0_Y   EQU 6
RESULT_COLUMN_1_Y   EQU 8
RESULT_COLUMN_2_Y   EQU 10
RESULT_COLUMN_3_Y   EQU 12
RESULT_COLUMN_4_Y   EQU 14
RESULT_COLUMN_5_Y   EQU 16
RESULT_COLUMN_6_Y   EQU 18
RESULT_COLUMN_7_Y   EQU 20
RESULT_COLUMN_8_Y   EQU 24
RESULT_COLUMN_9_Y   EQU 26

BEST_LAPPER_POINTS  EQU 3
BEST_LEADER_POINTS  EQU 1

RESULT_FILENAME:
    dc.b "raceresult.shr",0
    even

EXIT_TO_NEXT_RACE:
    dc.b "NEXT RACE",$FF
    even

TXT_RESULT_EMPTY: dc.b $FF,$FF

TXT_RESULT_HEADER: dc.b "RESULTS",$FF
    even

TXT_RESULT_FIRST_PLACE:
    dc.b "1ST",$FF
TXT_RESULT_SECOND_PLACE:
    dc.b "2ND",$FF
TXT_RESULT_THIRD_PLACE:
    dc.b "3RD",$FF
TXT_RESULT_FOURTH_PLACE:
    dc.b "4TH",$FF
TXT_RESULT_FIFTH_PLACE:
    dc.b "5TH",$FF
TXT_RESULT_SIXTH_PLACE:
    dc.b "6TH",$FF
TXT_RESULT_SEVENTH_PLACE:
    dc.b "7TH",$FF
TXT_RESULT_EIGHTH_PLACE:
    dc.b "8TH",$FF
TXT_RESULT_BEST_LAP_PLACE:
    dc.b "LAP",$FF
TXT_RESULT_BEST_LEADER_PLACE:
    dc.b "LDR",$FF

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
TXT_CAR_BEST_LAP_TIME_TXT:
    dc.b "000000",$FF
    even
TXT_CAR_BEST_LEADER_POINTS_TXT:
    dc.b "000000",$FF
    even

EXIT_TO_NEXT_RACE_FUNCTION:
    move.w  #1,MAIN_EXIT
    ENABLE_LOADING_SCREEN
    rts

RESULT_MENU_MAIN:

    dc.w 5,13
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


BEST_LAPPER_RESULT:
    dc.w RESULT_COLUMN_0_X,RESULT_COLUMN_8_Y
    dc.l TXT_RESULT_BEST_LAP_PLACE
    dc.w 8,7

    dc.w RESULT_COLUMN_1_X,RESULT_COLUMN_8_Y
    dc.l TXT_RESULT_EMPTY
    dc.w 8,7

    dc.w RESULT_COLUMN_2_X,RESULT_COLUMN_8_Y
    dc.l TXT_RESULT_EMPTY
    dc.w 8,7

    dc.w RESULT_COLUMN_3_X,RESULT_COLUMN_8_Y
    dc.l TXT_CAR_8_TIME_TXT
    dc.w 8,7

BEST_LEADER_RESULT:
    dc.w RESULT_COLUMN_0_X,RESULT_COLUMN_9_Y
    dc.l TXT_RESULT_BEST_LEADER_PLACE
    dc.w 8,7

    dc.w RESULT_COLUMN_1_X,RESULT_COLUMN_9_Y
    dc.l TXT_RESULT_EMPTY
    dc.w 8,7

    dc.w RESULT_COLUMN_2_X,RESULT_COLUMN_9_Y
    dc.l TXT_RESULT_EMPTY
    dc.w 8,7

    dc.w RESULT_COLUMN_3_X,RESULT_COLUMN_9_Y
    dc.l TXT_CAR_8_TIME_TXT
    dc.w 8,7

TXT_RESULT:
    dc.w RESULT_COLUMN_0_X,RESULT_COLUMN_0_Y
    dc.l TXT_RESULT_FIRST_PLACE
    dc.w 8,7

    dc.w RESULT_COLUMN_1_X,RESULT_COLUMN_0_Y
    dc.l TXT_RESULT_EMPTY
    dc.w 8,7

    dc.w RESULT_COLUMN_2_X,RESULT_COLUMN_0_Y
    dc.l TXT_RESULT_EMPTY
    dc.w 8,7

    dc.w RESULT_COLUMN_3_X,RESULT_COLUMN_0_Y
    dc.l TXT_CAR_1_TIME_TXT
    dc.w 8,7

    dc.w RESULT_COLUMN_0_X,RESULT_COLUMN_1_Y
    dc.l TXT_RESULT_SECOND_PLACE
    dc.w 8,7

    dc.w RESULT_COLUMN_1_X,RESULT_COLUMN_1_Y
    dc.l TXT_RESULT_EMPTY
    dc.w 8,7

    dc.w RESULT_COLUMN_2_X,RESULT_COLUMN_1_Y
    dc.l TXT_RESULT_EMPTY
    dc.w 8,7

    dc.w RESULT_COLUMN_3_X,RESULT_COLUMN_1_Y
    dc.l TXT_CAR_2_TIME_TXT
    dc.w 8,7

    dc.w RESULT_COLUMN_0_X,RESULT_COLUMN_2_Y
    dc.l TXT_RESULT_THIRD_PLACE
    dc.w 8,7

    dc.w RESULT_COLUMN_1_X,RESULT_COLUMN_2_Y
    dc.l TXT_RESULT_EMPTY
    dc.w 8,7

    dc.w RESULT_COLUMN_2_X,RESULT_COLUMN_2_Y
    dc.l TXT_RESULT_EMPTY
    dc.w 8,7

    dc.w RESULT_COLUMN_3_X,RESULT_COLUMN_2_Y
    dc.l TXT_CAR_3_TIME_TXT
    dc.w 8,7

    dc.w RESULT_COLUMN_0_X,RESULT_COLUMN_3_Y
    dc.l TXT_RESULT_FOURTH_PLACE
    dc.w 8,7

    dc.w RESULT_COLUMN_1_X,RESULT_COLUMN_3_Y
    dc.l TXT_RESULT_EMPTY
    dc.w 8,7

    dc.w RESULT_COLUMN_2_X,RESULT_COLUMN_3_Y
    dc.l TXT_RESULT_EMPTY
    dc.w 8,7

    dc.w RESULT_COLUMN_3_X,RESULT_COLUMN_3_Y
    dc.l TXT_CAR_4_TIME_TXT
    dc.w 8,7

    dc.w RESULT_COLUMN_0_X,RESULT_COLUMN_4_Y
    dc.l TXT_RESULT_FIFTH_PLACE
    dc.w 8,7

    dc.w RESULT_COLUMN_1_X,RESULT_COLUMN_4_Y
    dc.l TXT_RESULT_EMPTY
    dc.w 8,7

    dc.w RESULT_COLUMN_2_X,RESULT_COLUMN_4_Y
    dc.l TXT_RESULT_EMPTY
    dc.w 8,7

    dc.w RESULT_COLUMN_3_X,RESULT_COLUMN_4_Y
    dc.l TXT_CAR_5_TIME_TXT
    dc.w 8,7

    dc.w RESULT_COLUMN_0_X,RESULT_COLUMN_5_Y
    dc.l TXT_RESULT_SIXTH_PLACE
    dc.w 8,7

    dc.w RESULT_COLUMN_1_X,RESULT_COLUMN_5_Y
    dc.l TXT_RESULT_EMPTY
    dc.w 8,7

    dc.w RESULT_COLUMN_2_X,RESULT_COLUMN_5_Y
    dc.l TXT_RESULT_EMPTY
    dc.w 8,7

    dc.w RESULT_COLUMN_3_X,RESULT_COLUMN_5_Y
    dc.l TXT_CAR_6_TIME_TXT
    dc.w 8,7

    dc.w RESULT_COLUMN_0_X,RESULT_COLUMN_6_Y
    dc.l TXT_RESULT_SEVENTH_PLACE
    dc.w 8,7

    dc.w RESULT_COLUMN_1_X,RESULT_COLUMN_6_Y
    dc.l TXT_RESULT_EMPTY
    dc.w 8,7

    dc.w RESULT_COLUMN_2_X,RESULT_COLUMN_6_Y
    dc.l TXT_RESULT_EMPTY
    dc.w 8,7

    dc.w RESULT_COLUMN_3_X,RESULT_COLUMN_6_Y
    dc.l TXT_CAR_7_TIME_TXT
    dc.w 8,7

    dc.w RESULT_COLUMN_0_X,RESULT_COLUMN_7_Y
    dc.l TXT_RESULT_EIGHTH_PLACE
    dc.w 8,7

    dc.w RESULT_COLUMN_1_X,RESULT_COLUMN_7_Y
    dc.l TXT_RESULT_EMPTY
    dc.w 8,7

    dc.w RESULT_COLUMN_2_X,RESULT_COLUMN_7_Y
    dc.l TXT_RESULT_EMPTY
    dc.w 8,7

    dc.w RESULT_COLUMN_3_X,RESULT_COLUMN_7_Y
    dc.l TXT_CAR_8_TIME_TXT
    dc.w 8,7

HEADER_X:
    dc.w 7,1
HEADER_TXT:
    dc.l TXT_RESULT_HEADER
    dc.w 16,16

    dc.w 0,0
    dc.l 0
    dc.w 0,7

MENU_RESULTS_CURRENTLY_SELECTED:
    dc.l    RESULT_MENU_MAIN

RESULTSCREEN:
    move.w              #6,HEADER_X
    move.l              #TXT_RESULT_HEADER,HEADER_TXT

    DISABLE_AUDIO_DMA

    move.w              #1,LOAD_NEXT_TRACK_FLAG

    ; clear best lap row
    lea                 BEST_LAPPER_RESULT,a0
    ; first col
    clr.l               (a0)+
    clr.l               (a0)+
    clr.l               (a0)+

    ; second col
    clr.l               (a0)+
    clr.l               (a0)+
    clr.l               (a0)+

    ; third col
    clr.l               (a0)+
    clr.l               (a0)+
    clr.l               (a0)+

    ; fourth col
    clr.l               (a0)+
    clr.l               (a0)+
    clr.l               (a0)+

    ; clear best leader row
    ; first col
    clr.l               (a0)+
    clr.l               (a0)+
    clr.l               (a0)+

    ; second col
    clr.l               (a0)+
    clr.l               (a0)+
    clr.l               (a0)+

    ; third col
    clr.l               (a0)+
    clr.l               (a0)+
    clr.l               (a0)+

    ; fourth col
    clr.l               (a0)+
    clr.l               (a0)+
    clr.l               (a0)+

    ; clean all txt first
    moveq               #MAX_CARS-1,d7
    lea                 TXT_RESULT(PC),a0
resultscreen_cleanloop:
    ; first col
    clr.l               (a0)+
    clr.l               (a0)+
    clr.l               (a0)+

    ; second col
    clr.l               (a0)+
    clr.l               (a0)+
    clr.l               (a0)+

    ; third col
    clr.l               (a0)+
    clr.l               (a0)+
    clr.l               (a0)+

    ; fourth col
    clr.l               (a0)+
    clr.l               (a0)+
    clr.l               (a0)+

    dbra                d7,resultscreen_cleanloop

    ; best lapper
    move.l              RACE_BEST_LAP_CAR_PTR,a1
    addi.w              #BEST_LAPPER_POINTS,MOVER_POINTS(a1)
    lea                 BEST_LAPPER_RESULT(PC),a0

    move.w              #RESULT_COLUMN_0_X,(a0)+
    move.w              #RESULT_COLUMN_8_Y,(a0)+
    move.l              #TXT_RESULT_BEST_LAP_PLACE,(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

    move.w              #RESULT_COLUMN_1_X,(a0)+
    move.w              #RESULT_COLUMN_8_Y,(a0)+
    move.l              MOVER_PLAYER_NAME_ADDR(a1),(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

    move.w              #RESULT_COLUMN_2_X,(a0)+
    move.w              #RESULT_COLUMN_8_Y,(a0)+
    move.l              MOVER_PLAYER_TEAM_ADDR(a1),(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

    move.w              #RESULT_COLUMN_3_X,(a0)+
    move.w              #RESULT_COLUMN_8_Y,(a0)+
    move.l              a0,a2
    lea                 1+TXT_CAR_BEST_LAP_TIME_TXT(PC),a0
    move.w              BEST_TIME_OFFSET(a1),d1
    jsr                 dec2txt

    move.b              #$30,TXT_CAR_BEST_LAP_TIME_TXT
    addi.b              #$30,TXT_CAR_BEST_LAP_TIME_TXT+1
    addi.b              #$30,TXT_CAR_BEST_LAP_TIME_TXT+2
    addi.b              #$30,TXT_CAR_BEST_LAP_TIME_TXT+3
    addi.b              #$30,TXT_CAR_BEST_LAP_TIME_TXT+4
    addi.b              #$30,TXT_CAR_BEST_LAP_TIME_TXT+5
    move.b              #$FF,TXT_CAR_BEST_LAP_TIME_TXT+6
    move.l              a2,a0

    move.l              #TXT_CAR_BEST_LAP_TIME_TXT,(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

    ; best leader
    move.l              RACE_LEADING_LEADER_PTR,a1
    addi.w              #BEST_LEADER_POINTS,MOVER_POINTS(a1)
    lea                 BEST_LEADER_RESULT(PC),a0

    move.w              #RESULT_COLUMN_0_X,(a0)+
    move.w              #RESULT_COLUMN_9_Y,(a0)+
    move.l              #TXT_RESULT_BEST_LEADER_PLACE,(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

    move.w              #RESULT_COLUMN_1_X,(a0)+
    move.w              #RESULT_COLUMN_9_Y,(a0)+
    move.l              MOVER_PLAYER_NAME_ADDR(a1),(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

    move.w              #RESULT_COLUMN_2_X,(a0)+
    move.w              #RESULT_COLUMN_9_Y,(a0)+
    move.l              MOVER_PLAYER_TEAM_ADDR(a1),(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

    move.w              #RESULT_COLUMN_3_X,(a0)+
    move.w              #RESULT_COLUMN_9_Y,(a0)+
    move.l              a0,a2
    lea                 1+TXT_CAR_BEST_LEADER_POINTS_TXT(PC),a0
    move.w              MOVER_LEADING_LAPS(a1),d1
    jsr                 dec2txt

    move.b              #$30,TXT_CAR_BEST_LEADER_POINTS_TXT
    addi.b              #$30,TXT_CAR_BEST_LEADER_POINTS_TXT+1
    addi.b              #$30,TXT_CAR_BEST_LEADER_POINTS_TXT+2
    addi.b              #$30,TXT_CAR_BEST_LEADER_POINTS_TXT+3
    addi.b              #$30,TXT_CAR_BEST_LEADER_POINTS_TXT+4
    addi.b              #$30,TXT_CAR_BEST_LEADER_POINTS_TXT+5
    move.b              #$FF,TXT_CAR_BEST_LEADER_POINTS_TXT+6
    move.l              a2,a0

    move.l              #TXT_CAR_BEST_LEADER_POINTS_TXT,(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

    ; prepare txt according to the arrival order
    lea                 TXT_RESULT(PC),a0

    ; first place
    move.l              ARRIVAL_ORDER,a1
    tst.l               (a1)
    beq.w               result_draw_menu
    addi.w              #10,MOVER_POINTS(a1)
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
    addi.w              #8,MOVER_POINTS(a1)

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
    addi.w              #7,MOVER_POINTS(a1)

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
    addi.w              #6,MOVER_POINTS(a1)

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
    addi.w              #5,MOVER_POINTS(a1)

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
    addi.w              #4,MOVER_POINTS(a1)

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
    addi.w              #3,MOVER_POINTS(a1)

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
    addi.w              #1,MOVER_POINTS(a1)

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
    move.l              #18325,MENUSCREEN_IMAGE_SIZE
    move.l              #RESULT_MENU_MAIN,MENUSCREEN_ENTRIES     ; point "entry" data structure
    move.l              #BEST_LAPPER_RESULT,TXTSCREEN_ENTRIES            ; point "txt" data structure
    move.l              MENU_RESULTS_CURRENTLY_SELECTED,MENUSCREEN_SELECTED_ENTRY ; where the cursor is at the beginning?
    move.l              #ModuleMenu,MENU_MUSIC_PTR
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