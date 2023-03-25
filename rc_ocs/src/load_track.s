; How a .trk file works
; byte from to 9599         -> raw planar image first bitplane (320X240)
; byte from 9600 to 19199   -> raw planar image second bitplane (320X240)
; byte from 19200 to 28799  -> raw planar image third bitplane (320X240)
; byte from 28800 to 38399  -> raw planar image fouth bitplane (320X240)
; byte from 38400 to 47999  -> raw planar image fifth bitplane (320X240)
; byte from 48000 to 48063  -> color palette (32 colors)
; byte from 48064 to 124863 -> track metadata (raw indexed image 1 byte each pixel)

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
    dc.b "tracks/TRACK1.TRK"
    dcb.b 108+1,0
    even

LOAD_TRACK:
    movem.l d0-d7/a0-a6,-(sp)

    ;DEBUG 6666

    bsr.w	PreparaLoad	; Rispristina multitask e setta interrupt load

	moveq	#5,d1		; num. di frames da aspettare
	bsr.w	AspettaBlanks	; aspetta 5 frames

        move.w	#150,d1		; num. di frames da aspettare
	bsr.w	AspettaBlanks	; aspetta 150 frames
	bsr.w	DopoLoad	; Disabilita multitask e rimetti interrupt
    

    move.l  dosBase,a6
    move.l  #pathString,d1
    move.l  #ACCESS_READ,d2
    DEBUG 5555
    jsr     _LVOLock(a6)


    move.l  dosBase,a6
    move.l  #MODE_OLDFILE,d2
    move.l	#buffer,d1
    DEBUG 6666
    jsr     _LVOOpen(a6)
    tst.l	d0
    move.l	d0,fd

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

    ; close the file
	move.l	fd,d1				; result = LVOClose(handle[d1])      
    jsr     _LVOClose(a6) 

    move.l  dosBase,a6
    move.l  lock,d1
    jsr     _LVOUnLock(a6)

    DEBUG 9999



    DEBUG 6666

    move.w #$0010,$96(A5) ; enable DMA for floppy drive
    MOVE.L	#$7FFF7FFF,$9A(A5)	; DISABILITA GLI INTERRUPTS & INTREQS

    move.l				BaseVBR,a0
	move.l				#MioInt68KeyB,$68(A0)	; Routine for keyboard on int 2
    move.w 				#$C008,$dff09a ; intena, enable interrupt lvl 2

        movem.l (sp)+,d0-d7/a0-a6

    rts

	moveq	#5,d1		; num. di frames da aspettare
    bsr.w	AspettaBlanks	; aspetta 5 frames

    ;DEBUG 7777

    
    move.l  execBase,a6

    

    LEA	$DFF000,A5		; Base dei registri CUSTOM per Offsets
	MOVE.W	$2(A5),OLDDMAL		; Salva il vecchio status di DMACON
	MOVE.W	$1C(A5),OLDINTENAL	; Salva il vecchio status di INTENA
	MOVE.W	$1E(A5),OLDINTREQL	; Salva il vecchio status di INTREQ
 
    jsr	ClearMyCache


    lea	    $dff000,a5
	MOVE.L	#$7FFF7FFF,$9A(A5)	; INTERRUPTS & INTREQS DISABLE

	move.l	BaseVBR,a0	        ; Set VBR value into a0
    move.l	OldInt64,$64(a0) ; Sys int liv1 salvato (softint,dskblk)
    move.l	OldInt68,$68(a0)    ; Sys int liv2 (I/O,ciaa,int2)

        moveq	#50,d1		; num. di frames da aspettare
	bsr.w	AspettaBlanks	; aspetta 5 frames

    

    move.l	OldInt64,$64(a0) ; Sys int liv1 salvato (softint,dskblk)
	move.l	OldInt68,$68(a0) ; Sys int liv2 salvato (I/O,ciaa,int2)
	move.l	OldInt6c,$6c(a0) ; Sys int liv3 salvato (coper,vblanc,blit)

    

	move.l	OldInt70,$70(a0) ; Sys int liv4 salvato (audio)
	move.l	OldInt74,$74(a0) ; Sys int liv5 salvato (rbf,dsksync)
    
	move.l	OldInt78,$78(a0) ; Sys int liv6 salvato (exter,ciab,inten)

    

	MOVE.W	OLDADKCON,$9E(A5)	; ADKCON
	MOVE.W	OLDDMA,$96(A5)	; Rimetti il vecchio status DMA
    MOVE.W	OLDINTENA,$9A(A5)	; INTENA STATUS
	MOVE.W	OLDINTREQ,$9C(A5)	; INTREQ

    


    move.l	4.w,a6
	JSR	-$7e(A6)	; Enable
	JSR	-$8a(a6)	; Permit



    ; allocate memory for file info block
    ;move.l  #fib_SIZEOF,d0
    ;move.l  #MEMF_ANY,d1
    ;jsr     _LVOAllocVec(a6)
    ;move.l  d0,fib
    ;beq     .exit

    ; get directory lock
    ;move.l  dosBase,a6
    ;move.l  #pathString,d1
    ;move.l  #ACCESS_READ,d2
    ;jsr     _LVOLock(a6)
    ;move.l  d0,lock
    ;beq     .exit



    ; examine directory for ExNext
    ;move.l  lock,d1
    ;move.l #ALE,fib
    ;move.l  #ALE,d2
    ;jsr     _LVOExamine(a6)
    ;tst.w   d0
    ;beq     .exit

     ;   bra.w   .exit


    ; for each element inside the tracks directory
.loop:

    IFD LOL
    move.l  #ALE,a3

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
    ENDC

    DEBUG 1111
    move.l  dosBase,a6
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

    bra.w .exit  

; get next directory entry
.next:
    move.l  lock,d1
    move.l  #ALE,d2
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
    ;jsr     _LVOFreeVec(a6)
.l1
    move.l  dosBase,a1
    ;jsr     _LVOCloseLibrary(a6)

        MOVE.L	4.w,A6
    JSR	-$84(a6)	; Forbid
	JSR	-$78(A6)	; Disable

    jsr	ClearMyCache

    
    move.w #$0010,$96(A5) ; enable DMA for floppy drive
    MOVE.L	#$7FFF7FFF,$9A(A5)	; DISABILITA GLI INTERRUPTS & INTREQS

    move.l				BaseVBR,a0
	move.l				#MioInt68KeyB,$68(A0)	; Routine for keyboard on int 2
    move.w 				#$C008,$dff09a ; intena, enable interrupt lvl 2

    

    MOVE.W	OLDINTENAL,$9A(A5)	; INTENA STATUS
	MOVE.W	OLDINTREQL,$9C(A5)	; INTREQ




    move.w	#150,d1		; num. di frames da aspettare
	bsr.w	AspettaBlanks	; aspetta 150 frames
	;bsr.w	DopoLoad	; Disabilita multitask e rimetti interrupt

    movem.l (sp)+,d0-d7/a0-a6

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
	move.l	OldInt6c,$6c(a0) ; 
	move.l	OldInt70,$70(a0) ; Sys int liv4 salvato (audio)
	move.l	OldInt74,$74(a0) ; Sys int liv5 salvato (rbf,dsksync)
	move.l	OldInt78,$78(a0) ; Sys int liv6 salvato (exter,ciab,inten)

	MOVE.W	#%1000001001010000,$96(A5) ; Abilita blit e disk per sicurezza
	MOVE.W	OLDINTENA,$9A(A5)	; INTENA STATUS
	MOVE.W	OLDINTREQ,$9C(A5)	; INTREQ
	move.w	#$c010,$9a(a5)		; dobbiamo essere sicuri che COPER
					; (interrupt via copperlist) sia ON!

	move.l	4.w,a6
	;JSR	-$7e(A6)	; Enable
	;JSR	-$8a(a6)	; Permit
    ;rts

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
; Routine di interrupt da mettere durante il caricamento. Le routines che
; saranno messe in questo interrupt saranno eseguite anche durante il
; caricamento, sia che avvenga da floppy disk, da Hard Disk, o CD ROM.
; DA NOTARE CHE STIAMO USANDO L'INTERRUPT COPER, E NON QUELLO VBLANK,
; QUESTO PERCHE' DURANTE IL CARICAMENTO DA DISCO, SPECIALMENTE SOTTO KICK 1.3,
; L'INTERRUPT VERTB NON E' STABILE, tanto che la musica avrebbe dei sobbalzi.
; Invece, se mettiamo un "$9c,$8010" nella nostra copperlist, siamo sicuri
; che questa routine sara' eseguita una volta sola per fotogramma.
*****************************************************************************

myint6cLoad:
	btst.b	#4,$dff01f	; INTREQR - il bit 4, COPER, e' azzerato?
	beq.s	nointL		; Se si, non e' un "vero" int COPER!
	move.w	#%10000,$dff09c	; Se no, e' la volta buona, togliamo il req!
	movem.l	d0-d7/a0-a6,-(SP)
	;bsr.w	mt_music	; Suona la musica
	movem.l	(SP)+,d0-d7/a0-a6
nointL:
	dc.w	$4ef9		; val esadecimale di JMP
Crappyint:
	dc.l	0		; Indirizzo dove Jumpare, da AUTOMODIFICARE...
				; ATTENZIONE: il codice automodificante non
				; andrebbe usato. Comunque se si chiama un
				; ClearMyCache prima e dopo, funziona!










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

	;JSR	-$84(a6)	; Forbid
	;JSR	-$78(A6)	; Disable

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
	;move.l	#MioInt6c,$6c(a0)	; metto la mia rout. int. livello 3.
	MOVE.W	OLDDMAL,$96(A5)	; Rimetti il vecchio status DMA
	MOVE.W	OLDINTENAL,$9A(A5)	; INTENA STATUS
	MOVE.W	OLDINTREQL,$9C(A5)	; INTREQ
	rts

*****************************************************************************
*	ROUTINE IN INTERRUPT $6c (livello 3) - usato il VERTB e COPER.
*****************************************************************************

MioInt6c:
	btst.b	#5,$dff01f	; INTREQR - il bit 5, VERTB, e' azzerato?
	beq.s	NointVERTB		; Se si, non e' un "vero" int VERTB!
	movem.l	d0-d7/a0-a6,-(SP)	; salvo i registri nello stack
	;bsr.w	mt_music		; suono la musica
	;bsr.w	ColorCicla		; Cicla i colori della pic
	movem.l	(SP)+,d0-d7/a0-a6	; riprendo i reg. dallo stack
NointVERTB:
	move.w	#$70,$dff09c	; INTREQ - int eseguito, cancello la richiesta
				; dato che il 680x0 non la cancella da solo!!!
	rte			; Uscita dall'int VERTB