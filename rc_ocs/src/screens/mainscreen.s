MAIN_FILENAME:
    dc.b "main.data",0
    even

TITLE_TXT: dc.b "BY OZZY AND Z3K",$FF
    even

START_GAME_TXT:
    dc.b "START GAME",$FF
    even

OPTIONS_TXT:
    dc.b "OPTIONS",$FF
    even

EXIT_TO_OS_TXT:
    dc.b "EXIT TO OS",$FF
    even

START_RACE_FUNCTION:
    move.w  #1,MAIN_EXIT
    rts

EXIT_TO_OS_FUNCTION:
    move.w  #1,EXIT_TO_OS_FLAG
    move.w  #1,MAIN_EXIT
    rts

DRAFT_FUNCTION:
    rts

MENU_MAIN:
    dc.w 5,7
    dc.l START_GAME_TXT
    dc.l START_RACE_FUNCTION

    dc.w 5,9
    dc.l OPTIONS_TXT
    dc.l DRAFT_FUNCTION

    dc.w 5,11
    dc.l EXIT_TO_OS_TXT
    dc.l EXIT_TO_OS_FUNCTION

    dc.w 0,0
    dc.l 0
    dc.l 0

TXT_MAIN:
    dc.w 2,15
    dc.l TITLE_TXT

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