; Init car 1

CAR1_MAX_SPEED 		EQU %0001100000000000 ; 1.5 pixels per frame of max speed
CAR1_ENGINE_POWER 	EQU 16
CAR1_FRICTION		EQU %10000000
CAR_BRAKE			EQU %100000000
CAR1_WHEEL_BASE_LENGTH EQU 6
CAR_BOUNCE_WALL_FORCE EQU %0000101000000000
CAR_STEERING_ANGLE	EQU 2
CAR_HALF_WIDTH		EQU 6

PLAYER_ONE_NAME: 	dc.b "A CROST    ",$FF ; perrari
PLAYER_FIVE_NAME: 	dc.b "ALBERETTO  ",$FF ; perrari
PLAYER_TWO_NAME: 	dc.b "JJ LENTO   ",$FF ; alfa marameo
PLAYER_FOUR_NAME: 	dc.b "M PALLADIO ",$FF ; alfa maraneo
PLAYER_SIX_NAME: 	dc.b "BAGNACAUDA ",$FF ; perault
PLAYER_SEVEN_NAME: 	dc.b "FRITTICALDI",$FF ; perault
PLAYER_EIGHT_NAME: 	dc.b "R PRETESE  ",$FF ; mc lallen
PLAYER_THREE_NAME: 	dc.b "STARNOUX   ",$FF ; mc lallen

TRACK_START_PIXEL_DATA:
	dc.w %10110000

CAR1_INIT:
	jsr 	SET_CAR1_START_STATUS
	lea 	MOVER1,a0

	move.l  #PLAYER_ONE_NAME,MOVER_PLAYER_NAME_ADDR(a0)					; Car player name

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

	move.w  TRACK_START_PIXEL_DATA,CAR_FRONT_WHEEL_TRACK_PIXEL_DATA_OFFSET(a0) ; put here  in the high nibble the last track zone 
																			   ; and in the low nibble 0 for asphalt 1 for grass or 2 for ice
																   			   ; because when the race starts, all car must be placed 
																			   ; on the last zone

	; input routine
	move.l  #READJOY1,INPUT_ROUTINE_OFFSET(a0)

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
	move.l  #MOTOR1_SND,MOTOR_SAMPLE_OFFSET(a0)
	move.l  #$dff0a0,AUDIO_CHANNEL_ADDRESS_OFFSET(a0)
	move.w  #%0000000000000001,AUDIO_CHANNEL_DMA_BIT(a0)
	ENDC

	jsr		CALCULATE_WHEEL_POSITIONS

	rts

CAR2_INIT:
	jsr 	SET_CAR2_START_STATUS
	lea 	MOVER2,a0

	move.l  #PLAYER_TWO_NAME,MOVER_PLAYER_NAME_ADDR(a0)					; Car player name

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

	move.w  TRACK_START_PIXEL_DATA,CAR_FRONT_WHEEL_TRACK_PIXEL_DATA_OFFSET(a0) ; put here  in the high nibble the last track zone 
																			   ; and in the low nibble 0 for asphalt 1 for grass or 2 for ice
																   			   ; because when the race starts, all car must be placed 
																			   ; on the last zone
	; input routine
	move.l  #KEYBOARD_WASD,INPUT_ROUTINE_OFFSET(a0)

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
	move.l  #MOTOR1_SND,MOTOR_SAMPLE_OFFSET(a0)
	move.l  #$dff0b0,AUDIO_CHANNEL_ADDRESS_OFFSET(a0)
	move.w  #%0000000000000010,AUDIO_CHANNEL_DMA_BIT(a0)
	ENDC

	jsr		CALCULATE_WHEEL_POSITIONS

	rts

CAR3_INIT:
	jsr		SET_CAR3_START_STATUS
	lea 	MOVER3,a0

	move.l  #PLAYER_THREE_NAME,MOVER_PLAYER_NAME_ADDR(a0)					; Car player name

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

	move.w  TRACK_START_PIXEL_DATA,CAR_FRONT_WHEEL_TRACK_PIXEL_DATA_OFFSET(a0) ; put here  in the high nibble the last track zone 
																			   ; and in the low nibble 0 for asphalt 1 for grass or 2 for ice
																   			   ; because when the race starts, all car must be placed 
																			   ; on the last zone
	; input routine
	move.l  #KEYBOARD_IJKL,INPUT_ROUTINE_OFFSET(a0)

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
	move.l  #MOTOR1_SND,MOTOR_SAMPLE_OFFSET(a0)
	move.l  #$dff0c0,AUDIO_CHANNEL_ADDRESS_OFFSET(a0)
	move.w  #%0000000000000100,AUDIO_CHANNEL_DMA_BIT(a0)
	ENDC

	jsr		CALCULATE_WHEEL_POSITIONS

	rts

CAR4_INIT:
	jsr		SET_CAR4_START_STATUS
	lea 	MOVER4,a0

	move.l  #PLAYER_FOUR_NAME,MOVER_PLAYER_NAME_ADDR(a0)					; Car player name

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

	move.w  TRACK_START_PIXEL_DATA,CAR_FRONT_WHEEL_TRACK_PIXEL_DATA_OFFSET(a0) ; put here  in the high nibble the last track zone 
																			   ; and in the low nibble 0 for asphalt 1 for grass or 2 for ice
																   			   ; because when the race starts, all car must be placed 
																			   ; on the last zone
	; input routine
	move.l  #KEYBOARD_ARROWS,INPUT_ROUTINE_OFFSET(a0)

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
	move.l  #MOTOR1_SND,MOTOR_SAMPLE_OFFSET(a0)
	move.l  #$dff0d0,AUDIO_CHANNEL_ADDRESS_OFFSET(a0)
	move.w  #%0000000000001000,AUDIO_CHANNEL_DMA_BIT(a0)
	ENDC

	jsr		CALCULATE_WHEEL_POSITIONS

	rts