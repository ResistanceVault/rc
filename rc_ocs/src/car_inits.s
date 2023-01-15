; Init car 1

CAR1_MAX_SPEED 		EQU %0001100000000000 ; 1.5 pixels per frame of max speed
CAR1_ENGINE_POWER 	EQU 16
CAR1_FRICTION		EQU %10000000
CAR_BRAKE			EQU %100000000
CAR1_STEERING_ANGLE EQU 2
CAR1_WHEEL_BASE_LENGTH EQU 6
CAR_BOUNCE_WALL_FORCE EQU %0000101000000000

TRACK_START_PIXEL_DATA:
	dc.w %10110000

CAR1_INIT:
	lea 	MOVER1,a0

	move.w 	#0,CAR_ID_OFFSET(a0)										; Car unique identifier

	move.w 	#100*DECIMAL_MULTIPLIER,MOVER_X_POSITION_OFFSET(a0) 	 	; initial x position (position)
	move.w 	#200*DECIMAL_MULTIPLIER,MOVER_Y_POSITION_OFFSET(a0) 	 	; initial y position (position)

	move.w  #0*DECIMAL_MULTIPLIER/2,MOVER_X_VELOCITY_OFFSET(a0)   	 	; initial x velocity (velocity)
	move.w  #0*DECIMAL_MULTIPLIER/2,MOVER_Y_VELOCITY_OFFSET(a0)   	 	; initial y velocity (velocity)

	move.w  #0*DECIMAL_MULTIPLIER,MOVER_X_ACCELERATION_OFFSET(a0)   	; initial x accelleration (accelleration)
	move.w  #0*DECIMAL_MULTIPLIER,MOVER_Y_ACCELERATION_OFFSET(a0)   	; initial y accelleration (accelleration)

	move.w  #CAR1_WHEEL_BASE_LENGTH,MOVER_WHEEL_BASE_OFFSET(a0)     	; distance between 2 wheels in pixels (wheel_base)
	move.w  #CAR1_STEERING_ANGLE,MOVER_STEERING_ANGLE_OFFSET(a0)   	 	; how many degrees the car can steer at each frame? (steering angle)
	move.l  #0,MOVER_HEADING_OFFSET(a0)		 	  	 	; vector representing heading direction (heading) (private)

	move.w  #0,MOVER_STEER_DIRECTION_OFFSET(a0) 	 	; where the car should point at the beginning (degrees)? (steer_direction) (range 0-359)

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

	move.w  #0,MOVER_IS_ACCELERATING_OFFSET(a0) 	 	; if 0 means the car is not accellerating (is_accellerating) (private)
	move.w  #0,MOVER_IS_BRAKING_OFFSET(a0) 	  		 	; if 0 means the car is not braking (is_braking) (private)
	move.w  #0,MOVER_IS_COLLIDING_OFFSET(a0) 	  	 	; if 0 means the car is not colliding (is_colliding) (private)

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

	move.w	#1,CAR_NEXT_ZONE_OFFSET(a0)

	move.w 	#0,LAP_COUNTER_OFFSET(a0) ; race starts at lap number zero

	move.w  #0,TIME_OFFSET(a0) ; time starts at zero
	move.w  #$FFFF,BEST_TIME_OFFSET(a0) ; best time starts at max to allow first lap to be the best

	; input routine
	move.l  #READJOY1,INPUT_ROUTINE_OFFSET(a0)

	; car sprites address list
	move.l  #CAR_0,CAR_SPRITES_LIST_OFFSET_0(a0)
    move.l  #CAR_315,CAR_SPRITES_LIST_OFFSET_1(a0)
    move.l  #CAR_270,CAR_SPRITES_LIST_OFFSET_2(a0)
    move.l  #CAR_215,CAR_SPRITES_LIST_OFFSET_3(a0)
    move.l  #CAR_180,CAR_SPRITES_LIST_OFFSET_4(a0)
    move.l  #CAR_135,CAR_SPRITES_LIST_OFFSET_5(a0)
    move.l  #CAR_90,CAR_SPRITES_LIST_OFFSET_6(a0)
    move.l  #CAR_45,CAR_SPRITES_LIST_OFFSET_7(a0)
    move.l  #CAR_0,CAR_SPRITES_LIST_OFFSET_8(a0)
	move.l	#Sprite0pointers,CAR_SPRITE_POINTER_OFFSET(a0)

	IFD SOUND
	move.l  #MOTOR1_SND,MOTOR_SAMPLE_OFFSET(a0)
	move.l  #$dff0a0,AUDIO_CHANNEL_ADDRESS_OFFSET(a0)
	move.w  #%0000000000000001,AUDIO_CHANNEL_DMA_BIT(a0)
	ENDC

	jsr		CALCULATE_WHEEL_POSITIONS

	rts

CAR2_INIT:
	lea 	MOVER2,a0

	move.w 	#1,CAR_ID_OFFSET(a0)										; Car unique identifier

	move.w 	#120*DECIMAL_MULTIPLIER,MOVER_X_POSITION_OFFSET(a0) 	 	; initial x position (position)
	move.w 	#200*DECIMAL_MULTIPLIER,MOVER_Y_POSITION_OFFSET(a0) 	 	; initial y position (position)

	move.w  #0*DECIMAL_MULTIPLIER/2,MOVER_X_VELOCITY_OFFSET(a0)   	 	; initial x velocity (velocity)
	move.w  #0*DECIMAL_MULTIPLIER/2,MOVER_Y_VELOCITY_OFFSET(a0)   	 	; initial y velocity (velocity)

	move.w  #0*DECIMAL_MULTIPLIER,MOVER_X_ACCELERATION_OFFSET(a0)   	; initial x accelleration (accelleration)
	move.w  #0*DECIMAL_MULTIPLIER,MOVER_Y_ACCELERATION_OFFSET(a0)   	; initial y accelleration (accelleration)

	move.w  #CAR1_WHEEL_BASE_LENGTH,MOVER_WHEEL_BASE_OFFSET(a0)     	; distance between 2 wheels in pixels (wheel_base)
	move.w  #CAR1_STEERING_ANGLE,MOVER_STEERING_ANGLE_OFFSET(a0)   	 	; how many degrees the car can steer at each frame? (steering angle)
	move.l  #0,MOVER_HEADING_OFFSET(a0)		 	  	 	; vector representing heading direction (heading) (private)

	move.w  #0,MOVER_STEER_DIRECTION_OFFSET(a0) 	 	; where the car should point at the beginning (degrees)? (steer_direction) (range 0-359)

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

	move.w  #0,MOVER_IS_ACCELERATING_OFFSET(a0) 	 	; if 0 means the car is not accellerating (is_accellerating) (private)
	move.w  #0,MOVER_IS_BRAKING_OFFSET(a0) 	  		 	; if 0 means the car is not braking (is_braking) (private)
	move.w  #0,MOVER_IS_COLLIDING_OFFSET(a0) 	  	 	; if 0 means the car is not colliding (is_colliding) (private)

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

	move.w	#1,CAR_NEXT_ZONE_OFFSET(a0)

	move.w 	#0,LAP_COUNTER_OFFSET(a0) ; race starts at lap number zero

	move.w  #0,TIME_OFFSET(a0) ; time starts at zero
	move.w  #$FFFF,BEST_TIME_OFFSET(a0) ; best time starts at max to allow first lap to be the best

	; input routine
	move.l  #KEYBOARD_WASD,INPUT_ROUTINE_OFFSET(a0)

	; car sprites address list
	move.l  #CAR1_0,CAR_SPRITES_LIST_OFFSET_0(a0)
    move.l  #CAR1_315,CAR_SPRITES_LIST_OFFSET_1(a0)
    move.l  #CAR1_270,CAR_SPRITES_LIST_OFFSET_2(a0)
    move.l  #CAR1_215,CAR_SPRITES_LIST_OFFSET_3(a0)
    move.l  #CAR1_180,CAR_SPRITES_LIST_OFFSET_4(a0)
    move.l  #CAR1_135,CAR_SPRITES_LIST_OFFSET_5(a0)
    move.l  #CAR1_90,CAR_SPRITES_LIST_OFFSET_6(a0)
    move.l  #CAR1_45,CAR_SPRITES_LIST_OFFSET_7(a0)
    move.l  #CAR1_0,CAR_SPRITES_LIST_OFFSET_8(a0)
	move.l	#Sprite2pointers,CAR_SPRITE_POINTER_OFFSET(a0)

	IFD SOUND
	move.l  #MOTOR1_SND,MOTOR_SAMPLE_OFFSET(a0)
	move.l  #$dff0b0,AUDIO_CHANNEL_ADDRESS_OFFSET(a0)
	move.w  #%0000000000000010,AUDIO_CHANNEL_DMA_BIT(a0)
	ENDC

	jsr		CALCULATE_WHEEL_POSITIONS

	rts