CAR1_START_X_POSITION: dc.w 100
CAR1_START_Y_POSITION: dc.w 200

CAR2_START_X_POSITION: dc.w 120
CAR2_START_Y_POSITION: dc.w 200

CAR3_START_X_POSITION: dc.w 80
CAR3_START_Y_POSITION: dc.w 200

CAR4_START_X_POSITION: dc.w 60
CAR4_START_Y_POSITION: dc.w 200

SET_CAR1_START_STATUS:
    lea 	MOVER1,a0

    move.w  #DECIMAL_MULTIPLIER,d0
    muls    CAR1_START_X_POSITION,d0
    move.w 	d0,MOVER_X_POSITION_OFFSET(a0) 	 	; initial x position (position)

    move.w  #DECIMAL_MULTIPLIER,d0
    muls    CAR1_START_Y_POSITION,d0
	move.w 	d0,MOVER_Y_POSITION_OFFSET(a0) 	 	; initial y position (position)

    move.w  #0*DECIMAL_MULTIPLIER/2,MOVER_X_VELOCITY_OFFSET(a0)   	 	; initial x velocity (velocity)
	move.w  #0*DECIMAL_MULTIPLIER/2,MOVER_Y_VELOCITY_OFFSET(a0)   	 	; initial y velocity (velocity)

	move.w  #0*DECIMAL_MULTIPLIER,MOVER_X_ACCELERATION_OFFSET(a0)   	; initial x acceleration (accelleration)
	move.w  #0*DECIMAL_MULTIPLIER,MOVER_Y_ACCELERATION_OFFSET(a0)   	; initial y acceleration (accelleration)

    move.l  #0,MOVER_HEADING_OFFSET(a0)		 	  	 	; vector representing heading direction (heading) (private)
	move.w  #0,MOVER_STEER_DIRECTION_OFFSET(a0) 	 	; where the car should point at the beginning (degrees)? (steer_direction) (range 0-359)

    move.w  #0,MOVER_IS_ACCELERATING_OFFSET(a0) 	 	; if 0 means the car is not accellerating (is_accellerating) (private)
	move.w  #0,MOVER_IS_BRAKING_OFFSET(a0) 	  		 	; if 0 means the car is not braking (is_braking) (private)
	move.w  #0,MOVER_IS_COLLIDING_OFFSET(a0) 	  	 	; if 0 means the car is not colliding (is_colliding) (private)

    move.w	#1,CAR_NEXT_ZONE_OFFSET(a0)

	move.w 	#0,LAP_COUNTER_OFFSET(a0) ; race starts at lap number zero

	move.w  #0,TIME_OFFSET(a0) ; time starts at zero
	move.w  #$FFFF,BEST_TIME_OFFSET(a0) ; best time starts at max to allow first lap to be the best

    move.w  #$FFFF,RACE_COMPLETED_OFFSET(a0) ; race is not completed for this car

    rts


SET_CAR2_START_STATUS:
    lea 	MOVER2,a0

    move.w  #DECIMAL_MULTIPLIER,d0
    muls    CAR2_START_X_POSITION,d0
    move.w 	d0,MOVER_X_POSITION_OFFSET(a0) 	 	; initial x position (position)

    move.w  #DECIMAL_MULTIPLIER,d0
    muls    CAR2_START_Y_POSITION,d0
	move.w 	d0,MOVER_Y_POSITION_OFFSET(a0) 	 	; initial y position (position)

    move.w  #0*DECIMAL_MULTIPLIER/2,MOVER_X_VELOCITY_OFFSET(a0)   	 	; initial x velocity (velocity)
	move.w  #0*DECIMAL_MULTIPLIER/2,MOVER_Y_VELOCITY_OFFSET(a0)   	 	; initial y velocity (velocity)

	move.w  #0*DECIMAL_MULTIPLIER,MOVER_X_ACCELERATION_OFFSET(a0)   	; initial x acceleration (accelleration)
	move.w  #0*DECIMAL_MULTIPLIER,MOVER_Y_ACCELERATION_OFFSET(a0)   	; initial y acceleration (accelleration)

    move.l  #0,MOVER_HEADING_OFFSET(a0)		 	  	 	; vector representing heading direction (heading) (private)
	move.w  #0,MOVER_STEER_DIRECTION_OFFSET(a0) 	 	; where the car should point at the beginning (degrees)? (steer_direction) (range 0-359)

    move.w  #0,MOVER_IS_ACCELERATING_OFFSET(a0) 	 	; if 0 means the car is not accellerating (is_accellerating) (private)
	move.w  #0,MOVER_IS_BRAKING_OFFSET(a0) 	  		 	; if 0 means the car is not braking (is_braking) (private)
	move.w  #0,MOVER_IS_COLLIDING_OFFSET(a0) 	  	 	; if 0 means the car is not colliding (is_colliding) (private)

    move.w	#1,CAR_NEXT_ZONE_OFFSET(a0)

	move.w 	#0,LAP_COUNTER_OFFSET(a0) ; race starts at lap number zero

	move.w  #0,TIME_OFFSET(a0) ; time starts at zero
	move.w  #$FFFF,BEST_TIME_OFFSET(a0) ; best time starts at max to allow first lap to be the best

    move.w  #$FFFF,RACE_COMPLETED_OFFSET(a0) ; race is not completed for this car

    rts

SET_CAR3_START_STATUS:
    lea 	MOVER3,a0

    move.w  #DECIMAL_MULTIPLIER,d0
    muls    CAR3_START_X_POSITION,d0
    move.w 	d0,MOVER_X_POSITION_OFFSET(a0) 	 	; initial x position (position)

    move.w  #DECIMAL_MULTIPLIER,d0
    muls    CAR3_START_Y_POSITION,d0
	move.w 	d0,MOVER_Y_POSITION_OFFSET(a0) 	 	; initial y position (position)

    move.w  #0*DECIMAL_MULTIPLIER/2,MOVER_X_VELOCITY_OFFSET(a0)   	 	; initial x velocity (velocity)
	move.w  #0*DECIMAL_MULTIPLIER/2,MOVER_Y_VELOCITY_OFFSET(a0)   	 	; initial y velocity (velocity)

	move.w  #0*DECIMAL_MULTIPLIER,MOVER_X_ACCELERATION_OFFSET(a0)   	; initial x acceleration (accelleration)
	move.w  #0*DECIMAL_MULTIPLIER,MOVER_Y_ACCELERATION_OFFSET(a0)   	; initial y acceleration (accelleration)

    move.l  #0,MOVER_HEADING_OFFSET(a0)		 	  	 	; vector representing heading direction (heading) (private)
	move.w  #0,MOVER_STEER_DIRECTION_OFFSET(a0) 	 	; where the car should point at the beginning (degrees)? (steer_direction) (range 0-359)

    move.w  #0,MOVER_IS_ACCELERATING_OFFSET(a0) 	 	; if 0 means the car is not accellerating (is_accellerating) (private)
	move.w  #0,MOVER_IS_BRAKING_OFFSET(a0) 	  		 	; if 0 means the car is not braking (is_braking) (private)
	move.w  #0,MOVER_IS_COLLIDING_OFFSET(a0) 	  	 	; if 0 means the car is not colliding (is_colliding) (private)

    move.w	#1,CAR_NEXT_ZONE_OFFSET(a0)

	move.w 	#0,LAP_COUNTER_OFFSET(a0) ; race starts at lap number zero

	move.w  #0,TIME_OFFSET(a0) ; time starts at zero
	move.w  #$FFFF,BEST_TIME_OFFSET(a0) ; best time starts at max to allow first lap to be the best

    move.w  #$FFFF,RACE_COMPLETED_OFFSET(a0) ; race is not completed for this car

    rts

SET_CAR4_START_STATUS:
    lea 	MOVER4,a0

    move.w  #DECIMAL_MULTIPLIER,d0
    muls    CAR4_START_X_POSITION,d0
    move.w 	d0,MOVER_X_POSITION_OFFSET(a0) 	 	; initial x position (position)

    move.w  #DECIMAL_MULTIPLIER,d0
    muls    CAR4_START_Y_POSITION,d0
	move.w 	d0,MOVER_Y_POSITION_OFFSET(a0) 	 	; initial y position (position)

    move.w  #0*DECIMAL_MULTIPLIER/2,MOVER_X_VELOCITY_OFFSET(a0)   	 	; initial x velocity (velocity)
	move.w  #0*DECIMAL_MULTIPLIER/2,MOVER_Y_VELOCITY_OFFSET(a0)   	 	; initial y velocity (velocity)

	move.w  #0*DECIMAL_MULTIPLIER,MOVER_X_ACCELERATION_OFFSET(a0)   	; initial x acceleration (accelleration)
	move.w  #0*DECIMAL_MULTIPLIER,MOVER_Y_ACCELERATION_OFFSET(a0)   	; initial y acceleration (accelleration)

    move.l  #0,MOVER_HEADING_OFFSET(a0)		 	  	 	; vector representing heading direction (heading) (private)
	move.w  #0,MOVER_STEER_DIRECTION_OFFSET(a0) 	 	; where the car should point at the beginning (degrees)? (steer_direction) (range 0-359)

    move.w  #0,MOVER_IS_ACCELERATING_OFFSET(a0) 	 	; if 0 means the car is not accellerating (is_accellerating) (private)
	move.w  #0,MOVER_IS_BRAKING_OFFSET(a0) 	  		 	; if 0 means the car is not braking (is_braking) (private)
	move.w  #0,MOVER_IS_COLLIDING_OFFSET(a0) 	  	 	; if 0 means the car is not colliding (is_colliding) (private)

    move.w	#1,CAR_NEXT_ZONE_OFFSET(a0)

	move.w 	#0,LAP_COUNTER_OFFSET(a0) ; race starts at lap number zero

	move.w  #0,TIME_OFFSET(a0) ; time starts at zero
	move.w  #$FFFF,BEST_TIME_OFFSET(a0) ; best time starts at max to allow first lap to be the best

    move.w  #$FFFF,RACE_COMPLETED_OFFSET(a0) ; race is not completed for this car

    rts