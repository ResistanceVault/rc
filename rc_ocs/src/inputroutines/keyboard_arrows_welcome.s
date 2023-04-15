KEYBOARD_ARROWS_WELCOME:
    move.l d1,-(sp)
    moveq  #0,d0

    move.b KEY_ARROW_RIGHT,d0
    andi.b #%00000001,d0

    move.b KEY_ARROW_LEFT,d1
    andi.b #%00000010,d1
    or.b   d1,d0

    move.b KEY_ARROW_UP,d1
    andi.b #%00000100,d1
    or.b   d1,d0

    move.b KEY_ARROW_DOWN,d1
    andi.b #%00001000,d1
    or.b   d1,d0

    move.b KEY_ENTER,d1
    andi.b #%00010000,d1
    or.b   d1,d0
    move.l (sp)+,d1
    rts