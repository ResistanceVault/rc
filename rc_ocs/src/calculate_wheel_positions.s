; this routine calculates the wheel positions
; for the car pointed in a0 according to its
; position and wheel base value

WHEEL_VECTOR_1: 
    dc.l 0
WHEEL_VECTOR_2:
    dc.l 0
WHEEL_VECTOR_OUTPUT:
    dc.l 0

CALCULATE_WHEEL_POSITIONS:
    ; save car address into a2
    move.l              a0,a2

    ; step 1 - get the vector representing the distance from the center
    ; up to a generic wheel according to forward vector and wheel base
    lea                 WHEEL_VECTOR_1(PC),a0
    lea                 WHEEL_VECTOR_2(PC),a1
    move.l              MOVER_FORWARD_VECTOR_OFFSET(a2),(a0)
    move.w              MOVER_WHEEL_BASE_OFFSET(a2),(a1)
    move.w              MOVER_WHEEL_BASE_OFFSET(a2),2(a1)
    MUL2DVECTORSTATIC   WHEEL_VECTOR_OUTPUT
    lea WHEEL_VECTOR_OUTPUT,a3

    
    ; Divide by 2 and then divide by to no normalize (divide by 128)
    lea WHEEL_VECTOR_OUTPUT(PC),a0
    lea WHEEL_VECTOR_2(PC),a1
    move.l #$00020002,(a1)
    DIV2DVECTOR

    ; restore address of the car
    move.l              a2,a0

    ; step 2 - get the coordinate of the back wheel
    adda.w #MOVER_BACK_WHEEL_VECTOR_OFFSET,a0
    move.l MOVER_POSITION_OFFSET(a2),(a0)
    lea WHEEL_VECTOR_2(PC),a1
    SUB2DVECTORSTATIC WHEEL_VECTOR_1
    move.l WHEEL_VECTOR_1,(a0)




    ; restore address of the car
    move.l              a2,a0

    ; step 3 - get the coordinate of the front wheel
    adda.w #MOVER_FRONT_WHEEL_VECTOR_OFFSET,a0
    move.l MOVER_POSITION_OFFSET(a2),(a0)
    lea WHEEL_VECTOR_2(PC),a1
    ADD2DVECTORSTATIC WHEEL_VECTOR_1
    move.l WHEEL_VECTOR_1,(a0)

    rts