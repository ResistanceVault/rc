KEYBOARD_NUMPAD:

    move.b KEY_NUMPAD_6,d0 ; right?
    ror.w #1,d0

    move.b KEY_NUMPAD_4,d0 ; left?
    ror.w #1,d0

    move.b KEY_NUMPAD_8,d0 ; up?
    ror.w #1,d0

    move.b KEY_NUMPAD_5,d0 ; down?
    ror.w #1,d0

    rol.w #4,d0 ; put back bits into d0 lower byte

    andi.w #$000f,d0     ; clean up

    rts