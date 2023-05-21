    include "AProcessing/libs/copperlistmacros.i"

    SECTION	GRAPHIC,DATA_C

COPPERLIST:

	; Sprites pointer init
SpritePointers:
Sprite0pointers:
  dc.w       $120,$0000,$122,$0000

Sprite1pointers:
  dc.w       $124,$0000,$126,$0000

Sprite2pointers:
  dc.w       $128,$0000,$12a,$0000

Sprite3pointers:
  dc.w       $12c,$0000,$12e,$0000

Sprite4pointers:
  dc.w       $130,$0000,$132,$0000

Sprite5pointers:
  dc.w       $134,$0000,$136,$0000

Sprite6pointers;
  dc.w       $138,$0000,$13a,$0000

Sprite7pointers:
  dc.w       $13c,$0000,$13e,$0000

	dc.w	$8E,$2c81	; DiwStrt
	dc.w	$90,$2cc1	; DiwStop
	dc.w	$92,$0038	; DdfStart
	dc.w	$94,$00d0	; DdfStop
	dc.w	$102,0		; BplCon1
	dc.w	$104,$24	; BplCon2 - Tutti gli sprite sopra i bitplane
	dc.w	$108,0		; Bpl1Mod
	dc.w	$10a,0		; Bpl2Mod
		    ; 5432109876543210
;	dc.w	$100,%0010001000000000	; 2 bitplane LOWRES 320x256

;BPLPOINTERS:
;BPLPTR1:
;	dc.w $e0,0,$e2,0	;primo	 bitplane
;BPLPOINTERS1:
;BPLPTR2:
;	dc.w $e4,0,$e6,0	;secondo	 bitplane

; Set dual playfield mode, activating PLAYFIELD 1 with bitplanes 1 3 5 and PLAYFIELD 2 with bitplanes 2 4
; Bitplanes 2 4 are double buffered and will be used to paint stuff, PLAYFIELD 1 will contain static image.
  IFD COLOR
  COPSET5BPL
  ELSE
  COPSET23BPL
  ENDC

; BplCon2
; Playfield 2 priority over Playfield 1 ON
; Sprites max priority over playfields
  IFD COLOR
  dc.w       $104,$0064 ;uncomment this and comment the following line to get sprites over everything
  ELSE
  dc.w       $104,$0044;
  ENDC

  IFD COLOR
COPCOLOR0:
  dc.w	$0180,$000
COPCOLOR1:
  dc.w	$0182,$000
COPCOLOR2:
  dc.w	$0184,$000
COPCOLOR3:
  dc.w	$0186,$000
COPCOLOR4:
  dc.w	$0188,$000
COPCOLOR5:
  dc.w	$018A,$000
COPCOLOR6:
  dc.w	$018C,$000
COPCOLOR7:
  dc.w	$018E,$000
  ENDC

; Bitplanes Pointers
BPLPTR1:
  dc.w       $e0,$0000,$e2,$0000                                       ;first	 bitplane - BPL0PT
BPLPTR2:
  dc.w       $e4,$0000,$e6,$0000                                       ;second bitplane - BPL1PT
BPLPTR3:
  dc.w       $e8,$0000,$ea,$0000                                       ;third	 bitplane - BPL2PT
BPLPTR4:
  dc.w       $ec,$0000,$ee,$0000                                       ;fourth bitplane - BPL3PT
BPLPTR5:
  dc.w       $f0,$0000,$f2,$0000                                       ;fifth	 bitplane - BPL4PT

	IFND COLOR
	;dc.w	$0190,$000	; color0 - SFONDO
	dc.w	$0192,$f00	; color1 - SCRITTE
	dc.w	$0194,$0f0	; color2 - SCRITTE
	dc.w	$0196,$00f	; color3 - SCRITTE

	dc.w    $1a2,$222    ; color17
	dc.w    $1a4,$000    ; color18
	dc.w    $1a6,$a00    ; color19
	dc.w    $1a8,$a00    ; color20
	dc.w    $1aa,$390    ; color21
	dc.w    $1ac,$f0f    ; color22
	dc.w    $1ae,$f0f    ; color23
	dc.w    $1b0,$f0f    ; color24
	dc.w    $1b2,$f0f    ; color25
	dc.w    $1b4,$f0f    ; color26
	dc.w    $1b6,$f0f    ; color27
	dc.w    $1b8,$f0f    ; color28
	dc.w    $1ba,$f0f    ; color29
	dc.w    $1bc,$f0f    ; color30
	dc.w    $1be,$f0f    ; color31
	ELSE
	dc.w $ffdf,$fffe ; wait 255
	dc.w $1c07,$fffe ; wait for HUD
	; set HUD BPL POINTERS
	COPSET3BPL
BPLPTR_HUD:
BPLPTR1_HUD:
  	dc.w       $0000,$0000,$0000,$0000                                       ;first	 bitplane - BPL0PT
BPLPTR2_HUD:
  	dc.w       $0000,$0000,$0000,$0000                                       ;second bitplane - BPL1PT
BPLPTR3_HUD:
  	dc.w       $0000,$0000,$0000,$0000                                       ;third	 bitplane - BPL2PT
;BPLPTR4_HUD:
;  	dc.w       $0000,$0000,$0000,$0000                                       ;fourth bitplane - BPL3PT
;BPLPTR5_HUD:
;  	dc.w       $0000,$0000,$0000,$0000                                       ;fifth	 bitplane - BPL4PT


COPHUDCOLOR0:
  	dc.w	$0180,$0000
COPHUDCOLOR1:
	dc.w	$0182,$0000
COPHUDCOLOR2:
	dc.w	$0184,$0000
COPHUDCOLOR3:
	dc.w	$0186,$0000
COPHUDCOLOR4:
	dc.w	$0188,$0000
COPHUDCOLOR5:
	dc.w	$018A,$0000
COPHUDCOLOR6:
	dc.w	$018C,$0000
COPHUDCOLOR7:
	dc.w	$018E,$0000
	ENDC

	dc.w	$FFFF,$FFFE	; Fine della copperlist

; ************ COPPERLIST WELCOME SCREEN START *******************


COPPERLIST_WELCOME:

Sprite0Welcomepointers:
  dc.w       $120,$0000,$122,$0000

;Sprite1pointers:
  dc.w       $124,$0000,$126,$0000

;Sprite2pointers:
  dc.w       $128,$0000,$12a,$0000

;Sprite3pointers:
  dc.w       $12c,$0000,$12e,$0000

;Sprite4pointers:
  dc.w       $130,$0000,$132,$0000

;Sprite5pointers:
  dc.w       $134,$0000,$136,$0000

;Sprite6pointers;
  dc.w       $138,$0000,$13a,$0000

;Sprite7pointers:
  dc.w       $13c,$0000,$13e,$0000

	dc.w	$8E,$2c81	; DiwStrt
	dc.w	$90,$2cc1	; DiwStop
	dc.w	$92,$0038	; DdfStart
	dc.w	$94,$00d0	; DdfStop
	dc.w	$102,0		; BplCon1
	dc.w	$104,$24	; BplCon2
	dc.w	$108,0		; Bpl1Mod
	dc.w	$10a,0		; Bpl2Mod

COPCOLOR_WELCOME_0:
	dc.w	$0180,$000	; color0
COPCOLOR_WELCOME_1:
	dc.w	$0182,$f00	; color1
COPCOLOR_WELCOME_2:
	dc.w	$0184,$0f0	; color2
COPCOLOR_WELCOME_3:
	dc.w	$0186,$00f	; color3
COPCOLOR_WELCOME_4:
	dc.w	$0188,$000	; color4
COPCOLOR_WELCOME_5:
	dc.w	$018A,$f00	; color5
COPCOLOR_WELCOME_6:
	dc.w	$018C,$0f0	; color6
COPCOLOR_WELCOME_7:
	dc.w	$018E,$00f	; color7
	dc.w	$01a0,$d73	; color16
	dc.w    $1a2,$333    ; color17
	dc.w    $1a4,$921    ; color18
	dc.w    $1a6,$a00    ; color19
	dc.w    $1a8,$a00    ; color20
	dc.w    $1aa,$390    ; color21
	dc.w    $1ac,$f0f    ; color22
	dc.w    $1ae,$f0f    ; color23
	dc.w    $1b0,$f0f    ; color24
	dc.w    $1b2,$f0f    ; color25
	dc.w    $1b4,$f0f    ; color26
	dc.w    $1b6,$f0f    ; color27
	dc.w    $1b8,$f0f    ; color28
	dc.w    $1ba,$f0f    ; color29
	dc.w    $1bc,$f0f    ; color30
	dc.w    $1be,$f0f    ; color31


	; Bitplanes Pointers
BPLPTR1_WELCOME:
  dc.w       $e0,$0000,$e2,$0000                                       ;first	 bitplane - BPL0PT
BPLPTR2_WELCOME:
  dc.w       $e4,$0000,$e6,$0000                                       ;second bitplane - BPL1PT
BPLPTR3_WELCOME:
  dc.w       $e8,$0000,$ea,$0000                                       ;third	 bitplane - BPL2PT
BPLPTR4_WELCOME:
  dc.w       $ec,$0000,$ee,$0000                                       ;fourth bitplane - BPL3PT

  COPSET4BPL

    dc.w	$FFFF,$FFFE	;
; END OF COPPERLIST_WELCOME

; ************ COPPERLIST WELCOME INTRO START *******************
COPPERLIST_INTRO:

Sprite0Intropointers:
  dc.w       $120,$0000,$122,$0000

;Sprite1pointers:
  dc.w       $124,$0000,$126,$0000

;Sprite2pointers:
  dc.w       $128,$0000,$12a,$0000

;Sprite3pointers:
  dc.w       $12c,$0000,$12e,$0000

;Sprite4pointers:
  dc.w       $130,$0000,$132,$0000

;Sprite5pointers:
  dc.w       $134,$0000,$136,$0000

;Sprite6pointers;
  dc.w       $138,$0000,$13a,$0000

;Sprite7pointers:
  dc.w       $13c,$0000,$13e,$0000

	dc.w	$8E,$2c81	; DiwStrt
	dc.w	$90,$2cc1	; DiwStop
	dc.w	$92,$0038	; DdfStart
	dc.w	$94,$00d0	; DdfStop
	dc.w	$102,0		; BplCon1
	dc.w	$104,$24	; BplCon2
	dc.w	$108,0		; Bpl1Mod
	dc.w	$10a,0		; Bpl2Mod

COPCOLOR_INTRO_0:
	dc.w	$0180,$000	; color0
COPCOLOR_INTRO_1:
	dc.w	$0182,$000	; color1
COPCOLOR_INTRO_2:
	dc.w	$0184,$000	; color2
COPCOLOR_INTRO_3:
	dc.w	$0186,$000	; color3
COPCOLOR_INTRO_4:
	dc.w	$0188,$000	; color4
COPCOLOR_INTRO_5:
	dc.w	$018A,$000	; color5
COPCOLOR_INTRO_6:
	dc.w	$018C,$000	; color6
COPCOLOR_INTRO_7:
	dc.w	$018E,$000	; color7

	; Bitplanes Pointers
BPLPTR1_INTRO:
  dc.w       $e0,$0000,$e2,$0000                                       ;first	 bitplane - BPL0PT
BPLPTR2_INTRO:
  dc.w       $e4,$0000,$e6,$0000                                       ;second bitplane - BPL1PT
BPLPTR3_INTRO:
  dc.w       $e8,$0000,$ea,$0000                                       ;third	 bitplane - BPL2PT

  COPSET3BPL

    dc.w	$FFFF,$FFFE	;
; END OF COPPERLIST_INTRO



; ************ COPPERLIST TRACK SELECTION START *******************


COPPERLIST_TRACK:

Sprite0Trackpointers:
  dc.w       $120,$0000,$122,$0000

;Sprite1pointers:
  dc.w       $124,$0000,$126,$0000

;Sprite2pointers:
  dc.w       $128,$0000,$12a,$0000

;Sprite3pointers:
  dc.w       $12c,$0000,$12e,$0000

;Sprite4pointers:
  dc.w       $130,$0000,$132,$0000

;Sprite5pointers:
  dc.w       $134,$0000,$136,$0000

;Sprite6pointers;
  dc.w       $138,$0000,$13a,$0000

;Sprite7pointers:
  dc.w       $13c,$0000,$13e,$0000

  dc.w		 $8E,$2c81	; DiwStrt
  dc.w		 $90,$2cc1	; DiwStop
  dc.w		 $92,$0038	; DdfStart
  dc.w		 $94,$00d0	; DdfStop
  dc.w		 $102,0		; BplCon1
  dc.w		 $104,$24	; BplCon2
  dc.w		 $108,0		; Bpl1Mod
  dc.w		 $10a,0		; Bpl2Mod

	; Bitplanes Pointers
BPLPTR1_TRACK:
  dc.w       $e0,$0000,$e2,$0000                                       ;first	 bitplane - BPL0PT
BPLPTR2_TRACK:
  dc.w       $e4,$0000,$e6,$0000                                       ;second bitplane - BPL1PT
BPLPTR3_TRACK:
  dc.w       $e8,$0000,$ea,$0000                                       ;third	 bitplane - BPL2PT
BPLPTR4_TRACK:
  dc.w       $ec,$0000,$ee,$0000                                       ;fourth bitplane - BPL3PT
BPLPTR5_TRACK:
  dc.w       $f0,$0000,$f2,$0000
  COPSET5BPL

COPCOLOR_TRACK_BANNER_0:
	dc.w	$0180,$000	; color0
COPCOLOR_TRACK_BANNER_1:
	dc.w	$0182,$FFF	; color1
COPCOLOR_TRACK_BANNER_2:
	dc.w	$0184,$FFF	; color2
COPCOLOR_TRACK_BANNER_3:
	dc.w	$0186,$FFF	; color3
COPCOLOR_TRACK_BANNER_4:
	dc.w	$0188,$FFF	; color4
COPCOLOR_TRACK_BANNER_5:
	dc.w	$018A,$FFF	; color5
COPCOLOR_TRACK_BANNER_6:
	dc.w	$018C,$FFF	; color6
COPCOLOR_TRACK_BANNER_7:
	dc.w	$018E,$FFF	; color7

	dc.w    $6B01,$FFFE;  wait last line of banner top

COPCOLOR_TRACK_0:
	dc.w	$0180,$000	; color0
COPCOLOR_TRACK_1:
	dc.w	$0182,$000	; color1
COPCOLOR_TRACK_2:
	dc.w	$0184,$000	; color2
COPCOLOR_TRACK_3:
	dc.w	$0186,$000	; color3
COPCOLOR_TRACK_4:
	dc.w	$0188,$000	; color4
COPCOLOR_TRACK_5:
	dc.w	$018A,$000	; color5
COPCOLOR_TRACK_6:
	dc.w	$018C,$000	; color6
COPCOLOR_TRACK_7:
	dc.w	$018E,$000	; color7
COPCOLOR_TRACK_8:
	dc.w	$0190,$000	; color8
COPCOLOR_TRACK_9:
	dc.w	$0192,$000	; color9
COPCOLOR_TRACK_10:
	dc.w	$0194,$000	; color10
COPCOLOR_TRACK_11:
	dc.w	$0196,$000	; color11
COPCOLOR_TRACK_12:
	dc.w	$0198,$000	; color12
COPCOLOR_TRACK_13:
	dc.w	$019A,$000	; color13
COPCOLOR_TRACK_14:
	dc.w	$019C,$000	; color14
COPCOLOR_TRACK_15:
	dc.w	$019E,$000	; color15
COPCOLOR_TRACK_16:
	dc.w	$01a0,$000	; color16
COPCOLOR_TRACK_17:
	dc.w	$01a2,$000	; color17
COPCOLOR_TRACK_18:
	dc.w	$01a4,$000	; color18
COPCOLOR_TRACK_19:
	dc.w	$01a6,$000	; color19
COPCOLOR_TRACK_20:
	dc.w	$01a8,$000	; color20
COPCOLOR_TRACK_21:
	dc.w	$01aa,$000	; color21
COPCOLOR_TRACK_22:
	dc.w	$01ac,$000	; color22
COPCOLOR_TRACK_23:
	dc.w	$01ae,$000	; color23
COPCOLOR_TRACK_24:
	dc.w	$1b0,$000	; color24
COPCOLOR_TRACK_25:
	dc.w	$1b2,$000	; color25
COPCOLOR_TRACK_26:
	dc.w	$1b4,$000	; color26
COPCOLOR_TRACK_27:
	dc.w	$1b6,$000	; color27
COPCOLOR_TRACK_28:
	dc.w	$1b8,$000	; color28
COPCOLOR_TRACK_29:
	dc.w	$1ba,$000	; color29
COPCOLOR_TRACK_30:
	dc.w	$1bc,$000	; color30
COPCOLOR_TRACK_31:
	dc.w	$1be,$000	; color31

	dc.w    $E401,$FFFE;  wait last line of thumbnail
COPCOLOR_TRACK_BANNER2_0:
	dc.w	$0180,$000	; color0
COPCOLOR_TRACK_BANNER2_1:
	dc.w	$0182,$FFF	; color1
COPCOLOR_TRACK_BANNER2_2:
	dc.w	$0184,$FFF	; color2
COPCOLOR_TRACK_BANNER2_3:
	dc.w	$0186,$FFF	; color3
COPCOLOR_TRACK_BANNER2_4:
	dc.w	$0188,$FFF	; color4
COPCOLOR_TRACK_BANNER2_5:
	dc.w	$018A,$FFF	; color5
COPCOLOR_TRACK_BANNER2_6:
	dc.w	$018C,$FFF	; color6
COPCOLOR_TRACK_BANNER2_7:
	dc.w	$018E,$FFF	; color7

  dc.w	$FFFF,$FFFE	;
; END OF COPPERLIST_TRACK_SELECTION

COPPERLIST_MAIN:

Sprite0Mainpointers:
  dc.w       $120,$0000,$122,$0000
  dc.w       $124,$0000,$126,$0000
  dc.w       $128,$0000,$12a,$0000
  dc.w       $12c,$0000,$12e,$0000
  dc.w       $130,$0000,$132,$0000
  dc.w       $134,$0000,$136,$0000
  dc.w       $138,$0000,$13a,$0000
  dc.w       $13c,$0000,$13e,$0000

  dc.w		 $8E,$2c81	; DiwStrt
  dc.w		 $90,$2cc1	; DiwStop
  dc.w		 $92,$0038	; DdfStart
  dc.w		 $94,$00d0	; DdfStop
  dc.w		 $102,0		; BplCon1
  dc.w		 $104,$24	; BplCon2
  dc.w		 $108,0		; Bpl1Mod
  dc.w		 $10a,0		; Bpl2Mod

	; Bitplanes Pointers
BPLPTR1_MAIN:
  dc.w       $e0,$0000,$e2,$0000                                       ;first	 bitplane - BPL0PT
BPLPTR2_MAIN:
  dc.w       $e4,$0000,$e6,$0000                                       ;second bitplane - BPL1PT
BPLPTR3_MAIN:
  dc.w       $e8,$0000,$ea,$0000                                       ;third	 bitplane - BPL2PT
BPLPTR4_MAIN:
  dc.w       $ec,$0000,$ee,$0000                                       ;fourth bitplane - BPL3PT
BPLPTR5_MAIN:
  dc.w       $f0,$0000,$f2,$0000
  COPSET5BPL

COPCOLOR_MAIN_0:
	dc.w	$0180,$000	; color0
COPCOLOR_MAIN_1:
	dc.w	$0182,$000	; color1
COPCOLOR_MAIN_2:
	dc.w	$0184,$000	; color2
COPCOLOR_MAIN_3:
	dc.w	$0186,$000	; color3
COPCOLOR_MAIN_4:
	dc.w	$0188,$000	; color4
COPCOLOR_MAIN_5:
	dc.w	$018A,$000	; color5
COPCOLOR_MAIN_6:
	dc.w	$018C,$000	; color6
COPCOLOR_MAIN_7:
	dc.w	$018E,$000	; color7
COPCOLOR_MAIN_8:
	dc.w	$0190,$000	; color8
COPCOLOR_MAIN_9:
	dc.w	$0192,$000	; color9
COPCOLOR_MAIN_10:
	dc.w	$0194,$000	; color10
COPCOLOR_MAIN_11:
	dc.w	$0196,$000	; color11
COPCOLOR_MAIN_12:
	dc.w	$0198,$000	; color12
COPCOLOR_MAIN_13:
	dc.w	$019A,$000	; color13
COPCOLOR_MAIN_14:
	dc.w	$019C,$000	; color14
COPCOLOR_MAIN_15:
	dc.w	$019E,$000	; color15
COPCOLOR_MAIN_16:
	dc.w	$01a0,$000	; color16
COPCOLOR_MAIN_17:
	dc.w	$01a2,$000	; color17
COPCOLOR_MAIN_18:
	dc.w	$01a4,$000	; color18
COPCOLOR_MAIN_19:
	dc.w	$01a6,$000	; color19
COPCOLOR_MAIN_20:
	dc.w	$01a8,$000	; color20
COPCOLOR_MAIN_21:
	dc.w	$01aa,$000	; color21
COPCOLOR_MAIN_22:
	dc.w	$01ac,$000	; color22
COPCOLOR_MAIN_23:
	dc.w	$01ae,$000	; color23
COPCOLOR_MAIN_24:
	dc.w	$1b0,$000	; color24
COPCOLOR_MAIN_25:
	dc.w	$1b2,$000	; color25
COPCOLOR_MAIN_26:
	dc.w	$1b4,$000	; color26
COPCOLOR_MAIN_27:
	dc.w	$1b6,$000	; color27
COPCOLOR_MAIN_28:
	dc.w	$1b8,$000	; color28
COPCOLOR_MAIN_29:
	dc.w	$1ba,$000	; color29
COPCOLOR_MAIN_30:
	dc.w	$1bc,$000	; color30
COPCOLOR_MAIN_31:
	dc.w	$1be,$000	; color31

	dc.w    $D401,$FFFE;  wait last line of thumbnail
COPCOLOR2_MAIN_0:
	dc.w	$0180,$000	; color0
COPCOLOR2_MAIN_1:
	dc.w	$0182,$000	; color1
COPCOLOR2_MAIN_2:
	dc.w	$0184,$000	; color2
COPCOLOR2_MAIN_3:
	dc.w	$0186,$000	; color3
COPCOLOR2_MAIN_4:
	dc.w	$0188,$000	; color4
COPCOLOR2_MAIN_5:
	dc.w	$018A,$000	; color5
COPCOLOR2_MAIN_6:
	dc.w	$018C,$000	; color6
COPCOLOR2_MAIN_7:
	dc.w	$018E,$000	; color7
COPCOLOR2_MAIN_8:
	dc.w	$0190,$000	; color8
COPCOLOR2_MAIN_9:
	dc.w	$0192,$000	; color9
COPCOLOR2_MAIN_10:
	dc.w	$0194,$000	; color10
COPCOLOR2_MAIN_11:
	dc.w	$0196,$000	; color11
COPCOLOR2_MAIN_12:
	dc.w	$0198,$000	; color12
COPCOLOR2_MAIN_13:
	dc.w	$019A,$000	; color13
COPCOLOR2_MAIN_14:
	dc.w	$019C,$000	; color14
COPCOLOR2_MAIN_15:
	dc.w	$019E,$000	; color15
COPCOLOR2_MAIN_16:
	dc.w	$01a0,$000	; color16
COPCOLOR2_MAIN_17:
	dc.w	$01a2,$000	; color17
COPCOLOR2_MAIN_18:
	dc.w	$01a4,$000	; color18
COPCOLOR2_MAIN_19:
	dc.w	$01a6,$000	; color19
COPCOLOR2_MAIN_20:
	dc.w	$01a8,$000	; color20
COPCOLOR2_MAIN_21:
	dc.w	$01aa,$000	; color21
COPCOLOR2_MAIN_22:
	dc.w	$01ac,$000	; color22
COPCOLOR2_MAIN_23:
	dc.w	$01ae,$000	; color23
COPCOLOR2_MAIN_24:
	dc.w	$1b0,$000	; color24
COPCOLOR2_MAIN_25:
	dc.w	$1b2,$000	; color25
COPCOLOR2_MAIN_26:
	dc.w	$1b4,$000	; color26
COPCOLOR2_MAIN_27:
	dc.w	$1b6,$000	; color27
COPCOLOR2_MAIN_28:
	dc.w	$1b8,$000	; color28
COPCOLOR2_MAIN_29:
	dc.w	$1ba,$000	; color29
COPCOLOR2_MAIN_30:
	dc.w	$1bc,$000	; color30
COPCOLOR2_MAIN_31:
	dc.w	$1be,$000	; color31
  dc.w	$FFFF,$FFFE	;
; END OF COPPERLIST_MAIN