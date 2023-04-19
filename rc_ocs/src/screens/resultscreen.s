RESULT_FILENAME:
    dc.b "raceresult.data",0
    even

EXIT_TO_NEXT_RACE:
    dc.b "NEXT RACE",$FF
    even

TXT_RESULT_FIRST_PLACE:
    dc.b "1ST PLACE",$FF
TXT_RESULT_FIRST_PLACE_NAME:
    dc.b "CAR  ",$FF
TXT_RESULT_SECOND_PLACE:
    dc.b "2ND PLACE",$FF
TXT_RESULT_SECOND_PLACE_NAME:
    dc.b "CAR  ",$FF
TXT_RESULT_THIRD_PLACE:
    dc.b "3RD PLACE",$FF
TXT_RESULT_THIRD_PLACE_NAME:
    dc.b "CAR  ",$FF
TXT_RESULT_FOURTH_PLACE:
    dc.b "4TH PLACE",$FF
TXT_RESULT_FOURTH_PLACE_NAME:
    dc.b "CAR  ",$FF

EXIT_TO_NEXT_RACE_FUNCTION:
    move.w  #1,MAIN_EXIT
    rts

RESULT_MENU_MAIN:

    dc.w 5,11
    dc.l EXIT_TO_NEXT_RACE
    dc.l EXIT_TO_NEXT_RACE_FUNCTION
    dc.w 16
    dc.w 16

    dc.w 0,0
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

    dc.w 1,3
    dc.l TXT_RESULT_SECOND_PLACE
    dc.w 8,7

    dc.w 13,3
    dc.l TXT_RESULT_SECOND_PLACE_NAME
    dc.w 8,7

    dc.w 1,5
    dc.l TXT_RESULT_THIRD_PLACE
    dc.w 8,7

    dc.w 13,5
    dc.l TXT_RESULT_THIRD_PLACE_NAME
    dc.w 8,7

    dc.w 1,7
    dc.l TXT_RESULT_FOURTH_PLACE
    dc.w 8,7

    dc.w 13,7
    dc.l TXT_RESULT_FOURTH_PLACE_NAME
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
    move.w              CAR_ID_OFFSET(a1),d0
    addi.w              #$31,d0
    move.b              d0,TXT_RESULT_FIRST_PLACE_NAME+4
    ;dc.w 1,1
    ;dc.l TXT_RESULT_FIRST_PLACE
    ;dc.w 13,1
    ;dc.l TXT_RESULT_FIRST_PLACE_NAME
    move.w              #1,(a0)+
    move.w              #1,(a0)+
    move.l              #TXT_RESULT_FIRST_PLACE,(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+
    move.w              #13,(a0)+
    move.w              #1,(a0)+
    move.l              #TXT_RESULT_FIRST_PLACE_NAME,(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

    ; second place
    move.l              ARRIVAL_ORDER+4,a1
    tst.l               (a1)
    beq.w               result_draw_menu
    move.w              CAR_ID_OFFSET(a1),d0
    addi.w              #$31,d0
    move.b              d0,TXT_RESULT_SECOND_PLACE_NAME+4
    ;dc.w 1,3
    ;dc.l TXT_RESULT_SECOND_PLACE
    ;dc.w 13,3
    ;dc.l TXT_RESULT_SECOND_PLACE_NAME
    move.w              #1,(a0)+
    move.w              #3,(a0)+
    move.l              #TXT_RESULT_SECOND_PLACE,(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+
    move.w              #13,(a0)+
    move.w              #3,(a0)+
    move.l              #TXT_RESULT_SECOND_PLACE_NAME,(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

    ; third place
    move.l              ARRIVAL_ORDER+8,a1
    tst.l               (a1)
    beq.w               result_draw_menu
    move.w              CAR_ID_OFFSET(a1),d0
    addi.w              #$31,d0
    move.b              d0,TXT_RESULT_THIRD_PLACE_NAME+4
    ;dc.w 1,5
    ;dc.l TXT_RESULT_THIRD_PLACE
    ;dc.w 13,5
    ;dc.l TXT_RESULT_THIRD_PLACE_NAME
    move.w              #1,(a0)+
    move.w              #5,(a0)+
    move.l              #TXT_RESULT_THIRD_PLACE,(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+
    move.w              #13,(a0)+
    move.w              #5,(a0)+
    move.l              #TXT_RESULT_THIRD_PLACE_NAME,(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+

    ; fourth place
    move.l              ARRIVAL_ORDER+12,a1
    tst.l               (a1)
    beq.w               result_draw_menu
    move.w              CAR_ID_OFFSET(a1),d0
    addi.w              #$31,d0
    move.b              d0,TXT_RESULT_FOURTH_PLACE_NAME+4
    ;dc.w 1,7
    ;dc.l TXT_RESULT_FOURTH_PLACE
    ;dc.w 13,7
    ;dc.l TXT_RESULT_FOURTH_PLACE_NAME
    move.w              #1,(a0)+
    move.w              #7,(a0)+
    move.l              #TXT_RESULT_FOURTH_PLACE,(a0)+
    move.w              #8,(a0)+
    move.w              #7,(a0)+
    move.w              #13,(a0)+
    move.w              #7,(a0)+
    move.l              #TXT_RESULT_FOURTH_PLACE_NAME,(a0)+
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