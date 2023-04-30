STANDINGSSCREEN:
    ; clean all txt first
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

    ; prepare txt according to the arrival order
    lea                 TXT_RESULT(PC),a0

    ; first place
    move.l              ARRIVAL_ORDER,a1
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
    move.w              #12345,d1
    lea                 TXT_CAR_1_TIME_TXT,a0
    jsr                 dec2txt ; after this call buffer will be 01 02 03 04 05
    move.l a2,a0

    move.l              #TXT_CAR_1_TIME_TXT,(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

    ; draw menu
    move.l              #RESULT_FILENAME,MENUSCREEN_IMAGE        ; set background image file here
    move.l              #RESULT_MENU_MAIN,MENUSCREEN_ENTRIES     ; point "entry" data structure
    move.l              #TXT_RESULT,TXTSCREEN_ENTRIES            ; point "txt" data structure
    move.l              MENU_RESULTS_CURRENTLY_SELECTED,MENUSCREEN_SELECTED_ENTRY ; where the cursor is at the beginning?
    jsr                 MENUSCREEN

    rts