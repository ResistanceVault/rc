_LVOOpenResource     EQU   -498
_LVOFreeMiscResource     EQU   -12
_LVOAllocMiscResource     EQU   -6

MR_PARALLELPORT EQU 2
MR_PARALLELBITS EQU 3

_MiscResource	dc.l	0		; place to store misc.resource base

_ciaaddrb:      dc.b    0		; data direction register
_ciabddra:	dc.b    0		; data direction register
                even

MiscName: DC.B	'misc.resource',0
	even

Name	dc.b	'4play',0		; other applications will know
					; who's tying up the port. ;-)
					even

; This routine simply allocates the parallel port in a system friendly
; way, and sets up the lines we want to use as input lines.
GetParallelPort:
; save registers on the stack

	movem.l	a2-a6/d2-d7,-(sp)	; push regs

;open the misc.resource

	lea	MiscName,a1		; put name of misc.resource in a1
	movea.l	4.w,a6		; put SysBase in a6
	jsr	_LVOOpenResource(a6)
	move.l	d0,_MiscResource	; store address of misc.resource
	bne.s	.grabIt

;Oops, couldn't open misc.resource.  Sounds like big trouble to me.

	moveq	#20,d0			; error code
	bra	.done


;This is where we grab the hardware.  If some other task has allocated
;the parallel data port or the parallel control bits, this routine will
;return non-zero.
;This part grabs the port itself
.grabIt
	lea	Name,a1			; The name of our app
	moveq	#MR_PARALLELPORT,d0	; what we want
	movea.l	_MiscResource,a6	; MiscResource Base is in A6
	jsr	_LVOAllocMiscResource(a6)
	move.l	d0,d1
	beq.s	.grab2

;well, somebody else must've got the port first.

	moveq	#30,d0			; error code
	bra	.done

;This part grabs the control bits (busy, pout, and sel.)
;We really don't need pout, but it comes free with PARALLELBITS,
;so we'll take it anyway.

.grab2	
	DEBUG 1111

	lea	Name,a1			; The name of our app
	moveq	#MR_PARALLELBITS,d0	; what we want
	jsr	_LVOAllocMiscResource(a6)
	move.l	d0,d1
	beq.s	.setRead

;well, somebody else must've got the bits first.

	moveq	#40,d2
	bra	.freeParallelPort


;set up parallel port for reading

.setRead
	move.b	#0,_ciaaddrb		; all lines read
	andi.b	#$FF,_ciabddra		; busy, pout, and sel. to read

;Well, we made it this far, so we've got exclusive access to
;the parallel port, and all the lines we want to use are
;set up.   From here we can just put back the regs and return to
;the caller.

	bra	.done


;If something happened AFTER we got exclusive access to the parallel port,
;we'll need to let go of the port before we return the error.

.freeParallelPort
	moveq	#MR_PARALLELPORT,d0
	movea.l	_MiscResource,a6
	jsr	_LVOFreeMiscResource(a6)

	move.l	d2,d0			; put error code into d0


;Restore registers and return
;(error code is in d0)

.done	movem.l (sp)+,a2-a6/d2-d7	; pop regs
	rts