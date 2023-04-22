START_RACE_SCREEN_FILENAME:
    dc.b "carstartrace.data",0
    even

START_RACE_TXT:
    dc.b "START RACE",$FF
    even

MAIN_MENU_TXT:
    dc.b "MAIN MENU",$FF
    even

MENU_START_RACE_SCREEN:

    dc.w 5,5
    dc.l START_RACE_TXT
    dc.l ACTION_START_RACE_NEW
    dc.l 0
    dc.w 16
    dc.w 16

    dc.w 5,9
    dc.l MENU_CARS_SETUP_SCREEN_BACK_TXT
    dc.l MENU_CARS_SETUP_SCREEN_BACK_FUNCT
    dc.l 0
    dc.w 16
    dc.w 16

    dcb.b  menu_SIZEOF,$00 ; terminator

TXT_START_RACE_SCREEN:
    dcb.b  txt_SIZEOF,$00

MENU_START_RACE_CURRENTLY_SELECTED:
    dc.l    MENU_START_RACE_SCREEN

ACTION_START_RACE_NEW:
    move.w  #1,MAIN_EXIT
    clr.w   LOAD_NEXT_TRACK_FLAG

    ; Cars init
    jsr 	SET_CAR1_START_STATUS
    jsr 	SET_CAR2_START_STATUS
    jsr 	SET_CAR3_START_STATUS
    jsr 	SET_CAR4_START_STATUS
    rts

START_RACE_SCREEN:

    ; load track
    addi.w              #1,TRACK_NUMBER
    jsr     LOAD_TRACK

    ; print screen
    move.l  #START_RACE_SCREEN_FILENAME,MENUSCREEN_IMAGE
    move.l  #MENU_START_RACE_SCREEN,MENUSCREEN_ENTRIES
    move.l  #TXT_START_RACE_SCREEN,TXTSCREEN_ENTRIES
    move.l  MENU_START_RACE_CURRENTLY_SELECTED,MENUSCREEN_SELECTED_ENTRY
    jsr     MENUSCREEN
    rts