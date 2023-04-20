                                rsset   0
input_routines_Function         rs.l    1
input_routines_Description      rs.l    1
input_routines_SIZEOF           rs.b    0

READJOY1_DESC:          dc.b "JOY 1",$FF
                        even
KEYBOARD_WASD_DESC:     dc.b "WASD",$FF
                        even
KEYBOARD_IJKL_DESC:     dc.b "IJKL",$FF
                        even
KEYBOARD_ARROWS_DESC:   dc.b "ARROWS",$FF
                        even

ROUTINES_INPUTLIST:
    dc.l  READJOY1
    dc.l  READJOY1_DESC

    dc.l  KEYBOARD_WASD
    dc.l  KEYBOARD_WASD_DESC

    dc.l  KEYBOARD_IJKL
    dc.l  KEYBOARD_IJKL_DESC

    dc.l  KEYBOARD_ARROWS
    dc.l  KEYBOARD_ARROWS_DESC

    dc.l 0
    dc.l 0