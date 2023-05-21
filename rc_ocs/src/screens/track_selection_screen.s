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
    dc.l START_RACE_NEXT_TRACK_TXT
    dc.w 8
    dc.w 7

    dc.w 13,25
    dc.l START_RACE_TRACK_NAME_TXT
    dc.w 8
    dc.w 7

    dcb.b  txt_SIZEOF,$00 ; terminator

ACTION_TRACK_SELECTION_SCREEN_START_RACE:
    clr.l  NEXT_SCREEN
    jsr    ACTION_START_RACE_NEW
    rts

ACTION_TRACK_SELECTION_SCREEN_PREVIOUS:
    subi.w  #1,TRACK_NUMBER
    tst.w   TRACK_NUMBER
    bne.s   .previous_is_ok
    move.w  #1,TRACK_NUMBER
    rts
.previous_is_ok:
    move.l  #SELECT_TRACK_SCREEN,NEXT_SCREEN
    move.w  #1,MAIN_EXIT
    rts

ACTION_TRACK_SELECTION_SCREEN_NEXT:
    addi.w  #1,TRACK_NUMBER
    move.l  #SELECT_TRACK_SCREEN,NEXT_SCREEN
    move.w  #1,MAIN_EXIT
    rts

ACTION_TRACK_SELECTION_SCREEN_BACK:
    move.w  #1,MAIN_EXIT
    move.l  #MENU_START_RACE_SCREEN,NEXT_SCREEN
    clr.w   LOAD_NEXT_TRACK_FLAG
    rts

SELECT_TRACK_SCREEN:
    move.w              #1,TRACK_OPEN_FILE
    jsr                 LOAD_TRACK

    jsr PRINT_TRACK_NAME_NEW

    ; print screen
    ;move.l              #START_RACE_SCREEN_FILENAME,MENUSCREEN_IMAGE
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

    ; for each line
    move.w #(240/2)-1,d7
.drawthumbnailstart_y:
    ; 40 bytes for each row (source image)
    moveq #20,d6
.drawthumbnailstart_x:

    ; fetch a word from source image bpl1
    lea TRACK_DATA_1,a0
    move.w 0(a0,d4.w),d0
    jsr HALF_WORD

    ; write into screen bpl1
    lea 10+PHAZELOGO+LOAD_TRACK_THUMBNAIL_HEIGHT*40,a1
    move.b d0,0(a1,d5.w)

    ; fetch a word from source image bpl2
    lea TRACK_DATA_2,a0
    move.w 0(a0,d4.w),d0
    jsr HALF_WORD

    ; write into screen bpl2
    lea 10+PHAZELOGO+256*40*1+LOAD_TRACK_THUMBNAIL_HEIGHT*40,a1
    move.b d0,0(a1,d5.w)

    ; fetch a word from source image bpl3
    lea TRACK_DATA_3,a0
    move.w 0(a0,d4.w),d0
    jsr HALF_WORD

    ; write into screen bpl3
    lea 10+PHAZELOGO+256*40*2+LOAD_TRACK_THUMBNAIL_HEIGHT*40,a1
    move.b d0,0(a1,d5.w)

    ; fetch a word from source image bpl4
    lea TRACK_DATA_4,a0
    move.w 0(a0,d4.w),d0
    jsr HALF_WORD

    ; write into screen bpl4
    lea 10+PHAZELOGO_4+LOAD_TRACK_THUMBNAIL_HEIGHT*40,a1
    move.b d0,0(a1,d5.w)

    ; fetch a word from source image bpl5
    lea TRACK_DATA_5,a0
    move.w 0(a0,d4.w),d0
    jsr HALF_WORD

    ; write into screen bpl4
    lea 10+PHAZELOGO_5+LOAD_TRACK_THUMBNAIL_HEIGHT*40,a1
    move.b d0,0(a1,d5.w)

    addq #2,d4
    addq #1,d5

    dbra d6,.drawthumbnailstart_x

    ; skip next 40 bytes for source image
    add.w #40-2,d4
    add.w #20-1,d5

    dbra d7,.drawthumbnailstart_y

    MEMCPY4				TRACK_DATA_COLORS,MAIN_PALETTE,64/4

    movem.l (sp)+,d0-d7/a0-a6
    rts