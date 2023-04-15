KEYBOARD_WASD_WELCOME:
    ; start algo
    move.b KEY_D,d0 ; right?
    ror.w #1,d0

    move.b KEY_A,d0 ; left?
    ror.w #1,d0

    move.b KEY_W,d0 ; up?
    ror.w #1,d0

    move.b KEY_S,d0 ; down?
    ror.w #1,d0

    move.b KEY_ENTER,d0 ; fire?
    ror.w #1,d0

    rol.w #5,d0 ; put back bits into d0 lower byte

    andi.w #$001f,d0     ; clean up

    rts