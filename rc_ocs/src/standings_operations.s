STANDINGS_ORDER:dcb.b MAX_CARS*4,$00

CREATE_STANDINGS_ORDER:
    IFD DEBUG
    lea                 MOVERS,a0
    move.w              #10,MOVER_POINTS(a0)

    lea                 MOVERS2,a0
    move.w              #9,MOVER_POINTS(a0)

    lea                 MOVERS3,a0
    move.w              #8,MOVER_POINTS(a0)

    lea                 MOVERS4,a0
    move.w              #7,MOVER_POINTS(a0)

    lea                 MOVERS5,a0
    move.w              #6,MOVER_POINTS(a0)

    lea                 MOVERS6,a0
    move.w              #5,MOVER_POINTS(a0)

    lea                 MOVERS7,a0
    move.w              #4,MOVER_POINTS(a0)
    
    lea                 MOVERS8,a0
    move.w              #2,MOVER_POINTS(a0)
    ENDC

    lea                 STANDINGS_ORDER(PC),a1
    move.w 				#MAX_CARS-1,d7

    ; clear standing order array
standingsclearloop:
    clr.l               (a1)+
    dbra                d7,standingsclearloop

    ; build the unordered array of playing cars
    lea                 MOVERS,a0
    lea                 STANDINGS_ORDER(PC),a1
    move.w 				#MAX_CARS-1,d6
    moveq               #0,d7

arrival_order_start_loop:
    btst.b 				d6,CARS_IN_PLAY+1 ; clear stading array
    beq.s               arrival_order_not_in_play ; if not in play just go to next car
    move.l              a0,(a1)+
    addq                #1,d7
arrival_order_not_in_play:
    adda.l  			#MOVER_SIZE,a0
    dbra                d6,arrival_order_start_loop

    ; order based by points
    cmpi.w              #1,d7
    beq.s               arrival_skip_ordering
    lea                 STANDINGS_ORDER(PC),a0
    lea                 standings_compare_function,a2
    jsr                 bubble_sort_4_bytes
arrival_skip_ordering:

    ; assign position to cars
    lea                 CAR_INFO_DATA,a0    ; here we have the track positions
    lea                 STANDINGS_ORDER(PC),a1  ; here we have the array of cars
    move.w 				#MAX_CARS-1,d7
assigntocarsloop:
    tst.l               (a1)
    beq.s               create_standings_order_exit
    move.l              (a1),a2
    move.w              (a0)+,MOVER_START_X_POSITION_OFFSET(a2)
    move.w              (a0)+,MOVER_START_Y_POSITION_OFFSET(a2)
    move.w              (a0)+,MOVER_START_ANGLE_POSITION_OFFSET(a2)

    addq                #4,a1
    dbra                d7,assigntocarsloop
create_standings_order_exit:
    rts

standings_compare_function:
    movem.l d0/a5/a6,-(sp)
    move.l (a5),a5
    move.l (a6),a6
    move.w MOVER_POINTS(a5),d0
    moveq #0,d5
    cmp.w MOVER_POINTS(a6),d0
    ;smi d5
    shi d5
    movem.l (sp)+,d0/a5/a6
    rts