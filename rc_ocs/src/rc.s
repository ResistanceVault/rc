; Racing cars - A top down racing game for OCS/ECS Amigas

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
CAR_SPRITES_LIST_OFFSET_9			EQU 108
CAR_SPRITES_LIST_OFFSET_10			EQU 112
CAR_SPRITES_LIST_OFFSET_11			EQU 116
CAR_SPRITES_LIST_OFFSET_12			EQU 120
CAR_SPRITES_LIST_OFFSET_13			EQU 124
CAR_SPRITES_LIST_OFFSET_14			EQU 128
CAR_SPRITES_LIST_OFFSET_15			EQU 132
CAR_SPRITES_LIST_OFFSET_16			EQU 136
CAR_SPRITES_LIST_OFFSET_17			EQU 140
CAR_SPRITES_LIST_OFFSET_18			EQU 144
CAR_SPRITES_LIST_OFFSET_19			EQU 148
CAR_SPRITES_LIST_OFFSET_20			EQU 152
CAR_SPRITES_LIST_OFFSET_21			EQU 156
CAR_SPRITES_LIST_OFFSET_22			EQU 160
CAR_SPRITES_LIST_OFFSET_23			EQU 164
CAR_SPRITES_LIST_OFFSET_24			EQU 168

CAR_SPRITE_POINTER_OFFSET			EQU 172

MOTOR_SAMPLE_OFFSET					EQU 176
AUDIO_CHANNEL_ADDRESS_OFFSET		EQU 180
AUDIO_CHANNEL_DMA_BIT				EQU 184

CAR_ID_OFFSET 						EQU 188
RACE_COMPLETED_OFFSET				EQU 190

MOVER_TANGENT_FORWARD_VECTOR_OFFSET EQU 192
MOVER_FRONT_RIGHT_CORNER_OFFSET 	EQU 196
MOVER_BACK_RIGHT_CORNER_OFFSET 		EQU 200
MOVER_FRONT_LEFT_CORNER_OFFSET 		EQU 204
MOVER_BACK_LEFT_CORNER_OFFSET 		EQU 208

MOVER_HALF_WIDTH_DISTANCE_OFFSET	EQU 212

MOVER_RIGHT_SIDE_OFFSET				EQU 214
MOVER_LEFT_SIDE_OFFSET				EQU 218
MOVER_WHEEL_BASE_DIV_2_OFFSET		EQU 222
MOVER_WIDTH_DIV_2_OFFSET			EQU 224

MOVER_PLAYER_NAME_ADDR				EQU 226
MOVER_PLAYER_TEAM_ADDR				EQU 230

TIME_OFFSET_STR						EQU 234

HUD_POSITION_X						EQU 238
HUD_POSITION_Y						EQU	240

MOVER_POINTS						EQU 242

MOVER_HOTSPOT_CPU_PTR				EQU 244

MOVER_HEADING_MAGNITUDE				EQU 248
MOVER_CPU_CONSECUTIVE_COLLISIONS	EQU 250

MOVER_SIZE					 		EQU 252

DECIMAL_MULTIPLIER					EQU 128
DECIMAL_SHIFT						EQU 7

SPRITES								EQU 1

MAX_LAPS							EQU 9
MAX_CARS							EQU 8

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

DISABLE_AUDIO_DMA MACRO
    move.w              #$000F,$dff096
	ENDM

	;include	"daworkbench.s"	; togliere il ; prima di salvare con "WO"

*****************************************************************************
	include	"startup2.s"	; con questo include mi risparmio di
				; riscriverla ogni volta!
*****************************************************************************

DMASET EQU %1000011111100000 ;Master,Copper,Blitter,Bitplanes;Sprites
WaitDisk	EQU	30

	include "AProcessing/libs/precalc/half_word.s"
	include "AProcessing/libs/precalc/bubble_sort_4_bytes.s"
	include "AProcessing/libs/vectors/sqrt_q4_12_lookup_table.i"
	include "AProcessing/libs/rasterizers/globaloptions.s"
	include "AProcessing/libs/trigtables.i"
	IFND COLOR
	include "AProcessing/libs/rasterizers/processing_table_plotrefs.s"
	include "AProcessing/libs/rasterizers/processingfill.s"
	include "AProcessing/libs/rasterizers/clipping.s"
	include "AProcessing/libs/rasterizers/line.s"
	include "AProcessing/libs/rasterizers/processingclearfunctions.s"
	include "AProcessing/libs/matrix/matrixcommon.s"
	include "AProcessing/libs/matrix/matrix.s"
	include "AProcessing/libs/matrix/point.s"
	include "AProcessing/libs/rasterizers/point.s"
	ENDC
	include "AProcessing/libs/ammxmacros.i"
	include "AProcessing/libs/vectors/operations.s"
	include "AProcessing/libs/vectors/trigtables.i"
	include "AProcessing/libs/precalc/dec2txt.s"
	include "AProcessing/libs/math/operations.s"
	include "AProcessing/libs/packers/ShrinklerDecompress.S"

PLAY_SOUND: 	dc.w 1
CARS_IN_PLAY: 	dc.w %0000000000001111
ARRIVAL_ORDER:	dcb.b MAX_CARS*4,$00
ARRIVAL_ORDER_PTR: dc.l ARRIVAL_ORDER

	IFD COLOR
NEXT_SCREEN: dc.l MAINSCREEN
	ENDIF

JOY2_FIRE0_BIT    equ    2
CIAA EQU $bfe001
CIAB EQU $bff000
ciapra EQU $0000
ciaprb equ $0100
START:
	IFD INTRO
	jsr INTROSCREEN
	ENDC
	; clear introscreen
	move.w #40*256*3/4-1,d7
	lea PHAZELOGO,a0
clearintroscreen:
	clr.l (a0)+
	dbra d7,clearintroscreen

	jsr SETPOT

	move.l				BaseVBR,a0
	move.l				#MioInt68KeyB,$68(A0)	; Routine for keyboard on int 2

	; Cars init
	jsr 				CAR1_INIT
	jsr					CAR2_INIT
	jsr					CAR3_INIT
	jsr					CAR4_INIT
	jsr					CAR5_INIT
	jsr					CAR6_INIT
	jsr					CAR7_INIT
	jsr					CAR8_INIT

	; Open main screen
	IFD COLOR
print_screen:
	move.l				NEXT_SCREEN,a0
	jsr 				(a0)
	tst.w               EXIT_TO_OS_FLAG
    bne.w               exit
	tst.l				NEXT_SCREEN
	bne.s				print_screen
	ENDC
	; Open welcome screen
welcomescreen_start:
	IFD COLOR
	; Reset race with banner
	clr.b				KEY_ESC
	jsr					RESET_RACE
print_start_race_screen:
	jsr					START_RACE_SCREEN

	; go back to mainscreen if back has been selected
	cmp.l				#MAINSCREEN,NEXT_SCREEN
	beq.s				print_screen

	cmp.l				#SELECT_TRACK_SCREEN,NEXT_SCREEN
	bne.s				load_track_from_disk
.load_select_track_screen:
	jsr					SELECT_TRACK_SCREEN
	cmp.l				#MENU_START_RACE_SCREEN,NEXT_SCREEN
	beq.s				print_start_race_screen
	cmp.l				#SELECT_TRACK_SCREEN,NEXT_SCREEN
	beq.s				.load_select_track_screen

	; load track data from disk
load_track_from_disk:
	move.w              #1,TRACK_OPEN_FILE
    jsr                 LOAD_TRACK

	 ; Cars init
    jsr 	SET_CAR1_START_STATUS
    jsr 	SET_CAR2_START_STATUS
    jsr 	SET_CAR3_START_STATUS
    jsr 	SET_CAR4_START_STATUS
    jsr 	SET_CAR5_START_STATUS
    jsr 	SET_CAR6_START_STATUS
    jsr 	SET_CAR7_START_STATUS
    jsr 	SET_CAR8_START_STATUS

	ELSE
	jsr 				welcomescreen
	tst.w               EXIT_TO_OS_FLAG
    bne.w               exit
	ENDC

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

	move.w 	   			#DMASET,d1

	IFD SOUND
	tst.w 				PLAY_SOUND
	beq.w 				nosound1

	; for each car
	lea 				MOVERS,a0
	move.w 				#MAX_CARS-1,d7
carsaudioloop:
	btst.b 				d7,CARS_IN_PLAY+1
	beq.s 				carsaudionextloop
	move.l 				AUDIO_CHANNEL_ADDRESS_OFFSET(a0),a1
	move.l 				MOTOR_SAMPLE_OFFSET(a0),(a1)+
	move.w 				#8,(a1)+; size
	move.w 				#680,(a1)+
	move.w 				#64,(a1)+
	or.w 				AUDIO_CHANNEL_DMA_BIT(a0),d1
carsaudionextloop:
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

	IFND COLOR
	ENABLE_CLIPPING
	ELSE
	lea 				TRACK_DATA_COLORS,a0
	lea					$dff180,a1
	moveq				#32-1,d7
looptrackcolors2:
	move.w				(a0)+,(a1)+
	dbra				d7,looptrackcolors2
	; force black background
	move.w              #0,COPCOLOR0+2
	ENDC

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

	; if i have to display the go banner

	cmp.w 				#RACE_WAIT_GO,RACE_PROGRESS
	beq.w				DISPLAY_GO_BANNER
end_display_go_banner:

	;if space is pressed pause the game
	tst.w				KEY_SPACE
	beq.s				nouserpause
	move.w              #1,RACE_PAUSE
nouserpause:

	; if the game is on PAUSE manage it
	IFD COLOR
	tst.w				RACE_PAUSE
	bne.w				MANAGE_PAUSE
	ENDC
	;	move.w				#$f00,$dff180

before_moversloop:
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

	; disable input IF the car has completed the race
	and.w				RACE_COMPLETED_OFFSET(a0),d0

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

	; check collisions with other cars
	lea					MOVERS,a1
	move.w 				#MAX_CARS-1,d6
check_collisions_with_other_cars_loop:
	; skip check collisions with itself
	cmp.l 				a0,a1
	beq.s 				skip_check_collisions_with_other_cars

	; skip check collisions with cars not in play
	btst.b 				d6,CARS_IN_PLAY+1
	beq.s   			skip_check_collisions_with_other_cars

	; skip check collisions with cars which have completed the race
	tst.w				RACE_COMPLETED_OFFSET(a1)
	beq.w				skip_check_collisions_with_other_cars

	bsr.w 				CHECK_COLLISIONS_WITH_OTHER_CAR
skip_check_collisions_with_other_cars:
	adda.l  			#MOVER_SIZE,a1
	dbra 				d6,check_collisions_with_other_cars_loop

	; show the mover object on the screen
	bsr.w				DISPLAY

	;move.w				#$00f0,$dff180

	tst.w				RACE_COMPLETED_OFFSET(a0)
	beq.s				donotupdatetimer
	bsr.w   			UPDATE_TIMER
donotupdatetimer:

;	move.w				#$f00,$dff180

next_car:
	adda.l  			#MOVER_SIZE,a0
	dbra 				d7,moversloop
Aspetta:
	;move.w				#$000,$dff180
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

	; go to option screen if esc is pressed
	tst.b 				KEY_ESC
	bne.w 				welcomescreen_start

	bra.w 				mouse
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
	include "check_collisions_with_other_cars.s"
	include "check_collisions.s"
	include "inputroutines/inputroutines.i"
	include "inputroutines/mouseinput.s"
	include "inputroutines/joystickinput.s"
	include "inputroutines/joystickinput_welcome.s"
	include "inputroutines/joysetpot.s"
	include "inputroutines/keyboard.s"
	include "inputroutines/keyboard_wasd.s"
	include "inputroutines/keyboard_wasd_welcome.s"
	include "inputroutines/keyboard_ijkl.s"
	include "inputroutines/keyboard_arrows.s"
	include "inputroutines/joystick2.s"
	include "inputroutines/joystick3.s"
	include "inputroutines/cpucontrol.s"
	include "car_management.s"
	include "check_against_map.s"
	include "hud.s"
	include "screens/welcomescreen.s"
	include "banner_manager.s"
	include "race_manager.s"
	include "track_info_manager.s"
	IFND COLOE
	include "screens/race_results.s"
	ENDC
	IFD INTRO
	include "screens/introscreen.s"
	ENDC
	IFD COLOR
	include "menu.s"
	include "screens/mainscreen.s"
	include "screens/cars_setup_screen.s"
	include "screens/resultscreen.s"
	include "screens/standingsscreen.s"
	include "load_track_shr.s"
	;include "screens/trackselectscreen.s"
	include "screens/track_selection_screen.s"
	include "screens/startrace.s"
	include "screens/optionsscreen.s"
	ENDC

MOVERS:
	MOVER_INIT_MEM 1
MOVERS2:
	MOVER_INIT_MEM 2
MOVERS3:
	MOVER_INIT_MEM 3
MOVERS4:
	MOVER_INIT_MEM 4
MOVERS5:
	MOVER_INIT_MEM 5
MOVERS6:
	MOVER_INIT_MEM 6
MOVERS7:
	MOVER_INIT_MEM 7
MOVERS8:
	MOVER_INIT_MEM 8

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

	SECTION FONTS,DATA_C
	include "fonts.i"

	SECTION	SPRITES,DATA_C
	include "carsprites.i"

CURSOR:
	dc.b $3b,$40,$4b,$00
	incbin "assets/cars_small/car_0.raw"
	dc.w 0,0

	SECTION	MIOPLANE,DATA_C

TRACK_DATA_COLORS:
	IFD COLOR
	dcb.b 64,0
	ELSE
	incbin "assets/tracks/track1/rc045_320X240X8.pal"
	ENDC

	IFND DEBUG

	IFD COLOR
TRACK_DATA_1:
	;incbin  "assets/tracks/track1/rc045_320X240X32.raw.aa"
	dcb.b   40*240,0
DASHBOARD_DATA_1:
	dcb.b   40*16,0
TRACK_DATA_2:
	;incbin  "assets/tracks/track1/rc045_320X240X32.raw.ab"
	dcb.b   40*240,0
DASHBOARD_DATA_2:
	dcb.b   40*16,0
TRACK_DATA_3:
	;incbin  "assets/tracks/track1/rc045_320X240X32.raw.ac"
	dcb.b   40*240,0
DASHBOARD_DATA_3:
	dcb.b   40*16,0
TRACK_DATA_4:
	;incbin  "assets/tracks/track1/rc045_320X240X32.raw.ad"
	dcb.b   40*240,0
DASHBOARD_DATA_4:
	dcb.b   40*16,0
TRACK_DATA_5:
	;incbin  "assets/tracks/track1/rc045_320X240X32.raw.ae"
	dcb.b   40*240,0
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
START_RACE_BANNER_ACC_1:
	incbin "assets/banners/acctostart.raw.0"
START_RACE_BANNER_ACC_2:
	incbin "assets/banners/acctostart.raw.1"
START_RACE_BANNER_ACC_3:
	incbin "assets/banners/acctostart.raw.2"
START_RACE_BANNER_3_1:
	incbin "assets/banners/3.raw.0"
START_RACE_BANNER_3_2:
	incbin "assets/banners/3.raw.1"
START_RACE_BANNER_3_3:
	incbin "assets/banners/3.raw.2"
START_RACE_BANNER_2_1:
	incbin "assets/banners/2.raw.0"
START_RACE_BANNER_2_2:
	incbin "assets/banners/2.raw.1"
START_RACE_BANNER_2_3:
	incbin "assets/banners/2.raw.2"
START_RACE_BANNER_1_1:
	incbin "assets/banners/1.raw.0"
START_RACE_BANNER_1_2:
	incbin "assets/banners/1.raw.1"
START_RACE_BANNER_1_3:
	incbin "assets/banners/1.raw.2"
START_RACE_BANNER_GO_1:
	incbin "assets/banners/go.raw.0"
START_RACE_BANNER_GO_2:
	incbin "assets/banners/go.raw.1"
START_RACE_BANNER_GO_3:
	incbin "assets/banners/go.raw.2"

	IFD INTRO
PHAZELOGO_PALETTE:
	incbin "assets/phazelogo/phazelogo.plt"
	ENDC
MY_FIB:
    ds.b    fib_SIZEOF

	IFD INTRO
PHAZELOGO:
	incbin "assets/phazelogo/phazelogo.raw"
	ELSE
PHAZELOGO:
	dcb.b 10240,0
	dcb.b 10240,0
	dcb.b 10240,0
	ENDC
PHAZELOGO_4:
	dcb.b 10240,0
PHAZELOGO_5:
	dcb.b 10240,0

MAIN_PALETTE:
MAIN_PALETTE_0:     dc.w 0    ; color 0
MAIN_PALETTE_1:     dc.w 0    ; color 1
MAIN_PALETTE_2:     dc.w 0    ; color 2
MAIN_PALETTE_3:     dc.w 0    ; color 3
MAIN_PALETTE_4:     dc.w 0    ; color 4
MAIN_PALETTE_5:     dc.w 0    ; color 5
MAIN_PALETTE_6:     dc.w 0    ; color 6
MAIN_PALETTE_7:     dc.w 0    ; color 7
MAIN_PALETTE_8:     dc.w 0    ; color 8
MAIN_PALETTE_9:     dc.w 0    ; color 9
MAIN_PALETTE_10:    dc.w 0    ; color 10
MAIN_PALETTE_11:    dc.w 0    ; color 11
MAIN_PALETTE_12:    dc.w 0    ; color 12
MAIN_PALETTE_13:    dc.w 0    ; color 13
MAIN_PALETTE_14:    dc.w 0    ; color 14
MAIN_PALETTE_15:    dc.w 0    ; color 15
MAIN_PALETTE_16:    dc.w 0    ; color 16
MAIN_PALETTE_17:    dc.w 0    ; color 17
MAIN_PALETTE_18:    dc.w 0    ; color 18
MAIN_PALETTE_19:    dc.w 0    ; color 19
MAIN_PALETTE_20:    dc.w 0    ; color 20
MAIN_PALETTE_21:    dc.w 0    ; color 21
MAIN_PALETTE_22:    dc.w 0    ; color 22
MAIN_PALETTE_23:    dc.w 0    ; color 23
MAIN_PALETTE_24:    dc.w 0    ; color 24
MAIN_PALETTE_25:    dc.w 0    ; color 25
MAIN_PALETTE_26:    dc.w 0    ; color 26
MAIN_PALETTE_27:    dc.w 0    ; color 27
MAIN_PALETTE_28:    dc.w 0    ; color 28
MAIN_PALETTE_29:    dc.w 0    ; color 29
MAIN_PALETTE_30:    dc.w 0    ; color 30
MAIN_PALETTE_31:    dc.w 0    ; color 31

TRACK_METADATA:
	dcb.b 76800,0

TRACK_PADDING:
	dcb.b 48,0

CPU_POINTS_UNCOMPRESSED:
MOVER_DESTINATION:
MOVER_DESTINATION_X:
	dcb.b 2,0
MOVER_DESTINATION_Y:
	dcb.b 998,0 ; we support up to 249 points + 1 (terminator)
TRACK_PADDING_END:

MAIN_PALETTE2:
MAIN_PALETTE2_0:     dc.w 0    ; color 0
MAIN_PALETTE2_1:     dc.w 0    ; color 1
MAIN_PALETTE2_2:     dc.w 0    ; color 2
MAIN_PALETTE2_3:     dc.w 0    ; color 3
MAIN_PALETTE2_4:     dc.w 0    ; color 4
MAIN_PALETTE2_5:     dc.w 0    ; color 5
MAIN_PALETTE2_6:     dc.w 0    ; color 6
MAIN_PALETTE2_7:     dc.w 0    ; color 7
MAIN_PALETTE2_8:     dc.w 0    ; color 8
MAIN_PALETTE2_9:     dc.w 0    ; color 9
MAIN_PALETTE2_10:    dc.w 0    ; color 10
MAIN_PALETTE2_11:    dc.w 0    ; color 11
MAIN_PALETTE2_12:    dc.w 0    ; color 12
MAIN_PALETTE2_13:    dc.w 0    ; color 13
MAIN_PALETTE2_14:    dc.w 0    ; color 14
MAIN_PALETTE2_15:    dc.w 0    ; color 15
MAIN_PALETTE2_16:    dc.w 0    ; color 16
MAIN_PALETTE2_17:    dc.w 0    ; color 17
MAIN_PALETTE2_18:    dc.w 0    ; color 18
MAIN_PALETTE2_19:    dc.w 0    ; color 19
MAIN_PALETTE2_20:    dc.w 0    ; color 20
MAIN_PALETTE2_21:    dc.w 0    ; color 21
MAIN_PALETTE2_22:    dc.w 0    ; color 22
MAIN_PALETTE2_23:    dc.w 0    ; color 23
MAIN_PALETTE2_24:    dc.w 0    ; color 24
MAIN_PALETTE2_25:    dc.w 0    ; color 25
MAIN_PALETTE2_26:    dc.w 0    ; color 26
MAIN_PALETTE2_27:    dc.w 0    ; color 27
MAIN_PALETTE2_28:    dc.w 0    ; color 28
MAIN_PALETTE2_29:    dc.w 0    ; color 29
MAIN_PALETTE2_30:    dc.w 0    ; color 30
MAIN_PALETTE2_31:    dc.w 0    ; color 31

	include "AProcessing/libs/math/sqrt_table_q16_0.i"
