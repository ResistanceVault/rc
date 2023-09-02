RACE_WAIT_TO_START EQU 4
RACE_WAIT_3        EQU 3
RACE_WAIT_2        EQU 2
RACE_WAIT_1        EQU 1
RACE_WAIT_GO       EQU 5
RACE_WAIT_END       EQU 6
RACE_WAIT_TO_SPACE_RELEASE EQU 7
RACE_WAIT_RESUME_SPACE EQU 8
RACE_WAIT_TO_SPACE_RELEASE_2 EQU 9

RACE_WAIT_BETWEEN_STAGES EQU 50*1

RACE_PAUSE:                dc.w 0 ; set to 1 to pause the game
RACE_FORCED_PAUSE:      dc.w 0 ; set to 1 to indicate the game has been forcefully paused (waiting for the player to be ready at the start of the race)
RACE_PROGRESS:          dc.w 0 ; set to one of the above directive to indicata which stage of the race we are
RACE_MANAGER_TIMER:     dc.w 0 ; timer to transition from one stage to another
SPACE_PRESSED:          dc.w 0

RESET_RACE:
    move.w              #RACE_WAIT_TO_START,RACE_PROGRESS
    move.w              #1,RACE_PAUSE
    move.w              #1,RACE_FORCED_PAUSE
    clr.w               SPACE_PRESSED
    IFD COLOR
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

    ; reset ptr to leading leader
    clr.l               RACE_LEADING_LEADER_PTR

    ; reset music if set
    MY_P61_END

    rts

MANAGE_PAUSE:
    tst.w                 RACE_FORCED_PAUSE
    beq.w                 race_no_forced_pause

    cmpi.w               #RACE_WAIT_TO_SPACE_RELEASE,RACE_PROGRESS
    beq.w                MANAGE_SPACE_RELEASE_STATE

    cmpi.w               #RACE_WAIT_RESUME_SPACE,RACE_PROGRESS
    beq.w                MANAGE_WAIT_RESUME_SPACE

    cmpi.w               #RACE_WAIT_TO_SPACE_RELEASE_2,RACE_PROGRESS
    beq.w                MANAGE_SPACE_RELEASE_STATE_2

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

    ; it doesnt count for cpu driven car
    tst.w               STRICT_COMMANDS
    beq.s               .nostrictcommands
    DEBUG 7654
    cmp.l               #CPUCONTROL,INPUT_ROUTINE_OFFSET(a0)
    beq.s               movers_no_disable_pause
.nostrictcommands:

    move.w              #RACE_WAIT_3,RACE_PROGRESS
    move.w              #RACE_WAIT_BETWEEN_STAGES,RACE_MANAGER_TIMER
movers_no_disable_pause:

    bsr.w				MOVE

    bsr.w				DISPLAY

next_car_pause:
	adda.l  			#MOVER_SIZE,a0
	dbra 				d7,moversloop_pause
    bra.w               Aspetta

; start managing pause requested by the user
race_no_forced_pause:
    move.w              #RACE_WAIT_TO_SPACE_RELEASE,RACE_PROGRESS
    move.w              #1,RACE_PAUSE
    move.w              #1,RACE_FORCED_PAUSE
    ;IFD COLOR
    ;move.l              #START_RACE_BANNER_ACC_1,d0
    ;jsr                 SET_BANNER
    ;ENDC
    move.w              #1,SPACE_PRESSED
    bra.w               Aspetta

MANAGE_3_STATE:
    IFD COLOR
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
    move.l              #START_RACE_BANNER_GO_1,d0
    jsr                 SET_BANNER
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

    jsr                 CLEAR_PROGRESS_BAR_F
    jsr                 LOADING_SCREEN
    move.w              #1,LOADING_SCREEN_FLAG

    jsr                 RESULTSCREEN
    jsr                 STANDINGSSCREEN
    beq.w				welcomescreen_start
    ENDIF
no_real_end_race:
    bra.w               before_moversloop

clear_space_pressed:
    move.w              #0,SPACE_PRESSED
    bra.s               no_set_timer_banner

MANAGE_SPACE_RELEASE_STATE:
    IFD SOUND
    tst.w               PLAY_SOUND
	beq.s               nosound3
    clr.w               $dff0A8
    clr.w               $dff0B8
    clr.w               $dff0C8
    clr.w               $dff0D8
nosound3:
    MY_P61_END

    ENDC
    tst.w               KEY_SPACE
    bne.w               Aspetta
    move.w              #RACE_WAIT_RESUME_SPACE,RACE_PROGRESS
    bra.w               Aspetta

MANAGE_WAIT_RESUME_SPACE:
    tst.w               KEY_SPACE
    beq.w               Aspetta
    move.w              #RACE_WAIT_TO_SPACE_RELEASE_2,RACE_PROGRESS
    bra.w               Aspetta

MANAGE_SPACE_RELEASE_STATE_2:
    tst.w               KEY_SPACE
    bne.w               Aspetta
    clr.w               RACE_PAUSE
    clr.w               RACE_FORCED_PAUSE
    ;;    ---  Call P61_Init  ---
	tst.w				PLAY_MUSIC
	beq.s				.nomusicinit
	lea 				Module1,a0
	sub.l 				a1,a1
	sub.l 				a2,a2
	moveq 				#0,d0
	jsr P61_Init
.nomusicinit
    bra.w               Aspetta