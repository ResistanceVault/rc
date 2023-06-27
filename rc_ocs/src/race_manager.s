RACE_WAIT_TO_START EQU 4
RACE_WAIT_3        EQU 3
RACE_WAIT_2        EQU 2
RACE_WAIT_1        EQU 1
RACE_WAIT_GO       EQU 5
RACE_WAIT_END       EQU 6

RACE_WAIT_BETWEEN_STAGES EQU 50*1

RACE_PAUSE:                dc.w 0 ; set to 1 to pause the game
RACE_FORCED_PAUSE:      dc.w 0 ; set to 1 to indicate the game has been forcefully paused (waiting for the player to be ready at the start of the race)
RACE_PROGRESS:          dc.w 0 ; set to one of the above directive to indicata which stage of the race we are
RACE_MANAGER_TIMER:     dc.w 0 ; timer to transition from one stage to another
MOVE_CARS_ON_PAUSE:     dc.w 0
SPACE_PRESSED:          dc.w 0

RESET_RACE:
    move.w              #RACE_WAIT_TO_START,RACE_PROGRESS
    move.w              #1,RACE_PAUSE
    move.w              #1,RACE_FORCED_PAUSE
    IFD COLOR
    lea                 BPLPTR_HUD,a0
    move.l              #START_RACE_BANNER_ACC_1,d0
    jsr                 SET_BANNER
    ENDC
    moveq               #MAX_CARS-1,d7
    lea                 ARRIVAL_ORDER,a0
reset_arrival:
    clr.l               (a0)+
    dbra                d7,reset_arrival
    move.l              #ARRIVAL_ORDER,ARRIVAL_ORDER_PTR

    ; reset best time
    move.w              #$FFFF,RACE_BEST_LAP
    clr.l               RACE_BEST_LAP_CAR_PTR

    ; reset lap counter
    clr.w               MAX_LAP

    rts

MANAGE_PAUSE:
    tst.w                 RACE_FORCED_PAUSE
    beq.w                 race_no_forced_pause

    ; here we are managing a forced pause caused by the race waiting to start
    ; check if we are on countdown
    cmpi.w               #RACE_WAIT_3,RACE_PROGRESS
    beq.w                MANAGE_3_STATE

    cmpi.w               #RACE_WAIT_2,RACE_PROGRESS
    beq.w                MANAGE_2_STATE

    cmpi.w               #RACE_WAIT_1,RACE_PROGRESS
    beq.w                MANAGE_1_STATE

    ; check if we are at the end of the race
    cmpi.w               #RACE_WAIT_END,RACE_PROGRESS
    beq.w                MANAGE_END_STATE

    ; check if anyone is pressing accelerate button
    ; for each car
	lea 				MOVERS,a0
	move.w 				#MAX_CARS-1,d7

moversloop_pause:
    ; if the car is not in play skip
	btst.b 				d7,CARS_IN_PLAY+1
	beq.w   			next_car_pause

    ; this routine will read joystick movements and store result into d0 specifically for MANAGE_INPUT
	move.l  			INPUT_ROUTINE_OFFSET(a0),a1
	jsr					(a1)

    ; check if accelerate was pressed
    btst 				#2,d0
    ; if yes transition to banner 3 stage
    beq.s               movers_no_disable_pause
    move.w              #RACE_WAIT_3,RACE_PROGRESS
    move.w              #RACE_WAIT_BETWEEN_STAGES,RACE_MANAGER_TIMER
movers_no_disable_pause:

    tst.w               MOVE_CARS_ON_PAUSE
    bne.w               next_car_pause

    bsr.w				MOVE

    bsr.w				DISPLAY

next_car_pause:
	adda.l  			#MOVER_SIZE,a0
	dbra 				d7,moversloop_pause
    bra.w               Aspetta

; start managing pause requested by the user
race_no_forced_pause:
    jsr                 RESET_RACE
    move.w              #1,MOVE_CARS_ON_PAUSE
    move.w              #1,SPACE_PRESSED
    bra.w               Aspetta

MANAGE_3_STATE:
    IFD COLOR
    lea                 BPLPTR_HUD,a0
    move.l              #START_RACE_BANNER_3_1,d0
    jsr                 SET_BANNER
    subi.W              #1,RACE_MANAGER_TIMER
    bne.s               no2state
    move.w              #RACE_WAIT_2,RACE_PROGRESS
    move.W              #RACE_WAIT_BETWEEN_STAGES,RACE_MANAGER_TIMER
no2state:
    ENDC
    bra.w               Aspetta

MANAGE_2_STATE:
    IFD COLOR
    lea                 BPLPTR_HUD,a0
    move.l              #START_RACE_BANNER_2_1,d0
    jsr                 SET_BANNER
    subi.W              #1,RACE_MANAGER_TIMER
    bne.s               no1state
    move.w              #RACE_WAIT_1,RACE_PROGRESS
    move.W              #RACE_WAIT_BETWEEN_STAGES,RACE_MANAGER_TIMER
no1state:
    ENDC
    bra.w               Aspetta

MANAGE_1_STATE:
    IFD COLOR
    lea                 BPLPTR_HUD,a0
    move.l              #START_RACE_BANNER_1_1,d0
    jsr                 SET_BANNER
    subi.W              #1,RACE_MANAGER_TIMER
    bne.s               nogostate
    move.w              #RACE_WAIT_GO,RACE_PROGRESS
    move.W              #RACE_WAIT_BETWEEN_STAGES,RACE_MANAGER_TIMER
    move.w              #0,RACE_PAUSE
    move.w              #0,RACE_FORCED_PAUSE
nogostate:
    ENDC
    bra.w               Aspetta

DISPLAY_GO_BANNER:
    IFD COLOR
    lea                 BPLPTR_HUD,a0
    move.l              #START_RACE_BANNER_GO_1,d0
    jsr                 SET_BANNER
    move.w              #0,MOVE_CARS_ON_PAUSE
    subi.w              #1,RACE_MANAGER_TIMER
    bne.s               no_set_timer_banner
    move.w              #0,RACE_PROGRESS
    move.W              #RACE_WAIT_BETWEEN_STAGES,RACE_MANAGER_TIMER
    jsr                 RESTORE_TIMERS_BANNER
    tst.w               SPACE_PRESSED
    ;bne.s               no_set_timer_banner
    bne.s               clear_space_pressed
    jsr                 CLEAN_DASHBOARD
    ENDC
no_set_timer_banner:
    bra.w               end_display_go_banner

MANAGE_END_STATE:
    subi.w              #1,RACE_MANAGER_TIMER
    bne.s               no_real_end_race
    move.W              #RACE_WAIT_BETWEEN_STAGES,RACE_MANAGER_TIMER
    IFND COLOR
    bra.w               RACE_RESULTS_SCREEN
    ELSE
    jsr                 RESULTSCREEN
    jsr                 STANDINGSSCREEN
    beq.w				welcomescreen_start
    ENDIF
no_real_end_race:
    bra.w               before_moversloop

clear_space_pressed:
    move.w              #0,SPACE_PRESSED
    bra.s               no_set_timer_banner
