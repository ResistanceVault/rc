END_OF_CHAMPIONSHIP_X_POS equ 1
END_OF_CHAMPIONSHIP_Y_POS equ 27

CHAMPIONSHIP_MENU_FILENAME:
    dc.b "0.shr",0
    even

RESET_CHAMPIONSHIP_TXT:
    dc.b "END OF CHAMPIONSHIP",$FF
    even

CHAMPIONSHIP_WINNER_SENTENCE_1:
    dc.b "CONGRATULATIONS ABCDEFGHIJKL",$FF
    even

CHAMPIONSHIP_WINNER_SENTENCE_2:
    dc.b "YOU ARE THE RALLY CROSS 1984 CHAMPION",$FF
    even

CAR_WINNER: dc.l 0

CHAMPIONSHIP_MENU_MAIN:

    dc.w END_OF_CHAMPIONSHIP_X_POS,END_OF_CHAMPIONSHIP_Y_POS+7
    dc.l RESET_CHAMPIONSHIP_TXT
    dc.l RESET_GAME_FUNCTION
    dc.l 0
    dc.w 8
    dc.w 7

    dc.w 0,0
    dc.l 0
    dc.l 0
    dc.l 0
    dc.w 0
    dc.w 0

CHAMPIONSHIP_MENU_MAIN_TXT:

    dc.w END_OF_CHAMPIONSHIP_X_POS,END_OF_CHAMPIONSHIP_Y_POS
    dc.l CHAMPIONSHIP_WINNER_SENTENCE_1
    dc.w 8
    dc.w 7

    dc.w END_OF_CHAMPIONSHIP_X_POS,END_OF_CHAMPIONSHIP_Y_POS+2
    dc.l CHAMPIONSHIP_WINNER_SENTENCE_2
    dc.w 8
    dc.w 7

    dc.w 0,0
    dc.l 0
    dc.w 0,7

MENU_CHAMPIONSHIP_CURRENTLY_SELECTED:
    dc.l    CHAMPIONSHIP_MENU_MAIN

RESET_GAME_FUNCTION:
    clr.w               RACES_COUNTER
    clr.w               TRACK_NUMBER
    move.w              #1,MAIN_EXIT
    rts

championsip_end_screen:
    ; get name of the winner
    lea                 CHAMPIONSHIP_WINNER_SENTENCE_1+16,a1
    move.l              CAR_WINNER,a0
    adda.w              #MOVER_PLAYER_NAME_ADDR,a0
    move.l              (a0),a0
.printnamestartloop:
    move.b              (a0)+,d0
    move.b              d0,(a1)+
    cmp.b               #$FF,d0
    beq.s               .printnameendloop
    bra.s               .printnamestartloop
.printnameendloop:

    ; draw menu
    move.l              CAR_WINNER,a0
    adda.w              #CAR_ID_OFFSET,a0
    move.w              (a0),d0
    addi.w              #$30,d0
    suba.w              #CAR_ID_OFFSET,a0
    move.b              d0,CHAMPIONSHIP_MENU_FILENAME
    move.l              #CHAMPIONSHIP_MENU_FILENAME,MENUSCREEN_IMAGE        ; set background image file here
    adda.w              #MOVER_IMG_SIZE,a0
    move.w              (a0),d0
    ext.l               d0
    move.l              d0,MENUSCREEN_IMAGE_SIZE
    move.l              #CHAMPIONSHIP_MENU_MAIN,MENUSCREEN_ENTRIES     ; point "entry" data structure
    move.l              #CHAMPIONSHIP_MENU_MAIN_TXT,TXTSCREEN_ENTRIES            ; point "txt" data structure
    move.l              MENU_CHAMPIONSHIP_CURRENTLY_SELECTED,MENUSCREEN_SELECTED_ENTRY ; where the cursor is at the beginning?
    jsr                 MENUSCREEN
    rts
