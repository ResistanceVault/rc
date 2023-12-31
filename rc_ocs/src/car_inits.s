; Sample control
GROUP_1_SAMPLE_RATE equ 447 ; 8000 Hz
GROUP_2_SAMPLE_RATE equ 895   ;  3579546/4000 ; 4000 Hz
GROUP_3_SAMPLE_RATE equ 895   ;  3579546/4000 ; 4000 Hz
GROUP_4_SAMPLE_RATE equ 895   ;  3579546/4000 ; 4000 Hz

GROUP_1_SOUNDWAVE_SIZE_WORDS equ 2312/2
GROUP_2_SOUNDWAVE_SIZE_WORDS equ 49/2
GROUP_3_SOUNDWAVE_SIZE_WORDS equ 46/2
GROUP_4_SOUNDWAVE_SIZE_WORDS equ 90/2

;GROUP_1_SOUNDFILE equ FERRARI_SND ; sound of a ferrari
;GROUP_2_SOUNDFILE equ MCLAREN_SND ; sound of a mclaren
;GROUP_4_SOUNDFILE equ ALFAMARAMEO_SND ; sound of a alfaromeo (drum)

; Init car controls
CAR_CONTROL_1 EQU READJOY1
CAR_CONTROL_2 EQU CPUCONTROL
CAR_CONTROL_3 EQU CPUCONTROL
CAR_CONTROL_4 EQU CPUCONTROL
CAR_CONTROL_5 EQU CPUCONTROL
CAR_CONTROL_6 EQU CPUCONTROL
CAR_CONTROL_7 EQU CPUCONTROL
CAR_CONTROL_8 EQU CPUCONTROL

CAR1_MAX_SPEED 		EQU %0001100000000000 ; 1.5 pixels per frame of max speed
CAR1_ENGINE_POWER 	EQU 16
CAR1_FRICTION		EQU %10000000
CAR_BRAKE			EQU %100000000
CAR1_WHEEL_BASE_LENGTH EQU 6
CAR_BOUNCE_WALL_FORCE EQU %0000101000000000
CAR_STEERING_ANGLE	EQU 2
CAR_HALF_WIDTH		EQU 6

CAR1_HUD_X_POSITION EQU 0
CAR2_HUD_X_POSITION EQU 4
CAR3_HUD_X_POSITION EQU 8
CAR4_HUD_X_POSITION EQU 12
CAR5_HUD_X_POSITION EQU 16
CAR6_HUD_X_POSITION EQU 20
CAR7_HUD_X_POSITION EQU 24
CAR8_HUD_X_POSITION EQU 28

PLAYER_ONE_NAME: 	dc.b "STARNOUX   ",$FF ; perrari
PLAYER_FIVE_NAME: 	dc.b "ALBERETTO  ",$FF ; perrari

PLAYER_TWO_NAME: 	dc.b "A CROST    ",$FF ; mc lallen
PLAYER_SIX_NAME: 	dc.b "BAGNACAUDA ",$FF ; mc lallen


PLAYER_THREE_NAME: 	dc.b "TAMBURAY   ",$FF ; perault
PLAYER_SEVEN_NAME: 	dc.b "FRITTICALDI",$FF ; perault


PLAYER_FOUR_NAME: 	dc.b "R PRETESE  ",$FF ; alfa marameo
PLAYER_EIGHT_NAME: 	dc.b "JJ LENTO   ",$FF ; alfa marameo



PLAYER_ONE_FIVE_TEAM:		dc.b "PERRARI     ",$FF ; perrari for car 1 and 5
PLAYER_TWO_SIX_TEAM:		dc.b "MC LALLEN   ",$FF ; mc lallen for car 2 and 6
PLAYER_THREE_SEVEN_TEAM:	dc.b "PERAULT     ",$FF ; perault for car 3 and 6
PLAYER_FOUR_EIGHT_TEAM:		dc.b "ALFA MARAMEO",$FF ; alfa marameo for car 4 and 8

PLAYER_1_TIMER_TXT: 		dcb.b 6,$00
PLAYER_2_TIMER_TXT: 		dcb.b 6,$00
PLAYER_3_TIMER_TXT: 		dcb.b 6,$00
PLAYER_4_TIMER_TXT: 		dcb.b 6,$00
PLAYER_5_TIMER_TXT: 		dcb.b 6,$00
PLAYER_6_TIMER_TXT: 		dcb.b 6,$00
PLAYER_7_TIMER_TXT: 		dcb.b 6,$00
PLAYER_8_TIMER_TXT: 		dcb.b 6,$00

CAR1_INIT:
	jsr 	SET_CAR1_START_STATUS
	lea 	MOVER1,a0

	move.l  #PLAYER_ONE_NAME,MOVER_PLAYER_NAME_ADDR(a0)
	move.l  #PLAYER_ONE_FIVE_TEAM,MOVER_PLAYER_TEAM_ADDR(a0)				; Car player name

	move.w 	#0,CAR_ID_OFFSET(a0)										; Car unique identifier
	move.w  #CAR_STEERING_ANGLE,MOVER_STEERING_ANGLE_OFFSET(a0)   	 	; how many degrees the car can steer at each frame? (steering angle)

	move.w  #CAR1_WHEEL_BASE_LENGTH,MOVER_WHEEL_BASE_OFFSET(a0)     	; distance between 2 wheels in pixels (wheel_base)
	move.w  #CAR1_WHEEL_BASE_LENGTH/2,MOVER_WHEEL_BASE_DIV_2_OFFSET(a0)     	; distance between 2 wheels in pixels (wheel_base) divided by 2
	move.w  #CAR_HALF_WIDTH,MOVER_WIDTH_DIV_2_OFFSET(a0)

	; calculate forward vector
	move.w  MOVER_STEER_DIRECTION_OFFSET(a0),d7
	adda.w  #MOVER_FORWARD_VECTOR_OFFSET,a0
	CREATE2DVECTORFROMANGLE					 	     	; forward vector, normalized vector form of heading (forward_vector) (private)
	move.w (a0),d7
	asr.w #11-DECIMAL_SHIFT,d7
	move.w d7,(a0)
	move.w 2(a0),d7
	asr.w #11-DECIMAL_SHIFT,d7
	move.w d7,2(a0)
	suba.w  #MOVER_FORWARD_VECTOR_OFFSET,a0

	move.w  #CAR1_ENGINE_POWER,MOVER_ENGINE_POWER_OFFSET(a0) 	  	 	; engine power , high number means the car will reach max speed faster (engine_power)
	move.w 	#CAR1_MAX_SPEED,MOVER_MAX_SPEED_OFFSET(a0) 	  		 	; max speed of the car, limit maximum amount of movement pixel for each frame (max_speed)


	move.w  #CAR_BRAKE,MOVER_BRAKE_COEFFICIENT_OFFSET(a0)	; brake coefficient, the higher the value, the strongest the brakes of the car (brake_factor)
	move.w  #CAR1_FRICTION,MOVER_FRICTION_COEFFICIENT_OFFSET(a0) ; friction coefficientl, the higher the value, the greater the gravity force (friction_factor) 

	; repulsion force to bounce a car when hits the wall (high value means big bounce)
	move.w  #CAR_BOUNCE_WALL_FORCE,d0
	neg.w   d0
	move.w  d0,MOVER_BOUNCE_WALL_OFFSET(a0)

	; input routine
	move.l  #CAR_CONTROL_1,INPUT_ROUTINE_OFFSET(a0)

	; car sprites address list
	move.l  #CAR_0,CAR_SPRITES_LIST_OFFSET_0(a0)
    move.l  #CAR_345,CAR_SPRITES_LIST_OFFSET_1(a0)
    move.l  #CAR_330,CAR_SPRITES_LIST_OFFSET_2(a0)
    move.l  #CAR_315,CAR_SPRITES_LIST_OFFSET_3(a0)
    move.l  #CAR_300,CAR_SPRITES_LIST_OFFSET_4(a0)
    move.l  #CAR_285,CAR_SPRITES_LIST_OFFSET_5(a0)
    move.l  #CAR_270,CAR_SPRITES_LIST_OFFSET_6(a0)
    move.l  #CAR_255,CAR_SPRITES_LIST_OFFSET_7(a0)
    move.l  #CAR_240,CAR_SPRITES_LIST_OFFSET_8(a0)
	move.l  #CAR_225,CAR_SPRITES_LIST_OFFSET_9(a0)
	move.l  #CAR_210,CAR_SPRITES_LIST_OFFSET_10(a0)
	move.l  #CAR_195,CAR_SPRITES_LIST_OFFSET_11(a0)
	move.l  #CAR_180,CAR_SPRITES_LIST_OFFSET_12(a0)
	move.l  #CAR_165,CAR_SPRITES_LIST_OFFSET_13(a0)
	move.l  #CAR_150,CAR_SPRITES_LIST_OFFSET_14(a0)
	move.l  #CAR_135,CAR_SPRITES_LIST_OFFSET_15(a0)
	move.l  #CAR_120,CAR_SPRITES_LIST_OFFSET_16(a0)
	move.l  #CAR_105,CAR_SPRITES_LIST_OFFSET_17(a0)
	move.l  #CAR_90,CAR_SPRITES_LIST_OFFSET_18(a0)
	move.l  #CAR_75,CAR_SPRITES_LIST_OFFSET_19(a0)
	move.l  #CAR_60,CAR_SPRITES_LIST_OFFSET_20(a0)
	move.l  #CAR_45,CAR_SPRITES_LIST_OFFSET_21(a0)
	move.l  #CAR_30,CAR_SPRITES_LIST_OFFSET_22(a0)
	move.l  #CAR_15,CAR_SPRITES_LIST_OFFSET_23(a0)
	move.l  #CAR_0,CAR_SPRITES_LIST_OFFSET_24(a0)

	move.l	#Sprite0pointers,CAR_SPRITE_POINTER_OFFSET(a0)

	IFD SOUND
	move.l  #FERRARI_SND,MOTOR_SAMPLE_OFFSET(a0)
	move.l  #$dff0a0,AUDIO_CHANNEL_ADDRESS_OFFSET(a0)
	move.w  #%0000000000000001,AUDIO_CHANNEL_DMA_BIT(a0)
	move.w  #GROUP_1_SAMPLE_RATE,MOVER_SAMPLE_RATE(a0)
	move.w  #GROUP_1_SOUNDWAVE_SIZE_WORDS,MOVER_SOUNDWAVE_SIZE_WORDS(a0)
	ENDC
	move.l #MOVERS5,MOVER_TEAMMATE_CAR_PTR(a0)
	clr.w  MOVER_HEADING_MAGNITUDE(a0)
	clr.w  MOVER_CPU_CONSECUTIVE_COLLISIONS(a0)
	move.w #23291,MOVER_IMG_SIZE(a0)

	; hud position
	move.w	#CAR1_HUD_X_POSITION,HUD_POSITION_X(a0)
	move.w	#40,HUD_POSITION_Y(a0)

	jsr		CALCULATE_WHEEL_POSITIONS

	rts

CAR2_INIT:
	jsr 	SET_CAR2_START_STATUS
	lea 	MOVER2,a0

	move.l  #PLAYER_TWO_NAME,MOVER_PLAYER_NAME_ADDR(a0)					; Car player name
	move.l  #PLAYER_TWO_SIX_TEAM,MOVER_PLAYER_TEAM_ADDR(a0)

	move.w 	#1,CAR_ID_OFFSET(a0)										; Car unique identifier
	move.w  #CAR_STEERING_ANGLE,MOVER_STEERING_ANGLE_OFFSET(a0)   	 	; how many degrees the car can steer at each frame? (steering angle)

	move.w  #CAR1_WHEEL_BASE_LENGTH,MOVER_WHEEL_BASE_OFFSET(a0)     	; distance between 2 wheels in pixels (wheel_base)
	move.w  #CAR1_WHEEL_BASE_LENGTH/2,MOVER_WHEEL_BASE_DIV_2_OFFSET(a0)     	; distance between 2 wheels in pixels (wheel_base) divided by 2
	move.w  #CAR_HALF_WIDTH,MOVER_WIDTH_DIV_2_OFFSET(a0)
	move.l  #0,MOVER_HEADING_OFFSET(a0)		 	  	 	; vector representing heading direction (heading) (private)

	; calculate forward vector
	move.w  MOVER_STEER_DIRECTION_OFFSET(a0),d7
	adda.w  #MOVER_FORWARD_VECTOR_OFFSET,a0
	CREATE2DVECTORFROMANGLE					 	     	; forward vector, normalized vector form of heading (forward_vector) (private)
	move.w (a0),d7
	asr.w #11-DECIMAL_SHIFT,d7
	move.w d7,(a0)
	move.w 2(a0),d7
	asr.w #11-DECIMAL_SHIFT,d7
	move.w d7,2(a0)
	suba.w  #MOVER_FORWARD_VECTOR_OFFSET,a0

	move.w  #CAR1_ENGINE_POWER,MOVER_ENGINE_POWER_OFFSET(a0) 	  	 	; engine power , high number means the car will reach max speed faster (engine_power)
	move.w 	#CAR1_MAX_SPEED,MOVER_MAX_SPEED_OFFSET(a0) 	  		 	; max speed of the car, limit maximum amount of movement pixel for each frame (max_speed)

	move.w  #CAR_BRAKE,MOVER_BRAKE_COEFFICIENT_OFFSET(a0)	; brake coefficient, the higher the value, the strongest the brakes of the car (brake_factor)
	move.w  #CAR1_FRICTION,MOVER_FRICTION_COEFFICIENT_OFFSET(a0) ; friction coefficientl, the higher the value, the greater the gravity force (friction_factor) 

	; repulsion force to bounce a car when hits the wall (high value means big bounce)
	move.w  #CAR_BOUNCE_WALL_FORCE,d0
	neg.w   d0
	move.w  d0,MOVER_BOUNCE_WALL_OFFSET(a0)

	; input routine
	move.l  #CAR_CONTROL_2,INPUT_ROUTINE_OFFSET(a0)

	; car sprites address list
	move.l  #CAR1_0,CAR_SPRITES_LIST_OFFSET_0(a0)
    move.l  #CAR1_345,CAR_SPRITES_LIST_OFFSET_1(a0)
    move.l  #CAR1_330,CAR_SPRITES_LIST_OFFSET_2(a0)
    move.l  #CAR1_315,CAR_SPRITES_LIST_OFFSET_3(a0)
    move.l  #CAR1_300,CAR_SPRITES_LIST_OFFSET_4(a0)
    move.l  #CAR1_285,CAR_SPRITES_LIST_OFFSET_5(a0)
    move.l  #CAR1_270,CAR_SPRITES_LIST_OFFSET_6(a0)
    move.l  #CAR1_255,CAR_SPRITES_LIST_OFFSET_7(a0)
    move.l  #CAR1_240,CAR_SPRITES_LIST_OFFSET_8(a0)
	move.l  #CAR1_225,CAR_SPRITES_LIST_OFFSET_9(a0)
	move.l  #CAR1_210,CAR_SPRITES_LIST_OFFSET_10(a0)
	move.l  #CAR1_195,CAR_SPRITES_LIST_OFFSET_11(a0)
	move.l  #CAR1_180,CAR_SPRITES_LIST_OFFSET_12(a0)
	move.l  #CAR1_165,CAR_SPRITES_LIST_OFFSET_13(a0)
	move.l  #CAR1_150,CAR_SPRITES_LIST_OFFSET_14(a0)
	move.l  #CAR1_135,CAR_SPRITES_LIST_OFFSET_15(a0)
	move.l  #CAR1_120,CAR_SPRITES_LIST_OFFSET_16(a0)
	move.l  #CAR1_105,CAR_SPRITES_LIST_OFFSET_17(a0)
	move.l  #CAR1_90,CAR_SPRITES_LIST_OFFSET_18(a0)
	move.l  #CAR1_75,CAR_SPRITES_LIST_OFFSET_19(a0)
	move.l  #CAR1_60,CAR_SPRITES_LIST_OFFSET_20(a0)
	move.l  #CAR1_45,CAR_SPRITES_LIST_OFFSET_21(a0)
	move.l  #CAR1_30,CAR_SPRITES_LIST_OFFSET_22(a0)
	move.l  #CAR1_15,CAR_SPRITES_LIST_OFFSET_23(a0)
	move.l  #CAR1_0,CAR_SPRITES_LIST_OFFSET_24(a0)

	move.l	#Sprite2pointers,CAR_SPRITE_POINTER_OFFSET(a0)

	IFD SOUND
	move.l  #MCLAREN_SND,MOTOR_SAMPLE_OFFSET(a0)
	move.l  #$dff0b0,AUDIO_CHANNEL_ADDRESS_OFFSET(a0)
	move.w  #%0000000000000010,AUDIO_CHANNEL_DMA_BIT(a0)
	move.w  #GROUP_2_SAMPLE_RATE,MOVER_SAMPLE_RATE(a0)
	move.w  #GROUP_2_SOUNDWAVE_SIZE_WORDS,MOVER_SOUNDWAVE_SIZE_WORDS(a0)
	ENDC
	move.l #MOVERS6,MOVER_TEAMMATE_CAR_PTR(a0)

	clr.w  MOVER_HEADING_MAGNITUDE(a0)
	clr.w  MOVER_CPU_CONSECUTIVE_COLLISIONS(a0)
	move.w #25784,MOVER_IMG_SIZE(a0)

	; hud position
	move.w	#CAR2_HUD_X_POSITION,HUD_POSITION_X(a0)
	move.w	#40,HUD_POSITION_Y(a0)

	jsr		CALCULATE_WHEEL_POSITIONS

	rts

CAR3_INIT:
	jsr		SET_CAR3_START_STATUS
	lea 	MOVER3,a0

	move.l  #PLAYER_THREE_NAME,MOVER_PLAYER_NAME_ADDR(a0)					; Car player name
	move.l  #PLAYER_THREE_SEVEN_TEAM,MOVER_PLAYER_TEAM_ADDR(a0)

	move.w 	#2,CAR_ID_OFFSET(a0)										; Car unique identifier

	move.w  #CAR1_WHEEL_BASE_LENGTH,MOVER_WHEEL_BASE_OFFSET(a0)     	; distance between 2 wheels in pixels (wheel_base)
	move.w  #CAR1_WHEEL_BASE_LENGTH/2,MOVER_WHEEL_BASE_DIV_2_OFFSET(a0)     	; distance between 2 wheels in pixels (wheel_base) divided by 2
	move.w  #CAR_HALF_WIDTH,MOVER_WIDTH_DIV_2_OFFSET(a0)
	move.w  #CAR_STEERING_ANGLE,MOVER_STEERING_ANGLE_OFFSET(a0)   	 	; how many degrees the car can steer at each frame? (steering angle)

	; calculate forward vector
	move.w  MOVER_STEER_DIRECTION_OFFSET(a0),d7
	adda.w  #MOVER_FORWARD_VECTOR_OFFSET,a0
	CREATE2DVECTORFROMANGLE					 	     	; forward vector, normalized vector form of heading (forward_vector) (private)
	move.w (a0),d7
	asr.w #11-DECIMAL_SHIFT,d7
	move.w d7,(a0)
	move.w 2(a0),d7
	asr.w #11-DECIMAL_SHIFT,d7
	move.w d7,2(a0)
	suba.w  #MOVER_FORWARD_VECTOR_OFFSET,a0

	move.w  #CAR1_ENGINE_POWER,MOVER_ENGINE_POWER_OFFSET(a0) 	  	 	; engine power , high number means the car will reach max speed faster (engine_power)
	move.w 	#CAR1_MAX_SPEED,MOVER_MAX_SPEED_OFFSET(a0) 	  		 	; max speed of the car, limit maximum amount of movement pixel for each frame (max_speed)

	move.w  #CAR_BRAKE,MOVER_BRAKE_COEFFICIENT_OFFSET(a0)	; brake coefficient, the higher the value, the strongest the brakes of the car (brake_factor)
	move.w  #CAR1_FRICTION,MOVER_FRICTION_COEFFICIENT_OFFSET(a0) ; friction coefficientl, the higher the value, the greater the gravity force (friction_factor) 

	; repulsion force to bounce a car when hits the wall (high value means big bounce)
	move.w  #CAR_BOUNCE_WALL_FORCE,d0
	neg.w   d0
	move.w  d0,MOVER_BOUNCE_WALL_OFFSET(a0)

	; input routine
	move.l  #CAR_CONTROL_3,INPUT_ROUTINE_OFFSET(a0)

	; car sprites address list
	move.l  #CAR2_0,CAR_SPRITES_LIST_OFFSET_0(a0)
    move.l  #CAR2_345,CAR_SPRITES_LIST_OFFSET_1(a0)
    move.l  #CAR2_330,CAR_SPRITES_LIST_OFFSET_2(a0)
    move.l  #CAR2_315,CAR_SPRITES_LIST_OFFSET_3(a0)
    move.l  #CAR2_300,CAR_SPRITES_LIST_OFFSET_4(a0)
    move.l  #CAR2_285,CAR_SPRITES_LIST_OFFSET_5(a0)
    move.l  #CAR2_270,CAR_SPRITES_LIST_OFFSET_6(a0)
    move.l  #CAR2_255,CAR_SPRITES_LIST_OFFSET_7(a0)
    move.l  #CAR2_240,CAR_SPRITES_LIST_OFFSET_8(a0)
	move.l  #CAR2_225,CAR_SPRITES_LIST_OFFSET_9(a0)
	move.l  #CAR2_210,CAR_SPRITES_LIST_OFFSET_10(a0)
	move.l  #CAR2_195,CAR_SPRITES_LIST_OFFSET_11(a0)
	move.l  #CAR2_180,CAR_SPRITES_LIST_OFFSET_12(a0)
	move.l  #CAR2_165,CAR_SPRITES_LIST_OFFSET_13(a0)
	move.l  #CAR2_150,CAR_SPRITES_LIST_OFFSET_14(a0)
	move.l  #CAR2_135,CAR_SPRITES_LIST_OFFSET_15(a0)
	move.l  #CAR2_120,CAR_SPRITES_LIST_OFFSET_16(a0)
	move.l  #CAR2_105,CAR_SPRITES_LIST_OFFSET_17(a0)
	move.l  #CAR2_90,CAR_SPRITES_LIST_OFFSET_18(a0)
	move.l  #CAR2_75,CAR_SPRITES_LIST_OFFSET_19(a0)
	move.l  #CAR2_60,CAR_SPRITES_LIST_OFFSET_20(a0)
	move.l  #CAR2_45,CAR_SPRITES_LIST_OFFSET_21(a0)
	move.l  #CAR2_30,CAR_SPRITES_LIST_OFFSET_22(a0)
	move.l  #CAR2_15,CAR_SPRITES_LIST_OFFSET_23(a0)
	move.l  #CAR2_0,CAR_SPRITES_LIST_OFFSET_24(a0)

	move.l	#Sprite4pointers,CAR_SPRITE_POINTER_OFFSET(a0)

	IFD SOUND
	move.l  #RENAULT_SND,MOTOR_SAMPLE_OFFSET(a0)
	move.l  #$dff0c0,AUDIO_CHANNEL_ADDRESS_OFFSET(a0)
	move.w  #%0000000000000100,AUDIO_CHANNEL_DMA_BIT(a0)
	move.w  #GROUP_3_SAMPLE_RATE,MOVER_SAMPLE_RATE(a0)
	move.w  #GROUP_3_SOUNDWAVE_SIZE_WORDS,MOVER_SOUNDWAVE_SIZE_WORDS(a0)
	ENDC
	move.l #MOVERS7,MOVER_TEAMMATE_CAR_PTR(a0)

	clr.w  MOVER_HEADING_MAGNITUDE(a0)
	clr.w  MOVER_CPU_CONSECUTIVE_COLLISIONS(a0)
	move.w #27775,MOVER_IMG_SIZE(a0)

	; hud position
	move.w	#CAR3_HUD_X_POSITION,HUD_POSITION_X(a0)
	move.w	#40,HUD_POSITION_Y(a0)

	jsr		CALCULATE_WHEEL_POSITIONS

	rts

CAR4_INIT:
	jsr		SET_CAR4_START_STATUS
	lea 	MOVER4,a0

	move.l  #PLAYER_FOUR_NAME,MOVER_PLAYER_NAME_ADDR(a0)					; Car player name
	move.l  #PLAYER_FOUR_EIGHT_TEAM,MOVER_PLAYER_TEAM_ADDR(a0)

	move.w 	#3,CAR_ID_OFFSET(a0)										; Car unique identifier

	move.w  #CAR1_WHEEL_BASE_LENGTH,MOVER_WHEEL_BASE_OFFSET(a0)     	; distance between 2 wheels in pixels (wheel_base)
	move.w  #CAR1_WHEEL_BASE_LENGTH/2,MOVER_WHEEL_BASE_DIV_2_OFFSET(a0)     	; distance between 2 wheels in pixels (wheel_base) divided by 2
	move.w  #CAR_HALF_WIDTH,MOVER_WIDTH_DIV_2_OFFSET(a0)

	move.w  #CAR_STEERING_ANGLE,MOVER_STEERING_ANGLE_OFFSET(a0)   	 	; how many degrees the car can steer at each frame? (steering angle)

	; calculate forward vector
	move.w  MOVER_STEER_DIRECTION_OFFSET(a0),d7
	adda.w  #MOVER_FORWARD_VECTOR_OFFSET,a0
	CREATE2DVECTORFROMANGLE					 	     	; forward vector, normalized vector form of heading (forward_vector) (private)
	move.w (a0),d7
	asr.w #11-DECIMAL_SHIFT,d7
	move.w d7,(a0)
	move.w 2(a0),d7
	asr.w #11-DECIMAL_SHIFT,d7
	move.w d7,2(a0)
	suba.w  #MOVER_FORWARD_VECTOR_OFFSET,a0

	move.w  #CAR1_ENGINE_POWER,MOVER_ENGINE_POWER_OFFSET(a0) 	  	 	; engine power , high number means the car will reach max speed faster (engine_power)
	move.w 	#CAR1_MAX_SPEED,MOVER_MAX_SPEED_OFFSET(a0) 	  		 	; max speed of the car, limit maximum amount of movement pixel for each frame (max_speed)

	move.w  #CAR_BRAKE,MOVER_BRAKE_COEFFICIENT_OFFSET(a0)	; brake coefficient, the higher the value, the strongest the brakes of the car (brake_factor)
	move.w  #CAR1_FRICTION,MOVER_FRICTION_COEFFICIENT_OFFSET(a0) ; friction coefficientl, the higher the value, the greater the gravity force (friction_factor) 

	; repulsion force to bounce a car when hits the wall (high value means big bounce)
	move.w  #CAR_BOUNCE_WALL_FORCE,d0
	neg.w   d0
	move.w  d0,MOVER_BOUNCE_WALL_OFFSET(a0)

	; input routine
	move.l  #CAR_CONTROL_4,INPUT_ROUTINE_OFFSET(a0)

	; car sprites address list
	move.l  #CAR3_0,CAR_SPRITES_LIST_OFFSET_0(a0)
    move.l  #CAR3_345,CAR_SPRITES_LIST_OFFSET_1(a0)
    move.l  #CAR3_330,CAR_SPRITES_LIST_OFFSET_2(a0)
    move.l  #CAR3_315,CAR_SPRITES_LIST_OFFSET_3(a0)
    move.l  #CAR3_300,CAR_SPRITES_LIST_OFFSET_4(a0)
    move.l  #CAR3_285,CAR_SPRITES_LIST_OFFSET_5(a0)
    move.l  #CAR3_270,CAR_SPRITES_LIST_OFFSET_6(a0)
    move.l  #CAR3_255,CAR_SPRITES_LIST_OFFSET_7(a0)
    move.l  #CAR3_240,CAR_SPRITES_LIST_OFFSET_8(a0)
	move.l  #CAR3_225,CAR_SPRITES_LIST_OFFSET_9(a0)
	move.l  #CAR3_210,CAR_SPRITES_LIST_OFFSET_10(a0)
	move.l  #CAR3_195,CAR_SPRITES_LIST_OFFSET_11(a0)
	move.l  #CAR3_180,CAR_SPRITES_LIST_OFFSET_12(a0)
	move.l  #CAR3_165,CAR_SPRITES_LIST_OFFSET_13(a0)
	move.l  #CAR3_150,CAR_SPRITES_LIST_OFFSET_14(a0)
	move.l  #CAR3_135,CAR_SPRITES_LIST_OFFSET_15(a0)
	move.l  #CAR3_120,CAR_SPRITES_LIST_OFFSET_16(a0)
	move.l  #CAR3_105,CAR_SPRITES_LIST_OFFSET_17(a0)
	move.l  #CAR3_90,CAR_SPRITES_LIST_OFFSET_18(a0)
	move.l  #CAR3_75,CAR_SPRITES_LIST_OFFSET_19(a0)
	move.l  #CAR3_60,CAR_SPRITES_LIST_OFFSET_20(a0)
	move.l  #CAR3_45,CAR_SPRITES_LIST_OFFSET_21(a0)
	move.l  #CAR3_30,CAR_SPRITES_LIST_OFFSET_22(a0)
	move.l  #CAR3_15,CAR_SPRITES_LIST_OFFSET_23(a0)
	move.l  #CAR3_0,CAR_SPRITES_LIST_OFFSET_24(a0)

	move.l	#Sprite6pointers,CAR_SPRITE_POINTER_OFFSET(a0)

	IFD SOUND
	move.l  #ALFAMARAMEO_SND,MOTOR_SAMPLE_OFFSET(a0)
	move.l  #$dff0d0,AUDIO_CHANNEL_ADDRESS_OFFSET(a0)
	move.w  #%0000000000001000,AUDIO_CHANNEL_DMA_BIT(a0)
	move.w  #GROUP_4_SAMPLE_RATE,MOVER_SAMPLE_RATE(a0)
	move.w  #GROUP_4_SOUNDWAVE_SIZE_WORDS,MOVER_SOUNDWAVE_SIZE_WORDS(a0)
	ENDC
	move.l #MOVERS8,MOVER_TEAMMATE_CAR_PTR(a0)

	clr.w  MOVER_HEADING_MAGNITUDE(a0)
	clr.w  MOVER_CPU_CONSECUTIVE_COLLISIONS(a0)
	move.w #20589,MOVER_IMG_SIZE(a0)

	; hud position
	move.w	#CAR4_HUD_X_POSITION,HUD_POSITION_X(a0)
	move.w	#40,HUD_POSITION_Y(a0)

	jsr		CALCULATE_WHEEL_POSITIONS

	rts

CAR5_INIT:
	jsr		SET_CAR5_START_STATUS
	lea 	MOVER5,a0

	move.l  #PLAYER_FIVE_NAME,MOVER_PLAYER_NAME_ADDR(a0)					; Car player name
	move.l  #PLAYER_ONE_FIVE_TEAM,MOVER_PLAYER_TEAM_ADDR(a0)

	move.w 	#4,CAR_ID_OFFSET(a0)										; Car unique identifier

	move.w  #CAR1_WHEEL_BASE_LENGTH,MOVER_WHEEL_BASE_OFFSET(a0)     	; distance between 2 wheels in pixels (wheel_base)
	move.w  #CAR1_WHEEL_BASE_LENGTH/2,MOVER_WHEEL_BASE_DIV_2_OFFSET(a0)     	; distance between 2 wheels in pixels (wheel_base) divided by 2
	move.w  #CAR_HALF_WIDTH,MOVER_WIDTH_DIV_2_OFFSET(a0)

	move.w  #CAR_STEERING_ANGLE,MOVER_STEERING_ANGLE_OFFSET(a0)   	 	; how many degrees the car can steer at each frame? (steering angle)

	; calculate forward vector
	move.w  MOVER_STEER_DIRECTION_OFFSET(a0),d7
	adda.w  #MOVER_FORWARD_VECTOR_OFFSET,a0
	CREATE2DVECTORFROMANGLE					 	     	; forward vector, normalized vector form of heading (forward_vector) (private)
	move.w (a0),d7
	asr.w #11-DECIMAL_SHIFT,d7
	move.w d7,(a0)
	move.w 2(a0),d7
	asr.w #11-DECIMAL_SHIFT,d7
	move.w d7,2(a0)
	suba.w  #MOVER_FORWARD_VECTOR_OFFSET,a0

	move.w  #CAR1_ENGINE_POWER,MOVER_ENGINE_POWER_OFFSET(a0) 	  	 	; engine power , high number means the car will reach max speed faster (engine_power)
	move.w 	#CAR1_MAX_SPEED,MOVER_MAX_SPEED_OFFSET(a0) 	  		 	; max speed of the car, limit maximum amount of movement pixel for each frame (max_speed)

	move.w  #CAR_BRAKE,MOVER_BRAKE_COEFFICIENT_OFFSET(a0)	; brake coefficient, the higher the value, the strongest the brakes of the car (brake_factor)
	move.w  #CAR1_FRICTION,MOVER_FRICTION_COEFFICIENT_OFFSET(a0) ; friction coefficientl, the higher the value, the greater the gravity force (friction_factor) 

	; repulsion force to bounce a car when hits the wall (high value means big bounce)
	move.w  #CAR_BOUNCE_WALL_FORCE,d0
	neg.w   d0
	move.w  d0,MOVER_BOUNCE_WALL_OFFSET(a0)

	; input routine
	move.l  #CAR_CONTROL_5,INPUT_ROUTINE_OFFSET(a0)

	; car sprites address list
	move.l  #CAR4_0,CAR_SPRITES_LIST_OFFSET_0(a0)
    move.l  #CAR4_345,CAR_SPRITES_LIST_OFFSET_1(a0)
    move.l  #CAR4_330,CAR_SPRITES_LIST_OFFSET_2(a0)
    move.l  #CAR4_315,CAR_SPRITES_LIST_OFFSET_3(a0)
    move.l  #CAR4_300,CAR_SPRITES_LIST_OFFSET_4(a0)
    move.l  #CAR4_285,CAR_SPRITES_LIST_OFFSET_5(a0)
    move.l  #CAR4_270,CAR_SPRITES_LIST_OFFSET_6(a0)
    move.l  #CAR4_255,CAR_SPRITES_LIST_OFFSET_7(a0)
    move.l  #CAR4_240,CAR_SPRITES_LIST_OFFSET_8(a0)
	move.l  #CAR4_225,CAR_SPRITES_LIST_OFFSET_9(a0)
	move.l  #CAR4_210,CAR_SPRITES_LIST_OFFSET_10(a0)
	move.l  #CAR4_195,CAR_SPRITES_LIST_OFFSET_11(a0)
	move.l  #CAR4_180,CAR_SPRITES_LIST_OFFSET_12(a0)
	move.l  #CAR4_165,CAR_SPRITES_LIST_OFFSET_13(a0)
	move.l  #CAR4_150,CAR_SPRITES_LIST_OFFSET_14(a0)
	move.l  #CAR4_135,CAR_SPRITES_LIST_OFFSET_15(a0)
	move.l  #CAR4_120,CAR_SPRITES_LIST_OFFSET_16(a0)
	move.l  #CAR4_105,CAR_SPRITES_LIST_OFFSET_17(a0)
	move.l  #CAR4_90,CAR_SPRITES_LIST_OFFSET_18(a0)
	move.l  #CAR4_75,CAR_SPRITES_LIST_OFFSET_19(a0)
	move.l  #CAR4_60,CAR_SPRITES_LIST_OFFSET_20(a0)
	move.l  #CAR4_45,CAR_SPRITES_LIST_OFFSET_21(a0)
	move.l  #CAR4_30,CAR_SPRITES_LIST_OFFSET_22(a0)
	move.l  #CAR4_15,CAR_SPRITES_LIST_OFFSET_23(a0)
	move.l  #CAR4_0,CAR_SPRITES_LIST_OFFSET_24(a0)

	move.l	#Sprite1pointers,CAR_SPRITE_POINTER_OFFSET(a0)

	IFD SOUND
	move.l  #FERRARI_SND,MOTOR_SAMPLE_OFFSET(a0)
	move.l  #$dff0a0,AUDIO_CHANNEL_ADDRESS_OFFSET(a0)
	move.w  #%0000000000000001,AUDIO_CHANNEL_DMA_BIT(a0)
	move.w  #GROUP_1_SAMPLE_RATE,MOVER_SAMPLE_RATE(a0)
	move.w  #GROUP_1_SOUNDWAVE_SIZE_WORDS,MOVER_SOUNDWAVE_SIZE_WORDS(a0)
	ENDC
	move.l #MOVERS,MOVER_TEAMMATE_CAR_PTR(a0)

	clr.w  MOVER_HEADING_MAGNITUDE(a0)
	clr.w  MOVER_CPU_CONSECUTIVE_COLLISIONS(a0)
	move.w #21499,MOVER_IMG_SIZE(a0)

	; hud position
	move.w	#CAR5_HUD_X_POSITION,HUD_POSITION_X(a0)
	move.w	#(1+8)*40,HUD_POSITION_Y(a0)

	jsr		CALCULATE_WHEEL_POSITIONS

	rts

CAR6_INIT:
	jsr		SET_CAR6_START_STATUS
	lea 	MOVER6,a0

	move.l  #PLAYER_SIX_NAME,MOVER_PLAYER_NAME_ADDR(a0)					; Car player name
	move.l  #PLAYER_TWO_SIX_TEAM,MOVER_PLAYER_TEAM_ADDR(a0)

	move.w 	#5,CAR_ID_OFFSET(a0)										; Car unique identifier

	move.w  #CAR1_WHEEL_BASE_LENGTH,MOVER_WHEEL_BASE_OFFSET(a0)     	; distance between 2 wheels in pixels (wheel_base)
	move.w  #CAR1_WHEEL_BASE_LENGTH/2,MOVER_WHEEL_BASE_DIV_2_OFFSET(a0)     	; distance between 2 wheels in pixels (wheel_base) divided by 2
	move.w  #CAR_HALF_WIDTH,MOVER_WIDTH_DIV_2_OFFSET(a0)

	move.w  #CAR_STEERING_ANGLE,MOVER_STEERING_ANGLE_OFFSET(a0)   	 	; how many degrees the car can steer at each frame? (steering angle)

	; calculate forward vector
	move.w  MOVER_STEER_DIRECTION_OFFSET(a0),d7
	adda.w  #MOVER_FORWARD_VECTOR_OFFSET,a0
	CREATE2DVECTORFROMANGLE					 	     	; forward vector, normalized vector form of heading (forward_vector) (private)
	move.w (a0),d7
	asr.w #11-DECIMAL_SHIFT,d7
	move.w d7,(a0)
	move.w 2(a0),d7
	asr.w #11-DECIMAL_SHIFT,d7
	move.w d7,2(a0)
	suba.w  #MOVER_FORWARD_VECTOR_OFFSET,a0

	move.w  #CAR1_ENGINE_POWER,MOVER_ENGINE_POWER_OFFSET(a0) 	  	 	; engine power , high number means the car will reach max speed faster (engine_power)
	move.w 	#CAR1_MAX_SPEED,MOVER_MAX_SPEED_OFFSET(a0) 	  		 	; max speed of the car, limit maximum amount of movement pixel for each frame (max_speed)

	move.w  #CAR_BRAKE,MOVER_BRAKE_COEFFICIENT_OFFSET(a0)	; brake coefficient, the higher the value, the strongest the brakes of the car (brake_factor)
	move.w  #CAR1_FRICTION,MOVER_FRICTION_COEFFICIENT_OFFSET(a0) ; friction coefficientl, the higher the value, the greater the gravity force (friction_factor) 

	; repulsion force to bounce a car when hits the wall (high value means big bounce)
	move.w  #CAR_BOUNCE_WALL_FORCE,d0
	neg.w   d0
	move.w  d0,MOVER_BOUNCE_WALL_OFFSET(a0)

	; input routine
	move.l  #CAR_CONTROL_6,INPUT_ROUTINE_OFFSET(a0)

	; car sprites address list
	move.l  #CAR5_0,CAR_SPRITES_LIST_OFFSET_0(a0)
    move.l  #CAR5_345,CAR_SPRITES_LIST_OFFSET_1(a0)
    move.l  #CAR5_330,CAR_SPRITES_LIST_OFFSET_2(a0)
    move.l  #CAR5_315,CAR_SPRITES_LIST_OFFSET_3(a0)
    move.l  #CAR5_300,CAR_SPRITES_LIST_OFFSET_4(a0)
    move.l  #CAR5_285,CAR_SPRITES_LIST_OFFSET_5(a0)
    move.l  #CAR5_270,CAR_SPRITES_LIST_OFFSET_6(a0)
    move.l  #CAR5_255,CAR_SPRITES_LIST_OFFSET_7(a0)
    move.l  #CAR5_240,CAR_SPRITES_LIST_OFFSET_8(a0)
	move.l  #CAR5_225,CAR_SPRITES_LIST_OFFSET_9(a0)
	move.l  #CAR5_210,CAR_SPRITES_LIST_OFFSET_10(a0)
	move.l  #CAR5_195,CAR_SPRITES_LIST_OFFSET_11(a0)
	move.l  #CAR5_180,CAR_SPRITES_LIST_OFFSET_12(a0)
	move.l  #CAR5_165,CAR_SPRITES_LIST_OFFSET_13(a0)
	move.l  #CAR5_150,CAR_SPRITES_LIST_OFFSET_14(a0)
	move.l  #CAR5_135,CAR_SPRITES_LIST_OFFSET_15(a0)
	move.l  #CAR5_120,CAR_SPRITES_LIST_OFFSET_16(a0)
	move.l  #CAR5_105,CAR_SPRITES_LIST_OFFSET_17(a0)
	move.l  #CAR5_90,CAR_SPRITES_LIST_OFFSET_18(a0)
	move.l  #CAR5_75,CAR_SPRITES_LIST_OFFSET_19(a0)
	move.l  #CAR5_60,CAR_SPRITES_LIST_OFFSET_20(a0)
	move.l  #CAR5_45,CAR_SPRITES_LIST_OFFSET_21(a0)
	move.l  #CAR5_30,CAR_SPRITES_LIST_OFFSET_22(a0)
	move.l  #CAR5_15,CAR_SPRITES_LIST_OFFSET_23(a0)
	move.l  #CAR5_0,CAR_SPRITES_LIST_OFFSET_24(a0)

	move.l	#Sprite3pointers,CAR_SPRITE_POINTER_OFFSET(a0)

	IFD SOUND
	move.l  #MCLAREN_SND,MOTOR_SAMPLE_OFFSET(a0)
	move.l  #$dff0b0,AUDIO_CHANNEL_ADDRESS_OFFSET(a0)
	move.w  #%0000000000000010,AUDIO_CHANNEL_DMA_BIT(a0)
	move.w  #GROUP_2_SAMPLE_RATE,MOVER_SAMPLE_RATE(a0)
	move.w  #GROUP_2_SOUNDWAVE_SIZE_WORDS,MOVER_SOUNDWAVE_SIZE_WORDS(a0)
	ENDC
	move.l #MOVERS2,MOVER_TEAMMATE_CAR_PTR(a0)

	clr.w  MOVER_HEADING_MAGNITUDE(a0)
	clr.w  MOVER_CPU_CONSECUTIVE_COLLISIONS(a0)
	move.w #26390,MOVER_IMG_SIZE(a0)

	; hud position
	move.w	#CAR6_HUD_X_POSITION,HUD_POSITION_X(a0)
	move.w	#(1+8)*40,HUD_POSITION_Y(a0)

	jsr		CALCULATE_WHEEL_POSITIONS

	rts

CAR7_INIT:
	jsr		SET_CAR7_START_STATUS
	lea 	MOVER7,a0

	move.l  #PLAYER_SEVEN_NAME,MOVER_PLAYER_NAME_ADDR(a0)					; Car player name
	move.l  #PLAYER_THREE_SEVEN_TEAM,MOVER_PLAYER_TEAM_ADDR(a0)

	move.w 	#6,CAR_ID_OFFSET(a0)										; Car unique identifier

	move.w  #CAR1_WHEEL_BASE_LENGTH,MOVER_WHEEL_BASE_OFFSET(a0)     	; distance between 2 wheels in pixels (wheel_base)
	move.w  #CAR1_WHEEL_BASE_LENGTH/2,MOVER_WHEEL_BASE_DIV_2_OFFSET(a0)     	; distance between 2 wheels in pixels (wheel_base) divided by 2
	move.w  #CAR_HALF_WIDTH,MOVER_WIDTH_DIV_2_OFFSET(a0)

	move.w  #CAR_STEERING_ANGLE,MOVER_STEERING_ANGLE_OFFSET(a0)   	 	; how many degrees the car can steer at each frame? (steering angle)

	; calculate forward vector
	move.w  MOVER_STEER_DIRECTION_OFFSET(a0),d7
	adda.w  #MOVER_FORWARD_VECTOR_OFFSET,a0
	CREATE2DVECTORFROMANGLE					 	     	; forward vector, normalized vector form of heading (forward_vector) (private)
	move.w (a0),d7
	asr.w #11-DECIMAL_SHIFT,d7
	move.w d7,(a0)
	move.w 2(a0),d7
	asr.w #11-DECIMAL_SHIFT,d7
	move.w d7,2(a0)
	suba.w  #MOVER_FORWARD_VECTOR_OFFSET,a0

	move.w  #CAR1_ENGINE_POWER,MOVER_ENGINE_POWER_OFFSET(a0) 	  	 	; engine power , high number means the car will reach max speed faster (engine_power)
	move.w 	#CAR1_MAX_SPEED,MOVER_MAX_SPEED_OFFSET(a0) 	  		 	; max speed of the car, limit maximum amount of movement pixel for each frame (max_speed)

	move.w  #CAR_BRAKE,MOVER_BRAKE_COEFFICIENT_OFFSET(a0)	; brake coefficient, the higher the value, the strongest the brakes of the car (brake_factor)
	move.w  #CAR1_FRICTION,MOVER_FRICTION_COEFFICIENT_OFFSET(a0) ; friction coefficientl, the higher the value, the greater the gravity force (friction_factor) 

	; repulsion force to bounce a car when hits the wall (high value means big bounce)
	move.w  #CAR_BOUNCE_WALL_FORCE,d0
	neg.w   d0
	move.w  d0,MOVER_BOUNCE_WALL_OFFSET(a0)

	; input routine
	move.l  #CAR_CONTROL_7,INPUT_ROUTINE_OFFSET(a0)

	; car sprites address list
	move.l  #CAR6_0,CAR_SPRITES_LIST_OFFSET_0(a0)
    move.l  #CAR6_345,CAR_SPRITES_LIST_OFFSET_1(a0)
    move.l  #CAR6_330,CAR_SPRITES_LIST_OFFSET_2(a0)
    move.l  #CAR6_315,CAR_SPRITES_LIST_OFFSET_3(a0)
    move.l  #CAR6_300,CAR_SPRITES_LIST_OFFSET_4(a0)
    move.l  #CAR6_285,CAR_SPRITES_LIST_OFFSET_5(a0)
    move.l  #CAR6_270,CAR_SPRITES_LIST_OFFSET_6(a0)
    move.l  #CAR6_255,CAR_SPRITES_LIST_OFFSET_7(a0)
    move.l  #CAR6_240,CAR_SPRITES_LIST_OFFSET_8(a0)
	move.l  #CAR6_225,CAR_SPRITES_LIST_OFFSET_9(a0)
	move.l  #CAR6_210,CAR_SPRITES_LIST_OFFSET_10(a0)
	move.l  #CAR6_195,CAR_SPRITES_LIST_OFFSET_11(a0)
	move.l  #CAR6_180,CAR_SPRITES_LIST_OFFSET_12(a0)
	move.l  #CAR6_165,CAR_SPRITES_LIST_OFFSET_13(a0)
	move.l  #CAR6_150,CAR_SPRITES_LIST_OFFSET_14(a0)
	move.l  #CAR6_135,CAR_SPRITES_LIST_OFFSET_15(a0)
	move.l  #CAR6_120,CAR_SPRITES_LIST_OFFSET_16(a0)
	move.l  #CAR6_105,CAR_SPRITES_LIST_OFFSET_17(a0)
	move.l  #CAR6_90,CAR_SPRITES_LIST_OFFSET_18(a0)
	move.l  #CAR6_75,CAR_SPRITES_LIST_OFFSET_19(a0)
	move.l  #CAR6_60,CAR_SPRITES_LIST_OFFSET_20(a0)
	move.l  #CAR6_45,CAR_SPRITES_LIST_OFFSET_21(a0)
	move.l  #CAR6_30,CAR_SPRITES_LIST_OFFSET_22(a0)
	move.l  #CAR6_15,CAR_SPRITES_LIST_OFFSET_23(a0)
	move.l  #CAR6_0,CAR_SPRITES_LIST_OFFSET_24(a0)

	move.l	#Sprite5pointers,CAR_SPRITE_POINTER_OFFSET(a0)

	IFD SOUND
	move.l  #RENAULT_SND,MOTOR_SAMPLE_OFFSET(a0)
	move.l  #$dff0c0,AUDIO_CHANNEL_ADDRESS_OFFSET(a0)
	move.w  #%0000000000000100,AUDIO_CHANNEL_DMA_BIT(a0)
	move.w  #GROUP_3_SAMPLE_RATE,MOVER_SAMPLE_RATE(a0)
	move.w  #GROUP_3_SOUNDWAVE_SIZE_WORDS,MOVER_SOUNDWAVE_SIZE_WORDS(a0)
	ENDC
	move.l #MOVER3,MOVER_TEAMMATE_CAR_PTR(a0)

	clr.w  MOVER_HEADING_MAGNITUDE(a0)
	clr.w  MOVER_CPU_CONSECUTIVE_COLLISIONS(a0)
	move.w #19231,MOVER_IMG_SIZE(a0)

	; hud position
	move.w	#CAR7_HUD_X_POSITION,HUD_POSITION_X(a0)
	move.w	#(1+8)*40,HUD_POSITION_Y(a0)

	jsr		CALCULATE_WHEEL_POSITIONS

	rts

CAR8_INIT:
	jsr		SET_CAR8_START_STATUS
	lea 	MOVER8,a0

	move.l  #PLAYER_EIGHT_NAME,MOVER_PLAYER_NAME_ADDR(a0)					; Car player name
	move.l  #PLAYER_FOUR_EIGHT_TEAM,MOVER_PLAYER_TEAM_ADDR(a0)

	move.w 	#7,CAR_ID_OFFSET(a0)										; Car unique identifier

	move.w  #CAR1_WHEEL_BASE_LENGTH,MOVER_WHEEL_BASE_OFFSET(a0)     	; distance between 2 wheels in pixels (wheel_base)
	move.w  #CAR1_WHEEL_BASE_LENGTH/2,MOVER_WHEEL_BASE_DIV_2_OFFSET(a0)     	; distance between 2 wheels in pixels (wheel_base) divided by 2
	move.w  #CAR_HALF_WIDTH,MOVER_WIDTH_DIV_2_OFFSET(a0)

	move.w  #CAR_STEERING_ANGLE,MOVER_STEERING_ANGLE_OFFSET(a0)   	 	; how many degrees the car can steer at each frame? (steering angle)

	; calculate forward vector
	move.w  MOVER_STEER_DIRECTION_OFFSET(a0),d7
	adda.w  #MOVER_FORWARD_VECTOR_OFFSET,a0
	CREATE2DVECTORFROMANGLE					 	     	; forward vector, normalized vector form of heading (forward_vector) (private)
	move.w (a0),d7
	asr.w #11-DECIMAL_SHIFT,d7
	move.w d7,(a0)
	move.w 2(a0),d7
	asr.w #11-DECIMAL_SHIFT,d7
	move.w d7,2(a0)
	suba.w  #MOVER_FORWARD_VECTOR_OFFSET,a0

	move.w  #CAR1_ENGINE_POWER,MOVER_ENGINE_POWER_OFFSET(a0) 	  	 	; engine power , high number means the car will reach max speed faster (engine_power)
	move.w 	#CAR1_MAX_SPEED,MOVER_MAX_SPEED_OFFSET(a0) 	  		 	; max speed of the car, limit maximum amount of movement pixel for each frame (max_speed)

	move.w  #CAR_BRAKE,MOVER_BRAKE_COEFFICIENT_OFFSET(a0)	; brake coefficient, the higher the value, the strongest the brakes of the car (brake_factor)
	move.w  #CAR1_FRICTION,MOVER_FRICTION_COEFFICIENT_OFFSET(a0) ; friction coefficientl, the higher the value, the greater the gravity force (friction_factor) 

	; repulsion force to bounce a car when hits the wall (high value means big bounce)
	move.w  #CAR_BOUNCE_WALL_FORCE,d0
	neg.w   d0
	move.w  d0,MOVER_BOUNCE_WALL_OFFSET(a0)

	; input routine
	move.l  #CAR_CONTROL_8,INPUT_ROUTINE_OFFSET(a0)

	; car sprites address list
	move.l  #CAR7_0,CAR_SPRITES_LIST_OFFSET_0(a0)
    move.l  #CAR7_345,CAR_SPRITES_LIST_OFFSET_1(a0)
    move.l  #CAR7_330,CAR_SPRITES_LIST_OFFSET_2(a0)
    move.l  #CAR7_315,CAR_SPRITES_LIST_OFFSET_3(a0)
    move.l  #CAR7_300,CAR_SPRITES_LIST_OFFSET_4(a0)
    move.l  #CAR7_285,CAR_SPRITES_LIST_OFFSET_5(a0)
    move.l  #CAR7_270,CAR_SPRITES_LIST_OFFSET_6(a0)
    move.l  #CAR7_255,CAR_SPRITES_LIST_OFFSET_7(a0)
    move.l  #CAR7_240,CAR_SPRITES_LIST_OFFSET_8(a0)
	move.l  #CAR7_225,CAR_SPRITES_LIST_OFFSET_9(a0)
	move.l  #CAR7_210,CAR_SPRITES_LIST_OFFSET_10(a0)
	move.l  #CAR7_195,CAR_SPRITES_LIST_OFFSET_11(a0)
	move.l  #CAR7_180,CAR_SPRITES_LIST_OFFSET_12(a0)
	move.l  #CAR7_165,CAR_SPRITES_LIST_OFFSET_13(a0)
	move.l  #CAR7_150,CAR_SPRITES_LIST_OFFSET_14(a0)
	move.l  #CAR7_135,CAR_SPRITES_LIST_OFFSET_15(a0)
	move.l  #CAR7_120,CAR_SPRITES_LIST_OFFSET_16(a0)
	move.l  #CAR7_105,CAR_SPRITES_LIST_OFFSET_17(a0)
	move.l  #CAR7_90,CAR_SPRITES_LIST_OFFSET_18(a0)
	move.l  #CAR7_75,CAR_SPRITES_LIST_OFFSET_19(a0)
	move.l  #CAR7_60,CAR_SPRITES_LIST_OFFSET_20(a0)
	move.l  #CAR7_45,CAR_SPRITES_LIST_OFFSET_21(a0)
	move.l  #CAR7_30,CAR_SPRITES_LIST_OFFSET_22(a0)
	move.l  #CAR7_15,CAR_SPRITES_LIST_OFFSET_23(a0)
	move.l  #CAR7_0,CAR_SPRITES_LIST_OFFSET_24(a0)

	move.l	#Sprite7pointers,CAR_SPRITE_POINTER_OFFSET(a0)

	IFD SOUND
	move.l  #ALFAMARAMEO_SND,MOTOR_SAMPLE_OFFSET(a0)
	move.l  #$dff0d0,AUDIO_CHANNEL_ADDRESS_OFFSET(a0)
	move.w  #%0000000000001000,AUDIO_CHANNEL_DMA_BIT(a0)
	move.w  #GROUP_4_SAMPLE_RATE,MOVER_SAMPLE_RATE(a0)
	move.w  #GROUP_4_SOUNDWAVE_SIZE_WORDS,MOVER_SOUNDWAVE_SIZE_WORDS(a0)
	ENDC
	move.l #MOVER4,MOVER_TEAMMATE_CAR_PTR(a0)

	clr.w  MOVER_HEADING_MAGNITUDE(a0)
	clr.w  MOVER_CPU_CONSECUTIVE_COLLISIONS(a0)
	move.w #18817,MOVER_IMG_SIZE(a0)

	; hud position
	move.w	#CAR8_HUD_X_POSITION,HUD_POSITION_X(a0)
	move.w	#(1+8)*40,HUD_POSITION_Y(a0)

	jsr		CALCULATE_WHEEL_POSITIONS

	rts