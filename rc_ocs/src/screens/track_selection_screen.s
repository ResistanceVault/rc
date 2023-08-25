LOAD_TRACK_THUMBNAIL_HEIGHT EQU 32

TRACK_NUMBER:           dc.w 0
TRACK_INCREMENT:        dc.w 1

SET_TRACK_SELECT_BITPLANE: dc.w 1

TRACK_SELECTION_SCREEN_PREVIOUS: dc.b 'PREVIOUS TRACK',$FF
    even
TRACK_SELECTION_SCREEN_NEXT: dc.b 'NEXT TRACK',$FF
    even

TRACK_SELECTION_SCREEN_BACK: dc.b 'BACK',$FF
    even

TRACK_SELECTION_SCREEN_START_RACE: dc.b 'START RACE',$FF
    even

CURRENT_TRACK_TXT: dc.b "CURRENT TRACK",$FF
    even

MENU_TRACK_SELECTION_SCREEN:
    dc.w 1,29
    dc.l TRACK_SELECTION_SCREEN_PREVIOUS
    dc.l ACTION_TRACK_SELECTION_SCREEN_PREVIOUS
    dc.l 0
    dc.w 8
    dc.w 7

    dc.w 1,31
    dc.l TRACK_SELECTION_SCREEN_NEXT
    dc.l ACTION_TRACK_SELECTION_SCREEN_NEXT
    dc.l 0
    dc.w 8
    dc.w 7

    dc.w 1,33
    dc.l TRACK_SELECTION_SCREEN_START_RACE
    dc.l ACTION_TRACK_SELECTION_SCREEN_START_RACE
    dc.l 0
    dc.w 8
    dc.w 7

    dc.w 1,35
    dc.l TRACK_SELECTION_SCREEN_BACK
    dc.l ACTION_TRACK_SELECTION_SCREEN_BACK
    dc.l 0
    dc.w 8
    dc.w 7

    dcb.b  menu_SIZEOF,$00 ; terminator

TXT_TRACK_SELECTION_SCREEN:
    dc.w 1,25
    dc.l CURRENT_TRACK_TXT
    dc.w 8
    dc.w 7

    dc.w 17,25
    dc.l START_RACE_TRACK_NAME_TXT
    dc.w 8
    dc.w 7

    dcb.b  txt_SIZEOF,$00 ; terminator

ACTION_TRACK_SELECTION_SCREEN_START_RACE:
    clr.l  NEXT_SCREEN
    jsr    ACTION_START_RACE_NEW
    ENABLE_LOADING_SCREEN
    rts

ACTION_TRACK_SELECTION_SCREEN_PREVIOUS:
    subi.w  #1,TRACK_NUMBER
    tst.w   TRACK_NUMBER
    bne.s   .previous_is_ok
    move.w  #1,TRACK_NUMBER
    ENABLE_LOADING_SCREEN
    rts
.previous_is_ok:
    move.l  #SELECT_TRACK_SCREEN,NEXT_SCREEN
    move.w  #1,MAIN_EXIT
    ENABLE_LOADING_SCREEN
    rts

ACTION_TRACK_SELECTION_SCREEN_NEXT:
    addi.w  #1,TRACK_NUMBER
    move.l  #SELECT_TRACK_SCREEN,NEXT_SCREEN
    move.w  #1,MAIN_EXIT
    ENABLE_LOADING_SCREEN
    rts

ACTION_TRACK_SELECTION_SCREEN_BACK:
    move.w  #1,MAIN_EXIT
    move.l  #MENU_START_RACE_SCREEN,NEXT_SCREEN
    clr.w   LOAD_NEXT_TRACK_FLAG
    ENABLE_LOADING_SCREEN
    rts

SELECT_TRACK_SCREEN:
    ENABLE_LOADING_TRACK
    move.w              #1,TRACK_OPEN_FILE
    jsr                 LOAD_TRACK

    jsr                 PRINT_TRACK_NAME_NEW

    ; print screen
    move.l              #0,MENUSCREEN_IMAGE_SIZE
    move.l              #MENU_TRACK_SELECTION_SCREEN,MENUSCREEN_ENTRIES
    move.l              #TXT_TRACK_SELECTION_SCREEN,TXTSCREEN_ENTRIES
    move.l              #MENU_TRACK_SELECTION_SCREEN,MENUSCREEN_SELECTED_ENTRY
    MENU_SET_CALLBACK_BEFORE_LOOP  #TRACK_PRINT_HALF_IMAGE
    jsr                 MENUSCREEN
    rts

TRACK_PRINT_HALF_IMAGE:
    movem.l d0-d7/a0-a6,-(sp)
    moveq #0,d4
    moveq #0,d5

SCREEN_TRACK_SELECT:

    moveq #0,d1
    moveq #0,d2

    ; for each bitplane
    moveq #5-1,d7
.eachbitplane:

    lea TRACK_DATA_1,a0
    adda.l d1,a0

    lea 10+PHAZELOGO+LOAD_TRACK_THUMBNAIL_HEIGHT*40,a1;
    adda.l d2,a1

    ; for each row
    moveq #(240/2)-1,d6
.eachrow:

    ; for each word
    moveq #(40/2)-1,d5
.eachword:

    ; fetch data from original image
    move.w  (a0)+,d0
    jsr HALF_WORD
    move.b d0,(a1)+

    dbra    d5,.eachword

    adda.w  #40,a0 ; on the source image we must skip one row each time to halve the height
    adda.w  #40-20,a1 ; in the destination screen go to next line

    dbra    d6,.eachrow

    add.l   #40*256,d1  ; source image must point to next bitplane skipping the banner area
    add.l   #40*256,d2 ; destination image must point to next bitplane
    dbra    d7,.eachbitplane


    MEMCPY4				TRACK_DATA_COLORS,MAIN_PALETTE,64/4
    move.w              #BACKGROUNDCOLOR,MAIN_PALETTE_0
    move.w              #BACKGROUNDCOLOR,MAIN_PALETTE2_0

    movem.l (sp)+,d0-d7/a0-a6
    rts