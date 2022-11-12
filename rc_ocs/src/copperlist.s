    include "AProcessing/libs/copperlistmacros.i"

    SECTION	GRAPHIC,DATA_C

COPPERLIST:

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
  COPSET23BPL

; BplCon2
; Playfield 2 priority over Playfield 1 ON
; Sprites max priority over playfields
  dc.w       $104,$0064

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

	;dc.w	$0190,$000	; color0 - SFONDO
	dc.w	$0192,$f00	; color1 - SCRITTE
	dc.w	$0194,$0f0	; color2 - SCRITTE
	dc.w	$0196,$00f	; color3 - SCRITTE

	dc.w	$FFFF,$FFFE	; Fine della copperlist
