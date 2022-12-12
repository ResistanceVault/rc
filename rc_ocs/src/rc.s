
; Lezione8n2.s - Plot point on a 2 bitplane playfield

	Section	rc,CODE

MOVER_POSITION_OFFSET				EQU 0
MOVER_X_POSITION_OFFSET 			EQU 0
MOVER_Y_POSITION_OFFSET 			EQU 2

MOVER_VELOCITY_OFFSET 				EQU 4
MOVER_X_VELOCITY_OFFSET 			EQU 4
MOVER_Y_VELOCITY_OFFSET 			EQU 6

MOVER_ACCELERATION_OFFSET 			EQU 8
MOVER_X_ACCELERATION_OFFSET 		EQU 8
MOVER_Y_ACCELERATION_OFFSET 		EQU 10

MOVER_WHEEL_BASE_OFFSET				EQU 12
MOVER_STEERING_ANGLE_OFFSET			EQU 14
MOVER_HEADING_OFFSET				EQU 16
MOVER_STEER_DIRECTION_OFFSET		EQU 20
MOVER_FORWARD_VECTOR_OFFSET			EQU 22
MOVER_ENGINE_POWER_OFFSET			EQU 26
MOVER_MAX_SPEED_OFFSET				EQU 28

MOVER_IS_ACCELERATING_OFFSET		EQU 30
MOVER_IS_BRAKING_OFFSET				EQU 32
MOVER_IS_COLLIDING_OFFSET			EQU 34

MOVER_BRAKE_COEFFICIENT_OFFSET  	EQU 36
MOVER_FRICTION_COEFFICIENT_OFFSET  	EQU 38

MOVER_BACK_WHEEL_VECTOR_OFFSET		EQU 40
MOVER_BACK_WHEEL_X_VECTOR_OFFSET	EQU 40
MOVER_BACK_WHEEL_Y_VECTOR_OFFSET	EQU 42

MOVER_FRONT_WHEEL_VECTOR_OFFSET		EQU 44
MOVER_FRONT_WHEEL_X_VECTOR_OFFSET	EQU 44
MOVER_FRONT_WHEEL_Y_VECTOR_OFFSET	EQU 46

MOVER_SIZE					 		EQU 48

DECIMAL_MULTIPLIER					EQU 128
DECIMAL_SHIFT						EQU 7

	include "macros.i"

MOVER_INIT_MEM MACRO
	MOVER\1:
	dcb.b MOVER_SIZE,0
	even
	ENDM

  ; Place addr in d0 and the copperlist pointer addr in a1 before calling
POINTINCOPPERLIST MACRO
  move.w              d0,6(a1)
  swap                d0
  move.w              d0,2(a1)
  ENDM

SWAP_BPL MACRO
    neg.l SCREEN_OFFSET
    move.l SCREEN_OFFSET,d1
    move.l SCREEN_PTR_0,SCREEN_PTR_OTHER_0
    move.l SCREEN_PTR_1,SCREEN_PTR_OTHER_1
    add.l d1,SCREEN_PTR_0
    add.l d1,SCREEN_PTR_1
    ENDM

MUL2DVECTOR1X2_Q10_6 MACRO
    move.w   (a1),d0
    move.w    2(a1),d1
    muls.w    (a0),d0
    muls.w    (a0),d1
	asr.l     #6,d0
	asr.l	  #6,d1
    move.w    d0,(a1)
    move.w    d1,2(a1)
    ENDM

;	Include	"DaWorkBench.s"	; togliere il ; prima di salvare con "WO"

*****************************************************************************
	include	"startup1.s"	; con questo include mi risparmio di
				; riscriverla ogni volta!
*****************************************************************************

DMASET EQU %1000011111100000 ;Master,Copper,Blitter,Bitplanes;Sprites

	include "AProcessing/libs/vectors/sqrt_q4_12_lookup_table.i"
	include "AProcessing/libs/rasterizers/globaloptions.s"
	include "AProcessing/libs/trigtables.i"
	include "AProcessing/libs/rasterizers/processing_table_plotrefs.s"
	include "AProcessing/libs/rasterizers/processingfill.s"
	include "AProcessing/libs/rasterizers/clipping.s"
	include "AProcessing/libs/rasterizers/line.s"
	include "AProcessing/libs/rasterizers/processingclearfunctions.s"
	include "AProcessing/libs/matrix/matrixcommon.s"
	include "AProcessing/libs/matrix/matrix.s"
	include "AProcessing/libs/matrix/matrixreg.s"
	include "AProcessing/libs/matrix/scalereg.s"
	include "AProcessing/libs/matrix/rotatereg.s"
	include "AProcessing/libs/matrix/point.s"
	include "AProcessing/libs/rasterizers/point.s"
	include "AProcessing/libs/rasterizers/square.s"
	include "AProcessing/libs/ammxmacros.i"
	include "AProcessing/libs/vectors/operations.s"
	include "AProcessing/libs/vectors/trigtables.i"
	include "AProcessing/libs/precalc/map.s"

START:
	; Print track image

TRACK_DATA_HEIGHT	EQU 240

	move.l              #TRACK_DATA_1,d0
  	lea                 BPLPTR1,A1
  	bsr.w               POINTINCOPPERLIST_FUNCT

  	move.l              #TRACK_DATA_2,d0
  	lea                 BPLPTR3,A1
  	bsr.w               POINTINCOPPERLIST_FUNCT

  	move.l              #TRACK_DATA_3,d0
  	lea                 BPLPTR5,A1
  	bsr.w               POINTINCOPPERLIST_FUNCT

	; set track data colors
	lea 				TRACK_DATA_COLORS,a0
	lea					$dff180,a1
	moveq				#8-1,d7
looptrackcolors:
	move.w				(a0)+,(a1)+
	dbra				d7,looptrackcolors

	; Car sprite
	;move.l    			#CAR_180,d0
  	;lea       			Sprite0pointers,a1
  	;jsr       			POINTINCOPPERLIST_FUNCT

	;move.l    #CAR_180_1,d0
  	;lea       Sprite1pointers,a1
  	;jsr       POINTINCOPPERLIST_FUNCT


	; Puntiamo la cop...

	MOVE.W	#DMASET,$96(a5)		; DMACON - abilita bitplane, copper
					; e sprites.

	move.l	#COPPERLIST,$80(a5)	; Puntiamo la nostra COP
	move.w	d0,$88(a5)		; Facciamo partire la COP
	move.w	#0,$1fc(a5)		; Disattiva l'AGA
	move.w	#$c00,$106(a5)		; Disattiva l'AGA
	move.w	#$11,$10c(a5)		; Disattiva l'AGA

	ENABLE_CLIPPING

	; Car initialization
	jsr		CAR1_INIT

	; Start of gameloop
mouse:
    cmpi.b  #$ff,$dff006    ; Linea 255?
    bne.s   mouse

	jsr CLEARTOP

	WAITBLITTER

	STROKE #1
	move.w #0,d0
    move.w #0,d1
    jsr POINT

	move.w #WIDTH-1,d0
    move.w #0,d1
    jsr POINT

	move.w #WIDTH-1,d0
    move.w #HEIGHT-1,d1
    jsr POINT

	move.w #0,d0
    move.w #HEIGHT-1,d1
    jsr POINT

	; for each car
	lea MOVERS,a0
	move.w 	#1-1,d7
moversloop:

	 ; this routine will read joystick movements and store result into d0 specifically for MANAGE_INPUT
	bsr.w	LeggiJoyst
	;move.w  #%0100,d0

	; Change the internal state of the mover object according to player input on data register d0
	bsr.w   MANAGE_INPUT

	; Calculate friction
	bsr.w 	APPLY_FRICTION

	; Calculate acceleration
	bsr.w   ACCELERATE

	; Calculate braking
	bsr.w   BRAKE

	; Move the mover object (calculate next position)
	bsr.w	MOVE

	; Car behaviour must change according to the map metadata
	bsr.w   CHECK_MAP

    ; check collisions
    ;bsr.w 	CHECK_COLLISIONS

	; show the mover object on the screen
	bsr.w	DISPLAY

	adda.w  #MOVER_SIZE,a0
	dbra 	d7,moversloop

Aspetta:
    cmpi.b  #$ff,$dff006    ; linea 255?
    beq.s   Aspetta

	lea                 BPLPTR2,a1
	move.l              SCREEN_PTR_0,d0
	POINTINCOPPERLIST

	lea                 BPLPTR4,a1
	move.l              SCREEN_PTR_1,d0
	POINTINCOPPERLIST

	SWAP_BPL

	btst	#6,$bfe001	; mouse premuto?
	bne.w	mouse
	rts			; esci

	IFD DEBUG
    include "debug.s"
    ENDC
	include "car_inits.s"
	include "calculate_wheel_positions.s"
	include "display.s"
	include "accelerate.s"
	include "brake.s"
	include "friction.s"
	include "manage_input.s"
	include "move.s"
	include "check_collisions.s"
	include "joystickinput.s"
	include "car_management.s"
	include "check_against_map.s"

MOVERS:
	MOVER_INIT_MEM 1
MOVERS2:
	MOVER_INIT_MEM 2
MOVERS3:
	MOVER_INIT_MEM 3


CLEARTOP:
            WAITBLITTER
            move.w           #$0100,$dff040
            move.w           #$0000,$dff042
            move.l           SCREEN_PTR_0,$dff054 ; copy to d channel
            move.w           #0,$DFF066           ; D mod
            move.w           #$4014,$dff058


            WAITBLITTER
            move.l          SCREEN_PTR_1,$dff054 ; copy to d channel
            move.w          #$4014,$dff058

            rts

POINTINCOPPERLIST_FUNCT:
  	POINTINCOPPERLIST
  	rts

	include "AProcessing/libs/rasterizers/processing_bitplanes_fast.s"

	include "copperlist.s"
	SECTION	SPRITES,DATA_C
CAR_DATA:
CAR_0:
	dc.b $50,$90,$60,$00
	incbin "assets/cars/car0_16x16.sprite"
	dc.w 0,0

CAR_45:
	dc.b $50,$90,$60,$00
	incbin "assets/cars/car45_16x16.sprite"
	dc.w 0,0

CAR_90:
	dc.b $50,$90,$60,$00
	incbin "assets/cars/car90_16x16.sprite"
	dc.w 0,0

CAR_135:
	dc.b $50,$90,$60,$00
	;incbin "assets/cars/car135_16x16.sprite"
		dc.w $0000,$0000 ; line 1
		dc.w $0000,$0000 ; line 2
		dc.w $0000,$0000 ; line 3
		dc.w $0000,$0000 ; line 4
		dc.w $0200,$0000 ; line 5
		dc.w $0680,$0300 ; line 6
		dc.w $0F80,$07C0 ; line 7
		dc.w $02E0,$07C0 ; line 8
		dc.w $07F0,$0360 ; line 9
		dc.w $01E0,$03C0 ; line 10
		dc.w $01C0,$0080 ; line 11
		dc.w $0080,$0000 ; line 12
		dc.w $0000,$0000 ; line 13
		dc.w $0000,$0000 ; line 14
		dc.w $0000,$0000 ; line 15
		dc.w $0000,$0000 ; line 16
		dc.w 0,0

CAR_180:
	dc.b $50,$90,$60,$00
	incbin "assets/cars/car180_16x16.sprite"
	dc.w 0,0

CAR_215:
	dc.b $50,$90,$60,$00
	;incbin "assets/cars/car215_16x16.sprite"
		dc.w $0000,$0000 ; line 1
		dc.w $0000,$0000 ; line 2
		dc.w $0000,$0000 ; line 3
		dc.w $0000,$0000 ; line 4
		dc.w $0080,$0000 ; line 5
		dc.w $01C0,$0080 ; line 6
		dc.w $01E0,$03C0 ; line 7
		dc.w $07F0,$0360 ; line 8
		dc.w $02E0,$07C0 ; line 9
		dc.w $0F80,$07C0 ; line 10
		dc.w $0680,$0300 ; line 11
		dc.w $0200,$0000 ; line 12
		dc.w $0000,$0000 ; line 13
		dc.w $0000,$0000 ; line 14
		dc.w $0000,$0000 ; line 15
		dc.w $0000,$0000 ; line 16
		dc.w 0,0

CAR_270:
	dc.b $50,$90,$60,$00
	;incbin "assets/cars/car270_16x16.sprite"
		dc.w $0000,$0000 ; line 1
		dc.w $0000,$0000 ; line 2
		dc.w $0000,$0000 ; line 3
		dc.w $0000,$0000 ; line 4
		dc.w $07E0,$0000 ; line 5
		dc.w $0180,$0000 ; line 6
		dc.w $07E0,$03C0 ; line 7
		dc.w $03C0,$0660 ; line 8
		dc.w $03C0,$03C0 ; line 9
		dc.w $07E0,$03C0 ; line 10
		dc.w $0080,$0520 ; line 11
		dc.w $03C0,$0000 ; line 12
		dc.w $0000,$0000 ; line 13
		dc.w $0000,$0000 ; line 14
		dc.w $0000,$0000 ; line 15
		dc.w $0000,$0000 ; line 16
		dc.w 0,0

CAR_315:
	dc.b $50,$90,$60,$00
	;incbin "assets/cars/car135_16x16.sprite"
		dc.w $0000,$0000 ; line 1
	dc.w $0000,$0000 ; line 2
	dc.w $0000,$0000 ; line 3
	dc.w $0000,$0000 ; line 4
	dc.w $0100,$0000 ; line 5
	dc.w $0380,$0100 ; line 6
	dc.w $0780,$03C0 ; line 7
	dc.w $0FE0,$06C0 ; line 8
	dc.w $0740,$03E0 ; line 9
	dc.w $01F0,$03E0 ; line 10
	dc.w $0160,$00C0 ; line 11
	dc.w $0040,$0000 ; line 12
	dc.w $0000,$0000 ; line 13
	dc.w $0000,$0000 ; line 14
	dc.w $0000,$0000 ; line 15
	dc.w $0000,$0000 ; line 16
	dc.w 0,0

	SECTION	MIOPLANE,DATA_C
	IFND DEBUG

TRACK_DATA:
TRACK_DATA_1:
	incbin  "assets/images/raw/rc045_320X240X8.raw.aa"
	dcb.b   40*16,0
TRACK_DATA_2:
	incbin  "assets/images/raw/rc045_320X240X8.raw.ab"
	dcb.b   40*16,0
TRACK_DATA_3:
	incbin  "assets/images/raw/rc045_320X240X8.raw.ac"
	dcb.b   40*16,0

	ELSE
	TRACK_DATA:
TRACK_DATA_1:
	dcb.b   40*256,0
TRACK_DATA_2:
	dcb.b   40*256,0
TRACK_DATA_3:

	dcb.b   40*256,0
	ENDC
TRACK_DATA_COLORS:
	incbin  "assets/images/raw/rc045_320X240X8.pal"
TRACK_METADATA:
	incbin "assets/tracks/track1/rc045_320X240X8.data"
