DV_DIV MACRO
    move.w  \1,DEBUGVECTORCENTER
    move.w  \2,DEBUGVECTORCENTER+2
    move.l  \3,DEBUGVECTOR
    move.w  \4,DEBUGVECTORMULT
    jsr     DRAWDEBUGVECTOR_DIV
    ENDM

DV MACRO
    move.w  \1,DEBUGVECTORCENTER
    move.w  \2,DEBUGVECTORCENTER+2
    move.l  \3,DEBUGVECTOR
    move.w  \4,DEBUGVECTORMULT
    jsr     DRAWDEBUGVECTOR
    ENDM

DEBUGVECTORMULT: dc.w 0
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
    muls DEBUGVECTORMULT,d2
    muls DEBUGVECTORMULT,d3
    STROKE #2
    LINEDRAW #0,#0,d2,d3

    RESET_CURRENT_TRANSFORMATION_MATRIX_Q_10_6

    movem.l (sp)+,d0-d7/a0-a6
    rts

DRAWDEBUGVECTOR_DIV:
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
    divs DEBUGVECTORMULT,d2
    divs DEBUGVECTORMULT,d3
    STROKE #2
    LINEDRAW #0,#0,d2,d3

    RESET_CURRENT_TRANSFORMATION_MATRIX_Q_10_6

    movem.l (sp)+,d0-d7/a0-a6
    rts