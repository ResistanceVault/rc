                                rsset   0
input_routines_Function         rs.l    1
input_routines_Description      rs.l    1
input_routines_SIZEOF           rs.b    0

READJOY1_DESC:          dc.b "JOY 1",$FF
                        even
CPU_DESC:               dc.b "CPU   ",$FF
                        even
KEYBOARD_WASD_DESC:     dc.b "WASD  ",$FF
                        even
KEYBOARD_IJKL_DESC:     dc.b "IJKL  ",$FF
                        even
KEYBOARD_ARROWS_DESC:   dc.b "ARROWS",$FF
                        even
READJOY0_DESC:          dc.b "JOY 0 ",$FF
                        even
READJOY2_DESC:          dc.b "JOY 2 ",$FF
                        even
READJOY3_DESC:          dc.b "JOY 3 ",$FF
                        even
READJOY4_DESC:          dc.b "NPAD  ",$FF
                        even
OFF_DESC:               dc.b "OFF   ",$FF
                        even

ROUTINES_INPUTLIST:
    dc.l  READJOY1
    dc.l  READJOY1_DESC

    dc.l  CPUCONTROL
    dc.l  CPU_DESC

    dc.l  KEYBOARD_WASD
    dc.l  KEYBOARD_WASD_DESC

    dc.l  KEYBOARD_IJKL
    dc.l  KEYBOARD_IJKL_DESC

    dc.l  KEYBOARD_ARROWS
    dc.l  KEYBOARD_ARROWS_DESC

    dc.l  READJOY0
    dc.l  READJOY0_DESC

    dc.l  READJOY2
    dc.l  READJOY2_DESC

    dc.l  READJOY3
    dc.l  READJOY3_DESC

    dc.l  KEYBOARD_NUMPAD
    dc.l  READJOY4_DESC

    dc.l  0
    dc.l  OFF_DESC

    dc.l 0
    dc.l 0