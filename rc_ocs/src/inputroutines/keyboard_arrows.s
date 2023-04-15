KEYBOARD_ARROWS:

    move.b KEY_ARROW_RIGHT,d0 ; right?
    ror.w #1,d0

    move.b KEY_ARROW_LEFT,d0 ; left?
    ror.w #1,d0

    move.b KEY_ARROW_UP,d0 ; up?
    ror.w #1,d0

    move.b KEY_ARROW_DOWN,d0 ; down?
    ror.w #1,d0

    rol.w #4,d0 ; put back bits into d0 lower byte

    andi.w #$000f,d0     ; clean up

    rts