TXT_STANDINGS_HEADER: dc.b "STANDINGS",$FF
    even

STANDINGSSCREEN:
    move.w              #5,HEADER_X
    move.l              #TXT_STANDINGS_HEADER,HEADER_TXT

    ; clean all txt first

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

    moveq               #MAX_CARS-1,d7
    lea                 TXT_RESULT(PC),a0
.resultscreen_cleanloop:
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
    dbra                d7,.resultscreen_cleanloop


    ;reorder ARRIVAL ORDER POINTER
    lea                 ARRIVAL_ORDER,a0
    move.w 				#MAX_CARS-1,d6
    moveq               #0,d7
.countcarsarrivalorder:
    tst.l               (a0)
    beq.s               .countcarsarrivalorder_end
    addq                #1,d7
    addq                #4,a0
.countcarsarrivalorder_end:
    dbra                d6,.countcarsarrivalorder

    cmp.w               #1,d7
    beq.s               .skip_ordering

    lea                 ARRIVAL_ORDER,a0
    lea                 compare_function,a2
    jsr                 bubble_sort_4_bytes
.skip_ordering:

    move.l              ARRIVAL_ORDER,CAR_WINNER

    ; prepare txt according to the arrival order
    lea                 TXT_RESULT(PC),a0

    ; first place
    move.l              ARRIVAL_ORDER,a1
    tst.l               (a1)
    beq.w               standings_draw_menu
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

    move.l a0,a2
    move.w              MOVER_POINTS(a1),d1
    lea                 TXT_CAR_1_TIME_TXT+1,a0
    jsr                 dec2txt ; after this call buffer will be 01 02 03 04 05
    move.b              #$30,TXT_CAR_1_TIME_TXT
    addi.b              #$30,TXT_CAR_1_TIME_TXT+1
    addi.b              #$30,TXT_CAR_1_TIME_TXT+2
    addi.b              #$30,TXT_CAR_1_TIME_TXT+3
    addi.b              #$30,TXT_CAR_1_TIME_TXT+4
    addi.b              #$30,TXT_CAR_1_TIME_TXT+5
    move.b              #$FF,TXT_CAR_1_TIME_TXT+6
    move.l a2,a0

    move.l              #TXT_CAR_1_TIME_TXT,(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

    ; second place
    move.l              ARRIVAL_ORDER+4,a1
    tst.l               (a1)
    beq.w               standings_draw_menu
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

    move.l a0,a2
    move.w              MOVER_POINTS(a1),d1
    lea                 TXT_CAR_2_TIME_TXT+1,a0
    jsr                 dec2txt ; after this call buffer will be 01 02 03 04 05
    move.b              #$30,TXT_CAR_2_TIME_TXT
    addi.b              #$30,TXT_CAR_2_TIME_TXT+1
    addi.b              #$30,TXT_CAR_2_TIME_TXT+2
    addi.b              #$30,TXT_CAR_2_TIME_TXT+3
    addi.b              #$30,TXT_CAR_2_TIME_TXT+4
    addi.b              #$30,TXT_CAR_2_TIME_TXT+5
    move.b              #$FF,TXT_CAR_2_TIME_TXT+6
    move.l a2,a0

    move.l              #TXT_CAR_2_TIME_TXT,(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

    ; third place
    move.l              ARRIVAL_ORDER+8,a1
    tst.l               (a1)
    beq.w               standings_draw_menu
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

    move.l a0,a2
    move.w              MOVER_POINTS(a1),d1
    lea                 TXT_CAR_3_TIME_TXT+1,a0
    jsr                 dec2txt ; after this call buffer will be 01 02 03 04 05
    move.b              #$30,TXT_CAR_3_TIME_TXT
    addi.b              #$30,TXT_CAR_3_TIME_TXT+1
    addi.b              #$30,TXT_CAR_3_TIME_TXT+2
    addi.b              #$30,TXT_CAR_3_TIME_TXT+3
    addi.b              #$30,TXT_CAR_3_TIME_TXT+4
    addi.b              #$30,TXT_CAR_3_TIME_TXT+5
    move.b              #$FF,TXT_CAR_3_TIME_TXT+6
    move.l a2,a0

    move.l              #TXT_CAR_3_TIME_TXT,(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

    ; fourth place
    move.l              ARRIVAL_ORDER+12,a1
    tst.l               (a1)
    beq.w               standings_draw_menu
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

    move.l a0,a2
    move.w              MOVER_POINTS(a1),d1
    lea                 TXT_CAR_4_TIME_TXT+1,a0
    jsr                 dec2txt ; after this call buffer will be 01 02 03 04 05
    move.b              #$30,TXT_CAR_4_TIME_TXT
    addi.b              #$30,TXT_CAR_4_TIME_TXT+1
    addi.b              #$30,TXT_CAR_4_TIME_TXT+2
    addi.b              #$30,TXT_CAR_4_TIME_TXT+3
    addi.b              #$30,TXT_CAR_4_TIME_TXT+4
    addi.b              #$30,TXT_CAR_4_TIME_TXT+5
    move.b              #$FF,TXT_CAR_4_TIME_TXT+6
    move.l a2,a0

    move.l              #TXT_CAR_4_TIME_TXT,(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

    ; fifth place
    move.l              ARRIVAL_ORDER+16,a1
    tst.l               (a1)
    beq.w               standings_draw_menu
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

    move.l a0,a2
    move.w              MOVER_POINTS(a1),d1
    lea                 TXT_CAR_5_TIME_TXT+1,a0
    jsr                 dec2txt ; after this call buffer will be 01 02 03 04 05
    move.b              #$30,TXT_CAR_5_TIME_TXT
    addi.b              #$30,TXT_CAR_5_TIME_TXT+1
    addi.b              #$30,TXT_CAR_5_TIME_TXT+2
    addi.b              #$30,TXT_CAR_5_TIME_TXT+3
    addi.b              #$30,TXT_CAR_5_TIME_TXT+4
    addi.b              #$30,TXT_CAR_5_TIME_TXT+5
    move.b              #$FF,TXT_CAR_5_TIME_TXT+6
    move.l a2,a0

    move.l              #TXT_CAR_5_TIME_TXT,(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

    ; sixth place
    move.l              ARRIVAL_ORDER+20,a1
    tst.l               (a1)
    beq.w               standings_draw_menu
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

    move.l a0,a2
    move.w              MOVER_POINTS(a1),d1
    lea                 TXT_CAR_6_TIME_TXT+1,a0
    jsr                 dec2txt ; after this call buffer will be 01 02 03 04 05
    move.b              #$30,TXT_CAR_6_TIME_TXT
    addi.b              #$30,TXT_CAR_6_TIME_TXT+1
    addi.b              #$30,TXT_CAR_6_TIME_TXT+2
    addi.b              #$30,TXT_CAR_6_TIME_TXT+3
    addi.b              #$30,TXT_CAR_6_TIME_TXT+4
    addi.b              #$30,TXT_CAR_6_TIME_TXT+5
    move.b              #$FF,TXT_CAR_6_TIME_TXT+6
    move.l a2,a0

    move.l              #TXT_CAR_6_TIME_TXT,(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

    ; seventh place
    move.l              ARRIVAL_ORDER+24,a1
    tst.l               (a1)
    beq.w               standings_draw_menu
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

    move.l a0,a2
    move.w              MOVER_POINTS(a1),d1
    lea                 TXT_CAR_7_TIME_TXT+1,a0
    jsr                 dec2txt ; after this call buffer will be 01 02 03 04 05
    move.b              #$30,TXT_CAR_7_TIME_TXT
    addi.b              #$30,TXT_CAR_7_TIME_TXT+1
    addi.b              #$30,TXT_CAR_7_TIME_TXT+2
    addi.b              #$30,TXT_CAR_7_TIME_TXT+3
    addi.b              #$30,TXT_CAR_7_TIME_TXT+4
    addi.b              #$30,TXT_CAR_7_TIME_TXT+5
    move.b              #$FF,TXT_CAR_7_TIME_TXT+6
    move.l a2,a0

    move.l              #TXT_CAR_7_TIME_TXT,(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

    ; eigth place
    move.l              ARRIVAL_ORDER+28,a1
    tst.l               (a1)
    beq.w               standings_draw_menu
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

    move.l a0,a2
    move.w              MOVER_POINTS(a1),d1
    lea                 TXT_CAR_8_TIME_TXT+1,a0
    jsr                 dec2txt ; after this call buffer will be 01 02 03 04 05
    move.b              #$30,TXT_CAR_8_TIME_TXT
    addi.b              #$30,TXT_CAR_8_TIME_TXT+1
    addi.b              #$30,TXT_CAR_8_TIME_TXT+2
    addi.b              #$30,TXT_CAR_8_TIME_TXT+3
    addi.b              #$30,TXT_CAR_8_TIME_TXT+4
    addi.b              #$30,TXT_CAR_8_TIME_TXT+5
    move.b              #$FF,TXT_CAR_8_TIME_TXT+6
    move.l a2,a0

    move.l              #TXT_CAR_8_TIME_TXT,(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

    ; draw menu
standings_draw_menu:
    move.l              #RESULT_FILENAME,MENUSCREEN_IMAGE        ; set background image file here
    move.l              #18325,MENUSCREEN_IMAGE_SIZE
    move.l              #RESULT_MENU_MAIN,MENUSCREEN_ENTRIES     ; point "entry" data structure
    move.l              #TXT_RESULT,TXTSCREEN_ENTRIES            ; point "txt" data structure
    move.l              MENU_RESULTS_CURRENTLY_SELECTED,MENUSCREEN_SELECTED_ENTRY ; where the cursor is at the beginning?
    jsr                 MENUSCREEN

    rts

compare_function:
    movem.l d0/a5/a6,-(sp)
    move.l (a5),a5
    move.l (a6),a6
    move.w MOVER_POINTS(a5),d0
    moveq #0,d5
    cmp.w MOVER_POINTS(a6),d0
    smi d5
    movem.l (sp)+,d0/a5/a6
    rts