CARS_SETUP_COL_0_X	EQU 2
CARS_SETUP_COL_1_X	EQU 5
CARS_SETUP_COL_2_X	EQU 18

CARS_SETUP_START_Y  EQU 9

CARS_SETUP_TITLE_TXT:
    dc.b "CAR CONTROLS MENU",$FF

CARS_SETUP_CAR_1_TXT:
    dc.b "1 ",$FF
    even

CARS_SETUP_CAR_2_TXT:
    dc.b "2  ",$FF
    even

CARS_SETUP_CAR_3_TXT:
    dc.b "3  ",$FF
    even

CARS_SETUP_CAR_4_TXT:
    dc.b "4  ",$FF
    even

CARS_SETUP_CAR_5_TXT:
    dc.b "5  ",$FF
    even

CARS_SETUP_CAR_6_TXT:
    dc.b "6  ",$FF
    even

CARS_SETUP_CAR_7_TXT:
    dc.b "7  ",$FF
    even

CARS_SETUP_CAR_8_TXT:
    dc.b "8  ",$FF
    even

CARS_SETUP_SCREEN_FILENAME:
    dc.b "carsetup.data",0
    even

MENU_CARS_SETUP_SCREEN_CAR_1_TXT:
    dc.b "PERRARI",$FF
    even

MENU_CARS_SETUP_SCREEN_CAR_2_TXT:
    dc.b "ALFA MARAMEO",$FF
    even

MENU_CARS_SETUP_SCREEN_CAR_3_TXT:
    dc.b "PERAULT",$FF
    even

MENU_CARS_SETUP_SCREEN_CAR_4_TXT:
    dc.b "MC LALLEN",$FF
    even

MENU_CARS_SETUP_SCREEN_BACK_TXT:
    dc.b "BACK",$FF
    even

MENU_CARS_SETUP_SCREEN_BACK_FUNCT:
    move.w #1,MAIN_EXIT
    move.l #MAINSCREEN,NEXT_SCREEN
    rts

MENU_CARS_SETUP_SCREEN:

    dc.w CARS_SETUP_COL_0_X,CARS_SETUP_START_Y
    dc.l CARS_SETUP_CAR_1_TXT
    dc.l DRAFT_FUNCTION
    dc.w 8
    dc.w 7

    dc.w CARS_SETUP_COL_0_X,CARS_SETUP_START_Y+2
    dc.l CARS_SETUP_CAR_2_TXT
    dc.l DRAFT_FUNCTION
    dc.w 8
    dc.w 7

    dc.w CARS_SETUP_COL_0_X,CARS_SETUP_START_Y+4
    dc.l CARS_SETUP_CAR_3_TXT
    dc.l DRAFT_FUNCTION
    dc.w 8
    dc.w 7

    dc.w CARS_SETUP_COL_0_X,CARS_SETUP_START_Y+6
    dc.l CARS_SETUP_CAR_4_TXT
    dc.l DRAFT_FUNCTION
    dc.w 8
    dc.w 7

    dc.w CARS_SETUP_COL_0_X,CARS_SETUP_START_Y+8
    dc.l CARS_SETUP_CAR_5_TXT
    dc.l DRAFT_FUNCTION
    dc.w 8
    dc.w 7

    dc.w CARS_SETUP_COL_0_X,CARS_SETUP_START_Y+10
    dc.l CARS_SETUP_CAR_6_TXT
    dc.l DRAFT_FUNCTION
    dc.w 8
    dc.w 7

    dc.w CARS_SETUP_COL_0_X,CARS_SETUP_START_Y+12
    dc.l CARS_SETUP_CAR_7_TXT
    dc.l DRAFT_FUNCTION
    dc.w 8
    dc.w 7

    dc.w CARS_SETUP_COL_0_X,CARS_SETUP_START_Y+14
    dc.l CARS_SETUP_CAR_8_TXT
    dc.l DRAFT_FUNCTION
    dc.w 8
    dc.w 7

    dc.w 1,13
    dc.l MENU_CARS_SETUP_SCREEN_BACK_TXT
    dc.l MENU_CARS_SETUP_SCREEN_BACK_FUNCT
    dc.w 16
    dc.w 16

    dc.w 0,0
    dc.l 0
    dc.l 0
    dc.w 0
    dc.w 0

TXT_CARS_SETUP_SCREEN:

    dc.w 1,1
    dc.l CARS_SETUP_TITLE_TXT
    dc.w 16
    dc.w 16

    dc.w CARS_SETUP_COL_1_X,CARS_SETUP_START_Y
    dc.l PLAYER_ONE_NAME
    dc.w 8
    dc.w 7

    dc.w CARS_SETUP_COL_2_X,CARS_SETUP_START_Y
    dc.l MENU_CARS_SETUP_SCREEN_CAR_1_TXT
    dc.w 8
    dc.w 7

    dc.w CARS_SETUP_COL_1_X,CARS_SETUP_START_Y+2
    dc.l PLAYER_TWO_NAME
    dc.w 8
    dc.w 7

    dc.w CARS_SETUP_COL_2_X,CARS_SETUP_START_Y+2
    dc.l MENU_CARS_SETUP_SCREEN_CAR_2_TXT
    dc.w 8
    dc.w 7

    dc.w CARS_SETUP_COL_1_X,CARS_SETUP_START_Y+4
    dc.l PLAYER_THREE_NAME
    dc.w 8
    dc.w 7

    dc.w CARS_SETUP_COL_2_X,CARS_SETUP_START_Y+4
    dc.l MENU_CARS_SETUP_SCREEN_CAR_3_TXT
    dc.w 8
    dc.w 7

    dc.w CARS_SETUP_COL_1_X,CARS_SETUP_START_Y+6
    dc.l PLAYER_FOUR_NAME
    dc.w 8
    dc.w 7

    dc.w CARS_SETUP_COL_2_X,CARS_SETUP_START_Y+6
    dc.l MENU_CARS_SETUP_SCREEN_CAR_4_TXT
    dc.w 8
    dc.w 7

    dc.w CARS_SETUP_COL_1_X,CARS_SETUP_START_Y+8
    dc.l PLAYER_FIVE_NAME
    dc.w 8
    dc.w 7

    dc.w CARS_SETUP_COL_2_X,CARS_SETUP_START_Y+8
    dc.l MENU_CARS_SETUP_SCREEN_CAR_1_TXT
    dc.w 8
    dc.w 7

    dc.w CARS_SETUP_COL_1_X,CARS_SETUP_START_Y+10
    dc.l PLAYER_SIX_NAME
    dc.w 8
    dc.w 7

    dc.w CARS_SETUP_COL_2_X,CARS_SETUP_START_Y+10
    dc.l MENU_CARS_SETUP_SCREEN_CAR_2_TXT
    dc.w 8
    dc.w 7

    dc.w CARS_SETUP_COL_1_X,CARS_SETUP_START_Y+12
    dc.l PLAYER_SEVEN_NAME
    dc.w 8
    dc.w 7

    dc.w CARS_SETUP_COL_2_X,CARS_SETUP_START_Y+12
    dc.l MENU_CARS_SETUP_SCREEN_CAR_3_TXT
    dc.w 8
    dc.w 7

    dc.w CARS_SETUP_COL_1_X,CARS_SETUP_START_Y+14
    dc.l PLAYER_EIGHT_NAME
    dc.w 8
    dc.w 7

    dc.w CARS_SETUP_COL_2_X,CARS_SETUP_START_Y+14
    dc.l MENU_CARS_SETUP_SCREEN_CAR_4_TXT
    dc.w 8
    dc.w 7

    dc.w 0,0
    dc.l 0
    dc.w 0,0

MENU_CARS_SETUP_SCREEN_CURRENTLY_SELECTED:
    dc.l    MENU_CARS_SETUP_SCREEN;+menu_SIZEOF

CARS_SETUP_SCREEN:
    move.l  #CARS_SETUP_SCREEN_FILENAME,MENUSCREEN_IMAGE
    move.l  #MENU_CARS_SETUP_SCREEN,MENUSCREEN_ENTRIES
    move.l  #TXT_CARS_SETUP_SCREEN,TXTSCREEN_ENTRIES
    move.l  MENU_CARS_SETUP_SCREEN_CURRENTLY_SELECTED,MENUSCREEN_SELECTED_ENTRY
    jsr     MENUSCREEN
    rts