; friction routine: if both throttle and brake are NOT pressed
; the car must slow down anyway because we are sort of simulating
; earth gravity which is pressing the car on the ground.
; This must be represented with the velocity vector loosing some magnitude
; each frame. We will use friction factor to determine how much
; speed we lose.

FRICTION_VECTOR: dc.l 0

APPLY_FRICTION:
    
    tst.w MOVER_IS_ACCELERATING_OFFSET(a0)
    bne.w end_apply_friction

    tst.w MOVER_IS_BRAKING_OFFSET(a0)
    bne.w end_apply_friction

    movem.l a0/d7,-(sp)
    move.l a2,a0
    ; friction vector = velocity vector * -1
    ; we need this to have the vector pointing to the opposite direction
    move.w MOVER_X_VELOCITY_OFFSET(a0),d0
    move.w MOVER_Y_VELOCITY_OFFSET(a0),d1
    neg.w  d0
    neg.w  d1

    lea FRICTION_VECTOR,a0
    move.w d0,(a0)
    move.w d1,2(a0)

    ;FRICTION_VECTOR now holds the opposite direction of VELOCITY VECTOR
    ; we must scale it according to friction factor
    move.w MOVER_FRICTION_COEFFICIENT_OFFSET(a2),d7
    move.w               #%10000000,d7
    ;DEBUG 0001
    ;jsr SET2DMAGNITUDE
    jsr SET2DMAGNITUDE_Q4_12_TABLE_LOOKUP
     ;   DEBUG 0002


    IFD DEBUG
    DV_DIV #20,#64,(a0),#4
    ENDC

    ; put velocity into a1
    SETCARPROPERTYADDR MOVER_VELOCITY_OFFSET,a1  
    ; a1 now points to the velocity vector

    ; a0 is set to friction vector
    ; a1 is set to car velocity vector
    ADD2DVECTOR
    IFD DEBUG
    DV_DIV #160,#64,(a1),#64
    ENDC
    

    movem.l (sp)+,a0/d7
end_apply_friction:
    rts


GET2DMAGNITUDE_Q4_12_TABLE_LOOKUP MACRO
	move.w    (a0),d0
    muls.w     d0,d0
    move.w    2(a0),d1
    muls.w     d1,d1
    lsr.l      #6,d0
    lsr.l      #6,d0
    lsr.l      #6,d1
    lsr.l      #6,d1
    add.l      d1,d0
    lsl.l      #1,d0
    lea        SQRT_TABLE_Q4_12,a1
    adda.l     d0,a1
    move.w     (a1),d0
  ENDM

    ; set2dmagnitude
; a0 pointer to vector
; d7 magnitude
SET2DMAGNITUDE_Q4_12_TABLE_LOOKUP:
  GET2DMAGNITUDE_Q4_12_TABLE_LOOKUP
SET2DMAGNITUDE_NOGET_Q4_12_TABLE_LOOKUP:
  tst.w     d0
  bne.s     GET2DMAGNITUDE_NODIV_Q4_12_TABLE_LOOKUP
  move.l    #0,(a0)
  rts
GET2DMAGNITUDE_NODIV_Q4_12_TABLE_LOOKUP:

  move.w    (a0),d1
  move.w    2(a0),d2

  muls      d7,d1
  muls      d7,d2

  divs      d0,d1
  divs      d0,d2

  move.w    d1,(a0)
  move.w    d2,2(a0)
  rts

