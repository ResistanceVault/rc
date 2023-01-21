
; Rally Cross - A top down racing game for OCS/ECS Amigas

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

MOVER_PREVIOUS_POSITION_OFFSET		EQU 48
MOVER_PREVIOUS_X_POSITION_OFFSET 	EQU 48
MOVER_PREVIOUS_Y_POSITION_OFFSET 	EQU 50

MOVER_BOUNCE_WALL_OFFSET			EQU 52

CAR_FRONT_WHEEL_TRACK_PIXEL_DATA_OFFSET	EQU 54
CAR_NEXT_ZONE_OFFSET				EQU 56
LAP_COUNTER_OFFSET					EQU 58
TIME_OFFSET							EQU 60
BEST_TIME_OFFSET					EQU 62

MOVER_IS_ON_GRASS					EQU 64
MOVER_IS_ON_ICE						EQU 66

INPUT_ROUTINE_OFFSET				EQU 68

CAR_SPRITES_LIST_OFFSET				EQU 72
CAR_SPRITES_LIST_OFFSET_0			EQU 72
CAR_SPRITES_LIST_OFFSET_1			EQU 76
CAR_SPRITES_LIST_OFFSET_2			EQU 80
CAR_SPRITES_LIST_OFFSET_3			EQU 84
CAR_SPRITES_LIST_OFFSET_4			EQU 88
CAR_SPRITES_LIST_OFFSET_5			EQU 92
CAR_SPRITES_LIST_OFFSET_6			EQU 96
CAR_SPRITES_LIST_OFFSET_7			EQU 100
CAR_SPRITES_LIST_OFFSET_8			EQU 104

CAR_SPRITE_POINTER_OFFSET			EQU 108

MOTOR_SAMPLE_OFFSET					EQU 112
AUDIO_CHANNEL_ADDRESS_OFFSET		EQU 116
AUDIO_CHANNEL_DMA_BIT				EQU 120

CAR_ID_OFFSET 						EQU 124

MOVER_SIZE					 		EQU 126

DECIMAL_MULTIPLIER					EQU 128
DECIMAL_SHIFT						EQU 7

SPRITES								EQU 1

MAX_LAPS							EQU 10
MAX_CARS							EQU 2

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

;MUL2DVECTOR1X2_Q10_6 MACRO
;    move.w   (a1),d0
;   move.w    2(a1),d1
;    muls.w    (a0),d0
;    muls.w    (a0),d1
;	asr.l     #6,d0
;	asr.l	  #6,d1
;   move.w    d0,(a1)
;    move.w    d1,2(a1)
;    ENDM

;	Include	"DaWorkBench.s"	; togliere il ; prima di salvare con "WO"

*****************************************************************************
	include	"startup2.s"	; con questo include mi risparmio di
				; riscriverla ogni volta!
*****************************************************************************

DMASET EQU %1000011111100000 ;Master,Copper,Blitter,Bitplanes;Sprites
WaitDisk	EQU	30

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
	include "AProcessing/libs/precalc/dec2txt.s"

PLAY_SOUND: 	dc.w 1
CARS_IN_PLAY: 	dc.w %0000000000000011
RACE_STATUS: 	dc.w 0

START:

	move.l				BaseVBR,a0
	move.l				#MioInt68KeyB,$68(A0)	; Routine for keyboard on int 2

	; Open welcome screen
	jsr 				welcomescreen

	; Print track image
TRACK_DATA_HEIGHT	EQU 240

	IFD COLOR

	move.l              #TRACK_DATA_1,d0
  	lea                 BPLPTR1,A1
  	bsr.w               POINTINCOPPERLIST_FUNCT

  	move.l              #TRACK_DATA_2,d0
  	lea                 BPLPTR2,A1
  	bsr.w               POINTINCOPPERLIST_FUNCT

  	move.l              #TRACK_DATA_3,d0
  	lea                 BPLPTR3,A1
  	bsr.w               POINTINCOPPERLIST_FUNCT

	move.l              #TRACK_DATA_4,d0
  	lea                 BPLPTR4,A1
  	bsr.w               POINTINCOPPERLIST_FUNCT

	move.l              #TRACK_DATA_5,d0
  	lea                 BPLPTR5,A1
  	bsr.w               POINTINCOPPERLIST_FUNCT

	; set track data colors
	lea 				TRACK_DATA_COLORS,a0
	move.w				(a0),COPCOLOR0+2
	move.w				2(a0),COPCOLOR1+2
	move.w				COLORS_FONTS_SMALL+2,COPHUDCOLOR1+2
	move.w				4(a0),COPCOLOR2+2
	move.w				COLORS_FONTS_SMALL+4,COPHUDCOLOR2+2
	move.w				6(a0),COPCOLOR3+2
	move.w				COLORS_FONTS_SMALL+6,COPHUDCOLOR3+2
	move.w				8(a0),COPCOLOR4+2
	move.w				COLORS_FONTS_SMALL+8,COPHUDCOLOR4+2
	move.w				10(a0),COPCOLOR5+2
	move.w				COLORS_FONTS_SMALL+10,COPHUDCOLOR5+2
	move.w				12(a0),COPCOLOR6+2
	move.w				COLORS_FONTS_SMALL+12,COPHUDCOLOR6+2
	move.w				14(a0),COPCOLOR7+2
	move.w				COLORS_FONTS_SMALL+14,COPHUDCOLOR7+2
	lea					$dff180,a1
	moveq				#32-1,d7
looptrackcolors:
	move.w				(a0)+,(a1)+
	dbra				d7,looptrackcolors

	ELSE

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

	ENDC

	; Cars init
	jsr 				CAR1_INIT
	jsr					CAR2_INIT

	move.w 	   			#DMASET,d1

	IFD SOUND
	tst.w 				PLAY_SOUND
	beq.w 				nosound1

	; for each car
	lea 				MOVERS,a0
	move.w 				#MAX_CARS-1,d7
carsaudioloop:
	move.l 				AUDIO_CHANNEL_ADDRESS_OFFSET(a0),a1
	move.l 				MOTOR_SAMPLE_OFFSET(a0),(a1)+
	move.w 				#8,(a1)+; size
	move.w 				#680,(a1)+
	move.w 				#64,(a1)+
	or.w 				AUDIO_CHANNEL_DMA_BIT(a0),d1
	adda.w  			#MOVER_SIZE,a0
	dbra 				d7,carsaudioloop
nosound1:
	ENDC

	MOVE.W				d1,$96(a5)		; DMACON - enable bitplane, copper, sprites and audio (optional).

	; copperlist setup
	move.l				#COPPERLIST,$80(a5)	; Copperlist point
	move.w				d0,$88(a5)			; Copperlist start
	move.w				#0,$1fc(a5)			; AGA disable
	move.w				#$c00,$106(a5)		; AGA disable
	move.w				#$11,$10c(a5)		; AGA disable

	move.w 				#$C008,$dff09a ; intena, enable interrupt lvl 2

	ENABLE_CLIPPING

	; Start of gameloop
mouse:
    cmpi.b  			#$ff,$dff006    ; Linea 255?
    bne.s   			mouse

	IFND COLOR
	jsr 				CLEARTOP
	WAITBLITTER

	STROKE 				#1
	move.w 				#0,d0
    move.w 				#0,d1
    jsr 				POINT

	move.w 				#WIDTH-1,d0
    move.w 				#0,d1
    jsr 				POINT

	move.w 				#WIDTH-1,d0
    move.w 				#HEIGHT-1,d1
    jsr 				POINT

	move.w 				#0,d0
    move.w 				#HEIGHT-1,d1
    jsr 				POINT
	ENDC

	; for each car
	lea 				MOVERS,a0
	move.w 				#MAX_CARS-1,d7
moversloop:

	; if the car is not in play skip
	btst.b 				d7,CARS_IN_PLAY+1
	beq.w   			next_car

	; this routine will read joystick movements and store result into d0 specifically for MANAGE_INPUT
	move.l  			INPUT_ROUTINE_OFFSET(a0),a1
	jsr					(a1)

	; Change the internal state of the mover object according to player input on data register d0
	bsr.w   			MANAGE_INPUT

	; Calculate friction
	bsr.w 				APPLY_FRICTION

	; Calculate acceleration
	bsr.w   			ACCELERATE

	; Calculate braking
	bsr.w   			BRAKE

	; Move the mover object (calculate next position)
	bsr.w				MOVE

	IFND DEBUG
	; Car behaviour must change according to the map metadata
	bsr.w   			CHECK_MAP
	ENDC

    ; check collisions
    ;bsr.w 	CHECK_COLLISIONS

	; show the mover object on the screen
	bsr.w				DISPLAY

	bsr.w   			UPDATE_TIMER

next_car:
	adda.l  			#MOVER_SIZE,a0
	dbra 				d7,moversloop

Aspetta:
    cmpi.b  			#$ff,$dff006    ; linea 255?
    beq.s   			Aspetta

	IFND COLOR
	lea                 BPLPTR2,a1
	move.l              SCREEN_PTR_0,d0
	POINTINCOPPERLIST

	lea                 BPLPTR4,a1
	move.l              SCREEN_PTR_1,d0
	POINTINCOPPERLIST

	SWAP_BPL
	ENDC

	tst.b 				KEY_ESC
	bne.s 				exit

	tst.w 				RACE_STATUS
	bne.s 				exit

	btst				#6,$bfe001	; mouse premuto?
	bne.w				mouse
exit:
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
	include "inputroutines/joystickinput.s"
	include "inputroutines/keyboard.s"
	include "inputroutines/keyboard_wasd.s"
	include "car_management.s"
	include "check_against_map.s"
	include "hud.s"
	include "welcomescreen.s"

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
	IFD SOUND
	SECTION SOUNDS,DATA_C
	MOTOR1_SND:
	dc.b	0,40,90,110,127,110,90,40,0,-40,-90,-110,-127,-110,-90,-40
	;incbin "assets/sounds/Squares.wav.asd"
	ENDC

	SECTION	SPRITES,DATA_C
	include "carsprites.i"

CURSOR:
	dc.b $3b,$40,$4b,$00
	incbin "assets/cars/car0_16x16.sprite"
	dc.w 0,0

	SECTION	MIOPLANE,DATA_C
	IFND DEBUG

	IFD COLOR
TRACK_DATA_1:
	incbin  "assets/tracks/track1/rc045_320X240X32.raw.aa"
DASHBOARD_DATA_1:
	dcb.b   40*16,0
TRACK_DATA_2:
	incbin  "assets/tracks/track1/rc045_320X240X32.raw.ab"
DASHBOARD_DATA_2:
	dcb.b   40*16,0
TRACK_DATA_3:
	incbin  "assets/tracks/track1/rc045_320X240X32.raw.ac"
DASHBOARD_DATA_3:
	dcb.b   40*16,0
TRACK_DATA_4:
	incbin  "assets/tracks/track1/rc045_320X240X32.raw.ad"
DASHBOARD_DATA_4:
	dcb.b   40*16,0
TRACK_DATA_5:
	incbin  "assets/tracks/track1/rc045_320X240X32.raw.ae"
DASHBOARD_DATA_5:
	dcb.b   40*16,0
	ELSE

TRACK_DATA:
TRACK_DATA_1:
	incbin  "assets/tracks/track1/rc045_320X240X8.raw.aa"
DASHBOARD_DATA_1:
	dcb.b   40*16,0
TRACK_DATA_2:
	incbin  "assets/tracks/track1/rc045_320X240X8.raw.ab"
DASHBOARD_DATA_2:
	dcb.b   40*16,0
TRACK_DATA_3:
	incbin  "assets/tracks/track1/rc045_320X240X8.raw.ac"
DASHBOARD_DATA_3:
	dcb.b   40*16,0
	ENDC

	ELSE
	TRACK_DATA:
TRACK_DATA_1:
DASHBOARD_DATA_1:
	dcb.b   40*256,0
TRACK_DATA_2:
DASHBOARD_DATA_2:
	dcb.b   40*256,0
TRACK_DATA_3:
DASHBOARD_DATA_3:
	dcb.b   40*256,0
	ENDC
TRACK_DATA_COLORS:
	IFD COLOR
	incbin "assets/tracks/track1/rc045_320X240X32.pal"
	ELSE
	incbin "assets/tracks/track1/rc045_320X240X8.pal"
	ENDC
TRACK_METADATA:
	incbin "assets/tracks/track1/rc045_320X240X8.data"
