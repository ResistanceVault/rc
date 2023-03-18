; How a .trk file works
; byte from to 9599         -> raw planar image first bitplane (320X240)
; byte from 9600 to 19199   -> raw planar image second bitplane (320X240)
; byte from 19200 to 28799  -> raw planar image third bitplane (320X240)
; byte from 28800 to 38399  -> raw planar image fouth bitplane (320X240)
; byte from 38400 to 47999  -> raw planar image fifth bitplane (320X240)
; byte from 48000 to 48063  -> color palette (32 colors)
; byte from 48064 to 124863 -> track metadata (raw indexed image 1 byte each pixel)

LOAD_TRACK_THUMBNAIL_HEIGHT EQU 64

execBase equ 4
ACCESS_READ equ -2
MEMF_ANY equ 0
MODE_OLDFILE EQU 1005
;
; from exec includes
;
_LVOOpenLibrary equ -552
_LVOCloseLibrary equ -414
_LVOAllocVec equ -684
_LVOFreeVec equ -690

;
; from dos includes
;
_LVOExamine equ -102
_LVOExNext equ -108
_LVOLock equ -84
_LVOUnLock equ -90
_LVOOpen	EQU	-30
_LVOClose	EQU	-36
_LVORead     EQU   -42

                    rsset   0
fib_DiskKey         rs.l    1
fib_DirEntryType    rs.l    1
fib_FileName        rs.b    108
fib_Protection      rs.l    1
fib_EntryType       rs.l    1
fib_Size            rs.l    1
fib_NumBlocks       rs.l    1
fib_DateStamp       rs.b    12
fib_Comment         rs.b    80
fib_OwnerUID        rs.w    1
fib_OwnerGID        rs.w    1
fib_Reserved        rs.b    32
fib_SIZEOF          rs.b    0

pathString
    dc.b    "tracks/",0
    even

buffer: 
    dc.b "tracks/"
    dcb.b 108+1,0
    even

LOAD_TRACK:

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

    move.l  execBase,a6

    lea	    $dff000,a5
	MOVE.L	#$7FFF7FFF,$9A(A5)	; INTERRUPTS & INTREQS DISABLE

	move.l	BaseVBR,a0	        ; Set VBR value into a0
    move.l	OldInt68,$68(a0)    ; Sys int liv2 (I/O,ciaa,int2)

	move.w #$8010,$96(A5) ; enable DMA for floppy drive
    MOVE.W	OLDINTENA,$9A(A5)	; INTENA STATUS
	MOVE.W	OLDINTREQ,$9C(A5)	; INTREQ

    ; allocate memory for file info block
    move.l  #fib_SIZEOF,d0
    move.l  #MEMF_ANY,d1
    jsr     _LVOAllocVec(a6)
    move.l  d0,fib
    beq     .exit

    ; get directory lock
    move.l  dosBase,a6
    move.l  #pathString,d1
    move.l  #ACCESS_READ,d2
    jsr     _LVOLock(a6)
    move.l  d0,lock
    beq     .exit

    ; examine directory for ExNext
    move.l  lock,d1
    move.l  fib,d2
    jsr     _LVOExamine(a6)
    tst.w   d0
    beq     .exit

    ; for each element inside the tracks directory
.loop:

    move.l  fib,a3

    lea     fib_EntryType(a3),a4
    lea     fib_FileName(a3),a3

    cmpi.l #$2,(a4)
    beq.w .next

    ; copy full path
    lea buffer+7,a0
    move.l a3,a4
.startcopy:
    move.b (a4)+,(a0)+
    clr.b (a0)
    tst.b (a4)
    beq.s .endcopy
    bra.s .startcopy
.endcopy:


    ;Alessio start test
    moveq #3,d7
.ciao
    move.l  #MODE_OLDFILE,d2
    move.l	#buffer,d1
    jsr     _LVOOpen(a6)
    tst.l	d0
    move.l	d0,fd

    ; close the file
	move.l	fd,d1				; result = LVOClose(handle[d1])      
    jsr     _LVOClose(a6)

    dbra d7,.ciao
    move.l  #MODE_OLDFILE,d2
    move.l	#buffer,d1
    jsr     _LVOOpen(a6)
    tst.l	d0
    move.l	d0,fd

    ;file = Open( name, accessMode )
	;D0	     D1    D2

    ;actualLength = Read( file, buffer, length )
	;D0		     D1    D2	   D3
    ; first bitplane
    move.l fd,d1
    move.l #TRACK_DATA_1,d2
    move.l #9600,d3
    jsr     _LVORead(a6)

    ; second bitplane
    move.l fd,d1
    move.l #TRACK_DATA_2,d2
    move.l #9600,d3
    jsr     _LVORead(a6)

    ; third bitplane
    move.l fd,d1
    move.l #TRACK_DATA_3,d2
    move.l #9600,d3
    jsr     _LVORead(a6)

    ; fourth bitplane
    move.l fd,d1
    move.l #TRACK_DATA_4,d2
    move.l #9600,d3
    jsr     _LVORead(a6)

    ; fifth bitplane
    move.l fd,d1
    move.l #TRACK_DATA_5,d2
    move.l #9600,d3
    jsr     _LVORead(a6)

    ; colors
    move.l fd,d1
    move.l #TRACK_DATA_COLORS,d2
    move.l #64,d3
    jsr     _LVORead(a6)

    ; track metadata
    move.l fd,d1
    move.l #TRACK_METADATA,d2
    move.l #76800,d3
    jsr     _LVORead(a6)

    ; close the file
	move.l	fd,d1				; result = LVOClose(handle[d1])      
    jsr     _LVOClose(a6)

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
    ;move.w #(40*240/2)-1,d7
    ;clr.l d5
    ;clr.l d6
;.drawthumbnailstart:
;    lea TRACK_DATA_1,a0
;    lea PHAZELOGO+LOAD_TRACK_THUMBNAIL_HEIGHT*40,a1
;    bsr.w drawthumbyte

;    lea TRACK_DATA_2,a0
;    lea PHAZELOGO+256*40*1+LOAD_TRACK_THUMBNAIL_HEIGHT*40,a1
;    bsr.w drawthumbyte

;    lea TRACK_DATA_3,a0
;    lea PHAZELOGO+256*40*2+LOAD_TRACK_THUMBNAIL_HEIGHT*40,a1
;    bsr.w drawthumbyte

;    lea TRACK_DATA_4,a0
;    lea PHAZELOGO_4+LOAD_TRACK_THUMBNAIL_HEIGHT*40,a1
;    bsr.w drawthumbyte

;    lea TRACK_DATA_5,a0
;    lea PHAZELOGO_5+LOAD_TRACK_THUMBNAIL_HEIGHT*40,a1
;    bsr.w drawthumbyte

;    addq #2,d5
;    addq #1,d6

;    dbra d7,.drawthumbnailstart

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

    ; copy colors
    moveq #32-1,d7
    lea 				TRACK_DATA_COLORS,a0
    lea                 COPCOLOR_TRACK_0+2,a1
.colortrackthumb
    move.w              (a0)+,(a1)
    addq                #4,a1
            DEBUG 1112
    dbra d7,.colortrackthumb
            DEBUG 1111


; get next directory entry
.next:
    move.l  lock,d1
    move.l  fib,d2
    jsr     _LVOExNext(a6)
    tst.w   d0
    beq     .exit

    ;move.l  a3,(a2)
    ;move.l  #formatString,d1
    ;move.l  #printfArgs,d2
    ;jsr     _LVOVPrintf(a6)

.nomatch
    bra     .loop

.exit:
    move.l  dosBase,a6
    move.l  lock,d1
    jsr     _LVOUnLock(a6)

    move.l  execBase,a6
    move.l  fib,a1
    ;tst.l a1
    tst.l   fib
    beq     .l1
    jsr     _LVOFreeVec(a6)
.l1
    move.l  dosBase,a1
    jsr     _LVOCloseLibrary(a6)

    move.w #$0010,$96(A5) ; enable DMA for floppy drive
    MOVE.L	#$7FFF7FFF,$9A(A5)	; DISABILITA GLI INTERRUPTS & INTREQS

    move.l				BaseVBR,a0
	move.l				#MioInt68KeyB,$68(A0)	; Routine for keyboard on int 2
    move.w 				#$C008,$dff09a ; intena, enable interrupt lvl 2
mouseloadtrack:
    btst				#6,$bfe001	; mouse premuto?
	bne.w				mouseloadtrack
    rts

;
; variables
;
lock
    dc.l    0
fib
    dc.l    0
fd
    dc.l    0

drawthumbyte:
    move.w 0(a0,d5.w),d0
    jsr HALF_WORD
    move.b d0,0(a1,d6.w)
    rts