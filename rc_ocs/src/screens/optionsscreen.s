OPTIONS_SCREEN_SOUNDS_OPTIONS:
    dc.l MENU_OPTIONS_SOUND_STATUS_SFX_TXT
    dc.l MENU_OPTIONS_SOUND_STATUS_SFX_ACTION

    dc.l MENU_OPTIONS_SOUND_STATUS_MUSIC_TXT
    dc.l MENU_OPTIONS_SOUND_STATUS_MUSIC_ACTION

    dc.l MENU_OPTIONS_SOUND_STATUS_NOSOUND_TXT
    dc.l MENU_OPTIONS_SOUND_STATUS_NOSOUND_ACTION
OPTIONS_SCREEN_SOUNDS_OPTIONS_END:

OPTIONS_SCREEN_SOUNDS_OPTIONS_PTR:  dc.l OPTIONS_SCREEN_SOUNDS_OPTIONS

MENU_OPTIONS_SOUND_STATUS_SFX_TXT:
    dc.b "SFX   ",$FF
    even

MENU_OPTIONS_SOUND_STATUS_MUSIC_TXT:
    dc.b "MUSIC ",$FF
    even

MENU_OPTIONS_SOUND_STATUS_NOSOUND_TXT:
    dc.b "OFF   ",$FF
    even

MENU_OPTIONS_SOUND_STATUS_SFX_ACTION:
    clr.w       PLAY_MUSIC
    move.w      #1,PLAY_SOUND
    rts

MENU_OPTIONS_SOUND_STATUS_MUSIC_ACTION:
    clr.w       PLAY_SOUND
    move.w      #1,PLAY_MUSIC
    rts

MENU_OPTIONS_SOUND_STATUS_NOSOUND_ACTION:
    clr.w       PLAY_SOUND
    clr.w       PLAY_MUSIC
    rts

OPTIONS_SCREEN_FILENAME:
    dc.b "options.shr",0
    even

MENU_OPTIONS_SOUND_TXT:
    dc.b "SOUND ",$FF
    even

MENU_OPTIONS_SOUND_STATUS_TXT:
    dc.b "SFX   ",$FF
    even

CHAMPIONSHIP_RACES_TXT:
    dc.b "RACES",$FF
    even

MENU_OPTIONS_RACE_COUNTER_TXT:
    dc.b "2",$FF
    even

;MENU_OPTIONS_SOUND_STATUS_OFF_TXT:
 ;   dc.b "OFF   ",$FF
 ;   even

MENU_OPTIONS_SCREEN:

    dc.w 1,9
    dc.l CHAMPIONSHIP_RACES_TXT
    dc.l ACTION_CHANGE_RACE_COUNT
    dc.l 0
    dc.w 16
    dc.w 16

    dc.w 1,11
    dc.l MENU_OPTIONS_SOUND_TXT
    dc.l OPTIONS_CHANGE_SOUND_FUNCT
    dc.l 0
    dc.w 16
    dc.w 16

    dc.w 1,13
    dc.l MENU_CARS_SETUP_SCREEN_BACK_TXT
    dc.l MENU_CARS_SETUP_SCREEN_BACK_FUNCT
    dc.l 0
    dc.w 16
    dc.w 16

    dcb.b  menu_SIZEOF,$00 ; terminator

TXT_OPTIONS_SCREEN:

TXT_OPTION_RACE_COUNTER:
    dc.w 7,9
    dc.l MENU_OPTIONS_RACE_COUNTER_TXT
    dc.w 16
    dc.w 16

TXT_OPTIONS_SOUND_STATUS:
    dc.w 7,11
    dc.l MENU_OPTIONS_SOUND_STATUS_TXT
    dc.w 16
    dc.w 16

    dcb.b  txt_SIZEOF,$00


OPTIONS_SCREEN:

    ; prepare race number with default value
    move.w  MAX_RACES,d0
    addi.w  #$30,d0
    lsl.w   #8,d0
    move.b  #$FF,d0
    move.w  d0,MENU_OPTIONS_RACE_COUNTER_TXT

    ; print screen
    move.l  #OPTIONS_SCREEN_FILENAME,MENUSCREEN_IMAGE
    move.l  #13252,MENUSCREEN_IMAGE_SIZE
    move.l  #MENU_OPTIONS_SCREEN,MENUSCREEN_ENTRIES
    move.l  #TXT_OPTIONS_SCREEN,TXTSCREEN_ENTRIES
    move.l  #MENU_OPTIONS_SCREEN,MENUSCREEN_SELECTED_ENTRY
    jsr     MENUSCREEN
    rts

ACTION_CHANGE_RACE_COUNT:
    addi.w  #1,MAX_RACES
    IF_1_LESS_EQ_2_W_U #10,MAX_RACES,.donotresetracescounter,s
    move.w  #1,MAX_RACES
.donotresetracescounter:

    move.w  MAX_RACES,d0
    addi.w  #$30,d0
    lsl.w   #8,d0
    move.b  #$FF,d0
    move.w  d0,MENU_OPTIONS_RACE_COUNTER_TXT

    lea                 TXT_OPTION_RACE_COUNTER(PC),a1
    jsr                 REFRESH_TXT_ENTRY

    rts

OPTIONS_CHANGE_SOUND_FUNCT:
    ; read pointer to sound options into a1
    move.l              OPTIONS_SCREEN_SOUNDS_OPTIONS_PTR,a1

    ; find next , to do this add 8
    addq                #8,a1

    ; check if we are at the end, if this is the case reset
    cmpa.l              #OPTIONS_SCREEN_SOUNDS_OPTIONS_END,a1
    bne.s               .soundoption_noreset
    lea                 OPTIONS_SCREEN_SOUNDS_OPTIONS,a1
.soundoption_noreset:

    ; save new pointer
    move.l              a1,OPTIONS_SCREEN_SOUNDS_OPTIONS_PTR

    ; execute action
    move.l              4(a1),a0
    jsr                 (a0)

    ; refresh text
    lea                 TXT_OPTIONS_SOUND_STATUS(PC),a0
    move.l              0(a1),txt_DescPtr(a0)
    lea                 TXT_OPTIONS_SOUND_STATUS(PC),a1

    jsr                 REFRESH_TXT_ENTRY
    rts

;OPTIONS_CHANGE_SOUND_FUNCT:
;    tst.w               PLAY_SOUND
;    beq.s               .turn_sound_on
;    move.w              #0,PLAY_SOUND
;    jsr                 OPTIONS_SCREEN_SET_SOUND_DESC
;    lea                 TXT_OPTIONS_SOUND_STATUS(PC),a1
;    jsr                 REFRESH_TXT_ENTRY
;    rts
;.turn_sound_on
;    move.w              #1,PLAY_SOUND
;    jsr                 OPTIONS_SCREEN_SET_SOUND_DESC
;    lea                 TXT_OPTIONS_SOUND_STATUS(PC),a1
;    jsr                 REFRESH_TXT_ENTRY
;    rts

REFRESH_TXT_ENTRY:
    movem.l              d0-d7/a0-a6,-(sp)
    move.l               a1,a6
    move.w               txt_EntryX(a6),d0
    move.w               txt_EntryY(a6),d1
    move.l               txt_DescPtr(a6),a1
    cmp.w                #8,txt_FontWidthPx(a6)
    bne.s                refresh_txt_entry_printbigfonts2
    bsr.w                restorebackground_small
    bsr.w                printstringhigh_small
    movem.l              (sp)+,d0-d7/a0-a6
    rts
refresh_txt_entry_printbigfonts2:
    bsr.w                restorebackground_big
    bsr.w                printstringhigh
    movem.l              (sp)+,d0-d7/a0-a6
    rts

restorebackground_big:
    movem.l             a1/d0,-(sp)
restorebackground_big_startcycle
    moveq               #0,d6
    move.b              (a1)+,d6
    cmp.w               #$FF,d6
    beq.s               restorebackground_big_end
    bsr.w               restorebackground_tile_big
    addq                #1,d0
    bra.s               restorebackground_big_startcycle
restorebackground_big_end:
    movem.l             (sp)+,a1/d0
    rts

restorebackground_tile_big:
    movem.l             d0/d1/d6/a0-a6,-(sp)
    mulu.w              #40*16,d1
    lsl.w               #1,d0
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

    moveq               #16-1,d6
restorebackground_tile_big_start_loop:
    move.w              (a0),(a3)
    move.w              (a1),(a4)
    move.w              (a2),(a5)
    move.w              (a6),40*256(a5)
    clr.w               40*256*2(a5)

    adda.l              #40,a0
    adda.l              #40,a1
    adda.l              #40,a2
    adda.l              #40,a3
    adda.l              #40,a4
    adda.l              #40,a5
    adda.l              #40,a6

    dbra                d6,restorebackground_tile_big_start_loop

    movem.l             (sp)+,d0/d1/d6/a0-a6
    rts

;OPTIONS_SCREEN_SET_SOUND_DESC:
    ; read sound status
;    lea     TXT_OPTIONS_SOUND_STATUS(PC),a0
;    tst.w   PLAY_SOUND
;    beq.s   .option_screen_no_sound
;    move.l  #MENU_OPTIONS_SOUND_STATUS_SFX_TXT,txt_DescPtr(a0)
;    bra.s   .option_screen_sound_end
;.option_screen_no_sound
;     move.l  #MENU_OPTIONS_SOUND_STATUS_OFF_TXT,txt_DescPtr(a0)
;.option_screen_sound_end:
;    rts

OPTIONS_SCREEN_SET_SOUND_DESC:
    ; read pointer to sound options into a1
    move.l              OPTIONS_SCREEN_SOUNDS_OPTIONS_PTR,a1

    ; at this address and offset zero we have the address of the string to print
    move.l              (a1),a1

    ; slap this address into TXT_OPTIONS_SOUND_STATUS
    lea                 TXT_OPTIONS_SOUND_STATUS(PC),a0
    move.l              (a1),txt_DescPtr(a0)

    rts


