SCREEN_TRACK_SELECT:

    ; clean bitplanes

    ; Init tiles bitplanes
    move.l              #SCREEN_0,d0
    lea                 BPLPTR1_WELCOME,a1
    bsr.w               POINTINCOPPERLIST_FUNCT

    move.l              #SCREEN_1,d0
    lea                 BPLPTR2_WELCOME,a1
    bsr.w               POINTINCOPPERLIST_FUNCT

    move.l              #SCREEN_00,d0
    lea                 BPLPTR3_WELCOME,a1
    bsr.w               POINTINCOPPERLIST_FUNCT

    move.l              #SCREEN_11,d0
    lea                 BPLPTR4_WELCOME,a1
    bsr.w               POINTINCOPPERLIST_FUNCT
    rts