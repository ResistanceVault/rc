LOAD_TRACK_THUMBNAIL_HEIGHT EQU 64

TRACK_NUMBER:           dc.w 0
TRACK_INCREMENT:        dc.w 1
BANNERTXT:              dc.b "JOY1 L R TO SELECT."
BANNERTXT2:             dc.b "JOY1 FIRE TO CONFIRM."
    even
SET_TRACK_SELECT_BITPLANE: dc.w 1

SCREEN_TRACK_SELECT:
    ; wait for fire released
trackselectscreen_firstend:
    btst				#7,$bfe001	; joy 1 fire released?
	beq.s				trackselectscreen_firstend

    move.w				COLORS_FONTS_SMALL+2,COPCOLOR_TRACK_BANNER_1+2
	move.w				COLORS_FONTS_SMALL+4,COPCOLOR_TRACK_BANNER_2+2
	move.w				COLORS_FONTS_SMALL+6,COPCOLOR_TRACK_BANNER_3+2
	move.w				COLORS_FONTS_SMALL+8,COPCOLOR_TRACK_BANNER_4+2
	move.w				COLORS_FONTS_SMALL+10,COPCOLOR_TRACK_BANNER_5+2
	move.w				COLORS_FONTS_SMALL+12,COPCOLOR_TRACK_BANNER_6+2
	move.w				COLORS_FONTS_SMALL+14,COPCOLOR_TRACK_BANNER_7+2
    move.w				COLORS_FONTS_SMALL+2,COPCOLOR_TRACK_BANNER2_1+2
	move.w				COLORS_FONTS_SMALL+4,COPCOLOR_TRACK_BANNER2_2+2
	move.w				COLORS_FONTS_SMALL+6,COPCOLOR_TRACK_BANNER2_3+2
	move.w				COLORS_FONTS_SMALL+8,COPCOLOR_TRACK_BANNER2_4+2
	move.w				COLORS_FONTS_SMALL+10,COPCOLOR_TRACK_BANNER2_5+2
	move.w				COLORS_FONTS_SMALL+12,COPCOLOR_TRACK_BANNER2_6+2
	move.w				COLORS_FONTS_SMALL+14,COPCOLOR_TRACK_BANNER2_7+2

    clr.w               TRACK_INCREMENT

load_next_track:
    move.w              TRACK_INCREMENT,d0
    add.w               d0,TRACK_NUMBER     ; next track please!
    ; if zero we are out of bounds, force to 1
    bne.w               next_track_not_zero
    move.w              #1,TRACK_NUMBER
next_track_not_zero:
    move.w              #1,TRACK_OPEN_FILE
    jsr                 LOAD_TRACK
    jsr                 PRINT_TRACK_NAME

    ; clean banner on top (LOAD_TRACK_THUMBNAIL_HEIGHT lines)
    move.w #(LOAD_TRACK_THUMBNAIL_HEIGHT*40/4)-1,d7
    clr.l d6
.topbanner:
    lea PHAZELOGO+256*40*0,a0
    clr.l 0(a0,d6.w)
    lea PHAZELOGO+256*40*1,a0
    clr.l 0(a0,d6.w)
    lea PHAZELOGO+256*40*2,a0
    clr.l 0(a0,d6.w)
    lea PHAZELOGO_4,a0
    clr.l 0(a0,d6.w)
    lea PHAZELOGO_5,a0
    clr.l 0(a0,d6.w)
    addq #4,d6
    dbra d7,.topbanner

    ; print image thumbnail scaled
    ; reset counters
    moveq #0,d4
    moveq #0,d5

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

    ; copy colors
    moveq #31-1,d7
    lea 				TRACK_DATA_COLORS+2,a0
    lea                 COPCOLOR_TRACK_1+2,a1
.colortrackthumb
    move.w              (a0)+,(a1)
    addq                #4,a1
    dbra d7,.colortrackthumb

    ; print filename
    move.l              fib,a3
    lea                 fib_EntryType(a3),a1
    lea                 TRACK_FILENAME+TRACKDIR_LENGTH,a1
    moveq               #0,d0
    moveq               #0,d1
    bsr.w               printstringtrack

    ; do this only first time
    tst.w               SET_TRACK_SELECT_BITPLANE
    beq.w               nosettrackselectbitplane
    clr.w               SET_TRACK_SELECT_BITPLANE

    ; clean banner on bottom (remaining lines)
    move.w #((256-120-LOAD_TRACK_THUMBNAIL_HEIGHT)*40/4)-1,d7
    clr.l d6
.downbanner:
    lea PHAZELOGO+256*40*0+120*40+LOAD_TRACK_THUMBNAIL_HEIGHT*40,a0
    clr.l 0(a0,d6.w)
    lea PHAZELOGO+256*40*1+120*40+LOAD_TRACK_THUMBNAIL_HEIGHT*40,a0
    clr.l 0(a0,d6.w)
    lea PHAZELOGO+256*40*2+120*40+LOAD_TRACK_THUMBNAIL_HEIGHT*40,a0
    clr.l 0(a0,d6.w)
    lea PHAZELOGO_4+120*40+LOAD_TRACK_THUMBNAIL_HEIGHT*40,a0
    clr.l 0(a0,d6.w)
    lea PHAZELOGO_5+120*40+LOAD_TRACK_THUMBNAIL_HEIGHT*40,a0
    clr.l 0(a0,d6.w)
    addq #4,d6
    dbra d7,.downbanner

    lea                 BANNERTXT,a1
    moveq               #0,d0
    moveq               #13,d1
    bsr.w               printstringtrack

    lea                 BANNERTXT2,a1
    moveq               #0,d0
    moveq               #15,d1
    bsr.w               printstringtrack

    ; Init tiles bitplanes
    move.l              #PHAZELOGO,d0
    lea                 BPLPTR1_TRACK,a1
    bsr.w               POINTINCOPPERLIST_FUNCT

    move.l              #PHAZELOGO+256*40*1,d0
    lea                 BPLPTR2_TRACK,a1
    bsr.w               POINTINCOPPERLIST_FUNCT

    move.l              #PHAZELOGO+256*40*2,d0
    lea                 BPLPTR3_TRACK,a1
    bsr.w               POINTINCOPPERLIST_FUNCT

    move.l              #PHAZELOGO_4,d0
    lea                 BPLPTR4_TRACK,a1
    bsr.w               POINTINCOPPERLIST_FUNCT

    move.l              #PHAZELOGO_5,d0
    lea                 BPLPTR5_TRACK,a1
    bsr.w               POINTINCOPPERLIST_FUNCT

    move.l				#COPPERLIST_TRACK,$dff080	; Copperlist point
	move.w				d0,$dff088			; Copperlist start
nosettrackselectbitplane:


trackselectscreen_start:

mousewelcometrack:
    cmpi.b  			#$ff,$dff006    ; Linea 255?
    bne.s   			mousewelcometrack

    ;move.w #$0ff0,$dff180

    ;joy1_right_pressed ?
    jsr                 READJOY1
    btst                #0,d0
    beq.s               trackselectscreen_check_joy1_left
    move.w              #1,TRACK_INCREMENT
    bne.w               load_next_track

;joy1_right_pressed ?
trackselectscreen_check_joy1_left:
    jsr                 READJOY1
    btst                #1,d0
    beq.s               fireloadtrack
    move.w              #-1,TRACK_INCREMENT
    bne.w               load_next_track

fireloadtrack:
    btst				#7,$bfe001	; joy 1 fire pressed?
	bne.s				fireloadtrack_end
    DEBUG 7777

fireloadtrackrel:
    ;move.w #$0f00,$dff180
    btst				#7,$bfe001	; joy 1 fire released?
	beq.s				fireloadtrackrel
    bra.s               trackselectscreen_end
fireloadtrack_end:
    tst.b 				KEY_ESC
	bne.w 				trackselectscreen_end
waitwelcometrack:
    cmpi.b  			#$ff,$dff006    ; linea 255?
    beq.s   			waitwelcometrack
    bra.s               trackselectscreen_start
trackselectscreen_end:
    rts

printstringtrack:
    moveq               #0,d6
    move.b              (a1)+,d6
    cmp.w               #46,d6
    beq.s               printstringtrackend
    sub.w               #32,d6
    muls.w              #2*16*3,d6

    lea                 BIGFONTS,a0
    adda.l              d6,a0
    bsr.s               printbigfonttrack
    addq                #1,d0
    bra.s               printstringtrack

printstringtrackend:
    rts

printbigfonttrack:
    movem.l             a0/a1/a2/a3/d0/d1,-(sp)
    lea                 PHAZELOGO+256*40*0,a1
    lea                 PHAZELOGO+256*40*1,a2
    lea                 PHAZELOGO+256*40*2,a3

    lsl.w               #1,d0
    adda.w              d0,a1
    adda.w              d0,a2
    adda.w              d0,a3

    mulu.w              #40*16,d1
    adda.w              d1,a1
    adda.w              d1,a2
    adda.w              d1,a3


    moveq               #16-1,d7
bigfontcycletrack:
    move.b              (a0),(a1)
    move.b              1(a0),1(a1)

    move.b              2*16*1(a0),(a2)
    move.b              1+2*16*1(a0),1(a2)

    move.b              2*16*2(a0),(a3)
    move.b              1+2*16*2(a0),1(a3)

    addq                #2,a0
    adda.l              #40,a1
    adda.l              #40,a2
    adda.l              #40,a3

    dbra                d7,bigfontcycletrack
    movem.l             (sp)+,a0/a1/a2/a3/d0/d1
    rts