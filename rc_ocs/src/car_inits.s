; Init car 1

CAR1_MAX_SPEED 		EQU %0001100000000000 ; 1.5 pixels per frame of max speed
CAR1_ENGINE_POWER 	EQU %1001
CAR1_FRICTION		EQU %10000000
CAR1_STEERING_ANGLE EQU 2
CAR1_WHEEL_BASE_LENGTH EQU 6

CAR1_INIT:
	lea 	MOVER1,a0
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

	move.w  #1*DECIMAL_MULTIPLIER/20,MOVER_BRAKE_COEFFICIENT_OFFSET(a0)	; brake coefficient, the higher the value, the strongest the brakes of the car (brake_factor)
	move.w  #CAR1_FRICTION,MOVER_FRICTION_COEFFICIENT_OFFSET(a0) ; friction coefficientl, the higher the value, the greater the gravity force (friction_factor) 

	jsr		CALCULATE_WHEEL_POSITIONS
	rts