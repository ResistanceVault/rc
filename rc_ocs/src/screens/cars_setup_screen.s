CARS_SETUP_COL_0_X	EQU 2
CARS_SETUP_COL_1_X	EQU 5
CARS_SETUP_COL_2_X	EQU 18
CARS_SETUP_COL_3_X	EQU 34

CARS_SETUP_START_Y  EQU 9

NUM_TXT_COLUMNS     EQU 3

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
    dc.b "carsetup.shr",0
    even

MENU_CARS_SETUP_SCREEN_BACK_TXT:
    dc.b "BACK",$FF
    even

MENU_CARS_SETUP_SCREEN_BACK_FUNCT:
    move.w #1,MAIN_EXIT
    move.l #MAINSCREEN,NEXT_SCREEN
    ENABLE_LOADING_SCREEN
    rts

MENU_CARS_SETUP_SCREEN:

    dc.w CARS_SETUP_COL_0_X,CARS_SETUP_START_Y
    dc.l CARS_SETUP_CAR_1_TXT
    dc.l ACTION_TEST
    dc.l MOVERS
    dc.w 8
    dc.w 7

    dc.w CARS_SETUP_COL_0_X,CARS_SETUP_START_Y+2
    dc.l CARS_SETUP_CAR_2_TXT
    dc.l ACTION_TEST
    dc.l MOVERS2
    dc.w 8
    dc.w 7

    dc.w CARS_SETUP_COL_0_X,CARS_SETUP_START_Y+4
    dc.l CARS_SETUP_CAR_3_TXT
    dc.l ACTION_TEST
    dc.l MOVERS3
    dc.w 8
    dc.w 7

    dc.w CARS_SETUP_COL_0_X,CARS_SETUP_START_Y+6
    dc.l CARS_SETUP_CAR_4_TXT
    dc.l ACTION_TEST
    dc.l MOVERS4
    dc.w 8
    dc.w 7

    dc.w CARS_SETUP_COL_0_X,CARS_SETUP_START_Y+8
    dc.l CARS_SETUP_CAR_5_TXT
    dc.l ACTION_TEST
    dc.l MOVERS5
    dc.w 8
    dc.w 7

    dc.w CARS_SETUP_COL_0_X,CARS_SETUP_START_Y+10
    dc.l CARS_SETUP_CAR_6_TXT
    dc.l ACTION_TEST
    dc.l MOVERS6
    dc.w 8
    dc.w 7

    dc.w CARS_SETUP_COL_0_X,CARS_SETUP_START_Y+12
    dc.l CARS_SETUP_CAR_7_TXT
    dc.l ACTION_TEST
    dc.l MOVERS7
    dc.w 8
    dc.w 7

    dc.w CARS_SETUP_COL_0_X,CARS_SETUP_START_Y+14
    dc.l CARS_SETUP_CAR_8_TXT
    dc.l ACTION_TEST
    dc.l MOVERS8
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
    dc.l PLAYER_ONE_FIVE_TEAM
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
    dc.l PLAYER_TWO_SIX_TEAM
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
    dc.l PLAYER_THREE_SEVEN_TEAM
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
    dc.l PLAYER_FOUR_EIGHT_TEAM
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
    dc.l PLAYER_ONE_FIVE_TEAM
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
    dc.l PLAYER_TWO_SIX_TEAM
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
    dc.l PLAYER_THREE_SEVEN_TEAM
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
    dc.l PLAYER_FOUR_EIGHT_TEAM
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

    lea     MOVERS5,a0
    lea     txt_car_5_control(PC),a1
    bsr.w   CARS_SETUP_PRINT_CAR_CONTROL

    lea     MOVERS6,a0
    lea     txt_car_6_control(PC),a1
    bsr.w   CARS_SETUP_PRINT_CAR_CONTROL

    lea     MOVERS7,a0
    lea     txt_car_7_control(PC),a1
    bsr.w   CARS_SETUP_PRINT_CAR_CONTROL

    lea     MOVERS8,a0
    lea     txt_car_8_control(PC),a1
    bsr.w   CARS_SETUP_PRINT_CAR_CONTROL

    ; print screen
    move.l  #CARS_SETUP_SCREEN_FILENAME,MENUSCREEN_IMAGE
    move.l  #12347,MENUSCREEN_IMAGE_SIZE
    move.l  #MENU_CARS_SETUP_SCREEN,MENUSCREEN_ENTRIES
    move.l  #TXT_CARS_SETUP_SCREEN,TXTSCREEN_ENTRIES
    move.l  MENU_CARS_SETUP_SCREEN_CURRENTLY_SELECTED,MENUSCREEN_SELECTED_ENTRY
    jsr     MENUSCREEN
    rts

; this function takes a mover object as input, then it determines which input routine
; is associated with it (for example the routine to read joy1 state), then it looks up
; the address of this routine through each record of the list of input routines.
; If found it copies the address of the record within the list into a1.
; Input: a0 (address) of mover object
; Output: a1 (address) of the text entry where to place record address
;        a1 will have zero if the entry is not found in list
CARS_SETUP_FIND_CAR_CONTROL:
    movem.l a2/a4/a5,-(sp)
    lea     ROUTINES_INPUTLIST,a4

car_setup_find_car_control_start_loop:
    lea     input_routines_Function(a4),a5
    lea     INPUT_ROUTINE_OFFSET(a0),a2

    cmpm.l  (a2)+,(a5)+
    bne.s   car_setup_find_car_control_next
    movea.l a4,a1
    movem.l (sp)+,a2/a4/a5
    rts

car_setup_find_car_control_next:
    adda.l  #input_routines_SIZEOF,a4

    tst.l   input_routines_Description(a4)
    bne.s   car_setup_find_car_control_start_loop
    movea.l #0,a1
    movem.l (sp)+,a2/a4/a5
    rts

; this function takes a mover object as input, then it determines which input routine
; is associated with it (for example the routine to read joy1 state), then it looks up
; the address of this routine through each record of the list of input routines.
; If found it assigns to the text entry the corresponding text taken from the list.
; Input: a0 (address) of mover object
;        a1 (address) of the text entry where to place text address
CARS_SETUP_PRINT_CAR_CONTROL:
    move.l  a2,-(sp)
    move.l  a1,a2
    bsr.w   CARS_SETUP_FIND_CAR_CONTROL
    cmp.l   #0,a1
    beq.s   cars_setup_print_car_control_end
    move.l  input_routines_Description(a1),txt_DescPtr(a2)
cars_setup_print_car_control_end:
    move.l  (sp)+,a2
    rts

; this function takes a mover object, then tries to match
; the corresponding record from  the input routines list
; and tries to get the next record.
; if there is no next record or routine not found in list it returns 0 in a1
; Input: a0 (address) of mover object
; Output: a1 (address) of the next record in list
CARS_SETUP_FIND_NEXT_INPUT_ROUTINE:
    bsr.w   CARS_SETUP_FIND_CAR_CONTROL
    cmp.l   #0,a1
    beq.s   cars_setup_find_next_input_routine_end
    adda.l  #input_routines_SIZEOF,a1
    tst.l   input_routines_Description(a1)
    bne.s   cars_setup_find_next_input_routine_end
    ; if we are here it means we are at the end of the list, start again
    lea     ROUTINES_INPUTLIST,a1
cars_setup_find_next_input_routine_end:
    rts

ACTION_TEST:
    movem.l a0-a2/d3,-(sp)
    ; get mover obj addr
    move.l  MENUSCREEN_SELECTED_ENTRY,a0
    lea     menu_FunctArgsPtr(a0),a0
    move.l  (a0),a0

    ; save txt record into a2
    movea.l a1,a2
    ; find next

    bsr.w   CARS_SETUP_FIND_NEXT_INPUT_ROUTINE

    ; copy next input routine into the mover obj
    move.l  input_routines_Function(a1),INPUT_ROUTINE_OFFSET(a0)
    ;move.l  input_routines_Description(a1),txt_DescPtr(a2)

    ; setup text entries
    move.w  CAR_ID_OFFSET(a0),d3
    ;addq    #1,d3
    muls    #txt_SIZEOF*NUM_TXT_COLUMNS,d3
    lea     txt_car_1_control(PC),a1
    adda.l  d3,a1
    bsr.w   CARS_SETUP_PRINT_CAR_CONTROL

    move.w  CAR_ID_OFFSET(a0),d3
    ;DEBUG 6669
    ;addq    #1,d3
    muls    #txt_SIZEOF*NUM_TXT_COLUMNS,d3
    lea     txt_car_1_control(PC),a1
    adda.l  d3,a1
    bsr.w   REFRESH_TXT_ENTRY

    movem.l (sp)+,a0-a2/d3
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

restorebackground_small:
    movem.l             a1/d0,-(sp)
restorebackground_small_startcycle
    moveq               #0,d6
    move.b              (a1)+,d6
    cmp.w               #$FF,d6
    beq.s               restorebackground_small_end
    bsr.w               restorebackground_tile_small
    addq                #1,d0
    bra.s               restorebackground_small_startcycle
restorebackground_small_end:
    movem.l             (sp)+,a1/d0
    rts


restorebackground_tile_small:
    movem.l             d0/d1/d6/a0-a6,-(sp)
    mulu.w              #40*7,d1
    add.w               d1,d0
    lea                 SCREEN_0,a0
    lea                 SCREEN_1,a1
    lea                 SCREEN_00,a2
    lea                 SCREEN_11,a6

    lea                 PHAZELOGO,a3
    lea                 PHAZELOGO+10240,a4
    lea                 PHAZELOGO+10240*2,a5

    adda.l              d0,a0
    adda.l              d0,a1
    adda.l              d0,a2
    adda.l              d0,a6

    adda.l              d0,a3
    adda.l              d0,a4
    adda.l              d0,a5

    moveq               #7-1,d6
restorebackground_tile_small_start_loop:
    move.b              (a0),(a3)
    move.b              (a1),(a4)
    move.b              (a2),(a5)
    ;clr.b               40*256(a5)
    move.b              (a6),40*256(a5)
    clr.b               40*256*2(a5)

    adda.l              #40,a0
    adda.l              #40,a1
    adda.l              #40,a2
    adda.l              #40,a3
    adda.l              #40,a4
    adda.l              #40,a5
    adda.l              #40,a6

    dbra                d6,restorebackground_tile_small_start_loop

    movem.l             (sp)+,d0/d1/d6/a0-a6
    rts