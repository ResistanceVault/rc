CARS_SETUP_COL_0_X	EQU 2
CARS_SETUP_COL_1_X	EQU 5
CARS_SETUP_COL_2_X	EQU 18
CARS_SETUP_COL_3_X	EQU 34

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

CARS_SETUP_INPUT_ROUTINE_OFF_TXT:
    dc.b "OFF",$FF
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
    dc.l MOVERS
    dc.w 8
    dc.w 7

    dc.w CARS_SETUP_COL_0_X,CARS_SETUP_START_Y+2
    dc.l CARS_SETUP_CAR_2_TXT
    dc.l DRAFT_FUNCTION
    dc.l 0
    dc.w 8
    dc.w 7

    dc.w CARS_SETUP_COL_0_X,CARS_SETUP_START_Y+4
    dc.l CARS_SETUP_CAR_3_TXT
    dc.l DRAFT_FUNCTION
    dc.l 0
    dc.w 8
    dc.w 7

    dc.w CARS_SETUP_COL_0_X,CARS_SETUP_START_Y+6
    dc.l CARS_SETUP_CAR_4_TXT
    dc.l DRAFT_FUNCTION
    dc.l 0
    dc.w 8
    dc.w 7

    dc.w CARS_SETUP_COL_0_X,CARS_SETUP_START_Y+8
    dc.l CARS_SETUP_CAR_5_TXT
    dc.l DRAFT_FUNCTION
    dc.l 0
    dc.w 8
    dc.w 7

    dc.w CARS_SETUP_COL_0_X,CARS_SETUP_START_Y+10
    dc.l CARS_SETUP_CAR_6_TXT
    dc.l DRAFT_FUNCTION
    dc.l 0
    dc.w 8
    dc.w 7

    dc.w CARS_SETUP_COL_0_X,CARS_SETUP_START_Y+12
    dc.l CARS_SETUP_CAR_7_TXT
    dc.l DRAFT_FUNCTION
    dc.l 0
    dc.w 8
    dc.w 7

    dc.w CARS_SETUP_COL_0_X,CARS_SETUP_START_Y+14
    dc.l CARS_SETUP_CAR_8_TXT
    dc.l DRAFT_FUNCTION
    dc.l 0
    dc.w 8
    dc.w 7

    dc.w 1,13
    dc.l MENU_CARS_SETUP_SCREEN_BACK_TXT
    dc.l MENU_CARS_SETUP_SCREEN_BACK_FUNCT
    dc.l 0
    dc.w 16
    dc.w 16

    dc.w 0,0
    dc.l 0
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

txt_car_1_control:
    dc.w CARS_SETUP_COL_3_X,CARS_SETUP_START_Y
    dc.l CARS_SETUP_INPUT_ROUTINE_OFF_TXT
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

txt_car_2_control:
    dc.w CARS_SETUP_COL_3_X,CARS_SETUP_START_Y+2
    dc.l CARS_SETUP_INPUT_ROUTINE_OFF_TXT
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

txt_car_3_control:
    dc.w CARS_SETUP_COL_3_X,CARS_SETUP_START_Y+4
    dc.l CARS_SETUP_INPUT_ROUTINE_OFF_TXT
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

txt_car_4_control:
    dc.w CARS_SETUP_COL_3_X,CARS_SETUP_START_Y+6
    dc.l CARS_SETUP_INPUT_ROUTINE_OFF_TXT
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

txt_car_5_control:
    dc.w CARS_SETUP_COL_3_X,CARS_SETUP_START_Y+8
    dc.l CARS_SETUP_INPUT_ROUTINE_OFF_TXT
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

txt_car_6_control:
    dc.w CARS_SETUP_COL_3_X,CARS_SETUP_START_Y+10
    dc.l CARS_SETUP_INPUT_ROUTINE_OFF_TXT
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

txt_car_7_control:
    dc.w CARS_SETUP_COL_3_X,CARS_SETUP_START_Y+12
    dc.l CARS_SETUP_INPUT_ROUTINE_OFF_TXT
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

txt_car_8_control:
    dc.w CARS_SETUP_COL_3_X,CARS_SETUP_START_Y+14
    dc.l CARS_SETUP_INPUT_ROUTINE_OFF_TXT
    dc.w 8
    dc.w 7

    dc.w 0,0
    dc.l 0
    dc.w 0,0

MENU_CARS_SETUP_SCREEN_CURRENTLY_SELECTED:
    dc.l    MENU_CARS_SETUP_SCREEN;+menu_SIZEOF

CARS_SETUP_SCREEN:

    ; setup text entries
    lea     MOVERS,a0
    lea     txt_car_1_control(PC),a1
    bsr.w   CARS_SETUP_PRINT_CAR_CONTROL

    lea     MOVERS2,a0
    lea     txt_car_2_control(PC),a1
    bsr.w   CARS_SETUP_PRINT_CAR_CONTROL

    lea     MOVERS3,a0
    lea     txt_car_3_control(PC),a1
    bsr.w   CARS_SETUP_PRINT_CAR_CONTROL

    lea     MOVERS4,a0
    lea     txt_car_4_control(PC),a1
    bsr.w   CARS_SETUP_PRINT_CAR_CONTROL

    ; print screen
    move.l  #CARS_SETUP_SCREEN_FILENAME,MENUSCREEN_IMAGE
    move.l  #MENU_CARS_SETUP_SCREEN,MENUSCREEN_ENTRIES
    move.l  #TXT_CARS_SETUP_SCREEN,TXTSCREEN_ENTRIES
    move.l  MENU_CARS_SETUP_SCREEN_CURRENTLY_SELECTED,MENUSCREEN_SELECTED_ENTRY
    jsr     MENUSCREEN
    rts

; this function takes a mover object as input, then it determines which input routine
; is associated with it (for example the routine to read joy1 state), then it looks up
; the address of this routine through each record of the list of input routines.
; If found it assigns to the text entry the corresponding text taken from the list.
; Input: a0 (address) of mover object
;        a1 (address) of the text entry where to place text address
CARS_SETUP_PRINT_CAR_CONTROL:
    lea ROUTINES_INPUTLIST,a4

car_setup_print_car_control_start_loop:
    lea input_routines_Function(a4),a5
    lea INPUT_ROUTINE_OFFSET(a0),a2

    cmpm.l (a2)+,(a5)+
    bne.s   car_setup_print_car_control_next
    move.l input_routines_Description-4(a5),txt_DescPtr(a1)
    rts

car_setup_print_car_control_next:
    adda.l #input_routines_SIZEOF,a4

    tst.l  input_routines_Description(a4)
    bne.s  car_setup_print_car_control_start_loop
    rts

ACTION_FUNCTION:
    movem.l a0-a4,-(sp)
    move.l  MENU_CARS_SETUP_SCREEN_CURRENTLY_SELECTED,a0
    ; get car input routine
    lea  menu_FunctArgsPtr(a0),a1
    move.l (a1),a1 ; a1 now holds the mover address
    lea ROUTINES_INPUTLIST,a3

car_setup_start_iteration:
    lea  INPUT_ROUTINE_OFFSET(a1),a2
    lea input_routines_Function(a3),a4

    cmpm.l (a2)+,(a4)+ ; check if it's the same routine, if not go to next
    bne.s car_setup_next_iteration

    ; we found the routine, now we must print the description into the screen
    ;DEBUG 6667
    movem.l (sp)+,a0-a4
    rts
car_setup_next_iteration:
    adda.l #input_routines_SIZEOF,a3

    ; check if we are at the end of the list
    tst.l input_routines_Function(a3)
    beq car_setup_end_iteration
    bra.s  car_setup_start_iteration
car_setup_end_iteration:
    movem.l (sp)+,a0-a4
    rts