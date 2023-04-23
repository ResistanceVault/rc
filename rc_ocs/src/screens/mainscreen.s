MAIN_FILENAME:
    dc.b "main.data",0
    even

START_GAME_TXT:
    dc.b "START GAME",$FF
    even

OPTIONS_TXT:
    dc.b "OPTIONS",$FF
    even

CARS_SETUP_TXT:
    dc.b "CAR CONTROLS",$FF
    even

EXIT_TO_OS_TXT:
    dc.b "EXIT TO OS",$FF
    even

START_RACE_FUNCTION:
    move.w  #1,MAIN_EXIT
    clr.l   NEXT_SCREEN
    rts

EXIT_TO_OS_FUNCTION:
    move.w  #1,EXIT_TO_OS_FLAG
    move.w  #1,MAIN_EXIT
    rts

DRAFT_FUNCTION:
    rts

CARS_SETUP_SCREEN_FUNCTION:
    move.w  #1,MAIN_EXIT
    move.l  #CARS_SETUP_SCREEN,NEXT_SCREEN
    rts

OPTION_SCREEN_FUNCTION:
    move.w  #1,MAIN_EXIT
    move.l  #OPTIONS_SCREEN,NEXT_SCREEN
    rts

MENU_MAIN:
    dc.w 4,7
    dc.l START_GAME_TXT
    dc.l START_RACE_FUNCTION
    dc.l 0
    dc.w 16
    dc.w 16

    dc.w 4,9
    dc.l OPTIONS_TXT
    dc.l OPTION_SCREEN_FUNCTION
    dc.l 0
    dc.w 16
    dc.w 16

    dc.w 4,11
    dc.l CARS_SETUP_TXT
    dc.l CARS_SETUP_SCREEN_FUNCTION
    dc.l 0
    dc.w 16
    dc.w 16

    dc.w 4,13
    dc.l EXIT_TO_OS_TXT
    dc.l EXIT_TO_OS_FUNCTION
    dc.l 0
    dc.w 16
    dc.w 16


    dc.w 0,0
    dc.l 0
    dc.l 0
    dc.l 0
    dc.w 0
    dc.w 0

TXT_MAIN:
    dc.w 0,0
    dc.l 0

MENU_MAIN_CURRENTLY_SELECTED:
    dc.l    MENU_MAIN;+menu_SIZEOF

MAINSCREEN:
    move.l  #MAIN_FILENAME,MENUSCREEN_IMAGE
    move.l  #MENU_MAIN,MENUSCREEN_ENTRIES
    move.l  #TXT_MAIN,TXTSCREEN_ENTRIES
    move.l  MENU_MAIN_CURRENTLY_SELECTED,MENUSCREEN_SELECTED_ENTRY
    jsr     MENUSCREEN
    rts