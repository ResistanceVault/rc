DEBUGVECTOR: dc.l 0
DEBUGVECTORCENTER: dc.l 0
DRAWDEBUGVECTOR:
    movem.l d0-d7/a0-a6,-(sp)
    move.w                                        DEBUGVECTORCENTER,d0
    move.w                                        DEBUGVECTORCENTER+2,d1
    jsr                                           LOADIDENTITYANDTRANSLATE
    STROKE #1
    moveq #0,d0
    moveq #0,d1
    jsr POINT

    move.w DEBUGVECTOR,d2
    move.w DEBUGVECTOR+2,d3
    ;asr.w #5,d2
    ;asr.w #5,d3
    muls #4,d2
    muls #4,d3
    STROKE #2
    LINEDRAW #0,#0,d2,d3

    RESET_CURRENT_TRANSFORMATION_MATRIX_Q_10_6

    movem.l (sp)+,d0-d7/a0-a6
    rts