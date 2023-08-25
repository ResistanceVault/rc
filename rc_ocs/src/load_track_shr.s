; How a .TRK file works
; - FILE must be inside track subfolder
; - FILE name must be uppercase and letter + space character only
; - FILE MUST HAVE .TRK extension
; byte from to 9599         -> raw planar image first bitplane (320X240)
; byte from 9600 to 19199   -> raw planar image second bitplane (320X240)
; byte from 19200 to 28799  -> raw planar image third bitplane (320X240)
; byte from 28800 to 38399  -> raw planar image fourth bitplane (320X240)
; byte from 38400 to 47999  -> raw planar image fifth bitplane (320X240)
; byte from 48000 to 48063  -> color palette (32 colors)
; byte from 48064 to 124863 -> track metadata (raw indexed image 1 byte each pixel)
; byte from 124864 to 124869 -> car 1 start position in this format: first word X position, second word Y position, third word degrees
; byte from 124870 to 124875 -> car 2 start position in this format: first word X position, second word Y position, third word degrees
; byte from 124876 to 124881 -> car 3 start position in this format: first word X position, second word Y position, third word degrees
; byte from 124882 to 124887 -> car 4 start position in this format: first word X position, second word Y position, third word degrees
; byte from 124888 to 124893 -> car 5 start position in this format: first word X position, second word Y position, third word degrees
; byte from 124894 to 124899 -> car 6 start position in this format: first word X position, second word Y position, third word degrees
; byte from 124900 to 124905 -> car 7 start position in this format: first word X position, second word Y position, third word degrees
; byte from 124906 to 124911 -> car 8 start position in this format: first word X position, second word Y position, third word degrees
; byte from 124912 to 125911 -> cpu points
; byte from 125912 to 125913 -> number of sections inside track

TRACKDIR_LENGTH 	equ 10
TRK_FILE_SIZE		equ 125916
TRK_FILE_FIRST_BPL 	equ 0
TRK_FILE_SECOND_BPL equ 9600
TRK_FILE_THIRD_BPL	equ 19200
TRK_FILE_FOURTH_BPL	equ 28800
TRK_FILE_FIFTH_BPL  equ 38400
TRK_FILE_COLORS		equ 48000
TRK_FILE_POSITIONS	equ 124864
TRK_CPUPOINTS_POSITIONS equ 124912

execBase equ 4
ACCESS_READ equ -2
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

PRINT_TRACK_PROGRESS MACRO
	tst.w	LOADING_TRACK_FLAG
	beq.s	.track_progress_1\@
	moveq   \1,d0
    bsr.w   PRINTLOADINGBAR
.track_progress_1\@
	ENDM

pathString:
    dc.b    "tracksshr/",0
    even

TRACK_FILENAME:
    dc.b "tracksshr/"
    dcb.b 108+1,0
    even

TRACK_COUNTER:
    dc.w    0

TRACK_OPEN_FILE:
	dc.w	0

COPY_METADATA:
	dc.w 1

LOAD_TRACK:
    move.l  execBase,a6
    lea	    $dff000,a5
	MOVE.L	#$7FFF7FFF,$9A(A5)	; INTERRUPTS & INTREQS DISABLE

	bsr.w PreparaLoad
    moveq	#50,d1		; num. di frames da aspettare
	bsr.w	AspettaBlanks	; aspetta 5 frames

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
    move.l #$98765432,d0
    jsr     _LVOExamine(a6)
    tst.w   d0
    beq     .exit

    ; reset track counter to 1
    move.w  #0,TRACK_COUNTER

    ; for each element inside the tracks directory
.loop:

    move.l  fib,a3

    move.l  fib_size(a3),d3
    lea     fib_EntryType(a3),a4
    lea     fib_FileName(a3),a3

    cmpi.l #$2,(a4)
    beq.w .next

    addi.w #1,TRACK_COUNTER
    move.w TRACK_COUNTER(PC),d0
    cmp.w  TRACK_NUMBER,d0
    bne.w  .next

    ; copy full path
    lea TRACK_FILENAME+TRACKDIR_LENGTH,a0
    move.l a3,a4
.startcopy:
    move.b (a4)+,(a0)+
    clr.b (a0)
    tst.b (a4)
    beq.s .endcopy
    bra.s .startcopy
.endcopy:

	tst.w	TRACK_OPEN_FILE
	beq.s	.exit

    move.l  #1005,d2
    move.l	#TRACK_FILENAME,d1
    jsr     _LVOOpen(a6)
    ;tst.l	d0
    move.l	d0,fd

    ;file = Open( name, accessMode )
	;D0	     D1    D2

    ;actualLength = Read( file, buffer, length )
	;D0		     D1    D2	   D3
    ; first bitplane
    move.l fd,d1
    move.l #TRACK_DATA_1,d2
    jsr     _LVORead(a6)

    ; close the file
	move.l	fd,d1				; result = LVOClose(handle[d1])
    jsr     _LVOClose(a6)

	PRINT_TRACK_PROGRESS #15

	move.w		#1,SHR_DECOMPRESS
    bra.s 		.exit

; get next directory entry
.next:
    move.l  lock,d1
    move.l  fib,d2
    jsr     _LVOExNext(a6)
    tst.w   d0
    beq     .endoflist

.nomatch
    bra     .loop

.exit:
    move.l  dosBase,a6
    move.l  lock,d1
    jsr     _LVOUnLock(a6)

    move.l	#150,d1		; num. di frames da aspettare
	bsr.w	AspettaBlanks	; aspetta 5 frames

    bsr.w 	DopoLoad

	tst.w	SHR_DECOMPRESS
	beq.w	.shr_no_decompress

	; decompress stage start
	PRINT_TRACK_PROGRESS #20
    moveq               #0,d0
    lea                 TRACK_DATA_1,a0
    lea                 TRK_FILE_END-TRK_FILE_SIZE,a1
    move.l              #SHR_TRK_PROGRESS,a2
    move.l              #0,a3
    moveq               #0,d2
    moveq               #1,d7
    jsr                 ShrinklerDecompress
	clr.w				SHR_DECOMPRESS
	PRINT_TRACK_PROGRESS #90

	; start copying Bitplanes
	MEMCPY4				TRK_FILE_END-TRK_FILE_SIZE+TRK_FILE_FIRST_BPL,TRACK_DATA_1,9600/4
	MEMCPY4 			TRK_FILE_END-TRK_FILE_SIZE+TRK_FILE_SECOND_BPL,TRACK_DATA_2,9600/4
	MEMCPY4 			TRK_FILE_END-TRK_FILE_SIZE+TRK_FILE_THIRD_BPL,TRACK_DATA_3,9600/4
	MEMCPY4 			TRK_FILE_END-TRK_FILE_SIZE+TRK_FILE_FOURTH_BPL,TRACK_DATA_4,9600/4
	MEMCPY4				TRK_FILE_END-TRK_FILE_SIZE+TRK_FILE_FIFTH_BPL,TRACK_DATA_5,9600/4
	tst.l				COPY_METADATA
	beq.s				.donotcopymetadata
	MEMCPY4				TRK_FILE_END-TRK_FILE_SIZE+TRK_FILE_COLORS,TRACK_DATA_COLORS,64/4
.donotcopymetadata:
	MEMCPY4				TRK_FILE_END-TRK_FILE_SIZE+TRK_FILE_POSITIONS,CAR_INFO_DATA,6*8/4

.shr_no_decompress:
	PRINT_TRACK_PROGRESS #99
    clr.b               KEY_ESC
    clr.w               JOY1FIREPRESSED
    jsr                 SETPOT
	move.w				#1,COPY_METADATA
    rts

.endoflist
    move.w              TRACK_COUNTER(PC),TRACK_NUMBER
    bra.w               .exit

;
; variables
;
lock
    dc.l    0
fib
    dc.l    MY_FIB
fd
    dc.l    0
SHR_DECOMPRESS:
	dc.w	0

*****************************************************************************
; Questa routine aspetta D1 fotogrammi. Ogni 50 fotogrammi passa 1 secondo.
;
; d1 = numero di fotogrammi da attendere
;
*****************************************************************************

AspettaBlanks:
	LEA	$DFF000,A5	; CUSTOM REG per OFFSETS
WBLAN1xb:
	MOVE.w	#$80,D0
WBLAN1bxb:
	CMP.B	6(A5),D0	; vhposr
	BNE.S	WBLAN1bxb
WBLAN2xb:
	CMP.B	6(A5),D0	; vhposr
	Beq.S	WBLAN2xb
	DBRA	D1,WBLAN1xb
	rts

*****************************************************************************
; Routine che ripristina il sistema operativo, tranne la copperlist, e in
; piu' setta un interrupt $6c nostro, che poi salta a quello di sistema.
; Da notare che durante il load l'interrupt e' gestito dall'int "COPER"
*****************************************************************************

PreparaLoad:
	LEA	$DFF000,A5		; Base dei registri CUSTOM per Offsets
	MOVE.W	$2(A5),OLDDMAL		; Salva il vecchio status di DMACON
	MOVE.W	$1C(A5),OLDINTENAL	; Salva il vecchio status di INTENA
	MOVE.W	$1E(A5),OLDINTREQL	; Salva il vecchio status di INTREQ
	MOVE.L	#$80008000,d0		; Prepara la maschera dei bit alti
	OR.L	d0,OLDDMAL		; Setta il bit 15 dei valori salvati
	OR.W	d0,OLDINTREQL		; dei registri, per poterli rimettere.

	jsr	ClearMyCache

	MOVE.L	#$7FFF7FFF,$9A(a5)	; DISABILITA GLI INTERRUPTS & INTREQS

	move.l	BaseVBR,a0	     ; In a0 il valore del VBR
	move.l	OldInt64,$64(a0) ; Sys int liv1 salvato (softint,dskblk)
	move.l	OldInt68,$68(a0) ; Sys int liv2 salvato (I/O,ciaa,int2)
	move.l	OldInt6c,$6c(a0) ; Sys int liv3 salvato (coper,vblanc,blit)

	move.l	OldInt70,$70(a0) ; Sys int liv4 salvato (audio)
	move.l	OldInt74,$74(a0) ; Sys int liv5 salvato (rbf,dsksync)
	move.l	OldInt78,$78(a0) ; Sys int liv6 salvato (exter,ciab,inten)

	MOVE.W	#%1000001001010000,$96(A5) ; Abilita blit e disk per sicurezza
	MOVE.W	OLDINTENA,$9A(A5)	; INTENA STATUS
	MOVE.W	OLDINTREQ,$9C(A5)	; INTREQ
	move.w	#$c010,$9a(a5)		; dobbiamo essere sicuri che COPER
					; (interrupt via copperlist) sia ON!

	move.l	4.w,a6
	JSR	-$7e(A6)	; Enable
	JSR	-$8a(a6)	; Permit

	MOVE.L	GfxBase,A6
	jsr	-$E4(A6)	; Aspetta la fine di eventuali blittate
	JSR	-$E4(A6)	; WaitBlit
	jsr	-$1ce(a6)	; DisOwnBlitter, il sistema operativo ora
				; puo' nuovamente usare il blitter
				; (nel kick 1.3 serve per caricare da disk)
	MOVE.L	4.w,A6
	SUBA.L	A1,A1		; NULL task - trova questo task
	JSR	-$126(A6)	; findtask (Task(name) in a1, -> d0=task)
	MOVE.L	D0,A1		; Task in a1
	MOVEQ	#0,D0		; Priorita' in d0 (-128, +127) - NORMALE
				; (Per permettere ai drives di respirare)
	JSR	-$12C(A6)	;_LVOSetTaskPri (d0=priorita', a1=task)
	rts

OLDDMAL:
	dc.w	0
OLDINTENAL:		; Vecchio status INTENA
	dc.w	0
OLDINTREQL:		; Vecchio status INTREQ
	DC.W	0


*****************************************************************************
; Routine che richiude il sistema operativo e rimette il nostro interrupt
*****************************************************************************

DopoLoad:
	MOVE.L	4.w,A6
	SUBA.L	A1,A1		; NULL task - trova questo task
	JSR	-$126(A6)	; findtask (Task(name) in a1, -> d0=task)
	MOVE.L	D0,A1		; Task in a1
	MOVEQ	#127,D0		; Priorita' in d0 (-128, +127) - MASSIMA
	JSR	-$12C(A6)	;_LVOSetTaskPri (d0=priorita', a1=task)

	JSR	-$84(a6)	; Forbid
	JSR	-$78(A6)	; Disable

	MOVE.L	GfxBase,A6
	jsr	-$1c8(a6)	; OwnBlitter, che ci da l'esclusiva sul blitter
				; impedendone l'uso al sistema operativo.
	jsr	-$E4(A6)	; WaitBlit - Attende la fine di ogni blittata
	JSR	-$E4(A6)	; WaitBlit

	jsr	ClearMyCache

	LEA	$dff000,a5		; Custom base per offsets
AspettaF:
	MOVE.L	4(a5),D0	; VPOSR e VHPOSR - $dff004/$dff006
	AND.L	#$1ff00,D0	; Seleziona solo i bit della pos. verticale
	CMP.L	#$12d00,D0	; aspetta la linea $12d per evitare che
	BEQ.S	AspettaF	; spegnendo i DMA si abbiano sfarfallamenti

	MOVE.L	#$7FFF7FFF,$9A(A5)	; DISABILITA GLI INTERRUPTS & INTREQS

		; 5432109876543210
	MOVE.W	#%0000010101110000,d0	; DISABILITA DMA

	btst	#8-8,olddmal	; test bitplane
	beq.s	NoPlanesA
	bclr.l	#8,d0		; non spengere planes
NoPlanesA:
	btst	#5,olddmal+2	; test sprite
	beq.s	NoSpritez
	bclr.l	#5,d0		; non spengere sprite
NoSpritez:
	MOVE.W	d0,$96(A5) ; DISABILITA DMA

	move.l	BaseVBR,a0		; In a0 il valore del VBR
	move.l				#MioInt68KeyB,$68(A0)	; Routine for keyboard on int 2
	MOVE.W	OLDDMAL(PC),$96(A5)	; Rimetti il vecchio status DMA
	MOVE.W	OLDINTENAL(PC),$9A(A5)	; INTENA STATUS
	MOVE.W	OLDINTREQL(PC),$9C(A5)	; INTREQ
	rts

SHR_TRK_PROGRESS:
	movem.l             d0-d7/a0-a6,-(sp)
    lsr.w               #3,d0
    
    move.w              #0,d1
    move.w              #TRK_FILE_SIZE/8,d2
    moveq               #0,d3
    move.w              #70-1,d4
    jsr                 MAP

    ; update progress bar
    move.w              d4,d0
    addi.w              #20,d0

    cmp.w               SHR_TRK_PREV_PROG,d0
    beq.s               shr_trk_noupd

    move.w              d0,SHR_TRK_PREV_PROG
    bsr.w               PRINTLOADINGBAR

shr_trk_noupd:
    movem.l             (sp)+,d0-d7/a0-a6
	rts

SHR_TRK_PREV_PROG: 		dc.w 0