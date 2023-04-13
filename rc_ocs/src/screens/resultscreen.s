RESULT_FILENAME:
    dc.b "raceresult.data",0
    even

EXIT_TO_NEXT_RACE:
    dc.b "NEXT RACE",$FF
    even

EXIT_TO_NEXT_RACE_FUNCTION:
    rts

RESULT_MENU_MAIN:

    dc.w 5,11
    dc.l EXIT_TO_NEXT_RACE
    dc.l EXIT_TO_NEXT_RACE_FUNCTION

    dc.w 0,0
    dc.l 0
    dc.l 0

MENU_RESULTS_CURRENTLY_SELECTED:
    dc.l    RESULT_MENU_MAIN

RESULTSCREEN:
    move.l  #RESULT_FILENAME,MENUSCREEN_IMAGE        ; set background image file here
    move.l  #RESULT_MENU_MAIN,MENUSCREEN_ENTRIES     ; point entry data structure
    move.l  MENU_RESULTS_CURRENTLY_SELECTED,MENUSCREEN_SELECTED_ENTRY ; where the cursor is at the beginning?
    jsr     MENUSCREEN
    rts