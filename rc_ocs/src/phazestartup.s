;======================================================================================================================
; 680x0 & AGA Startup File
; By Prince / Phaze101
; Version 1.0
; Based on Fabio Ciucci Startup File Complexity 2
; https://linktr.ee/phaze101
;
; ██████╗ ██╗  ██╗ █████╗ ███████╗███████╗ ██╗ ██████╗  ██╗
; ██╔══██╗██║  ██║██╔══██╗╚══███╔╝██╔════╝███║██╔═████╗███║
; ██████╔╝███████║███████║  ███╔╝ █████╗  ╚██║██║██╔██║╚██║
; ██╔═══╝ ██╔══██║██╔══██║ ███╔╝  ██╔══╝   ██║████╔╝██║ ██║
; ██║     ██║  ██║██║  ██║███████╗███████╗ ██║╚██████╔╝ ██║
; ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚══════╝ ╚═╝ ╚═════╝  ╚═╝
;----------------------------------------------------------------------------------------------------------------------
;
; Additions to Original
;
; 01. Done - Converted to English
; 02. Done - Full converted to the Visual Code Extention
; 03. Done - Code Formatting / Tabulation / Case etc
; 04. Detects Processor
; 05. OCS or ECS or AGA
; 06. Detects Total Memory
; 07. Detects Amount of Chipmem
; 08. Detects Amount of Fastmem
; 09. Detects Pal or NTSC system
; 10. Detects Kickstart Rom Version
; 11. Done - A600 Compatible (Fabio's version had an issue with A600)
; 12. Add Music
; 13. Add Intro screen
; 14. Load Function
; 15. Done - Fix Bug of LoadRGB4
; 16. Fix Bug of ResetSpritesV39
;
;----------------------------------------------------------------------------------------------------------------------
; To Fix
; The colour part of LoadRGB4 - It is not needed and can't understand why we go into that trouble
;
;----------------------------------------------------------------------------------------------------------------------
;
; Documentaiton provided separately
; Check the file Startup101_HowTo.txt
;
;======================================================================================================================

MainCode:
		movem.l	d0-d7/a0-a6,-(SP)				; Save All Registers

	;------------------------------------------------------------------------------------------------------------------
	; Get teh DosBase Address
		move.l	4.w,a6							; ExecBase in a6
		lea		DosName(PC),a1					; A1 = Address of library string name "dos.library"
		jsr		-$198(a6)						; Call - Library (d0) = OldOpenLibrary(libName,A1)
		move.l	d0,DosBase						; Save the Dos Base in D0 in the DosBase variable
		beq.w	Exit3							; If this is a zero exit

	;------------------------------------------------------------------------------------------------------------------
	; Get the Graphics Library Base
		lea		GfxName(PC),a1					; A1 = Address of library string name "graphics.library"
		jsr		-$198(a6)						; Call - Library (d0) = OldOpenLibrary(libName,A1)
		move.l	d0,GfxBase						; Save the Graphics Base in D0 in the GfxBase variable
		beq.w	Exit2							; If this is a zero exit

	;------------------------------------------------------------------------------------------------------------------
	; Get the Intuition Base
		lea		IntuiName(PC),a1				; A1 = Address of library string name "intiution.library"
		jsr		-$198(a6)						; Call - Library (d0) = OldOpenLibrary(libName,A1)
		move.l	d0,IntuiBase					; Save the Intiution Base in D0 in the IntuiBase variable
		beq.w	Exit1							; If this is a zero exit

	;------------------------------------------------------------------------------------------------------------------
	; Check the Intuition Version
		move.l	d0,a0							; Intuition Library Base (Structure is Library Base)
		cmp.w	#39,$14(a0)						; Is it Version 39 or better? (kick3.0+)
		blt.s	OldIntuition					; Let than 36 then jump to OldIntuition

	;------------------------------------------------------------------------------------------------------------------
	; Save color 0

		bsr.w	ResetSpritesV39					; If it is kick3.0+ then reset sprites

		; *** Missing code here
		; if screen no blocked we need to exit

	OldIntuition:
	;------------------------------------------------------------------------------------------------------------------
	; Save color 0
		move.l	IntuiBase(PC),a6				; Load A6 with Intuition Base Address
		move.l	$3c(a6),a0						; $3c - First Screen in Intuition Base (Ib_FirstScreen)
		; *** Replace with Below -LEA	$2c(A0),A0	;  vp  =  A pointer to a ViewPort structure.
		move.l	$2c(a0),a0						; $2c =  A pointer to a ViewPort structure
		move.l	a0,VPFirstScreen				; Save the First Screen ViewPort Structure Address
		move.l	4(a0),a0						; colormap = Colour Map of current ViewPort
		moveq	#0,d0							; entry - I want to have the Colour 0 (background Colour)
		move.l	GfxBase(PC),a6					; A6 = Address of the Graphics Library name "graphics.library"
		jsr		-$246(a6)						; GetRGB4(colorMap,entry)(a0,d0) - Get the Value of colour 0
												; From the Screen Colour Map (-1 if error!)
		move.w	d0,TSavedColour0				; Save the Value of Colour 0 in the variable TSaveColour0

	;------------------------------------------------------------------------------------------------------------------
	; Let's Change Colour 0
		; *** Replaced with  below - move.l	VPfirstScreen(PC),a0
		lea		VPFirstScreen(PC),a0			; First Screen ViewPort Structure Address
		lea		Colour0(PC),a1					; Colour0 - $0RGB
		moveq.l	#1,d0							; Which Index - Only the Background colour
		jsr		-$c0(a6)						; LoadRGB4(vp,colors,count)(a0/a1,d0) - Load RGB Colour Values From Table

	;------------------------------------------------------------------------------------------------------------------
	; Set the screen Colour background
		move.l	$22(a6),WBActiView				; Save the WB Active View of the AmigaOS 
		sub.l	a1,a1							; Clear a1 or make it 0
		jsr		-$de(a6)						; LoadView(view)(a1) LoadView Null or 0 no view is displayed
		sub.l	a1,a1							; Clear a1 or make it 0
		jsr		-$de(a6)						; LoadView - (To be sure due to different versions of OS)
		jsr		-$10e(a6)						; WaitTOF()() - Called more than once to reset the interface
		jsr		-$10e(a6)						; WaitTOF()() - Wait for 4 Frames
		jsr		-$10e(a6)						; WaitTOF()() - To give chance to the OS to clear everything
		jsr		-$10e(a6)						; WaitTOF()()

	;------------------------------------------------------------------------------------------------------------------
	; Switch off all Input
		bsr.w	InputOFF						; Disable the intution Input, hence do not read mouse and keyboard input

	;------------------------------------------------------------------------------------------------------------------
	; Get this process of this current program
		move.l	4.w,a6							; Get the Exec Base
		sub.l	a1,a1							; Clear a1 or make it 0 - NULL task - Find this task
		jsr		-$126(a6)						; FindTask(name)(a1) - Find the current process of this same program -> d0=task
		move.l	d0,a1							; Process in a1
		move.l	d0,ThisTask						; Save Process in varaible ThisTask
		
	;------------------------------------------------------------------------------------------------------------------
	; Stop the opening of requesters from DOS
		move.l	$b8(a1),pr_WindowPtr			; $b8 - Save the address of the Window from which the program was run
												; which is necessary for DOS to know from where the request was opened

	;------------------------------------------------------------------------------------------------------------------
	; Set Process priority to -1 (-128 lowest, +127 Highest)
		move.l	#-1,$b8(a1)						; Set to -1 DOS does not open Requesters.
												; In fact if there is an error when opening a file using
												; the dos.lib, the system will try to open a requester,
												; but with the blitter disabled (OwnBlit) it can't.
												; When disabled it can't draw to screen because everything is blocked.
		moveq	#-1,d0							; Priority in d0 (-128, +127)
		jsr		-$12c(a6)						; SetTaskPri(task,priority)(a1,d0) 

	;------------------------------------------------------------------------------------------------------------------
	; Make sure that the Hard Disk and Floppy Drive have finished their activity
		lea		$dff006,a5						; VhPosr
		lea		$bfe001,a4						; Register to check Left mouse button
		moveq	#6,d2							; Used to wait for Checking the mouse

		move.w	#$dd,d0							; Raster Line to Wait
		move.w	#WaitDisk,D1					; How many times to at the Rasterline to be sure that the Disk Drive
												; or Hard Disk have finished
	WaitaLoop:							
		btst.b	d2,(a4)							; btst #6,$bfe001 -> Wait for the left mouse button pressed
		beq.s	SkippaWait						; Now check for Release

		cmp.b	(a5),d0							; Are we on the raster line $dd
		bne.s	WaitaLoop						; No Loop back else do a loop to test if we are on the same line

	Wait2:
		cmp.B	(a5),d0							; Are we still on Raster line $dd
		beq.s	Wait2							; If so Continue to wait
		dbra	d1,WaitaLoop					; Decrement D1 (how many times we have to wait) and exit when all done
	
	SkippaWait:
		btst.b	d2,(a4)							; btst #6,$bfe001 -> Wait for the left mouse button released
		beq.s	SkippaWait

	;------------------------------------------------------------------------------------------------------------------
	; Set current process to highest priority
		move.l	4.w,a6							; Get Exec Base
		move.l	ThisTask(PC),a1					; Task in a1
		moveq	#127,d0							; Set priority in d0 to Maximum (-128, +127)
		jsr		-$12C(a6)						; SetTaskPri(task,priority)(a1,d0)

	;------------------------------------------------------------------------------------------------------------------
	; Own the blitter
		move.l	GfxBase(PC),a6
		jsr		-$1c8(a6)						; OwnBlitter(), we get exclusive blitter ownership from the OS
		jsr		-$e4(a6)						; WaitBlit() - Wait for the blitter to be finished before proceeding
		jsr		-$e4(a6)						; WaitBlit()

	;------------------------------------------------------------------------------------------------------------------
	; Disable Multitasking
		move.l	4.w,a6							; ExecBase in A6
		jsr		-$84(a6)						; Forbid() - Disable Multitasking

	;------------------------------------------------------------------------------------------------------------------
	; Disable Interrupts
		jsr		-$78(A6)						; Disable() - disable interrupt processing

	;------------------------------------------------------------------------------------------------------------------
	; Work with Hardware registers directly
		bsr.w	HeavyInit						; Now you can work on the hardware register directly

	;------------------------------------------------------------------------------------------------------------------
	; Enable Interrupts
		move.l	4.w,a6							; ExecBase in A6
		jsr		-$7e(a6)						; Enable() - permit system interrupts to resume

	;------------------------------------------------------------------------------------------------------------------
	; Enable Multitasking
		jsr		-$8a(a6)						; Permit() - permit task rescheduling

	;------------------------------------------------------------------------------------------------------------------
	; Set the task Priority to Normal
		move.l	ThisTask(PC),a1					; Task in a1
		move.l	pr_WindowPtr(PC),$b8(a1)		; Restore Window Address
		moveq	#0,d0							; Set priority to Normal 0 in d0 (-128, +127)
		jsr		-$12c(a6)						; SetTaskPri(task,priority)(a1,d0)

	;------------------------------------------------------------------------------------------------------------------
	; Release the blitter to be used by the OS
		move.l	GfxBase(PC),a6					; GfxBase in A6
		jsr		-$e4(a6)						; WaitBlit() - Wait for the blitter to be finished before proceeding
		jsr		-$e4(a6)						; WaitBlit()
		jsr		-$1ce(a6)						; DisownBlitter(), return blitter to free state so OS can use it

	;------------------------------------------------------------------------------------------------------------------
	; Release the blitter to be used by the OS
		move.l	IntuiBase(PC),a0				; Intuition Library Base (Structure is Library Base)
		cmp.w	#39,$14(a0)						; Is it greater than V39+ ?
		blt.s	OldIntuitionRestore				; No, then jump to OldIntuitionRestore
		bsr.w	RestoreSprites					; Yes, Restore Sprites 
	
	OldIntuitionRestore:
	;------------------------------------------------------------------------------------------------------------------
	; Restore Colour 0
		move.l	GfxBase(PC),a6					; GfxBase in A6
		; *** move.l	VPFirstScreen(PC),a0
		lea		VPFirstScreen(PC),a0			; First Screen ViewPort Structure Address
		lea		TSavedColour0(PC),a1			; Colour0 - $0RGB
		moveq.l	#1,d0							; Which Index - Only the Background colour
		jsr		-$C0(a6)						; LoadRGB4(vp,colors,count)(a0/a1,d0) - Load RGB Colour Values From Table

	;------------------------------------------------------------------------------------------------------------------
	; Restore the WB / DOS Active View or Window
		move.l	WBActiView(PC),a1				; Old WB Active View in A1
		jsr		-$de(a6)						; LoadView(view)(a1) LoadView Null or 0 no view is displayed
		jsr		-$10e(a6)						; WaitTOF()() - Called more than once to reset the interface
		jsr		-$10e(a6)						; WaitTOF()()

	;------------------------------------------------------------------------------------------------------------------
	; Restore Bit Plane Control Register to its default $0011 or $0000 0000 0001 0001
		move.w	#$11,$dff10c					; Restore Bit Plane Control Register (display masks)

	;------------------------------------------------------------------------------------------------------------------
	; Restore Copper location registers COP1LCx and COP2LCx
		move.l	$26(a6),$dff080					; COP1LC - Punta la vecchia copper1 di sistema
		move.l	$32(a6),$dff084					; COP2LC - Punta la vecchia copper2 di sistema

	;------------------------------------------------------------------------------------------------------------------
	; Enable all Input again to the OS
		bsr.w	InputOn							; Enable Input Again

	;------------------------------------------------------------------------------------------------------------------
	; Restore the OS display - redraw everything back
		move.l	IntuiBase(PC),a6				; Intuition Library Base (Structure is Library Base)
		jsr		-$186(a6)						; RethinkDisplay()() - Grand manipulation of the entire Intuition display
												; Redraw all the screen including ViewPorts

	;------------------------------------------------------------------------------------------------------------------
	; Close Intuition Library
		move.l	a6,a1							; Load A6 with Intuition Base Address
		move.l	4.w,a6							; ExecBase in A6
		jsr		-$19e(a6)						; CloseLibrary(library)(a1) - Close the intuition.library

	Exit1:
	;------------------------------------------------------------------------------------------------------------------
	; Close Graphics Library
		move.l	GfxBase(PC),a1					; GfxBase in A1
		jsr		-$19e(a6)						; CloseLibrary(library)(a1) - Close graphics.library

	Exit2:
	;------------------------------------------------------------------------------------------------------------------
	; Close Dos Library
		MOVE.L	DosBase(PC),a1					; DosBase in A1 per chiudere la libreria
		jsr		-$19e(a6)						; CloseLibrary(library)(a1) - Close dos.library

	Exit3:
	;------------------------------------------------------------------------------------------------------------------
	; Restore all regsiters as they where to the OS
		movem.l	(SP)+,d0-d7/a0-a6 				; Restore all the registers
		RTS			  							; Return to the OS

;======================================================================================================================
; Main Code Variables 
;======================================================================================================================

; Window Address Pointer from where program was launched
pr_WindowPtr:
	dc.l	0
	even

; Our Program Background Colour
Colour0:
	dc.w	$0012
	even

; OS Background Colour
TSavedColour0:
	dc.w	0
	even

;Active Viewport of first Screen
VPFirstScreen:
		dc.l	0
		even

; This program process or task
ThisTask:
		dc.l	0
		even

;======================================================================================================================
; Reset the sprite resolution legally
;======================================================================================================================

ResetSpritesV39:
	;------------------------------------------------------------------------------------------------------------------
	; Save the Workbench Screen as is
		move.l	IntuiBase(PC),a6				; Load A6 with Intuition Base Address
		lea		Workbench(PC),a0				; Name of Workbench screen 
		jsr		-$1fe(a6)						; LockPubScreen(name)(a0) - Prevent a public screen from closing

		move.l	d0,BlockedScreen				; Screen Structure of blocked Screen
		beq.s	ErrorScreen						; If D0 has no structure address and is 0 then exit
		move.l	d0,a0							; Screen Structure in a0
		move.l	$30(a0),a0						; From Screen Structure we get the Viewport Structure which
												; is in the screen structure ($2c).
												; From Viewport offset of $2c we add $04 hence $30 to get
												; the Viewport Colour Map address.
												; In A0 we have the Colour Map address.
												; This is needed to execute the video Control of the Graphics.library  
		lea		GETVidCtrlTags(PC),a1			; The request the that we do to the Video_Control Routine
												; is that of the VTAG_SPRITERESN_GET which means that
												; we want to know the resolution of the current actual sprites
		move.l	GfxBase(PC),a6
		jsr		-$2c4(a6)						; VideoControl(colorMap,tagarray)(a0/a1)
												; VideoControl will report back in the laglist
												; in the long word *resolution* the actual
												; sprite resolution of that screen.

	;------------------------------------------------------------------------------------------------------------------
	; So now lets save the resolution of the current screen.
	; For example the assembler screen if run from the assembler.

		; Save the Current Screen from where we are executing this
		move.l	IntuiBase(PC),a6				; Load A6 with Intuition Base Address
		move.l	$3c(a6),a0						; $3c - First Screen in Intuition Base (Ib_FirstScreen)
		move.l	$30(a0),a0						; From Screen Structure we get the Viewport Structure which
												; is in the screen structure ($2c).
												; From Viewport offset of $2c we add $04 hence $30 to get
												; the Viewport Colour Map address.
												; In A0 we have the Colour Map address.
												; This is needed to execute the video Control of the Graphics.library  
		lea		GETVidCtrlTags2(PC),a1			; The request the that we do to the Video_Control Routine
												; is that of the VTAG_SPRITERESN_GET which means that
												; we want to know the resolution of the current actual sprites
		move.l	GfxBase(PC),a6
		jsr		-$2c4(a6)						; VideoControl(colorMap,tagarray)(a0/a1)
												; VideoControl will report back in the laglist
												; in the long word *resolution* the actual
												; sprite resolution of that screen.

	;------------------------------------------------------------------------------------------------------------------
	; Now tell the routine VideoControl to set the resolution
	; SPRITERESN_140NS -> lowres!
	; Workbench Screen
		move.l	BlockedScreen(PC),a0			; Screen Structure of blocked Screen
		move.l	$30(a0),a0						; From Screen Structure we get the Viewport Structure which
												; is in the screen structure ($2c).
												; From Viewport offset of $2c we add $04 hence $30 to get
												; the Viewport Colour Map address.
												; In A0 we have the Colour Map address.
												; This is needed to execute the video Control of the Graphics.library  
		lea		SETVidCtrlTags(PC),a1			; Taglist that reset the sprites
		move.l	GfxBase(PC),a6	
		jsr		-$2c4(a6)						; VideoControl(colorMap,tagarray)(a0/a1)
												; Reset Sprites
	;------------------------------------------------------------------------------------------------------------------
	; Now tell the routine VideoControl to set the resolution
	; SPRITERESN_140NS -> lowres!
	; Current Screen
		move.l	IntuiBase(PC),a6				; Load A6 with Intuition Base Address
		move.l	$3c(a6),a0						; $3c - First Screen in Intuition Base (Ib_FirstScreen)
		move.l	$30(a0),a0						; From Screen Structure we get the Viewport Structure which
												; is in the screen structure ($2c).
												; From Viewport offset of $2c we add $04 hence $30 to get
												; the Viewport Colour Map address.
												; In A0 we have the Colour Map address.
												; This is needed to execute the video Control of the Graphics.library  
		lea		SETVidCtrlTags(PC),a1			; Taglist that reset the sprites
		move.l	GfxBase(PC),a6
		jsr		-$2c4(a6)						; VideoControl(colorMap,tagarray)(a0/a1)
												; Reset Sprites
	;------------------------------------------------------------------------------------------------------------------
	; Creates a view port for workbench screen 
		move.l	BlockedScreen(PC),a0			; Screen Structure of blocked Screen
		move.l	IntuiBase(PC),a6				; Load A6 with Intuition Base Address
		jsr		-$17a(a6)						; MakeScreen(screen)(a0)
												; Allows you to do a MakeVPort() for the viewport of your
												; custom screen in an Intuition-integrated way

	;------------------------------------------------------------------------------------------------------------------
	; Creates a view port for current screen 
		move.l	$3c(a6),a0						; FirstScreen - Uses the first screen for example the screen of the assembler
		jsr		-$17a(a6)						; MakeScreen(screen)(a0)
												; Allows you to do a MakeVPort() for the viewport of your
												; custom screen in an Intuition-integrated way

	;------------------------------------------------------------------------------------------------------------------
	; Redraw Display
		jsr		-$186(a6)						; RethinkDisplay()()
												; Performs the Intuition global display reconstruction

	ErrorScreen:								; Exit
		rts

;======================================================================================================================
; Restore the sprites to the original way when they were initialised
;======================================================================================================================

RestoreSprites:
	;------------------------------------------------------------------------------------------------------------------
	; Restore the workbench screen
		move.l	BlockedScreen(PC),d0				; Screen Structure of blocked Screen
		beq.s	DidntWork							; If 0 then it didn't work so exit
		move.l	d0,a0
		move.l	OldResolution(PC),OldResolution2	; Restore the old resolution
		lea		SETOldVidCtrlTags(PC),a1
		move.l	$30(a0),a0							; Colour Map Structure of screen
		move.l	GfxBase(PC),a6
		jsr		-$2c4(a6)							; VideoControl(colorMap,tagarray)(a0/a1) - Restore the Resolution

	;------------------------------------------------------------------------------------------------------------------
	; Restore that of the current screen
		move.l	IntuiBase(PC),a6					; Load A6 with Intuition Base Address
		move.l	$3c(a6),a0							; $3c - First Screen in Intuition Base (Ib_FirstScreen)
													; Example that of the assembler
		move.l	OldResolutionP(PC),OldResolution2	; Restore teh Old resolution
		lea		SETOldVidCtrlTags(PC),a1
		move.l	$30(a0),a0							; Colour Map Structure of screen
		move.l	GfxBase(PC),a6
		jsr		-$2c4(a6)							; VideoControl(colorMap,tagarray)(a0/a1) - Restore the Resolution

	;------------------------------------------------------------------------------------------------------------------
	; Creates the VPort for the workbench screen 
		move.l	IntuiBase(PC),a6					; Load A6 with Intuition Base Address
		move.l	BlockedScreen(PC),a0				; Screen Structure of blocked Screen
		jsr		-$17a(a6)							; MakeScreen(screen)(a0)
													; Allows you to do a MakeVPort() for the viewport of your
													; custom screen in an Intuition-integrated way

	;------------------------------------------------------------------------------------------------------------------
	; Creates the VPort for the current screen 
		move.l	$3c(a6),a0							; FirstScreen - Uses the first screen for example the screen of the assembler
		jsr		-$17a(a6)							; MakeScreen(screen)(a0)
													; Allows you to do a MakeVPort() for the viewport of your
													; custom screen in an Intuition-integrated way

	;------------------------------------------------------------------------------------------------------------------
		move.l	BlockedScreen(PC),a1				; Screen Structure of blocked Screen
		sub.l	a0,a0								; null
		move.l	IntuiBase(PC),a6					; Load A6 with Intuition Base Address
		jsr		-$204(a6)							; UnlockPubScreen(name,screen)(a0/a1) - Unlock the workbench screen
	DidntWork:
		rts

;======================================================================================================================
; Sprite Variables 
;======================================================================================================================

BlockedScreen:
	dc.l	0
	even

; This is the structure of the Video_Control.
; The first long word is for changing the resolution of the sprites (SET)
; or to know the old resolution of the sprite (GET)

GETVidCtrlTags:
		dc.l	$80000032					; GET - %1000 0000 0000 0000 0000 0000 0011 0010
OldResolution:
		dc.l	0							; Sprite Resolution: 0=ECS, 1=lowres, 2=hires, 3=shres (Super Hires 1280)
		dc.l	0,0,0						; Three zeros for TAG_DONE (End of TagList)
		even

GETVidCtrlTags2:
		dc.l	$80000032					; GET - %1000 0000 0000 0000 0000 0000 0011 0010
OldResolutionP:
		dc.l	0							; Sprite Resolution: 0=ECS, 1=lowres, 2=hires, 3=shres (Super Hires 1280)
		dc.l	0,0,0						; Three zeros for TAG_DONE (End of TagList)
		even

SETVidCtrlTags:
		dc.l	$80000031					; SET - %1000 0000 0000 0000 0000 0000 0011 0001
		dc.l	1							; Sprite Resolution: 0=ECS, 1=lowres, 2=hires, 3=shres (Super Hires 1280)
		dc.l	0,0,0						; Three zeros for TAG_DONE (End of TagList)
		even

SETOldVidCtrlTags:
		dc.l	$80000031					; SET - %1000 0000 0000 0000 0000 0000 0011 0001
OldResolution2:
		dc.l	0							; Sprite Resolution: 0=ECS, 1=lowres, 2=hires, 3=shres (Super Hires 1280)
		dc.l	0,0,0						; Three zeros for TAG_DONE (End of TagList)
		even

; Name of Workbench Screen
Workbench:
		dc.b	'Workbench',0
		even

;======================================================================================================================
; This routine blocks intuition by creating a message port that has a higher priority level
; than that of intuition so that all messages related to intuition are sent to this message port
;======================================================================================================================

InputOFF:
	;------------------------------------------------------------------------------------------------------------------
	; Create a port
		lea		InputMPort(PC),a1			; Port to Create
		bsr.w	CreatePort					; Create a port

		cmp.l	#-1,d0						; Did we manage to open create a port
		beq.w	IntuiError					; If the answer is a NO then we have an Intuition error

	;------------------------------------------------------------------------------------------------------------------
	; Open a device for IORequests
		move.l	#InputMPort,InputIOST		; MN_REPLYPORT+inputio
		lea		InputDevice(PC),a0			; DevName: input.device
		moveq	#0,d0						; Unit Number - The unit number to open on that device.
											; The format of the unit number is device specific.
											; If the device does not have separate units, send a zero.
		lea		InputIO(PC),a1				; OIRequest - The I/O request block to be returned with
											;             the appropriate fields initialized.
		moveq	#0,d1						; Flags: No Flags
		move.l	4.w,a6						; Get the Exec Base
		jsr		-$1BC(a6)					; OpenDevice(devName,unit,ioRequest,flags)(a0,d0/a1,d1)
											; This function opens the named device/unit
											; and initializes the given I/O request block.

		tst.l	D0							; If D0 = 0 then no error
		bne.s	IntuitionOn1				; Else exit
	
	;------------------------------------------------------------------------------------------------------------------
	; Now our input handler need higher priority than that of intuition
	; that has a priority of 50. It is enough to make a priority of 51
	
		move.b	#51,LN_Pri					; Set Priority of 51 for the Input Handler
		clr.l	Is_Data						; Set Is_Data variable of the Input Handler to 0
		move.l	#ReadInput,Is_Code			; Address point to some code that does nothing and returns with D0 is 0.
		move.w	#9,IO_Command				; Command: CMD_NONSTD - 9 (exec/io.h)
		move.l	#InputHandler,IO_Data

		lea		InputIO(PC),a1				; iOrequest - pointer to an IORequest initialized by OpenDevice()
		move.l	4.w,a6						; Get the Exec Base
		jsr		-$1C8(a6)					; DoIO(ioRequest)(a1) - This function requests a device driver
											; to perform the I/O command specified in the I/O request
		rts
	
;======================================================================================================================
; Routine that we call for out input handler - Doesn't do anything
;======================================================================================================================

	ReadInput:
		moveq	#0,d0						; We don't pass any input to Intuition
		rts

;======================================================================================================================
; Restore the IO back to the Intiution
;======================================================================================================================

InputOn:
		tst.b	InputErrFlag					; Test if there was an Error
		bne.s	ExitInputOn						; If yes then Exit
		move.w	#10,IO_Command					; Command: Remove Handler(CMD_INVALID)
		move.l	#InputHandler,IO_Data

		lea		InputIO(PC),a1					; iORequest Address Structure
		move.l	4.w,a6
		jsr		-$1C8(a6)						; DoIO(ioRequest)(a1) - This function requests a device driver
												; to perform the I/O command specified in the I/O request

		lea		InputIO(PC),a1					; iORequest
		move.l	4.w,a6							; Get teh Exec Base
		jsr		-$1C2(a6)						; CloseDevice(ioRequest)(a1) - CloseDevice

	IntuitionOn1:
		lea		InputMPort(PC),a1				; Address of port created
		bsr.s	FreeUpPort						; Release the port

	IntuiError:
		move.b	#$FF,InputErrFlag				; Mark that it was an error

	ExitInputOn:
		rts

InputErrFlag:
		dc.w	0
		even

;======================================================================================================================
; Create a Port
; a1=address of port
; On Exit if d0 = -1 then there is an error
;======================================================================================================================

CreatePort:
		move.l	a1,-(SP)						; Store A1 on the Stack
		moveq	#-1,d0							; SignalNum -1 (Any Signal)
		move.l	4.w,a6							; Exec BAse
		jsr		-$14A(a6)						; AllocSignal(signalNum)(d0) - allocate a signal bit from the current tasks' pool

		moveq	#-1,d1							; Error Value in D1
		cmp.l	d1,d0							; Was there an Error - D0 holds the value returned
		beq.s	FreeUpPort1						; If D0 is equal to D1 then there was an error, so exit

		move.l	(SP),a0							; Port in a0
		move.b	#0,9(a0)						; LN_PRI
		move.b	#4,8(a0)						; NT_MSGPORT, LN_TYPE
		move.b	#0,14(a0)						; PA_SIGNAL, MP_FLAGS
		move.b	d0,15(a0)						; MP_SIGBIT
		suba.l	a1,a1							; Clear A1
		move.l	4.w,a6							; Exec Base
		jsr		-$126(a6)						; FindTask(name)(a1) - This function will check all task queues for a task
												; with the given name, and return a pointer to its task control block.

		move.l	(SP),a1							; Retore A1
		move.l	d0,$10(a1)						; d0,MP_SIGTASK
		lea		$14(a1),a0						; MP_MSGLIST,a0
		move.l	a0,(a0)							; NEWLIST a0
		addq.l	#4,(a0)							; 
		clr.l	4(a0)							; 
		move.l	a0,8(a0)						;

CREATEPORTEXIT:
		move.l	(SP)+,d0						; Restore value of A1 in D0
		RTS

;======================================================================================================================
; Release (Free) the port created
; a1=address of port
;======================================================================================================================

FreeUpPort:
		move.l	a1,-(SP)						; Save A1 to the Stack
		move.b	15(a1),d0						; MP_SIGBIT,d0 (SignalNum)
		move.l	4.w,a6							; Exec Base
		jsr		-$150(a6)						; FreeSignal(signalNum)(d0) - This function frees a previously
												; allocated signal bit for reuse
FreeUpPort1:
		move.l	(SP)+,a1
		rts

;======================================================================================================================
; Data Used by the IO Device
;======================================================================================================================

; Port Structure
InputMPort:
	ds.b	34	; MP_SIZE

; Input IO Structure
InputIO:
		ds.b	14
	InputIOST:
		ds.b	14
	IO_Command:
		ds.b	12
	IO_Data:
		ds.b	8

; Input Handler Structure
InputHandler:
		ds.b	9
	LN_Pri:
		ds.b	5
	Is_Data:
		dc.l	0
	Is_Code:
		dc.l	0

; Device Name
InputDevice:
		dc.b	'input.device',0
		even

;======================================================================================================================
; From here onwards we can work on the hardware directly
;======================================================================================================================

HeavyInit:
		lea		$dff000,a5						; Base of Custome Chip registers
		move.w	$2(a5),OldDMA					; Save the old status of DMACON
		move.w	$1c(a5),OldIntena				; Save the old status of INTENA
		move.w	$10(a5),OldAdkCON				; Save the old status of ADKCON
		move.w	$1e(a5),OldIntreq				; Save the old status of INTREQ
		move.l	#$80008000,d0					; Prepare the mask for the high
												; bits to be set in the word where 
												; the resiters have been saved
		or.l	d0,OldDMA						; Set bit 15 of all the values saved
		or.l	d0,OldAdkCON					; of the hardware registers, it is important 
												; to put back the values as they where in the registers

		move.l	#$7FFF7FFF,$9a(a5)				; Disable the Interrupts and the Interrupt Requests
		move.l	#0,$144(A5)						; SPR0DAT - Kill the address pointer - Mouse Sprite
		move.w	#$7fff,$96(a5)					; Disable the DMA
;		move.l	#0,$144(A5)						; SPR0DAT - Kill the address pointer - Mouse Sprite

		move.l	4.w,a6							; ExecBase in a6
		btst.b	#0,$129(a6)						; Check if we are on a 68010+
		beq.s	IntOK							; If it is 68000 then the Vector Base address is always 0
		lea		SuperCode(PC),a5 				; Routine to Execute in Supervisor mode
		jsr		-$1e(a6)						; Supervisor(userFunction)(a5)
		bra.s	IntOK							; ok we have the VBR Base address so we continue

;----------------------------------------------------------------------------------------------------------------------
; Supervisor Mode code for CPUs that are 68010 or higher
;----------------------------------------------------------------------------------------------------------------------
SuperCode:
		dc.l  	$4e7a9801						; Movec Vbr,A1 (This is a 68010+ Instruction)
												; It is in hexadecimal because not all assemblers
												;  can understand the MOVEC instruction
		move.l	a1,BaseVBR						; Store the VBR at BaseVBR
		RTE										; Return from exception
;----------------------------------------------------------------------------------------------------------------------

BaseVBR:										; If we do not modify the VBR Base address we remain with th Value of 0
		dc.l	0

IntOK:
		move.l	BaseVBR(PC),a0	 				; In a0 we have teh value of the VBR
		move.l	$64(a0),OldInt64 				; System interrupt level 1 saved (softint,dskblk)
		move.l	$68(a0),OldInt68 				; System interrupt level 2 saved (I/O,ciaa,int2)
		move.l	$6c(a0),OldInt6c 				; System interrupt level 3 saved (coper,vblanc,blit)
		move.l	$70(a0),OldInt70 				; System interrupt level 4 saved (audio)
		move.l	$74(a0),OldInt74 				; System interrupt level 5 saved (rbf,dsksync)
		move.l	$78(a0),OldInt78 				; System interrupt level 6 saved (exter,ciab,inten)

		bsr.w	ClearMyCache

		lea		$dff000,a5						; Custom register in a5
		jsr	    START							; Execute our Program
		bsr.w	ClearMyCache

		LEA		$dff000,a5						; Custom Chips Base address Register
		MOVE.W	#$8240,$96(a5)					; Restore DMACON
		BTST.b	#6,2(a5)						; Wait for Blitter to Finish

Wblittez:
		BTST.b	#6,2(a5)						; Wait for Blitter to Finish
		BNE.S	Wblittez

		MOVE.W	#$7FFF,$96(A5)					; Disable all the DMA
		MOVE.L	#$7FFF7FFF,$9A(A5)				; Disable all the Interrupts and interrupt requests
		MOVE.W	#$7fff,$9E(a5)					; Disable the bits of ADKCON (Audio, Disk, UART)

		move.l	BaseVBR(PC),a0	     			; In a0 we have the value of the VBR
		move.l	OldInt64(PC),$64(a0) 			; System interrupt level 1 Restored (softint,dskblk)
		move.l	OldInt68(PC),$68(a0) 			; System interrupt level 2 Restored (I/O,ciaa,int2)
		move.l	OldInt6c(PC),$6c(a0) 			; System interrupt level 3 Restored (coper,vblanc,blit)
		move.l	OldInt70(PC),$70(a0) 			; System interrupt level 4 Restored (audio)
		move.l	OldInt74(PC),$74(a0) 			; System interrupt level 5 Restored (rbf,dsksync)
		move.l	OldInt78(PC),$78(a0) 			; System interrupt level 6 Restored  (exter,ciab,inten)

		MOVE.W	OldAdkCON(PC),$9E(A5)			; Restore the OS ADKCON
		MOVE.W	OldDMA(PC),$96(A5)				; Restore the OS DMA
		MOVE.W	OldIntena(PC),$9A(A5)			; Restore the Interrupts (INTENA) status register
		MOVE.W	OldIntreq(PC),$9C(A5)			; Restore the Interrupts Request (INTREQ) status register 
		RTS

;======================================================================================================================
;	Saved Data by the startup file
;======================================================================================================================

WBActiView:										; Workbench view address
		DC.L	0
		even

;----------------------------------------------------------------------------------------------------------------------
; Library Names
GfxName:
		dc.b	'graphics.library',0,0
		even

IntuiName:
		dc.b	'intuition.library',0
		even

DosName:
		dc.b	"dos.library",0
		even

;----------------------------------------------------------------------------------------------------------------------
; Libraries Base Address
GfxBase:		; Graphics Library Base Address
		dc.l	0
		even

IntuiBase:		; Intuition Library Base Address
		dc.l	0
		even

DosBase:		; Dos Library Base Address
		dc.l	0
		even

;----------------------------------------------------------------------------------------------------------------------
; Interrupt and DMA Status settings
OldDMA:			; Old DMACON status settings
		dc.w	0
		even

OldIntena:		; Old INTENA status Settings
		dc.w	0
		even

OldAdkCON:		; Old ADKCON status settings
		DC.W	0
		even

OldIntreq:		; Old INTREQ status settings
		DC.W	0
		even

;----------------------------------------------------------------------------------------------------------------------
; Old OS Interrupt status settings

OldInt64:
		dc.l	0
		even

OldInt68:
		dc.l	0
		even

OldInt6c:
		dc.l	0
		even

OldInt70:
		dc.l	0
		even

OldInt74:
		dc.l	0
		even

OldInt78:
		dc.l	0
		even

;======================================================================================================================
; Routine that is called when there is auto modification code.
; Doing Self Modification code of tables in fast ram, or while loading from disk etc 
;======================================================================================================================

ClearMyCache:
		movem.l	d0-d7/a0-a6,-(SP)				; Save all Registers
		move.l	4.w,a6							; Get the Exec Base
		move.w	$14(a6),d0						; Get the library version
		cmp.w	#37,d0							; is it V37+ ? (kick 2.0+)
		blo.s	NoCaches						; If it is Kickstart 1.3 or less the problem is that
												; it can't know if the CPU is a 68040 so it is risky.
												; It is also assumed that if someone has a 68020+
												; with a Kickstart 1.3 has the cache disabled.
		jsr		-$27c(a6)						; CacheClearU()() - User callable simple cache clearing
												; This routine is only available from Kickstart V37 Upwards

	NoCaches:
		movem.l	(sp)+,d0-d7/a0-a6				; Restore all registers
		rts

