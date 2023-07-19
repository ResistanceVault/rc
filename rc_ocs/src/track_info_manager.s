CAR_INFO_DATA:
CAR1_INFO_DATA:
CAR1_START_X_POSITION: dc.w 100
CAR1_START_Y_POSITION: dc.w 200
CAR1_START_DEGREES: dc.w 0

CAR2_INFO_DATA:
CAR2_START_X_POSITION: dc.w 120
CAR2_START_Y_POSITION: dc.w 200
CAR2_START_DEGREES: dc.w 0

CAR3_INFO_DATA:
CAR3_START_X_POSITION: dc.w 80
CAR3_START_Y_POSITION: dc.w 200
CAR3_START_DEGREES: dc.w 0

CAR4_INFO_DATA:
CAR4_START_X_POSITION: dc.w 60
CAR4_START_Y_POSITION: dc.w 200
CAR4_START_DEGREES: dc.w 0

CAR5_INFO_DATA:
CAR5_START_X_POSITION: dc.w 60
CAR5_START_Y_POSITION: dc.w 200
CAR5_START_DEGREES: dc.w 0

CAR6_INFO_DATA:
CAR6_START_X_POSITION: dc.w 60
CAR6_START_Y_POSITION: dc.w 200
CAR6_START_DEGREES: dc.w 0

CAR7_INFO_DATA:
CAR7_START_X_POSITION: dc.w 60
CAR7_START_Y_POSITION: dc.w 200
CAR7_START_DEGREES: dc.w 0

CAR8_INFO_DATA:
CAR8_START_X_POSITION: dc.w 60
CAR8_START_Y_POSITION: dc.w 200
CAR8_START_DEGREES: dc.w 0

SET_CAR1_START_STATUS:
    lea 	MOVER1,a0

    move.w  #DECIMAL_MULTIPLIER,d0
    muls    CAR1_START_X_POSITION,d0
    move.w 	d0,MOVER_X_POSITION_OFFSET(a0) 	 	; initial x position (position)

    move.w  #DECIMAL_MULTIPLIER,d0
    muls    CAR1_START_Y_POSITION,d0
	move.w 	d0,MOVER_Y_POSITION_OFFSET(a0) 	 	; initial y position (position)

    move.w  CAR1_START_DEGREES,MOVER_STEER_DIRECTION_OFFSET(a0) 	 	; where the car should point at the beginning (degrees)? (steer_direction) (range 0-359)

    move.w  #0*DECIMAL_MULTIPLIER/2,MOVER_X_VELOCITY_OFFSET(a0)   	 	; initial x velocity (velocity)
	move.w  #0*DECIMAL_MULTIPLIER/2,MOVER_Y_VELOCITY_OFFSET(a0)   	 	; initial y velocity (velocity)

	move.w  #0*DECIMAL_MULTIPLIER,MOVER_X_ACCELERATION_OFFSET(a0)   	; initial x acceleration (accelleration)
	move.w  #0*DECIMAL_MULTIPLIER,MOVER_Y_ACCELERATION_OFFSET(a0)   	; initial y acceleration (accelleration)

    move.l  #0,MOVER_HEADING_OFFSET(a0)		 	  	 	; vector representing heading direction (heading) (private)

    move.w  #0,MOVER_IS_ACCELERATING_OFFSET(a0) 	 	; if 0 means the car is not accellerating (is_accellerating) (private)
	move.w  #0,MOVER_IS_BRAKING_OFFSET(a0) 	  		 	; if 0 means the car is not braking (is_braking) (private)
	move.w  #0,MOVER_IS_COLLIDING_OFFSET(a0) 	  	 	; if 0 means the car is not colliding (is_colliding) (private)
    clr.w   MOVER_HEADING_MAGNITUDE(a0)

    move.w	#1,CAR_NEXT_ZONE_OFFSET(a0)

	move.w 	#0,LAP_COUNTER_OFFSET(a0) ; race starts at lap number zero

	move.w  #0,TIME_OFFSET(a0) ; time starts at zero
    move.l  #PLAYER_1_TIMER_TXT,TIME_OFFSET_STR(a0)
    move.l  #$0,PLAYER_1_TIMER_TXT
    move.w  #$0,PLAYER_1_TIMER_TXT+4

	move.w  #$FFFF,BEST_TIME_OFFSET(a0) ; best time starts at max to allow first lap to be the best

    move.w  #$FFFF,RACE_COMPLETED_OFFSET(a0) ; race is not completed for this car

    move.l  #MOVER_DESTINATION,MOVER_HOTSPOT_CPU_PTR(a0)

    clr.w   MOVER_LEADING_LAPS(a0)

    move.w  TRACK_NUM_ZONES,CAR_FRONT_WHEEL_TRACK_PIXEL_DATA_OFFSET(a0) ; put here  in the high nibble the last track zone 
																			   ; and in the low nibble 0 for asphalt 1 for grass or 2 for ice
																   			   ; because when the race starts, all car must be placed 
																			   ; on the last zone

    rts


SET_CAR2_START_STATUS:
    lea 	MOVER2,a0

    move.w  #DECIMAL_MULTIPLIER,d0
    muls    CAR2_START_X_POSITION,d0
    move.w 	d0,MOVER_X_POSITION_OFFSET(a0) 	 	; initial x position (position)

    move.w  #DECIMAL_MULTIPLIER,d0
    muls    CAR2_START_Y_POSITION,d0
	move.w 	d0,MOVER_Y_POSITION_OFFSET(a0) 	 	; initial y position (position)

    move.w  CAR2_START_DEGREES,MOVER_STEER_DIRECTION_OFFSET(a0) 	 	; where the car should point at the beginning (degrees)? (steer_direction) (range 0-359)

    move.w  #0*DECIMAL_MULTIPLIER/2,MOVER_X_VELOCITY_OFFSET(a0)   	 	; initial x velocity (velocity)
	move.w  #0*DECIMAL_MULTIPLIER/2,MOVER_Y_VELOCITY_OFFSET(a0)   	 	; initial y velocity (velocity)

	move.w  #0*DECIMAL_MULTIPLIER,MOVER_X_ACCELERATION_OFFSET(a0)   	; initial x acceleration (accelleration)
	move.w  #0*DECIMAL_MULTIPLIER,MOVER_Y_ACCELERATION_OFFSET(a0)   	; initial y acceleration (accelleration)

    move.l  #0,MOVER_HEADING_OFFSET(a0)		 	  	 	; vector representing heading direction (heading) (private)

    move.w  #0,MOVER_IS_ACCELERATING_OFFSET(a0) 	 	; if 0 means the car is not accellerating (is_accellerating) (private)
	move.w  #0,MOVER_IS_BRAKING_OFFSET(a0) 	  		 	; if 0 means the car is not braking (is_braking) (private)
	move.w  #0,MOVER_IS_COLLIDING_OFFSET(a0) 	  	 	; if 0 means the car is not colliding (is_colliding) (private)
    clr.w   MOVER_HEADING_MAGNITUDE(a0)

    move.w	#1,CAR_NEXT_ZONE_OFFSET(a0)

	move.w 	#0,LAP_COUNTER_OFFSET(a0) ; race starts at lap number zero

	move.w  #0,TIME_OFFSET(a0) ; time starts at zero
    move.l  #PLAYER_2_TIMER_TXT,TIME_OFFSET_STR(a0)
    move.l  #$0,PLAYER_2_TIMER_TXT
    move.w  #$1,PLAYER_2_TIMER_TXT+4

	move.w  #$FFFF,BEST_TIME_OFFSET(a0) ; best time starts at max to allow first lap to be the best

    move.w  #$FFFF,RACE_COMPLETED_OFFSET(a0) ; race is not completed for this car

    move.l  #MOVER_DESTINATION,MOVER_HOTSPOT_CPU_PTR(a0)

    clr.w   MOVER_LEADING_LAPS(a0)

    move.w  TRACK_NUM_ZONES,CAR_FRONT_WHEEL_TRACK_PIXEL_DATA_OFFSET(a0) ; put here  in the high nibble the last track zone 
																		; and in the low nibble 0 for asphalt 1 for grass or 2 for ice
																   		; because when the race starts, all car must be placed 
																		; on the last zone


    rts

SET_CAR3_START_STATUS:
    lea 	MOVER3,a0

    move.w  #DECIMAL_MULTIPLIER,d0
    muls    CAR3_START_X_POSITION,d0
    move.w 	d0,MOVER_X_POSITION_OFFSET(a0) 	 	; initial x position (position)

    move.w  #DECIMAL_MULTIPLIER,d0
    muls    CAR3_START_Y_POSITION,d0
	move.w 	d0,MOVER_Y_POSITION_OFFSET(a0) 	 	; initial y position (position)

	move.w  CAR3_START_DEGREES,MOVER_STEER_DIRECTION_OFFSET(a0) 	 	; where the car should point at the beginning (degrees)? (steer_direction) (range 0-359)

    move.w  #0*DECIMAL_MULTIPLIER/2,MOVER_X_VELOCITY_OFFSET(a0)   	 	; initial x velocity (velocity)
	move.w  #0*DECIMAL_MULTIPLIER/2,MOVER_Y_VELOCITY_OFFSET(a0)   	 	; initial y velocity (velocity)

	move.w  #0*DECIMAL_MULTIPLIER,MOVER_X_ACCELERATION_OFFSET(a0)   	; initial x acceleration (accelleration)
	move.w  #0*DECIMAL_MULTIPLIER,MOVER_Y_ACCELERATION_OFFSET(a0)   	; initial y acceleration (accelleration)

    move.l  #0,MOVER_HEADING_OFFSET(a0)		 	  	 	; vector representing heading direction (heading) (private)

    move.w  #0,MOVER_IS_ACCELERATING_OFFSET(a0) 	 	; if 0 means the car is not accellerating (is_accellerating) (private)
	move.w  #0,MOVER_IS_BRAKING_OFFSET(a0) 	  		 	; if 0 means the car is not braking (is_braking) (private)
	move.w  #0,MOVER_IS_COLLIDING_OFFSET(a0) 	  	 	; if 0 means the car is not colliding (is_colliding) (private)
    clr.w   MOVER_HEADING_MAGNITUDE(a0)

    move.w	#1,CAR_NEXT_ZONE_OFFSET(a0)

	move.w 	#0,LAP_COUNTER_OFFSET(a0) ; race starts at lap number zero

	move.w  #0,TIME_OFFSET(a0) ; time starts at zero
	move.l  #PLAYER_3_TIMER_TXT,TIME_OFFSET_STR(a0)
    move.l  #$0,PLAYER_3_TIMER_TXT
    move.w  #$0,PLAYER_3_TIMER_TXT+4

    move.w  #$FFFF,BEST_TIME_OFFSET(a0) ; best time starts at max to allow first lap to be the best

    move.w  #$FFFF,RACE_COMPLETED_OFFSET(a0) ; race is not completed for this car

    move.l  #MOVER_DESTINATION,MOVER_HOTSPOT_CPU_PTR(a0)

    clr.w   MOVER_LEADING_LAPS(a0)

    move.w  TRACK_NUM_ZONES,CAR_FRONT_WHEEL_TRACK_PIXEL_DATA_OFFSET(a0) ; put here  in the high nibble the last track zone 
																		; and in the low nibble 0 for asphalt 1 for grass or 2 for ice
																   		; because when the race starts, all car must be placed 
																		; on the last zone

    rts

SET_CAR4_START_STATUS:
    lea 	MOVER4,a0

    move.w  #DECIMAL_MULTIPLIER,d0
    muls    CAR4_START_X_POSITION,d0
    move.w 	d0,MOVER_X_POSITION_OFFSET(a0) 	 	; initial x position (position)

    move.w  #DECIMAL_MULTIPLIER,d0
    muls    CAR4_START_Y_POSITION,d0
	move.w 	d0,MOVER_Y_POSITION_OFFSET(a0) 	 	; initial y position (position)

    move.w  CAR4_START_DEGREES,MOVER_STEER_DIRECTION_OFFSET(a0) 	 	; where the car should point at the beginning (degrees)? (steer_direction) (range 0-359)

    move.w  #0*DECIMAL_MULTIPLIER/2,MOVER_X_VELOCITY_OFFSET(a0)   	 	; initial x velocity (velocity)
	move.w  #0*DECIMAL_MULTIPLIER/2,MOVER_Y_VELOCITY_OFFSET(a0)   	 	; initial y velocity (velocity)

	move.w  #0*DECIMAL_MULTIPLIER,MOVER_X_ACCELERATION_OFFSET(a0)   	; initial x acceleration (accelleration)
	move.w  #0*DECIMAL_MULTIPLIER,MOVER_Y_ACCELERATION_OFFSET(a0)   	; initial y acceleration (accelleration)

    move.l  #0,MOVER_HEADING_OFFSET(a0)		 	  	 	; vector representing heading direction (heading) (private)

    move.w  #0,MOVER_IS_ACCELERATING_OFFSET(a0) 	 	; if 0 means the car is not accellerating (is_accellerating) (private)
	move.w  #0,MOVER_IS_BRAKING_OFFSET(a0) 	  		 	; if 0 means the car is not braking (is_braking) (private)
	move.w  #0,MOVER_IS_COLLIDING_OFFSET(a0) 	  	 	; if 0 means the car is not colliding (is_colliding) (private)
    clr.w   MOVER_HEADING_MAGNITUDE(a0)

    move.w	#1,CAR_NEXT_ZONE_OFFSET(a0)

	move.w 	#0,LAP_COUNTER_OFFSET(a0) ; race starts at lap number zero

	move.w  #0,TIME_OFFSET(a0) ; time starts at zero
    move.l  #PLAYER_4_TIMER_TXT,TIME_OFFSET_STR(a0)
    move.l  #$0,PLAYER_4_TIMER_TXT
    move.w  #$0,PLAYER_4_TIMER_TXT+4

	move.w  #$FFFF,BEST_TIME_OFFSET(a0) ; best time starts at max to allow first lap to be the best

    move.w  #$FFFF,RACE_COMPLETED_OFFSET(a0) ; race is not completed for this car

    move.l  #MOVER_DESTINATION,MOVER_HOTSPOT_CPU_PTR(a0)

    clr.w   MOVER_LEADING_LAPS(a0)

    move.w  TRACK_NUM_ZONES,CAR_FRONT_WHEEL_TRACK_PIXEL_DATA_OFFSET(a0) ; put here  in the high nibble the last track zone 
																		; and in the low nibble 0 for asphalt 1 for grass or 2 for ice
																   		; because when the race starts, all car must be placed 
																		; on the last zone

    rts

SET_CAR5_START_STATUS:
    lea 	MOVER5,a0

    move.w  #DECIMAL_MULTIPLIER,d0
    muls    CAR5_START_X_POSITION,d0
    move.w 	d0,MOVER_X_POSITION_OFFSET(a0) 	 	; initial x position (position)

    move.w  #DECIMAL_MULTIPLIER,d0
    muls    CAR5_START_Y_POSITION,d0
	move.w 	d0,MOVER_Y_POSITION_OFFSET(a0) 	 	; initial y position (position)

    move.w  CAR5_START_DEGREES,MOVER_STEER_DIRECTION_OFFSET(a0) 	 	; where the car should point at the beginning (degrees)? (steer_direction) (range 0-359)

    move.w  #0*DECIMAL_MULTIPLIER/2,MOVER_X_VELOCITY_OFFSET(a0)   	 	; initial x velocity (velocity)
	move.w  #0*DECIMAL_MULTIPLIER/2,MOVER_Y_VELOCITY_OFFSET(a0)   	 	; initial y velocity (velocity)

	move.w  #0*DECIMAL_MULTIPLIER,MOVER_X_ACCELERATION_OFFSET(a0)   	; initial x acceleration (accelleration)
	move.w  #0*DECIMAL_MULTIPLIER,MOVER_Y_ACCELERATION_OFFSET(a0)   	; initial y acceleration (accelleration)

    move.l  #0,MOVER_HEADING_OFFSET(a0)		 	  	 	; vector representing heading direction (heading) (private)

    move.w  #0,MOVER_IS_ACCELERATING_OFFSET(a0) 	 	; if 0 means the car is not accellerating (is_accellerating) (private)
	move.w  #0,MOVER_IS_BRAKING_OFFSET(a0) 	  		 	; if 0 means the car is not braking (is_braking) (private)
	move.w  #0,MOVER_IS_COLLIDING_OFFSET(a0) 	  	 	; if 0 means the car is not colliding (is_colliding) (private)
    clr.w   MOVER_HEADING_MAGNITUDE(a0)

    move.w	#1,CAR_NEXT_ZONE_OFFSET(a0)

	move.w 	#0,LAP_COUNTER_OFFSET(a0) ; race starts at lap number zero

	move.w  #0,TIME_OFFSET(a0) ; time starts at zero
    move.l  #PLAYER_5_TIMER_TXT,TIME_OFFSET_STR(a0)
    move.l  #$0,PLAYER_5_TIMER_TXT
    move.w  #$0,PLAYER_5_TIMER_TXT+4

	move.w  #$FFFF,BEST_TIME_OFFSET(a0) ; best time starts at max to allow first lap to be the best

    move.w  #$FFFF,RACE_COMPLETED_OFFSET(a0) ; race is not completed for this car

    move.l  #MOVER_DESTINATION,MOVER_HOTSPOT_CPU_PTR(a0)

    clr.w   MOVER_LEADING_LAPS(a0)

    move.w  TRACK_NUM_ZONES,CAR_FRONT_WHEEL_TRACK_PIXEL_DATA_OFFSET(a0) ; put here  in the high nibble the last track zone 
																		; and in the low nibble 0 for asphalt 1 for grass or 2 for ice
																   		; because when the race starts, all car must be placed 
																		; on the last zone

    rts

SET_CAR6_START_STATUS:
    lea 	MOVER6,a0

    move.w  #DECIMAL_MULTIPLIER,d0
    muls    CAR6_START_X_POSITION,d0
    move.w 	d0,MOVER_X_POSITION_OFFSET(a0) 	 	; initial x position (position)

    move.w  #DECIMAL_MULTIPLIER,d0
    muls    CAR6_START_Y_POSITION,d0
	move.w 	d0,MOVER_Y_POSITION_OFFSET(a0) 	 	; initial y position (position)

    move.w  CAR6_START_DEGREES,MOVER_STEER_DIRECTION_OFFSET(a0) 	 	; where the car should point at the beginning (degrees)? (steer_direction) (range 0-359)

    move.w  #0*DECIMAL_MULTIPLIER/2,MOVER_X_VELOCITY_OFFSET(a0)   	 	; initial x velocity (velocity)
	move.w  #0*DECIMAL_MULTIPLIER/2,MOVER_Y_VELOCITY_OFFSET(a0)   	 	; initial y velocity (velocity)

	move.w  #0*DECIMAL_MULTIPLIER,MOVER_X_ACCELERATION_OFFSET(a0)   	; initial x acceleration (accelleration)
	move.w  #0*DECIMAL_MULTIPLIER,MOVER_Y_ACCELERATION_OFFSET(a0)   	; initial y acceleration (accelleration)

    move.l  #0,MOVER_HEADING_OFFSET(a0)		 	  	 	; vector representing heading direction (heading) (private)

    move.w  #0,MOVER_IS_ACCELERATING_OFFSET(a0) 	 	; if 0 means the car is not accellerating (is_accellerating) (private)
	move.w  #0,MOVER_IS_BRAKING_OFFSET(a0) 	  		 	; if 0 means the car is not braking (is_braking) (private)
	move.w  #0,MOVER_IS_COLLIDING_OFFSET(a0) 	  	 	; if 0 means the car is not colliding (is_colliding) (private)
    clr.w   MOVER_HEADING_MAGNITUDE(a0)

    move.w	#1,CAR_NEXT_ZONE_OFFSET(a0)

	move.w 	#0,LAP_COUNTER_OFFSET(a0) ; race starts at lap number zero

	move.w  #0,TIME_OFFSET(a0) ; time starts at zero
    move.l  #PLAYER_6_TIMER_TXT,TIME_OFFSET_STR(a0)
    move.l  #$0,PLAYER_6_TIMER_TXT
    move.w  #$0,PLAYER_6_TIMER_TXT+4

	move.w  #$FFFF,BEST_TIME_OFFSET(a0) ; best time starts at max to allow first lap to be the best

    move.w  #$FFFF,RACE_COMPLETED_OFFSET(a0) ; race is not completed for this car

    move.l  #MOVER_DESTINATION,MOVER_HOTSPOT_CPU_PTR(a0)

    clr.w   MOVER_LEADING_LAPS(a0)

    move.w  TRACK_NUM_ZONES,CAR_FRONT_WHEEL_TRACK_PIXEL_DATA_OFFSET(a0) ; put here  in the high nibble the last track zone 
																		; and in the low nibble 0 for asphalt 1 for grass or 2 for ice
																   		; because when the race starts, all car must be placed 
																		; on the last zone

    rts

SET_CAR7_START_STATUS:
    lea 	MOVER7,a0

    move.w  #DECIMAL_MULTIPLIER,d0
    muls    CAR7_START_X_POSITION,d0
    move.w 	d0,MOVER_X_POSITION_OFFSET(a0) 	 	; initial x position (position)

    move.w  #DECIMAL_MULTIPLIER,d0
    muls    CAR7_START_Y_POSITION,d0
	move.w 	d0,MOVER_Y_POSITION_OFFSET(a0) 	 	; initial y position (position)

    move.w  CAR7_START_DEGREES,MOVER_STEER_DIRECTION_OFFSET(a0) 	 	; where the car should point at the beginning (degrees)? (steer_direction) (range 0-359)

    move.w  #0*DECIMAL_MULTIPLIER/2,MOVER_X_VELOCITY_OFFSET(a0)   	 	; initial x velocity (velocity)
	move.w  #0*DECIMAL_MULTIPLIER/2,MOVER_Y_VELOCITY_OFFSET(a0)   	 	; initial y velocity (velocity)

	move.w  #0*DECIMAL_MULTIPLIER,MOVER_X_ACCELERATION_OFFSET(a0)   	; initial x acceleration (accelleration)
	move.w  #0*DECIMAL_MULTIPLIER,MOVER_Y_ACCELERATION_OFFSET(a0)   	; initial y acceleration (accelleration)

    move.l  #0,MOVER_HEADING_OFFSET(a0)		 	  	 	; vector representing heading direction (heading) (private)

    move.w  #0,MOVER_IS_ACCELERATING_OFFSET(a0) 	 	; if 0 means the car is not accellerating (is_accellerating) (private)
	move.w  #0,MOVER_IS_BRAKING_OFFSET(a0) 	  		 	; if 0 means the car is not braking (is_braking) (private)
	move.w  #0,MOVER_IS_COLLIDING_OFFSET(a0) 	  	 	; if 0 means the car is not colliding (is_colliding) (private)
    clr.w   MOVER_HEADING_MAGNITUDE(a0)

    move.w	#1,CAR_NEXT_ZONE_OFFSET(a0)

	move.w 	#0,LAP_COUNTER_OFFSET(a0) ; race starts at lap number zero

	move.w  #0,TIME_OFFSET(a0) ; time starts at zero
    move.l  #PLAYER_7_TIMER_TXT,TIME_OFFSET_STR(a0)
    move.l  #$0,PLAYER_7_TIMER_TXT
    move.w  #$0,PLAYER_7_TIMER_TXT+4

	move.w  #$FFFF,BEST_TIME_OFFSET(a0) ; best time starts at max to allow first lap to be the best

    move.w  #$FFFF,RACE_COMPLETED_OFFSET(a0) ; race is not completed for this car

    move.l  #MOVER_DESTINATION,MOVER_HOTSPOT_CPU_PTR(a0)

    clr.w   MOVER_LEADING_LAPS(a0)

    move.w  TRACK_NUM_ZONES,CAR_FRONT_WHEEL_TRACK_PIXEL_DATA_OFFSET(a0) ; put here  in the high nibble the last track zone 
																		; and in the low nibble 0 for asphalt 1 for grass or 2 for ice
																   		; because when the race starts, all car must be placed 
																		; on the last zone

    rts

SET_CAR8_START_STATUS:
    lea 	MOVER8,a0

    move.w  #DECIMAL_MULTIPLIER,d0
    muls    CAR8_START_X_POSITION,d0
    move.w 	d0,MOVER_X_POSITION_OFFSET(a0) 	 	; initial x position (position)

    move.w  #DECIMAL_MULTIPLIER,d0
    muls    CAR8_START_Y_POSITION,d0
	move.w 	d0,MOVER_Y_POSITION_OFFSET(a0) 	 	; initial y position (position)

    move.w  CAR8_START_DEGREES,MOVER_STEER_DIRECTION_OFFSET(a0) 	 	; where the car should point at the beginning (degrees)? (steer_direction) (range 0-359)

    move.w  #0*DECIMAL_MULTIPLIER/2,MOVER_X_VELOCITY_OFFSET(a0)   	 	; initial x velocity (velocity)
	move.w  #0*DECIMAL_MULTIPLIER/2,MOVER_Y_VELOCITY_OFFSET(a0)   	 	; initial y velocity (velocity)

	move.w  #0*DECIMAL_MULTIPLIER,MOVER_X_ACCELERATION_OFFSET(a0)   	; initial x acceleration (accelleration)
	move.w  #0*DECIMAL_MULTIPLIER,MOVER_Y_ACCELERATION_OFFSET(a0)   	; initial y acceleration (accelleration)

    move.l  #0,MOVER_HEADING_OFFSET(a0)		 	  	 	; vector representing heading direction (heading) (private)

    move.w  #0,MOVER_IS_ACCELERATING_OFFSET(a0) 	 	; if 0 means the car is not accellerating (is_accellerating) (private)
	move.w  #0,MOVER_IS_BRAKING_OFFSET(a0) 	  		 	; if 0 means the car is not braking (is_braking) (private)
	move.w  #0,MOVER_IS_COLLIDING_OFFSET(a0) 	  	 	; if 0 means the car is not colliding (is_colliding) (private)
    clr.w   MOVER_HEADING_MAGNITUDE(a0)

    move.w	#1,CAR_NEXT_ZONE_OFFSET(a0)

	move.w 	#0,LAP_COUNTER_OFFSET(a0) ; race starts at lap number zero

	move.w  #0,TIME_OFFSET(a0) ; time starts at zero
    move.l  #PLAYER_8_TIMER_TXT,TIME_OFFSET_STR(a0)
    move.l  #$0,PLAYER_8_TIMER_TXT
    move.w  #$0,PLAYER_8_TIMER_TXT+4

	move.w  #$FFFF,BEST_TIME_OFFSET(a0) ; best time starts at max to allow first lap to be the best

    move.w  #$FFFF,RACE_COMPLETED_OFFSET(a0) ; race is not completed for this car

    move.l  #MOVER_DESTINATION,MOVER_HOTSPOT_CPU_PTR(a0)

    clr.w   MOVER_LEADING_LAPS(a0)

    move.w  TRACK_NUM_ZONES,CAR_FRONT_WHEEL_TRACK_PIXEL_DATA_OFFSET(a0) ; put here  in the high nibble the last track zone 
																		; and in the low nibble 0 for asphalt 1 for grass or 2 for ice
																   		; because when the race starts, all car must be placed 
																		; on the last zone

    rts