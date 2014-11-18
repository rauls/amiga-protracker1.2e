**********************************************************
*                                                        *
*  Protracker Version 1.2e -                             *
*                                                        *
*  Based on Soundtracker V2.5 / Noisetracker x.x)        *
*  Original Coding by Lars Hamre                         *
*  with some "Resource" help from Anders Hamre           *
*  Thanks to Rune, and a hi there to Sven, Morten,       *
*  Per and Torgeir.                                      *
*                                                        *
*--------------------------------------------------------*

;	bliterase modulo,address,size
bclear:	macro
	move	#$0100,$40(a6)	;bltcon0
	clr	$42(a6)		;bltcon1
	clr.l	$44(a6)		;mask read all
	move	\4,$64(a6)
	move	#\1,$66(a6)	;destination	mod
	move.l	\2,$54(a6)	;Destination	D
	move	#\3,$58(a6)
	endm


_largetext	EQU	1		;if defined GFX is large text (orig)
pt_version	EQU	'1.2e'





; FileFormat
sd_songname	EQU	0
sd_sampleinfo	EQU	20
sd_numofpatt	EQU	950
sd_pattpos	EQU	952
sd_mahokakt	EQU	1080
sd_patterndata	EQU	1084

; audXtemp offsets
n_note		EQU	0  ; W
n_cmd		EQU	2  ; W
n_cmdlo		EQU	3  ; low B of cmd
n_start		EQU	4  ; L
n_length	EQU	8  ; W
n_loopstart	EQU	10 ; L
n_replen	EQU	14 ; W
n_period	EQU	16 ; W
n_finetune	EQU	18 ; B
n_volume	EQU	19 ; B
n_dmabit	EQU	20 ; W
n_toneportdirec	EQU	22 ; B
n_toneportspeed	EQU	23 ; B
n_wantedperiod	EQU	24 ; W
n_vibratocmd	EQU	26 ; B
n_vibratopos	EQU	27 ; B
n_tremolocmd	EQU	28 ; B
n_tremolopos	EQU	29 ; B
n_wavecontrol	EQU	30 ; B
n_glissfunk	EQU	31 ; B
n_sampleoffset	EQU	32 ; B
n_pattpos	EQU	33 ; B
n_loopcount	EQU	34 ; B
n_funkoffset	EQU	35 ; B
n_wavestart	EQU	36 ; L
n_reallength	EQU	40 ; W
n_trigger	EQU	42 ; B
n_samplenum	EQU	43 ; B


; Exec Library Offsets
LVOFindTask	EQU	-294
LVOFindName	EQU	-276
LVOForbid	EQU	-132
LVOPermit	EQU	-138
LVOAddPort	EQU	-354
LVORemPort	EQU	-360
LVOWaitPort	EQU	-384
LVOOpenLibrary	EQU	-552
LVOCloseLibrary	EQU	-414
LVOOpenDevice	EQU	-444
LVOCloseDevice	EQU	-450
LVODoIO		EQU	-456
LVOSendIO	EQU	-462
LVOGetMsg	EQU	-372
LVOReplyMsg	EQU	-378
LVOAllocMem	EQU	-198
LVOAllocAbs	EQU	-204
LVOFreeMem	EQU	-210
LVOAvailMem	EQU	-216
LVOAddIntServer	EQU	-168
LVORemIntServer	EQU	-174
LVOOpenResource	EQU	-498
LVOSetFunction	EQU	-420
LVOSetIntVector	EQU	-162
LVORemDevice	EQU	-438

; CIA Resource Offsets
AddICRVector	EQU	-6
RemICRVector	EQU	-12

; DOS Library Offsets
LVOOpen		EQU	-30
LVOClose	EQU	-36
LVORead		EQU	-42
LVOWrite	EQU	-48
LVODeleteFile	EQU	-72
LVORename	EQU	-78
LVOLock		EQU	-84
LVOUnLock	EQU	-90
LVOExamine	EQU	-102
LVOExNext	EQU	-108
LVOInfo		EQU	-114
LVOIoErr	EQU	-132
LVOSeek		EQU	-66
LVOCreateDir	EQU	-120
LVOCurrentDir	EQU	-126
LVODateStamp	EQU	-192
LVODelay	EQU	-198
LVOExecute	EQU	-222
LVOUnLoadSeg	EQU	-156

; Intuition Library Offsets
LVOAutoRequest	  EQU	-348
LVOEasyRequest	  EQU	-588		;V37+ function!
LVODisplayAlert   EQU	-90
LVOOpenWorkbench  EQU	-210
LVOCloseWorkbench EQU	-78
LVOWBenchToFront  EQU	-342

; Graphics Library Offsets
LVOBltBitMap	EQU	-30
LVOWaitBlit	EQU	-228
LVOOwnBlitter	EQU	-456
LVODisownBlitter EQU	-462


; DateStamp
ofib_DateStamp	EQU	$84
ds_Days		EQU	$00
ds_Minute	EQU	$04
ds_Tick		EQU	$08

; Memory Alloc Flags
MEMF_PUBLIC	EQU	$0001
MEMF_CHIP	EQU	$0002
MEMF_FAST	EQU	$0004
MEMF_CLEAR	EQU	$10000
MEMF_LARGEST	EQU	$20000

; IO Block Offsets
IO_COMMAND	EQU	$1C
IO_FLAGS	EQU	$1E
IO_ACTUAL	EQU	$20
IO_LENGTH	EQU	$24
IO_DATA		EQU	$28
IO_OFFSET	EQU	$2C

; Device Commands 
CMD_READ	EQU	$2
CMD_WRITE	EQU	$3
CMD_UPDATE	EQU	$4
TD_MOTOR	EQU	$9
TD_FORMAT	EQU	$B
TD_CHANGESTATE	EQU	$E
TD_PROTSTATUS	EQU	$F

; Exec Offsets
DeviceList	EQU	350
IDNestCnt	EQU	294


DirNameLength	EQU	30
ConfigFileSize	EQU	1024
KeyBufSize	EQU	20


; Screen Offsets
ScreenWidth	EQU	40
ScreenHeight	EQU	256
ScreenPlanes	EQU	2
PlaneSize	EQU	ScreenWidth*ScreenHeight

A_BoxData	EQU	22
T_BoxData	EQU	44
P_BoxData	EQU	66
H_BoxData	EQU	88
C_BoxData	EQU	110

; More Screen Offsets
TopMenusPos	EQU	(ScreenWidth*01)+15
SpectrumAnaPos	EQU	(ScreenWidth*45)+15		;1815
FormatBoxPos	EQU	(ScreenWidth*52)+10		;2090
SureBoxPos	EQU	(ScreenWidth*52)+20		;2100
SamScrPos	EQU	(ScreenWidth*122)		;4880
VolBoxPos	EQU	(ScreenWidth*155)+9		;6209
PattBlkSize	EQU	(ScreenWidth*694)


; Text Pos Offsets
TempoTextPos	EQU	(ScreenWidth*15)+7
TempoNumPos	EQU	(ScreenWidth*124)+4
TimerNumPos	EQU	(ScreenWidth*103)+34
FreeMemPos	EQU	(ScreenWidth*131)+33
TuneMemPos	EQU	(ScreenWidth*124)+33
ChanNumPos	EQU	(ScreenWidth*61)+2

;Scope Offsets
Scope1Pos	EQU	(ScreenWidth*56)+16
ScopeBox1Pos	EQU	(ScreenWidth*72)+16
ScopeBox2Pos	EQU	(ScreenWidth*72)+22
ScopeBox3Pos	EQU	(ScreenWidth*72)+28
ScopeBox4Pos	EQU	(ScreenWidth*72)+34

;PitchControl Offsets
PitchCtrlYPos	EQU	145
PitchCtrlSize	EQU	97
PitchCtrl0x	EQU	12
PitchCtrl1x	EQU	21
PitchCtrl2x	EQU	30
PitchCtrl3x	EQU	39
PitchCtrl0Pos	EQU	(ScreenWidth*PitchCtrlYPos)+PitchCtrl0x
PitchCtrl1Pos	EQU	(ScreenWidth*PitchCtrlYPos)+PitchCtrl1x
PitchCtrl2Pos	EQU	(ScreenWidth*PitchCtrlYPos)+PitchCtrl2x
PitchCtrl3Pos	EQU	(ScreenWidth*PitchCtrlYPos)+PitchCtrl3x

AnaBlkPos	EQU	(ScreenWidth*49)+16

PointerYsize	EQU	16











;**************************************************************************
; RunBack Hunk for Protracker
; Written by Lars Hamre/Amiga Freelancers 1990
; NOTE: This version will not pass arguments or WBMsg to the new Process!

	SECTION	ptrunback,CODE

rb_HunkStart
	SUB.L	A1,A1
	MOVE.L	4.W,A6
	JSR	-294(A6)	; FindTask
	MOVE.L	D0,A4
	MOVEQ	#0,D0
	TST.L	$AC(A4)		; pr_CLI
	BNE.S	rb_FromCLI
	LEA	$5C(A4),A0	; pr_MsgPort
	JSR	-384(A6)	; WaitPort
	LEA	$5C(A4),A0
	JSR	-372(A6)	; GetMsg
rb_FromCLI
	MOVE.L	D0,D7		; D7 = WBmsg
	LEA	rb_DOSname(PC),A1
	MOVEQ	#0,D0
	JSR	-552(A6)	; OpenLibrary
	TST.L	D0
	BEQ.S	rb_dexit
	MOVE.L	D0,A5
	EXG	A5,A6		; A6=DOS
	MOVE.L	$98(A4),D1	; pr_CurrentDir
	JSR	-96(A6)		; DupLock
	MOVE.L	D0,rb_CurrentDir
	EXG	A5,A6 ; A6=exec
	JSR	-132(A6) ; Forbid
	MOVE.L	#rb_ProgName,D1
	MOVEQ.L	#0,D2
	MOVE.B	9(A4),D2	; priority
	LEA	rb_HunkStart-4(PC),A0
	MOVE.L	(A0),D3		; Ptr to next segment
	CLR.L	(A0)		; Unlink next segment
	MOVE.L	#4000,D4
	EXG	A5,A6		; A6=DOS
	JSR	-138(A6)	; CreateProc
	EXG	A5,A6		; A6=exec
	JSR	-138(A6)	; Permit
	MOVE.L	A5,A1
	JSR	-414(A6)	; CloseLibrary
rb_dexit
	TST.L	D7
	BEQ.S	rb_exit
	JSR	-132(A6)	; Forbid
	MOVE.L	D7,A1
	JSR	-378(A6)	; ReplyMsg
rb_exit	MOVEQ	#0,D0
	RTS
rb_DOSname
	dc.b	"dos.library",0
; End of runback hunk




;******************** CODE HUNK *********************

	SECTION ptcode,CODE

START	MOVE.L	4.W,A6
	SUB.L	A1,A1
	JSR	LVOFindTask(A6)
	MOVE.L	D0,PTProcess
	BSR.S	Main
	MOVE.L	4.W,A6
	JSR	LVOForbid(A6)
	MOVE.L	DOSBase,A6
	MOVE.L	rb_CurrentDir(PC),D1
	JSR	LVOUnLock(A6)
	LEA	START-4(PC),A0
	MOVE.L	A0,D1
	LSR.L	#2,D1
	JSR	LVOUnLoadSeg(A6)
	MOVEQ	#0,D0
	RTS

Main				;move.l #CopList,$300.w		;///
	MOVE.L	SP,StackSave
	BSR	OpenLotsOfThings
	BSR	SetVBInt
	BSR	SetSERInt
	BSR	SetMusicInt
	BSR	SetInputHandler
	BSR	SetAutoReq
	BSR	SetEasyReq
	JSR	SetPatternPos
	BSR	SetNormalPtrCol
	BSR	StorePtrCol
	BSR	RedrawToggles
	BSR	DoShowFreeMem
	BSR	SetTempo
	BSR	SetCopList
	BSR	CheckInitError
	LEA	VersionText(PC),A0
	JSR	ShowStatusText
	BSR	RedrawPitchCtrl

MainLoop
		BSR	DoKeyBuffer
		BSR	CheckTransKeys
		BSR	CheckCtrlKeys
		BSR	CheckAltKeys
		BSR	CheckKeyboard
		BSR	CheckF1_F2
		BSR	CheckF3_F5
		BSR	CheckF6_F10
		BSR	CheckPlayKeys
		BSR	CheckHelpKey
		BSR	ArrowKeys2
		BSR	ShowTimer
		BSR	ShowFreeMem
		BSR	CheckBlockPos
		JSR	CheckSampleLength
		BSR	CheckRedraw
		JSR	CheckMIDIin
		BSR	CheckSerialByte
		BTST	#6,$BFE001
		BNE.S	MainLoop    ; Loop if not pressed

	TST	CurrScreen
	BNE.S	MainSkip
	MOVE	#1,notogfl
	BSR	DisplayMainScreen
	JSR	ShowAllRight
	BSR	WaitForButtonUp

;-------------- if mouse button pressed go here
MainSkip
	BSR	ArrowKeys
	BSR	CheckGadgets
	RTS



notogfl		dc.w 0
PTProcess	dc.l 0
rb_CurrentDir	dc.l 0
rb_ProgName	dc.b 'PT'
		dc.l pt_version,0
VersionText	dc.b 'RELEASE  V'
		dc.l pt_version,0
WBVERTXT        dc.b '$VER: ProTracker_Serial-Link 1.2e (9.1.94)',0
		even

CheckInitError
	MOVE.B	InitError,D0
	BEQ	Return1
	BTST	#0,D0
	BEQ.S	cieskp1
	JSR	PLSTMemErr
cieskp1	MOVE.B	InitError,D0
	BTST	#1,D0
	BEQ.S	cieskp2
	JSR	PLSTOpenErr
	JSR	FreePLST
cieskp2	MOVE.B	InitError,D0
	BTST	#2,D0
	BEQ.S	cieskp3
	BSR	ConfigErr
cieskp3	MOVE.B	InitError,D0
	BTST	#3,D0
	BEQ	Return1
	BSR	ConfigErr2
	BSR	SetNormalPtrCol
	BRA	StorePtrCol

CheckRedraw
	TST.B	UpdateTempo
	BEQ.S	chkredr
	CLR.B	UpdateTempo
	BSR	SetTempo
chkredr	CMP.L	#'patp',RunMode
	BNE	Return1
	JSR	ShowPosition
	TST.B	PattRfsh
	BEQ	Return1
	MOVE.L	PattRfshNum,PatternNumber
	JMP	RedrawPattern




;---- Cleanup upon exit from PT ----
ExitCleanup
	JSR	StopIt
	SF	EdEnable
	BSR	EscPressed
	BSR	EscPressed
	BSR	ResetSERInt
	BSR	ResetVBInt
	BSR	ResetMusicInt
	BSR	ResetInputHandler
	BSR	ResetAutoReq
	BSR	ResetEasyReq
	BSR	ResetCopList
	JSR	CloseMIDI
	JSR	FreeCopyBuf
errorexit1
errorexit2
	MOVE.L	StackSave,SP
	MOVE.L	4.W,A6
	MOVE.L	GfxBase,A1
	JSR	LVOCloseLibrary(A6)
	MOVE.L	IntuitionBase,A1
	JSR	LVOCloseLibrary(A6)
	MOVE.L	DOSBase,A1
	JSR	LVOCloseLibrary(A6)

	MOVE.L	TextBplPtr,D1
	BEQ.S	exex1
	MOVE.L	D1,A1
	MOVE.L	#PattBlkSize,D0
	JSR	LVOFreeMem(A6)
exex1	MOVE.L	SongDataPtr,D1
	BEQ.S	exex2
	MOVE.L	D1,A1
	MOVE.L	#70716,D0
	JSR	LVOFreeMem(A6)
exex2	BSR	FreeDirMem
	BSR	GiveBackInstrMem
	JSR	FreePLST
	JSR	TurnOffVoices
	BCLR	#1,$BFE001
	MOVE.B	LEDStatus,D0
	AND.B	#2,D0
	OR.B	D0,$BFE001			; Restore LED Status
	MOVEQ	#0,D0
Return1	RTS


;---- Open Lots Of Things ----
OpenLotsOfThings
	MOVE.L	#MainScreenData,pic_buf	;decrunch main screen!
	MOVE.L	#BitPlaneData,bitplane
	JSR	doiff

	MOVE.B	$BFE001,LEDStatus
	BSET	#1,$BFE001
	JSR	TurnOffVoices
	MOVE.L	4.W,A6
	LEA	DOSname(PC),A1		; Open DOS library
	MOVEQ	#0,D0
	JSR	LVOOpenLibrary(A6)
	MOVE.L	D0,DOSBase
	LEA	GraphicsName(PC),A1	; Open graphics library
	MOVEQ	#0,D0
	JSR	LVOOpenLibrary(A6)
	MOVE.L	D0,GfxBase
	LEA	IntuitionName(PC),A1	; Open Intuition library
	MOVEQ	#0,D0
	JSR	LVOOpenLibrary(A6)
	MOVE.L	D0,IntuitionBase
	MOVE.l	D0,A6
	MOVE	$14(A6),IntuitionVer

	MOVE.L	DOSBase,A6
	MOVE.L	rb_CurrentDir(PC),D1
	JSR	LVOCurrentDir(A6)

	MOVE.L	#PattBlkSize,D0		; Alloc 27k CHIP textbpl
	MOVE.L	#MEMF_CHIP!MEMF_CLEAR,D1
	MOVE.L	4.W,A6
	JSR	LVOAllocMem(A6)
	MOVE.L	D0,TextBplPtr
	BEQ	errorexit1
	MOVE	D0,NoteBplptrLow	; set low word
	SWAP	D0
	MOVE	D0,NoteBplptrHigh	; set high word

	MOVE.L	#70716,D0		; Alloc 70k patternmemory
	MOVE.L	#MEMF_PUBLIC!MEMF_CLEAR,D1
	JSR	LVOAllocMem(A6)
	MOVE.L	D0,SongDataPtr
	BEQ	errorexit2

	MOVE.L	D0,A0
	LEA	$14(A0),A0
	MOVEQ	#30,D0
alotloop1
	MOVE	#1,$1C(A0)
	LEA	$1E(A0),A0
	DBF	D0,alotloop1
	MOVE.L	SongDataPtr,A0
	MOVE	#$017F,sd_numofpatt(A0)
	MOVE.L	#'M.K.',sd_mahokakt(A0)	; M.K. again...

	MOVEQ	#6,D0
	MOVE.L	D0,CurrSpeed
	MOVE	#1,PEDPos
	MOVE.L	#ModulesPath2,PathPtr
	MOVE.L	#CopList,CopListPtr
	MOVE.L	#CopListBitplanes,CopListBplPtr
	MOVE.L	#CopListColors,CopListColorPtr
	MOVE.L	#CopListBpl4,CopListBpl4Ptr
	MOVE.L	#KbdTransTable2,KeyTransTabPtr
	MOVE.L	#NoteNames1,NoteNamesPtr
	MOVE.L	#VUMeterColors,TheRightColors

	MOVE.L	#BitPlaneData,D0 ; Set pointers to bitplane data
	LEA	CopListBitplanes,A1
	MOVE	D0,6(A1)
	SWAP	D0
	MOVE	D0,2(A1)
	SWAP	D0
	ADD.L	#PlaneSize,D0
	MOVE	D0,14(A1)
	SWAP	D0
	MOVE	D0,10(A1)
	BSR	SetDefSpritePtrs
	BSR	UpdateCursorPos
	JSR	RedrawPattern
	JSR	ShowPosition
	JSR	ShowSongLength
	MOVE	#1,InsNum
	JSR	ShowSampleInfo

	LEA	BitPlaneData+TopMenusPos,A0
	LEA	TopMenusBuffer,A1
	MOVEQ	#44-1,D0
stmloop	MOVEQ	#25-1,D1
stmloop2
	MOVE.B	(A0)+,(A1)+
	MOVE.B	PlaneSize-1(A0),1099(A1)
	DBF	D1,stmloop2
	LEA	15(A0),A0
	DBF	D0,stmloop

	BSR	DoResetAll
	BSR	cfgupda
	BSR	DoLoadConfig
	MOVE.L	#NoteNames1,NoteNamesPtr
	TST.B	Accidental
	BEQ	.skip
	MOVE.L	#NoteNames2,NoteNamesPtr
.skip	JSR	DoLoadPLST
ChangeCopList
	TST	SamScrEnable
	BNE	Return1
	BSR	SetupAnaCols
SetupVUCols
	TST	SamScrEnable
	BNE	Return1
	LEA	CopListMark2,A0		;VUmeter coloring
	MOVE	#($BA<<8)+7,D5		;Start position $BA07
	LEA	VUMeterColors,A5
	MOVEQ	#47,D7			;Change 48 lines
alotlp4	MOVE	D5,(A0)+
	MOVE	#$FFFE,(A0)+
	LEA	VUmeterColRegs(PC),A1
	MOVEQ	#1,D6
alotlp5	MOVE	(A5),D4
	MOVE	(A1)+,(A0)+
	MOVE	#3,FadeX
	MOVE	D4,D0
	BSR	FadeCol
	MOVE	D0,(A0)+
	MOVE	(A1)+,(A0)+
	MOVE	D4,(A0)+
	MOVE	(A1)+,(A0)+
	MOVE	#-3,FadeX
	MOVE	D4,D0
	BSR	FadeCol
	MOVE	D0,(A0)+
	DBF	D6,alotlp5
	ADDQ	#2,A5
	ADD	#$0100,D5	; Next line...
	DBF	D7,alotlp4
	RTS

VUmeterColRegs
	dc.w	$01B2,$01B4,$01B6,$01BA,$01BC,$01BE

CopListBpl4Ptr	dc.l	0
CopListPtr	dc.l	0
CopListBplPtr	dc.l	0
CopListColorPtr	dc.l	0
DOSname		dc.b	'dos.library',0
IntuitionName	dc.b	'intuition.library',0
GraphicsName	dc.b	'graphics.library',0,0

SetupAnaCols
	LEA	CopListAnalyzer,A5
	MOVE	ColorTable+12,D2
	MOVEQ	#39,D0		; Change col 40 lines
	MOVE	#$687D,D1	; Start pos
sacloop	MOVE	D1,(A5)+	; Set wait
	MOVE	#$FFFE,(A5)+
	MOVE	#$018C,(A5)+	; Set analyzer color
	ADDQ.L	#2,A5
	ADD	#$0060,D1	; Move x-pos
	MOVE	D1,(A5)+	; Wait
	MOVE	#$FFFE,(A5)+
	MOVE	#$018C,(A5)+	; Set text color
	MOVE	D2,(A5)+
	ADD	#$0100,D1	; Next line...
	SUB	#$0060,D1
	DBF	D0,sacloop
	TST.B	DisableAnalyzer
	BNE.S	ClearAnalyzerColors
SetAnalyzerColors
	LEA	CopListAnalyzer+6,A1
	LEA	AnalyzerColors,A0
	MOVEQ	#39,D0		; 40 lines
sanclop	MOVE	(A0)+,(A1)
	LEA	16(A1),A1
	DBF	D0,sanclop
	RTS

ClearAnalyzerColors
	LEA	CopListAnalyzer+6,A0
	MOVE	ColorTable+12,D1
	MOVEQ	#39,D0	; 40 lines.
cacloop	MOVE	D1,(A0)
	LEA	16(A0),A0
	DBF	D0,cacloop
	RTS

SetSamSpritePtrs
	MOVE.L	#LoopSpriteData1,Ch1SpritePtr
	MOVE.L	#LoopSpriteData2,Ch2SpritePtr
	MOVE.L	#PlayPosSpriteData,Ch3SpritePtr
	MOVE.L	#NoSpriteData,Ch4SpritePtr
	BRA.S	sdsp2
SetDefSpritePtrs
	MOVE.L	#VUSpriteData1,Ch1SpritePtr
	MOVE.L	#VUSpriteData2,Ch2SpritePtr
	MOVE.L	#VUSpriteData3,Ch3SpritePtr
	MOVE.L	#VUSpriteData4,Ch4SpritePtr
sdsp2	MOVE.L	#CursorSpriteData,CursorPosPtr
	MOVE.L	#PointerSpriteData,PointerSpritePtr
	MOVE.L	#LineCurSpriteData,LineCurPosPtr
	MOVE.L	#NoSpriteData,NoSpritePtr
	MOVE.L	PointerSpritePtr,SpritePtrsPtr

	LEA	SpritePtrsPtr,A0	; Set pointers to spritedata
	LEA	SprList,A1
	MOVEQ	#15,D2
alotloop2
	MOVE	(A0)+,2(A1)
	ADDQ.L	#4,A1
	DBF	D2,alotloop2
	RTS

PointerSpritePtr
	dc.l	0



;---- AutoRequest() ----
SetAutoReq
	MOVE.L	4.W,A6
	JSR	LVOForbid(A6)
	MOVE.L	IntuitionBase,A1
	MOVE.L	#NewAutoRequest,D0
	MOVE.L	#LVOAutoRequest,A0
	JSR	LVOSetFunction(A6)
	MOVE.L	D0,AutoReqSave
	MOVE.L	D0,xyzza+2
	JSR	LVOPermit(A6)
	RTS

ResetAutoReq
	MOVE.L	4.W,A6
	MOVE.L	IntuitionBase,A1
	MOVE.L	AutoReqSave(PC),D0
	MOVE.L	#LVOAutoRequest,A0
	JSR	LVOSetFunction(A6)
	RTS

NewAutoRequest
	TST	MountFlag
	BNE	PositiveReturn
	BTST.B	#0,AutoReqRunning
	BNE.S	xyzza
		OR.b	#1,AutoReqRunning
		MOVE.L	A0,saveA0
		BSR	ResetCopList
		MOVE.L	saveA0(pc),A0
xyzzy		JSR	$fc00d2
		clr.b	AutoReqRunning
		BRA	SetCopList

xyzza	JMP	$fc00d2
AutoReqSave	EQU xyzzy+2
saveA0	dc.l	0

;---- EasyRequest() ----	V37+
SetEasyReq
	CMP	#37,IntuitionVer
	BLT	noeasyreq
		MOVE.L	4.W,A6
		JSR	LVOForbid(A6)
		MOVE.L	IntuitionBase,A1
		MOVE.L	#NewEasyRequest,D0
		MOVE.L	#LVOEasyRequest,A0
		JSR	LVOSetFunction(A6)
		MOVE.L	D0,EasyReqSave+2
		JSR	LVOPermit(A6)
noeasyreq
	RTS

ResetEasyReq
	CMP	#37,IntuitionVer
	BLT	noeasyreq
	MOVE.L	4.W,A6
	MOVE.L	IntuitionBase,A1
	MOVE.L	EasyReqSave+2(PC),D0
	MOVE.L	#LVOEasyRequest,A0
	JSR	LVOSetFunction(A6)
	RTS

NewEasyRequest
	TST	MountFlag
	BNE	PositiveReturn
	BTST.B	#0,AutoReqRunning
	BNE.S	EasyReqSave
		OR.b	#1,AutoReqRunning
		MOVE.L	A0,saveA0
		BSR	ResetCopList
		MOVE.L	saveA0(pc),A0
		BSR	EasyReqSave		;goto orig vector
		clr.b	AutoReqRunning
		BRA	SetCopList

EasyReqSave	JMP	$fc00d2

IntuitionVer	dc.w	0

;---- DisplayAlert() ----

SetDispAlert
	MOVE.L	IntuitionBase,A0
	MOVE.L	LVODisplayAlert+2(A0),DispAlertSave
	MOVE.L	#NewDispAlert,LVODisplayAlert+2(A0)
	RTS

ResetDispAlert
	MOVE.L	IntuitionBase,A0
	MOVE.L	DispAlertSave,LVODisplayAlert+2(A0)
	RTS

NewDispAlert
	MOVEM.L	D0-D7/A0-A6,-(SP)
	LEA	SoftFailText(PC),A1
	ADDQ.L	#3,A0
	MOVEQ	#16,D0
ndaloop	CMP.B	(A1)+,(A0)+
	BNE.S	ndaexit
	DBF	D0,ndaloop
	BSR	FindAdr
	TST.L	D0
	BEQ.S	ndaexit
	MOVE.L	D0,A1
	MOVE.L	SongDataPtr,A0
	MOVE.L	#70716,D0
ndalop2	MOVE.B	(A0)+,D1
	MOVE	D1,$DFF180
	MOVE.B	D1,(A1)+
	SUBQ.L	#1,D0
	BNE.S	ndalop2
ndaexit	MOVEM.L	(SP)+,D0-D7/A0-A6
xyzzy2	JMP	$FC0000


DispAlertSave EQU xyzzy2+2
SoftFailText	dc.b	"Software Failure :-(",0
		even

;---- Copper List Functions ----
SetCopList
	MOVE.L	GfxBase,A0
	move.l	38(a0),oldcopA
	move.l	50(a0),oldcopB
	MOVE.L	#CopList,$DFF080
	MOVE.L	#CopListB,$DFF084
	move	#0,$dff088
	RTS

ResetCopList
	MOVE.L	GfxBase,A0
	MOVE.L	38(A0),$DFF080
	MOVE.L	50(A0),$DFF084
	move	#0,$dff088
	RTS

oldcopA	dc.l	0
oldcopB	dc.l	0



;---- Vertical Blank Interrupt Functions ----

SetVBInt
	MOVEQ	#5,D0
	LEA	VBIntServer,A1
	MOVE.L	4.W,A6
	JSR	LVOAddIntServer(A6)
	RTS

ResetVBInt
	MOVEQ	#5,D0
	LEA	VBIntServer,A1
	MOVE.L	4.W,A6
	JSR	LVORemIntServer(A6)
	RTS

vbint	MOVEM.L	D0-D7/A0-A6,-(SP)
	JSR	SetNewPitchCtrl
	BSR	UpdatePointerPos
	BSR	VUmeters
	BSR	Scope
	BSR	SpecAnaInt
	BSR	ArrowKeys
	BSR	CheckKeyRepeat
	BSR	UpdateTicks
	MOVEM.L	(SP)+,D0-D7/A0-A6
	RTS

VBIntServer
	dc.l 0,0
	dc.b 2,0			; type, priority
	dc.l vbintname
	dc.l 0,vbint

vbintname
	dc.b "Protracker_Music_VBlank",0
	even






;---------------------------- Serial Interrupt Functions -----------    (SPICE)
SetSERInt
	move	#1<<11,$dff09a		;intena
	MOVEQ	#11,D0
	LEA	SERIntServer,A1
	MOVE.L	4.W,A6
	JSR	LVOSetIntVector(A6)
	move.l	d0,OldSerVector
	bsr	InitSerial
	move	#(1<<11)+$8000,$dff09a
	RTS
OldSerVector
	dc.l	0

;-------------- Set serial baud rate
InitSerial
	move	#(3546895/19200)-1,$dff032
;	MOVE	#$8801,$DFF09A	;RBF & TBE on!!
	rts


ResetSERInt
	move.l	OldSerVector,A1
	cmp.l	#0,A1
	beq.s	.noreset
		move	#1<<11,$dff09a		;intena
		MOVEQ	#11,D0
		MOVE.L	4.W,A6
		JSR	LVOSetIntVector(A6)
		move	#(1<<11)+$8000,$dff09a
.noreset
	RTS


;-------------- Serial interupt handler code
SERIALint
	MOVEM.L	D0-D2/A0-A1,-(SP)
	bsr	GetSerial
	MOVEM.L	(SP)+,D0-D2/A0-A1
	RTS
;-------------- serial recieve character
SerialByteRec	dc.w	0
GetSerial
	move	$dff018,d0
	MOVE	#$0800,$DFF09C ;intreq
	move	#$00f,$dff180
	move.b	d0,SerialByteRec
	rts


; ------------- serial send character
SerialByteL	dc.b	$01
SerialByte	dc.b	$00
SendSerial
	move	#$4000,$dff09a
	move	#$f0f,$dff180
	move	d0,-(sp)
	MOVE	#1,$dff09C	;clear intreq bit
;	move	$dff018,d0
;	btst	#13,d0
;	beq.s	.s
		move	SerialByteL,$dff030
.s	move	(sp)+,d0
	move	#$c000,$dff09a
	rts




;--------------- check serial byte and act on it
CheckSerialByte
	move.b	SerialByteRec(pc),d0
	clr	SerialByteRec
	cmp.b	#'1',d0
	beq	RecSerialPlay
	cmp.b	#'2',d0
	beq	RecSerialPatt
	cmp.b	#'3',d0
	beq	RecSerialRec
	cmp.b	#'4',d0
	beq	RecSerialStop

	tst.b	d0
	beq.s	.novalue

	move	#$f00,$dff180
	move	#$4000,d0
.del	nop
	nop
	nop
	dbf	d0,.del
	move	#$0,$dff180

.novalue
	rts



RecSerialPlay	jsr	PlaySong
		LEA	SerialPlayText(pc),A0
		JSR	ShowStatusText
		RTS

RecSerialPatt	jsr	PlayPattern
		LEA	SerialPattText(pc),A0
		JSR	ShowStatusText
		RTS

RecSerialRec	jsr	RecordPattern
		LEA	SerialRecText(pc),A0
		JSR	ShowStatusText
		RTS

RecSerialStop	jsr	StopIt
		LEA	SerialStopText(pc),A0
		JSR	ShowStatusText
		RTS

ContPlayText	dc.b	'Continue Play..',0
ContPattText	dc.b	'Continue Patt..',0
ContRecText	dc.b	'Continue Rec...',0

NormalPlayText	dc.b	'Normal Play....',0
NormalPattText	dc.b	'Normal Patt....',0
NormalRecText	dc.b	'Normal Rec.....',0
NormalEditText	dc.b	'Normal Edit....',0
NormalStopText	dc.b	'Normal Stop....',0

SerialPlayText	dc.b	'Serial Play....',0
SerialPattText	dc.b	'Serial Patt....',0
SerialRecText	dc.b	'Serial Rec.....',0
SerialStopText	dc.b	'Serial Stop....',0
			;0123456789abcdef

SERIntServer
	dc.l 0,0
	dc.b 2,1			; type, priority
	dc.l SERintname
	dc.l 0,SERIALint

SERintname
	dc.b "Protracker_Serial_Interupt",0
	even







;---------------------------- Music Interrupt ---------------------
SetMusicInt
	TST.B	IntMode
	BNE.S	SetCIAInt
	MOVEQ	#5,D0
	LEA	MusicIntServer,A1
	MOVE.L	4.W,A6
	JSR	LVOAddIntServer(A6)
	RTS

ResetMusicInt
	TST.B	IntMode
	BNE	ResetCIAInt
	MOVEQ	#5,D0
	LEA	MusicIntServer,A1
	MOVE.L	4.W,A6
	JSR	LVORemIntServer(A6)
	RTS

MusicIntServer
	dc.l 0,0
	dc.b 2,1			; type, priority
	dc.l musintname
	dc.l 0,IntMusic

musintname	dc.b "Protracker_Music_CIAInt",0
		even
;---- CIA Interrupt ----

ciatalo = $400
ciatahi = $500
ciatblo = $600
ciatbhi = $700
ciacra  = $E00
ciacrb  = $F00

SetCIAInt
	MOVEQ	#2,D6
	LEA	$BFD000,A5
	MOVE.B	#'b',CIAAname+3
SetCIALoop
	MOVEQ	#0,D0
	LEA	CIAAname(PC),A1
	MOVE.L	4.W,A6
	JSR	LVOOpenResource(A6)
	MOVE.L	D0,CIAAbase
	BEQ	Return1
	MOVE.L	D0,A6

	MOVE.L	GfxBase,A0
	MOVE	206(A0),D0	; DisplayFlags
	BTST	#2,D0		; PAL?
	BEQ.S	WasNTSC
	MOVE.L	#1773447,D7	; PAL
	BRA.S	sciask
WasNTSC	MOVE.L	#1789773,D7	; NTSC
sciask	MOVE.L	D7,TimerValue
	DIVU	#125,D7		; Default to normal 50 Hz timer

	CMP	#2,D6
	BEQ.S	TryTimerA
TryTimerB
	LEA	MusicIntServer(PC),A1
	MOVEQ	#1,D0	; Bit 1: Timer B
	JSR	AddICRVector(A6)
	MOVE.L	#1,TimerFlag
	TST.L	D0
	BNE.S	CIAError
	MOVE.L	A5,CIAAaddr
	MOVE.B	D7,ciatblo(A5)
	LSR	#8,D7
	MOVE.B	D7,ciatbhi(A5)
	BSET	#0,ciacrb(A5)
	BRA	SetTempo

TryTimerA
	LEA	MusicIntServer(PC),A1
	MOVEQ	#0,D0		; Bit 0: Timer A
	JSR	AddICRVector(A6)
	CLR.L	TimerFlag
	TST.L	D0
	BNE.S	CIAError
	MOVE.L	A5,CIAAaddr
	MOVE.B	D7,ciatalo(A5)
	LSR	#8,D7
	MOVE.B	D7,ciatahi(A5)
	BSET	#0,ciacra(A5)
	BRA	SetTempo

CIAError
	MOVE.B	#'a',CIAAname+3
	LEA	$BFE001,A5
	SUBQ	#1,D6
	BNE	SetCIALoop
	CLR.L	CIAAbase
	RTS

ResetCIAInt
	MOVE.L	CIAAbase(PC),D0
	BEQ	Return1
	CLR.L	CIAAbase
	MOVE.L	D0,A6
	MOVE.L	CIAAaddr(PC),A5
	TST.L	TimerFlag
	BEQ.S	ResTimerA

	BCLR	#0,ciacrb(A5)
	MOVEQ	#1,D0
	BRA.S	RemInt

ResTimerA
	BCLR	#0,ciacra(A5)
	MOVEQ	#0,D0
RemInt	LEA	MusicIntServer(PC),A1
	MOVEQ	#0,d0
	JSR	RemICRVector(A6)
	RTS

CIAAname	dc.b 'ciaa.resource',0
CIAAbase	dc.l 0
TimerFlag	dc.l 0
TimerValue	dc.l 0

;---- Tempo ----

TempoGadg
	CMP	#60,D0
	BHS	Return1
	CMP	#44,D0
	BHS.S	TemDown
TemUp	MOVE	RealTempo(PC),D0
	ADDQ	#1,D0
	BTST	#2,$DFF016
	BNE.S	teupsk
	ADDQ	#8,D0
	ADDQ	#1,D0
teupsk	CMP	#255,D0
	BLS.S	teposk
	MOVE	#255,D0
teposk	MOVE	D0,RealTempo
	BSR	SetTempo
	JMP	Wait_4000

TemDown	MOVE	RealTempo(PC),D0
	SUBQ	#1,D0
	BTST	#2,$DFF016
	BNE.S	tednsk
	SUBQ	#8,D0
	SUBQ	#1,D0
tednsk	CMP	#32,D0
	BHS.S	teposk
	MOVE	#32,D0
	BRA.S	teposk


ChangeTempo
	CMP	#94,D0
	BHS.S	TempoDown
	CMP	#80,D0
	BHS.S	TempoUp
	RTS

TempoUp	MOVE	Tempo,D0
	ADDQ	#1,D0
	BTST	#2,$DFF016
	BNE.S	temupsk
	ADDQ	#8,D0
	ADDQ	#1,D0
temupsk	CMP	#255,D0
	BLS.S	temposk
	MOVE	#255,D0
temposk	MOVE	D0,Tempo
	MOVE	D0,RealTempo
	BSR.S	ShowTempo
	BSR.S	SetTempo
	JMP	Wait_4000

TempoDown
	MOVE	Tempo,D0
	SUBQ	#1,D0
	BTST	#2,$DFF016
	BNE.S	temdnsk
	SUBQ	#8,D0
	SUBQ	#1,D0
temdnsk	CMP	#32,D0
	BHS.S	temposk
	MOVE	#32,D0
	BRA.S	temposk

ShowTempo
	MOVE	#TempoTextPos,TextOffset
	MOVE	RealTempo(PC),WordNumber
	JMP	Print3DecDigits

SetTempo
	MOVEQ	#125,D0
	MOVE.L	CIAAbase(PC),D1
	BEQ.S	setesk3
	MOVE	RealTempo(PC),D0
	CMP	#32,D0
	BHS.S	setemsk
	MOVEQ	#32,D0
setemsk	MOVE	D0,RealTempo
setesk3	TST	SamScrEnable
	BNE.S	setesk2
	MOVE	#TempoNumPos,TextOffset
	MOVE	D0,WordNumber
	JSR	Print3DecDigits
setesk2	MOVE.L	CIAAbase(PC),D0
	BEQ	Return1
	MOVE	RealTempo(PC),D0
	MOVE.L	TimerValue(PC),D1
	DIVU	D0,D1
	MOVE.L	CIAAaddr(PC),A5
	MOVE.L	TimerFlag(PC),D0
	BEQ.S	SetTemA
	MOVE.B	D1,ciatblo(A5)	;and set the CIA timer
	LSR	#8,D1
	MOVE.B	D1,ciatbhi(A5)
	RTS

SetTemA	MOVE.B	D1,ciatalo(A5)
	LSR	#8,D1
	MOVE.B	D1,ciatahi(A5)
	RTS

RealTempo	dc.w 125
CIAAaddr	dc.l 0

;---- Input Event Handler ----

SetInputHandler
	MOVE.L	4.W,A6
	LEA	InpEvPort,A1
	JSR	LVOAddPort(A6)
	LEA	InputDevName,A0
	MOVEQ	#0,D0
	LEA	InpEvIOReq,A1
	MOVEQ	#0,D1
	MOVE.L	#InpEvPort,14(A1)
	JSR	LVOOpenDevice(A6)
	LEA	InpEvIOReq,A1
	MOVE	#9,IO_COMMAND(A1) ; IND_ADDHANDLER
	MOVE.B	#1,IO_FLAGS(A1)
	MOVE.L	#InpEvStuff,IO_DATA(A1)
	JSR	LVOSendIO(A6)
	RTS

ResetInputHandler
	MOVE.L	4.W,A6
	LEA	InpEvIOReq,A1
	MOVE	#10,IO_COMMAND(A1) ; IND_REMHANDLER
	MOVE.B	#1,IO_FLAGS(A1)
	MOVE.L	#InpEvStuff,IO_DATA(A1)
	JSR	LVOSendIO(A6)
	LEA	InpEvIOReq,A1
	JSR	LVOCloseDevice(A6)
	LEA	InpEvPort,A1
	JSR	LVORemPort(A6)
	RTS


InpEvStuff
	dc.l	0,0
	dc.b	2,52 ; type, priority
	dc.l	inpevname
	dc.l	0,InputHandler

inpevname
	dc.b "Protracker_InputHandler",0
	even

;--------------------------------------
; A0-InputEvent, A1-Data Area
;
InputHandler
	MOVEM.L	D1/A0-A3,-(SP)
	TST.B	AutoReqRunning
	BNE.S	inphend
	SUB.L	A2,A2
	MOVE.L	A0,A1
	MOVE.B	4(A1),D0 ; ie_Class
	CMP.B	#1,D0    ; RAWKEY
	BEQ.S	InpRawkey
	CMP.B	#2,D0    ; RAWMOUSE
	BEQ.S	InpRawmouse
	MOVE.L	A1,A2
InpNext	MOVE.L	(A1),A1
	MOVE.L	A1,D0
	BNE.S	InputHandler
inphend	MOVE.L	A0,D0
	MOVEM.L	(SP)+,D1/A0-A3
	RTS

InpRawkey
	BSR	InpUnchain
	MOVE	6(A1),D0
	BSR	ProcessRawkey
	BRA	InpNext

InpRawmouse
	BSR	InpUnchain
	MOVE	MouseX3,D0
	MOVE	MouseY3,D1
	ADD	10(A1),D0
	ADD	12(A1),D1
	TST	D0
	BPL.S	irskip1
	MOVEQ	#0,D0
irskip1	TST	D1
	BPL.S	irskip2
	MOVEQ	#0,D1
irskip2	CMP	#320,D0
	BLO.S	irskip3
	MOVE	#320-1,D0
irskip3	CMP	#256,D1
	BLO.S	irskip4
	MOVE	#256-1,D1
irskip4	MOVE	D0,MouseX3
	MOVE	D1,MouseY3
;	LSR	#1,D0			;moves faster without this
;	LSR	#1,D1
	MOVE	D0,MouseX
	MOVE	D1,MouseY
	BRA.S	InpNext

InpUnchain
	MOVE.L	A2,D0
	BNE.S	InpUnc2
	MOVE.L	(A1),A0
	RTS
InpUnc2	MOVE.L	(A1),(A2)
	RTS



;---- Process rawkey code from the keyboard ----
ProcessRawkey
	CMP.B	LastRawkey,D0
	BEQ	Return1
	MOVE.B	D0,LastRawkey
	CMP.B	#67+128,D0
	BEQ	LowerInstr2
	CMP.B	#96,D0
	BEQ	ShiftOn
	CMP.B	#97,D0
	BEQ	ShiftOn2
	CMP.B	#100,D0
	BEQ	AltOn
	CMP.B	#101,D0
	BEQ	AltOn2
	CMP.B	#99,D0
	BEQ	CtrlOn
	CMP.B	#102,D0
	BEQ	LeftAmigaOn
	CMP.B	#99+128,D0
	BEQ	CtrlOff
	CMP.B	#100+128,D0
	BEQ	AltOff
	CMP.B	#96+128,D0
	BEQ.S	ShiftOff
	CMP.B	#101+128,D0
	BEQ	AltOff
	CMP.B	#97+128,D0
	BEQ.S	ShiftOff
	CMP.B	#102+128,D0
	BEQ	LeftAmigaOff
	CMP.B	#98,D0
	BEQ.S	KeyRepOn
	CMP.B	#98+128,D0
	BEQ.S	KeyRepOff
kbintSetKey
	TST.B	D0
	BNE.S	kbintDoSet
	MOVE.B	#127,D0
kbintDoSet
	MOVE	KeyBufPos(PC),D1
	CMP	#KeyBufSize,D1
	BHS	Return1
	LEA	KeyBuffer(PC),A3
	MOVE.B	D0,(A3,D1.W)
	ADDQ	#1,KeyBufPos
	RTS

LowerInstr2
	CLR	HiLowInstr
	BRA.S	kbintSetKey

KeyRepOn
	ST	KeyRepeat
	RTS

KeyRepOff
	SF	KeyRepeat
	RTS

ShiftOn	MOVE	#1,ShiftKeyStatus
	RTS

ShiftOn2
	MOVE	#1,ShiftKeyStatus
	BRA.S	kbintSetKey
 
ShiftOff
	CLR	ShiftKeyStatus
	RTS
 
AltOn	MOVE	#1,AltKeyStatus
	RTS

AltOn2	MOVE	#1,AltKeyStatus
	BRA.S	kbintSetKey
 
AltOff	CLR	AltKeyStatus
	RTS

CtrlOn	MOVE	#1,CtrlKeyStatus
	RTS
 
CtrlOff	CLR	CtrlKeyStatus
	RTS

LeftAmigaOn
	MOVE	#1,LeftAmigaStatus
	RTS
 
LeftAmigaOff
	CLR	LeftAmigaStatus
	RTS

DoKeyBuffer
	MOVE	KeyBufPos(PC),D0
	BEQ	Return1
	SUBQ	#1,D0
	LEA	KeyBuffer(PC),A0
	MOVE.B	(A0,D0.W),D1
	MOVE	D0,KeyBufPos
	MOVE.B	D1,RawKeyCode
	MOVE.B	D1,SaveKey
	MOVE	KeyRepDelay,KeyRepCounter
	BTST	#7,D1
	BEQ.S	dkbend
	CLR	KeyRepCounter
dkbend	RTS

KeyBufPos	dc.w	0
KeyBuffer	dcb.b	KeyBufSize,0
ShiftKeyStatus	dc.w	0
AltKeyStatus	dc.w	0
CtrlKeyStatus	dc.w	0
LeftAmigaStatus	dc.w	0
LastRawkey	dc.b	255,0
SaveKey		dc.b	0
KeyRepeat	dc.b	0
KeyRepCounter	dc.w	0

;---- Key repeat ----

CheckKeyRepeat
	TST.B	KeyRepeat
	BEQ	Return1
	MOVE	KeyRepCounter(PC),D0
	BEQ	Return1
	SUBQ	#1,D0
	BEQ.S	RepDown
	MOVE	D0,KeyRepCounter
	RTS

RepDown	MOVE.B	SaveKey(PC),RawKeyCode
	MOVE	KeyRepSpeed,KeyRepCounter
	RTS

;---- Update Mousepointer Position ----

UpdatePointerPos
	MOVE	MouseX,D0
	ADDQ	#3,D0
	MOVE	MouseY,D1
	MOVEQ	#PointerYsize,D2
	MOVE.L	PointerSpritePtr,A0
	JMP	SetSpritePos

;---- Timer ----

UpdateTicks
	CMP.L	#'patp',RunMode
	BNE	Return1
	ADDQ	#1,PatternTicks
	MOVE	PatternTicks(PC),D0
	MOVE.L	4.W,A0
	CMP.B	$212(A0),D0
	BNE	Return1
	CLR	PatternTicks
	ADDQ.L	#1,TimerTicks
	RTS
 
ShowTimer
	CMP	#4,CurrScreen
	BEQ	Return1
	MOVE.L	TimerTicks(PC),D0
	DIVU	#60,D0
	MOVE	D0,WordNumber
	SWAP	D0
	MOVE	D0,D7
	MOVE	#TimerNumPos,TextOffset
	JSR	Print2DecDigits
	MOVE	D7,WordNumber
	ADDQ	#1,TextOffset
	JMP	Print2DecDigits

PatternTicks	dc.w	0
TimerTicks	dc.l	0

;---- Spectrum Analyzer ----

SpecAnaInt
	CMP	#1,CurrScreen
	BNE	Return1
	TST.B	DisableAnalyzer
	BNE	Return1
.loop	TST.B	AnaDrawFlag
	BNE	Return1
	ST	AnaDrawFlag
	MOVEQ	#40,D5
	MOVEQ	#126,D6
	LEA	AnalyzerHeights,A0
	LEA	AnalyzerOpplegg,A1
	LEA	AnalyzerOffsets(PC),A2
	MOVE.L	TextBplPtr,A3
	LEA	AnaBlkPos(A3),A3
	MOVEQ	#$16,D7
spanlab1
	MOVE	(A0)+,D0
	CMP	#36,D0
	BLO.S	spanskip2
	MOVE	#36,D0
spanskip2
	MOVE	(A1)+,D1
	CMP	D0,D1
	BEQ.S	spanskip3
	BLO.S	span_r2
	SUB	D0,D1
	SUBQ	#1,D1
	ADD	D0,D0
	MOVE	(A2,D0.W),D0
spanloop
	CLR.B	(A3,D0.W)
	SUB	D5,D0
	DBF	D1,spanloop
	BRA.S	spanskip3
 
span_r2	SUB	D1,D0
	SUBQ	#1,D0
	LSL	#1,D1
	MOVE	0(A2,D1.W),D1
spanloop2
	MOVE.B	D6,0(A3,D1.W)
	SUB	D5,D1
	DBF	D0,spanloop2
spanskip3
	ADDQ.L	#1,A3
	DBF	D7,spanlab1
	LEA	AnalyzerHeights,A0
	LEA	AnalyzerOpplegg,A1
	MOVEQ	#22,D7
spanloop3
	MOVE	(A0),D0
	MOVE	D0,(A1)+
	BEQ.S	spanskip4
	SUBQ	#1,D0
spanskip4
	MOVE	D0,(A0)+
	DBF	D7,spanloop3
	SF	AnaDrawFlag
	RTS

ClearAnaHeights
	LEA	AnalyzerOpplegg,A0
	LEA	AnalyzerHeights,A1
	MOVEQ	#22,D7
	MOVEQ	#0,D0
cahloop	MOVE	D0,(A0)+
	MOVE	D0,(A1)+
	DBF	D7,cahloop
	RTS

PlayNoteAnalyze		; Called by keyboard play
	MOVEM.L	D0-D3/A0,-(SP)
	MOVEQ	#0,D2
	MOVE	2(A6),D2
	BRA.S	SpecAna2

SpectrumAnalyzer	; Called by playroutine
	TST	(A4)
	BEQ	Return1
	MOVEM.L	D0-D3/A0,-(SP)
	MOVEQ	#0,D2
	MOVE.B	n_volume(A6),D2	; Get channel volume
SpecAna2
	TST.B	AnaDrawFlag
	BNE	ohno
	ST	AnaDrawFlag
	BSR	SetAnalyzerVolumes
	BEQ.S	saend
	LSL	#8,D2
	DIVU	#682,D2
	MOVE	D2,D3
	LSR	#1,D3
	LEA	AnalyzerHeights,A0
	SUB	#113,D0	; Subtract 113 (highest rate)
	MOVE	#743,D1
	SUB	D0,D1	; Invert range 0-743
	MULU	D1,D1	; 0 - 743^2
	DIVU	#25093,D1
	MOVE	D1,D0
	CMP	#46,D0
	BLO.S	saskip
	MOVEQ	#45,D0
saskip	LSL	#1,D0
	ADD	D2,(A0,D0.W)
	CMP	#36,(A0,D0.W)
	BLO.S	saskip2
	MOVE	#36,(A0,D0.W)
saskip2	TST	D0
	BEQ.S	saskip3
	ADD	D3,-2(A0,D0.W)
	CMP	#36,-2(A0,D0.W)
	BLO.S	saskip3
	MOVE	#36,-2(A0,D0.W)
saskip3	CMP	#44,D0
	BEQ.S	saend
	ADD	D3,2(A0,D0.W)
	CMP	#36,2(A0,D0.W)
	BLO.S	saend
	MOVE	#36,2(A0,D0.W)
saend	SF	AnaDrawFlag
ohno	MOVEM.L	(SP)+,D0-D3/A0
	RTS

AnalyzerOffsets
	dc.w $0730,$0708,$06E0,$06B8,$0690,$0668,$0640,$0618
	dc.w $05F0,$05C8,$05A0,$0578,$0550,$0528,$0500,$04D8
	dc.w $04B0,$0488,$0460,$0438,$0410,$03E8,$03C0,$0398
	dc.w $0370,$0348,$0320,$02F8,$02D0,$02A8,$0280,$0258
	dc.w $0230,$0208,$01E0,$01B8,$0190,$0168,$0140,$0118
	dc.w $00F0

AnaDrawFlag	dc.b 0,0







;---------------------------- Scope --------------------------------

ns_sampleptr =  0
ns_endptr    =  4
ns_repeatptr =  8
ns_rependptr = 12
ns_period    = 16
ns_volume    = 18

Scope	LEA	audchan1temp,A0
	LEA	ScopeInfo,A2
	LEA	ScopeSamInfo,A1
	LEA	BlankSample,A3
	LEA	PitchCtrl,a4
	MOVEQ	#3,D6
ScoLoop	MOVE	(A0),D0
	AND	#$0FFF,D0
	OR	n_period(A0),D0
	BEQ	ScoSampleEnd ; end if no note & no period

	move	(a4)+,d0			;PITCH
	sub	#PitchCtrlSize>>1,d0
	add	d0,d0				;scale pitch_ctrl range
	MOVE	n_period(A0),ns_period(A2)
	add	d0,ns_period(A2)		;PITCH

	MOVE.B	n_volume(A0),ns_volume(A2)

	TST.B	n_trigger(A0)
	BEQ	ScoContinue
ScoRetrig
	SF	n_trigger(A0)
	BSR	SetScope
	MOVEQ	#0,D0
	MOVE.B	n_samplenum(A0),D0
	SUBQ	#1,D0
	LSL	#4,D0
	MOVE.L	ns_sampleptr(A1,D0.W),ns_sampleptr(A2)
	MOVE.L	ns_endptr(A1,D0.W),ns_endptr(A2)
	MOVE.L	ns_repeatptr(A1,D0.W),ns_repeatptr(A2)
	MOVE.L	ns_rependptr(A1,D0.W),ns_rependptr(A2)
	MOVE.L	ns_sampleptr(A2),D0
	CMP.L	A3,D0 ; at end of sample...
	BEQ.S	ScoNextChan
	BRA	ScoChk
ScoContinue
	MOVE.L	ns_sampleptr(A2),D0
	CMP.L	A3,D0 ; at end of sample...
	BEQ.S	ScoNextChan
	MOVEQ	#0,D1
	MOVE	ns_period(A2),D1
	LSR	#1,D1
	BEQ.S	ScoNextChan
	MOVE.L	#35469,D2
	DIVU	D1,D2
	EXT.L	D2
	ADD.L	D2,D0
ScoChk	CMP.L	ns_endptr(A2),D0
	BLO.S	ScoUpdatePtr
	TST.L	ns_repeatptr(A2)
	BNE.S	ScoSamLoop
ScoSampleEnd
	MOVE.L	A3,D0
	BRA.S	ScoUpdatePtr

ScoSamLoop
	SUB.L	ns_endptr(A2),D0
	ADD.L	ns_repeatptr(A2),D0
	MOVE.L	ns_rependptr(A2),ns_endptr(A2)
	CMP.L	ns_endptr(A2),D0
	BHS	ScoSamLoop
ScoUpdatePtr
	MOVE.L	D0,ns_sampleptr(A2)
ScoNextChan
	LEA	20(A2),A2			;ADD.L	#20,A2
	LEA	44(A0),A0			;ADD.L	#44,A0
	DBF	D6,ScoLoop

; now draw channels
	TST.B	ScopeEnable
	BEQ.S	clsnot
	CMP	#1,CurrScreen
	BNE.S	clsnot
	TST.B	EdEnable
	BNE.S	clsnot

	MOVE.L	TextBplPtr,A0
	ADD.L	#Scope1Pos,A0
	MOVEQ	#0,D0
	MOVEQ	#32,D1
clscop1					;MOVEQ	#5,D2
	MOVE.L	D0,(A0)+
	MOVE.L	D0,(A0)+
	MOVE.L	D0,(A0)+
	MOVE.L	D0,(A0)+
	MOVE.L	D0,(A0)+
	MOVE.L	D0,(A0)+
					;DBF	D2,clscop2
	LEA	16(A0),A0
	DBF	D1,clscop1

clsnot	MOVEQ	#-1,D4
	TST	SamScrEnable
	BEQ.S	ScoNClr
	MOVEQ	#0,D4
ScoNClr	MOVEQ	#0,D7
	MOVE	$DFF002,D6 ; dmaconr
	MOVEQ	#0,D5
	MOVE.L	#ScopeBox1Pos,A1
	LEA	xBlankSample,A2
	BTST	#0,D6
	BEQ.S	ScoSkp1
	LEA	ScopeInfo,A2
	MOVE.B	ns_volume(A2),D5
ScoSkp1	BSR.S	ScoDraw

	MOVEQ	#0,D5
	MOVE.L	#ScopeBox2Pos,A1
	LEA	xBlankSample,A2
	BTST	#1,D6
	BEQ.S	ScoSkp2
	LEA	ScopeInfo+20,A2
	MOVE.B	ns_volume(A2),D5
ScoSkp2	BSR.S	ScoDraw

	MOVEQ	#0,D5
	MOVE.L	#ScopeBox3Pos,A1
	LEA	xBlankSample,A2
	BTST	#2,D6
	BEQ.S	ScoSkp3
	LEA	ScopeInfo+40,A2
	MOVE.B	ns_volume(A2),D5
ScoSkp3	BSR.S	ScoDraw

	MOVEQ	#0,D5
	MOVE.L	#ScopeBox4Pos,A1
	LEA	xBlankSample,A2
	BTST	#3,D6
	BEQ.S	ScoSkp4
	LEA	ScopeInfo+60,A2
	MOVE.B	ns_volume(A2),D5
ScoSkp4	BSR	ScoDraw
	TST.L	D7
	BEQ	sdloscr
Scorts	RTS


ScoDraw	TST.B	ScopeEnable
	BEQ.S	sdlpos
	CMP	#1,CurrScreen
	BNE.S	sdlpos
	TST.B	EdEnable
	BNE.S	sdlpos
	LSR	#1,D5
	CMP	#32,D5
	BLS.S	sdsk1
	MOVEQ	#32,D5
sdsk1	MOVE.L	(A2),A0
	ADD.L	TextBplPtr,A1
	MOVEQ	#4,D2
sdlp1	MOVEQ	#7,D3
sdlp2	MOVE.B	(A0)+,D0	; get byte
	EXT	D0		; extend to word
	NEG	D0		; negate
	MULS	D5,D0		; multiply by volume
	ASR	#8,D0		; shift down
	MOVE	D0,D1
	ASL	#5,D0		; * 32
	ASL	#3,D1		; * 8
	ADD	D1,D0		; (32+8) = * 40
	BSET	D3,(A1,D0.W)	; set a bit
	DBF	D3,sdlp2
	ADDQ.L	#1,A1		; yes
sdlskip	DBF	D2,sdlp1

sdlpos	TST.B	D4
	BNE.S	Scorts
	LEA	xBlankSample(PC),A0
	CMP.L	A0,A2
	BEQ.S	sdloscr
	MOVE.L	(A2),D1
	MOVE.L	SamDrawStart(PC),D0
	CMP.L	D0,D1
	BLS.S	Scorts
	CMP.L	SamDrawEnd(PC),D1
	BHS.S	Scorts
	SUB.L	D0,D1
	MULU	#314,D1
	MOVE.L	SamDisplay,D0
	BEQ.S	Scorts
	DIVU	D0,D1
	ST	D4
	ST	D7
	MOVE.L	D1,D0
	ADDQ	#6,D0
	MOVE	#139,D1
sdlpspr	MOVEQ	#64,D2
	LEA	PlayPosSpriteData,A0
	JMP	SetSpritePos

sdloscr	MOVEQ	#0,D0
	MOVE	#270,D1
	BRA.S	sdlpspr

SetScope
	MOVEQ	#0,D1
	MOVE.B	n_samplenum(A0),D1
	SUBQ	#1,D1
	LSL	#4,D1
	LEA	ScopeSamInfo,A4
	LEA	(A4,D1.W),A4

	MOVE.L	n_start(A0),D0
	MOVE.L	D0,ns_sampleptr(A4)
	MOVEQ	#0,D1
	MOVE	n_length(A0),D1
	ADD.L	D1,D0
	ADD.L	D1,D0
	MOVE.L	D0,ns_endptr(A4)

	MOVE.L	n_loopstart(A0),D0
	MOVE.L	D0,ns_repeatptr(A4)
	MOVEQ	#0,D1
	MOVE	n_replen(A0),D1
	CMP	#1,D1
	BEQ.S	sconorep
	ADD.L	D1,D0
	ADD.L	D1,D0
	MOVE.L	D0,ns_rependptr(A4)
	BRA	Return1
sconorep
	CLR.L	ns_repeatptr(A4)
	RTS

ToggleAnaScope
	TST	notogfl
	BNE	Return1
	BSR	WaitForButtonUp
	MOVEQ	#0,D4
	TST.B	AnaScopFlag
	BNE.S	tasana
	ST	AnaScopFlag
	BRA	RedrawAnaScope
tasana	SF	AnaScopFlag
	BRA	RedrawAnaScope

ScopeEnable	dc.b 0
AnaScopFlag	dc.b 1
xBlankSample	dc.l BlankSample
SamDrawStart	dc.l 0
SamDrawEnd	dc.l 0






;---- Show Free/Tune Memory ----
DoShowFreeMem
	MOVE	#1,UpdateFreeMem
ShowFreeMem
	MOVEM.L	D0-D7/A0-A6,-(SP)
	TST	UpdateFreeMem
	BEQ.S	sfmskp
	CLR	UpdateFreeMem
	CLR.L	FreeMemory
	CLR.L	TuneMemory
sfmskp	BSR	ShowTuneMem
	MOVEQ	#MEMF_CHIP,D1
	TST.B	ShowPublicFlag
	BEQ	sfmskp2
	MOVEQ	#MEMF_PUBLIC,D1
sfmskp2	MOVE.L	4.W,A6
	JSR	LVOAvailMem(A6)
	CMP.L	FreeMemory(PC),D0
	BEQ.S	fremend
	MOVE.L	D0,FreeMemory
	TST.B	ShowDecFlag
	BNE.S	shfrdec
	MOVE.L	D0,D6
	MOVE	#FreeMemPos,TextOffset
	SWAP	D0
	AND	#$FF,D0
	MOVE	D0,WordNumber
	JSR	PrintHexByte
	MOVE	D6,WordNumber
	JSR	PrintHexWord
fremend	MOVEM.L	(SP)+,D0-D7/A0-A6
	RTS

shfrdec	MOVE.L	FreeMemory(PC),D0
	MOVE	#FreeMemPos,TextOffset
	JSR	Print6DecDigits
	BRA.S	fremend

ShowTuneMem
	MOVE.L	SongDataPtr,A0
	LEA	42(A0),A0
	MOVE	TuneUp(PC),D7
	SUBQ	#1,D7
	MOVE	#31,TuneUp
	MOVEQ	#0,D0	; Zero length
stumeloop
	MOVEQ	#0,D1
	MOVE	(A0),D1
	ASL	#1,D1
	ADD.L	D1,D0	; Add samplelength
	ADD.L	#30,A0
	DBF	D7,stumeloop
	ADD.L	#1084,D0	; Add 1084 to length
	MOVE.L	SongDataPtr,A0
	MOVEQ	#127,D7
	ADD.L	#952,A0
	MOVEQ	#0,D6
stumeloop2
	MOVE.B	(A0)+,D5
	CMP.B	D5,D6
	BHI.S	stumeskip
	MOVE.B	D5,D6
stumeskip
	DBF	D7,stumeloop2
	ADDQ	#1,D6
	ASL.L	#8,D6
	ASL.L	#2,D6
	ADD.L	D6,D0	; Add 1024 x Number of patterns
	CMP.L	TuneMemory(PC),D0
	BEQ	Return1
	MOVE.L	D0,TuneMemory
	TST.B	ShowDecFlag
	BNE.S	shtudec
	MOVE.L	D0,D6
	MOVE	#TuneMemPos,TextOffset
	SWAP	D0
	AND	#$FF,D0
	MOVE	D0,WordNumber
	JSR	PrintHexByte
	MOVE	D6,WordNumber
	JMP	PrintHexWord

shtudec	MOVE.L	TuneMemory(PC),D0
	MOVE	#TuneMemPos,TextOffset
	JMP	Print6DecDigits

UpdateFreeMem	dc.w	0
FreeMemory	dc.l	0
TuneMemory	dc.l	0
TuneUp		dc.w	31

;---- Audio Channel Toggles ----

CheckToggle
	MOVE	MouseY2,D0
	CMP	#1,CurrScreen
	BNE	Return1
	CMP	#44,D0
	BHS	Return1
DoToggleMute
	CMP	#34,D0
	BHS.S	ToggleCh4
	CMP	#23,D0
	BHS.S	ToggleCh3
	CMP	#12,D0
	BHS.S	ToggleCh2
ToggleCh1
	LEA	audchan1toggle(PC),A0
	BRA.S	TogCh
ToggleCh2
	LEA	audchan2toggle(PC),A0
	BRA.S	TogCh
ToggleCh3
	LEA	audchan3toggle(PC),A0
	BRA.S	TogCh
ToggleCh4
	LEA	audchan4toggle(PC),A0
TogCh	CLR.B	RawKeyCode
	EOR	#1,(A0)
	BSR	WaitForButtonUp
	CLR	D0
	MOVE	audchan4toggle(PC),D0
	LSL.B	#1,D0
	OR	audchan3toggle(PC),D0
	LSL.B	#1,D0
	OR	audchan2toggle(PC),D0
	LSL.B	#1,D0
	OR	audchan1toggle(PC),D0
	MOVE	D0,ActiveChannels
	BSR.S	RedrawToggles
	JSR	Wait_4000
	JMP	Wait_4000

RedrawToggles
	CMP	#1,CurrScreen
	BNE	Return1
	LEA	audchan1toggle(PC),A0
	BSR.S	RedrawSingleTogg
	LEA	audchan2toggle(PC),A0
	BSR.S	RedrawSingleTogg
	LEA	audchan3toggle(PC),A0
	BSR.S	RedrawSingleTogg
	LEA	audchan4toggle(PC),A0
RedrawSingleTogg
	LEA	BitPlaneData,A1
	MOVEQ	#0,D0
	MOVE	2(A0),D0
	ADD.L	D0,A1
	MOVEQ	#0,D0
	MOVE	4(A0),D0
	LEA	ToggleONdata,A2
	TST	(A0)
	BNE.S	rtskip
	LEA	ToggleOFFdata,A2
rtskip	ADD.L	D0,A2
	MOVEQ	#10,D4
rtloop2	MOVE	(ScreenWidth*2)+8(A2),PlaneSize(A1)
	MOVE	(A2)+,(A1)
	LEA	ScreenWidth(A1),A1
	DBF	D4,rtloop2
	RTS

rtdoit	MOVEQ	#10,D4
rtloop	MOVE	(ScreenWidth*3)+12(A2),PlaneSize(A1)
	MOVE	(A2)+,(A1)
	LEA	ScreenWidth(A1),A1
	DBF	D4,rtloop
	RTS

;---- VU Meters ----

VUmeters
	LEA	audchan1temp,A1
	LEA	VUSpriteData1,A2
	MOVE	audchan1toggle(PC),D0
	BSR.S	OneVUmeter
	LEA	audchan2temp,A1
	LEA	VUSpriteData2,A2
	MOVE	audchan2toggle(PC),D0
	BSR.S	OneVUmeter
	LEA	audchan3temp,A1
	LEA	VUSpriteData3,A2
	MOVE	audchan3toggle,D0
	BSR.S	OneVUmeter
	LEA	audchan4temp,A1
	LEA	VUSpriteData4,A2
	MOVE	audchan4toggle,D0
OneVUmeter
	TST.L	RunMode
	BEQ.S	VUmeterDown
	TST	(A1)
	BEQ.S	VUmeterDown
	TST	D0
	BEQ.S	VUmeterDown
	TST.L	Counter
	BNE.S	VUmeterDown
	MOVEQ	#0,D0		; New note
	MOVE.B	n_volume(A1),D0	; Get volume
	CMP	#$40,D0		; Higher than $40 ?
	BLS.S	iccskip		; No, skip
	MOVEQ	#$40,D0		; Yes, set to $40
iccskip	LEA	VUmeterHeights(PC),A3
	MOVE.B	#233,D7		; Set to 233
	SUB.B	0(A3,D0.W),D7	; Subtract to get new height
	MOVE.B	D7,(A2)
	RTS

VUmeterDown
	CMP.B	#233,(A2)
	BEQ	Return1
	ADDQ.B	#1,(A2)
	RTS

audchan1toggle	dc.w	1,(ScreenWidth*01)+38,0
Chan1Volume	dc.w	0
audchan2toggle	dc.w	1,(ScreenWidth*12)+38,22
Chan2Volume	dc.w	0
audchan3toggle	dc.w	1,(ScreenWidth*23)+38,44
Chan3Volume	dc.w	0
audchan4toggle	dc.w	1,(ScreenWidth*34)+38,66
Chan4Volume	dc.w	0
ActiveChannels	dc.w	15

VUmeterHeights
	dc.b	0,0,1,2,2,3,4,5,5,6,7,8,8,9,10,11
	dc.b	11,12,13,14,14,15,16,17,17,18,19,20,20,21,22,23
	dc.b	23,24,25,26,26,27,28,29,29,30,31,32,32,33,34,35
	dc.b	35,36,37,38,38,39,40,41,41,42,43,44,44,45,46,47
	dc.b	47,0

SetAnalyzerVolumes
	MOVEM.L	D0-D3/A0,-(SP)
	LSL	#8,D2
	DIVU	#640,D2
	CMP	#$F0A0,A5
	BNE.S	savCh2
	TST	audchan1toggle
	BEQ.S	savCh2
	CMP	Chan1Volume,D2 ; volume
	BLO.S	savCh2
	MOVE	D2,Chan1Volume
savCh2	CMP	#$F0B0,A5
	BNE.S	savCh3
	TST	audchan2toggle
	BEQ.S	savCh3
	CMP	Chan2Volume,D2
	BLO.S	savCh3
	MOVE	D2,Chan2Volume
savCh3	CMP	#$F0C0,A5
	BNE.S	savCh4
	TST	audchan3toggle
	BEQ.S	savCh4
	CMP	Chan3Volume,D2
	BLO.S	savCh4
	MOVE	D2,Chan3Volume
savCh4	CMP	#$F0D0,A5
	BNE.S	savNone
	TST	audchan4toggle
	BEQ.S	savNone
	CMP	Chan4Volume,D2
	BLO.S	savNone
	MOVE	D2,Chan4Volume
savNone	MOVEM.L	(SP)+,D0-D3/A0
	MOVEQ	#1,D4
	RTS

;---- Disk Op. ---- +++

DiskOp	CLR.B	RawKeyCode
	MOVE	CurrScreen,D0
	CMP	#3,D0
	BEQ	ExitFromDir
	CMP	#1,D0
	BNE	Return1
ShowDirScreen
	BSR	WaitForButtonUp
	MOVE	#3,CurrScreen
	ST	DisableAnalyzer
	ST	NoSampleInfo
	JSR	ClearAnalyzerColors
	BSR	Clear100Lines
	BSR	SwapDirScreen
	BEQ	DisplayMainAll
	BSR	ShowDiskSpace
	BSR	ShowModPackMode
	BSR	ShowPackMode
	BSR	ShowRAWIFFMode
DoAutoDir
	TST.B	AutoDirFlag
	BEQ	SelectPath
	MOVE	DirPathNum,D0 
	BEQ	LoadModuleGadg
	CMP	#1,D0
	BEQ	LoadSongGadg
	CMP	#2,D0
	BEQ	LoadSampleGadg
	BRA	SelectModules
SelectPath
	MOVE	DirPathNum,D0 
	BEQ	SelectModules
	CMP	#1,D0
	BEQ	SelectSongs
	BRA	SelectSamples

SwapDirScreen
	MOVE.L	DecompMemPtr,D0
	BEQ.S	sdirs2
	MOVE.L	D0,A1
	BSR.S	ssets3
	BRA	FreeDecompMem
sdirs2	LEA	DirScreenData,A0
	BSR	Decompact
	BEQ	Return1
ssets3
	LEA	BitPlaneData,A0
	MOVEQ	#1,D2				;2 planes
sxloop1	MOVE	#1000-1,D0
sxloop2	MOVE.L	(A0),D1
	MOVE.L	(A1),(A0)+
	MOVE.L	D1,(A1)+
	DBF	D0,sxloop2
	LEA	(ScreenWidth*156)(A0),A0
	DBF	D2,sxloop1
	MOVEQ	#-1,D0
	RTS

CheckDirGadgets
	MOVEM.W	MouseX2,D0/D1
	CMP	#44,D1
	BHI	CheckDirGadgets2
	CMP	#33,D1
	BLS.S	ExtrasMenu
	CMP	#11,D0
	BLO	DirBrowseGadg
	CMP	#187,D0
	BLO	DirPathGadg
	CMP	#216,D0
	BLO	ParentDirGadg
	CMP	#307,D0
	BLO	ShowFreeDiskGadg
	BRA	CheckDirGadgets2

ExtrasMenu
	CMP	#94,D0
	BHS	ToggleMenu
	CMP	#22,D1
	BHI.S	DeleteFileGadg
	CMP	#11,D1
	BHI.S	RenameFileGadg
	BRA	DiskFormatGadg

RenameFileGadg
	BSR	StorePtrCol
	BSR	WaitForButtonUp
	BSR	ClearFileNames
	MOVE.L	PathPtr,A4
	BSR	ShowDirPath
	LEA	FileNamesPtr(PC),A5
	BSR	HasDiskChanged
	BEQ.S	RenameFileDirOk
	BSR	ClearDirTotal
	BSR	DirDisk
	BNE	RestorePtrCol

RenameFileDirOk
	MOVE	FileNameScrollPos,D0
	BSR	RedrawFileNames
	MOVE	#10,Action
	LEA	SelectFileText,A0
	JSR	ShowStatusText
	BRA	RestorePtrCol

DeleteFileGadg
	MOVE	DirPathNum,D0
	BEQ	DeleteModuleGadg
	CMP	#1,D0
	BEQ	DeleteSongGadg
	CMP	#2,D0
	BEQ	DeleteSampleGadg
	RTS

ToggleMenu
	CMP	#146,D0
	BHS	SelectMenu
	CMP	#22,D1
	BHI	ToggleIFFSave
	CMP	#11,D1
	BHI.S	ToggleSongPack
ToggleModPack
	CLR.B	ModPackMode
	BSR	ShowNotImpl
ShowModPackMode
	LEA	ToggleOFFText(PC),A0
	TST.B	ModPackMode
	BEQ.S	smpmskp
	LEA	ToggleONText2(PC),A0
smpmskp	MOVEQ	#3,D0
	MOVE	#175,D1
	JSR	ShowText3
	BRA	WaitForButtonUp

ShowNotImpl
	LEA	NotImplText(PC),A0
	JSR	ShowStatusText
	BRA	SetErrorPtrCol

NotImplText	dc.b	'Not implemented',0

ToggleSongPack
	EOR.B	#1,PackMode
ShowPackMode
	LEA	ToggleOFFText(PC),A0
	TST.B	PackMode
	BEQ.S	spsskip
	LEA	ToggleONText2(PC),A0
spsskip	MOVEQ	#3,D0
	MOVE	#615,D1
	JSR	ShowText3
	BRA	WaitForButtonUp

ToggleIFFSave
	EOR.B	#1,RAWIFFMode
ShowRAWIFFMode
	LEA	RAWText(PC),A0
	TST.B	RAWIFFMode
	BEQ.S	sraffu
	LEA	IFFText(PC),A0
sraffu	MOVEQ	#3,D0
	MOVE	#1055,D1
	JSR	ShowText3
	BRA	WaitForButtonUp

RAWText	dc.b "RAW",0
IFFText	dc.b "IFF",0

SelectMenu
	CMP	#156,D0
	BHS	LoadMenu
	CMP	#22,D1
	BHI	SelectSamples
	CMP	#11,D1
	BHI	SelectSongs
	BRA	SelectModules

LoadMenu
	CMP	#238,D0
	BHS.S	SaveMenu
	CMP	#22,D1
	BHI	LoadSampleGadg
	CMP	#11,D1
	BHI	LoadSongGadg
	BRA	LoadModuleGadg

SaveMenu
	CMP	#22,D1
	BHI	SaveSampleGadg
	CMP	#11,D1
	BHI	SaveSongGadg
	BRA	SaveModuleGadg

CheckDirGadgets2
	MOVEM	MouseX2,D0/D1
	CMP	#3,CurrScreen
	BNE	Return1
	CMP	#307,D0
	BLO	FileNamePressed
	CMP	#44,D1
	BLS	FileNameOneUp
	CMP	#89,D1
	BLO.S	ExitFromDir
	BRA	FileNameOneDown

ExitFromDir
	BSR	WaitForButtonUp
	CLR.B	RawKeyCode
	BSR	SwapDirScreen
	BSR	Clear100Lines
DisplayMainAll
	BSR	DisplayMainScreen
	JSR	ShowSongLength
	JSR	ShowSampleInfo
	JSR	ShowSongName
	JSR	Show_MS
	TST	LoadInProgress
	BNE.S	dimaskp
	JSR	ShowAllRight
dimaskp	JMP	ShowPosition

DirBrowseGadg
	MOVEQ	#0,D3
	MOVE	DirPathNum,D3
	LEA	dpnum(PC),A0
	ADD.L	D3,A0
	MOVEQ	#0,D0
	MOVE.B	(A0),D0
	ADDQ.B	#1,D0
	CMP.B	#7,D0
	BLO.S	dbgskip
	MOVEQ	#0,D0
dbgskip	MOVE.B	D0,(A0)
	MULU	#5,D0
	MOVE.L	PathPtr,A0
	MOVEQ	#63,D1
	MOVEQ	#0,D2
dbglop1	MOVE.B	D2,(A0)+
	DBF	D1,dbglop1
	LEA	dirpaths(PC),A0
	LEA	-5(A0,D0.W),A0
	TST	D0
	BNE.S	dbgskp2
	LEA	ModulesPath,A0
	TST	D3
	BEQ.S	dbgskp2
	LEA	SongsPath,A0
	CMP	#1,D3
	BEQ.S	dbgskp2
	LEA	SamplePath,A0
dbgskp2	MOVE.L	PathPtr,A1
dbglop2	MOVE.B	(A0)+,(A1)+
	BNE.S	dbglop2
	BSR	ShowDirPath
	MOVE	#3,WaitTime
	BRA	WaitALittle

dirpaths
	dc.b "DF0:",0,"DF1:",0,"SYS:",0,"WORK:",0,"RAM:",0,"ST-00:",0
dpnum	dc.b 0,0,0,0
	even
DirPathNum
	dc.w 3

SelectModules
	MOVEQ	#0,D0
	BRA.S	ChangePath
SelectSongs
	MOVEQ	#1,D0
	BRA.S	ChangePath
SelectSamples
	MOVEQ	#2,D0
ChangePath
	MOVE.L	TextBplPtr,A0
	LEA	178(A0),A0
	MOVEQ	#0,D2
	MOVEQ	#26,D1
chpalop	MOVE	D2,(A0)
	LEA	ScreenWidth(A0),A0
	DBF	D1,chpalop
	LEA	ModulesPath2,A4
	MOVE	#178,D1
	MOVE	D0,DirPathNum
	BEQ.S	chpaski
	LEA	SongsPath2,A4
	MOVE	#618,D1
	CMP	#1,D0
	BEQ.S	chpaski
	LEA	SamplePath2,A4
	MOVE	#1058,D1
chpaski	MOVE.L	TextBplPtr,A0
	LEA	(A0,D1.W),A0
	MOVE	#$0100,(A0)
	MOVE	#$0F80,40(A0)
	MOVE	#$0FC0,80(A0)
	MOVE	#$0F80,120(A0)
	MOVE	#$0100,160(A0)
	MOVE.L	A4,PathPtr
	BSR	ShowDirPath
	BRA	WaitForButtonUp

;---- Song Gadgets ----

LoadSongGadg
	BSR	StorePtrCol
	BSR	WaitForButtonUp
	BSR	ClearFileNames
	BSR	SelectSongs
	LEA	FileNamesPtr(PC),A5
	BSR	HasDiskChanged
	BEQ	LoadSongDirOk
	BSR	ClearDirTotal
	BSR	DirDisk
	BNE	RestorePtrCol
LoadSongDirOk
	MOVE	FileNameScrollPos,D0
	BSR	RedrawFileNames
	MOVE	#1,Action
	LEA	SelectSongText,A0
	JSR	ShowStatusText
	BRA	RestorePtrCol

SaveSongGadg
	BSR	SelectSongs
	LEA	SaveSongText,A0
	BSR	AreYouSure
	BNE	Return1
	BSR	RestorePtrCol
	BSR	ClearFileNames
	BSR	StopIt
	JSR	SaveSong
	MOVE	#1,Action
	RTS
 
DeleteSongGadg
	BSR	WaitForButtonUp
	BSR	ClearFileNames
	BSR	SelectSongs
	LEA	FileNamesPtr(PC),A5
	BSR	HasDiskChanged
	BEQ.S	DeleteSongDirOk
	BSR	ClearDirTotal
	BSR	DirDisk
	BEQ.S	DeleteSongDirOk
	BRA	RestorePtrCol

DeleteSongDirOk
	MOVE	FileNameScrollPos,D0
	BSR	RedrawFileNames
	MOVE	#2,Action
	LEA	SelectSongText,A0
	JSR	ShowStatusText
	BRA	SetDeletePtrCol

;---- Module Gadgets ----

LoadModuleGadg
	BSR	StorePtrCol
	BSR	WaitForButtonUp
	BSR	ClearFileNames
	BSR	SelectModules
	LEA	FileNamesPtr(PC),A5
	BSR	HasDiskChanged
	BEQ.S	LoadModDirOk
	BSR	ClearDirTotal
	BSR	DirDisk
	BEQ.S	LoadModDirOk
	BRA	RestorePtrCol

LoadModDirOk
	MOVE	FileNameScrollPos,D0
	BSR	RedrawFileNames
	MOVE	#3,Action
	LEA	SelectModuleText,A0
	JSR	ShowStatusText
	BRA	RestorePtrCol

SaveModuleGadg
	BSR	SelectModules
	LEA	SaveModuleText,A0
	BSR	AreYouSure
	BNE	Return1
	JSR	SaveModule
	MOVE	#3,Action
	JMP	ShowAllRight

DeleteModuleGadg
	BSR	WaitForButtonUp
	BSR	ClearFileNames
	BSR	SelectModules
	LEA	FileNamesPtr(PC),A5
	BSR	HasDiskChanged
	BEQ.S	DeleteModDirOk
	BSR	ClearDirTotal
	BSR	DirDisk
	BEQ.S	DeleteModDirOk
	BRA	RestorePtrCol

DeleteModDirOk
	MOVE	FileNameScrollPos(PC),D0
	BSR	RedrawFileNames
	MOVE	#4,Action
	LEA	SelectModuleText,A0
	JSR	ShowStatusText
	BRA	SetDeletePtrCol

;---- Sample Gadgets ----

LoadSampleGadg
	BSR	StorePtrCol
	BSR	WaitForButtonUp
	BSR	ClearFileNames
	BSR	SelectSamples
	LEA	FileNamesPtr(PC),A5
	BSR	HasDiskChanged
	BEQ.S	LoadSampleDirOk
	BSR	ClearDirTotal
	BSR	DirDisk
	BEQ.S	LoadSampleDirOk
	BRA	RestorePtrCol

LoadSampleDirOk
	MOVE	FileNameScrollPos,D0
	BSR	RedrawFileNames
	MOVE	#5,Action
	LEA	SelectSampleText,A0
	JSR	ShowStatusText
	BRA	RestorePtrCol

SaveSampleGadg
	BSR	SelectSamples
	CLR.B	RawKeyCode
	MOVE	InsNum,D0
	BEQ	NotSampleNull
	LEA	SaveSampleText,A0
	BSR	AreYouSure
	BNE	Return1
dosavesample
	BSR	StorePtrCol
	BSR	CreateSampleName
	MOVE.L	DiskDataLength,D1
	BEQ	Return1
	MOVEQ	#0,D1
	MOVE	InsNum,D1
	LSL.L	#2,D1
	LEA	SamplePtrs,A0
	MOVE.L	0(A0,D1.W),DiskDataPtr

	BSR	SetDiskPtrCol
	MOVE.L	DOSBase,A6
	MOVE.L	FileNamePtr,D1
	MOVE.L	#1006,D2
	JSR	LVOOpen(A6)
	MOVE.L	D0,FileHandle
	BNE	SaveSample
	JSR	CantOpenFile
	BRA	ErrorRestoreCol

SaveSample
	LEA	SavingSampleText,A0
	JSR	ShowStatusText
	TST.B	RAWIFFMode
	BEQ	savesam
	MOVE.L	FileHandle,D1
	MOVE.L	#IFFFORM,D2
	MOVEQ	#IFFEND-IFFFORM,D3
	JSR	LVOWrite(A6)
savesam	MOVE.L	FileHandle,D1
	MOVE.L	DiskDataPtr,D2
	MOVE.L	DiskDataLength,D3
	JSR	LVOWrite(A6)

	MOVE.L	FileHandle,D1
	JSR	LVOClose(A6)
	CLR.L	FileHandle
	MOVE	#5,Action
	JSR	ShowAllRight
	BRA	RestorePtrCol

IFFFORM	dc.b	"FORM"
	dc.l	0
	dc.b	"8SVX"
IFFVHDR	dc.b	"VHDR"
	dc.l	20
	dc.l	0,0,32	; oneshot, repeat, hisamples
	dc.w	16726	; This is really NTSC (16574 for PAL!!!)
	dc.b	1,0	; octaves, compression
	dc.l	$10000	; volume
IFFNAME	dc.b	"NAME"
	dc.l	24
	dcb.b	24,0
	dc.b	"ANNO"
	dc.l	16
	dc.b	"Protracker 1.2e",0
IFFBODY	dc.b	"BODY"
	dc.l	0
IFFEND


;---- Delete Sample ----

DeleteSampleGadg
	BSR	StorePtrCol
	BSR	WaitForButtonUp
	BSR	ClearFileNames
	BSR	SelectSamples
	LEA	FileNamesPtr(PC),A5
	BSR	HasDiskChanged
	BEQ.S	DeleteSamDirOk
	BSR	ClearDirTotal
	BSR	DirDisk
	BEQ.S	DeleteSamDirOk
	BRA	RestorePtrCol

DeleteSamDirOk
	MOVE	FileNameScrollPos(PC),D0
	BSR	RedrawFileNames
	MOVE	#6,Action
	LEA	SelectSampleText,A0
	JSR	ShowStatusText
	BRA	SetDeletePtrCol

;---- Directory Path Gadget ----

DirPathGadg
	BSR	StorePtrCol
	BSR	SetWaitPtrCol
	MOVE.L	PathPtr,A6
	MOVE.L	A6,ShowTextPtr
	MOVE.L	A6,TextEndPtr
	ADD.L	#63,TextEndPtr
	MOVE	#19,TextLength
	MOVE	#1484,A4
	BSR	GetTextLine
	BRA	RestorePtrCol


CopyPath
	LEA	FileName,A1
	TST.B	(A0)		; If no path
	BEQ	Return1
cploop	MOVE.B	(A0)+,(A1)+	; Copy path to filename
	BNE.S	cploop
	CMP.B	#':',-2(A1)	; If ending with ':' it's ok
	BEQ.S	PathCharBack
	CMP.B	#'/',-2(A1)	; If ending with '/' it's ok
	BEQ.S	PathCharBack
	MOVE.B	#'/',-1(A1)	; Add '/' to end path
	RTS

PathCharBack
	SUBQ.L	#1,A1
	RTS

ShowDirPath
	CMP	#3,CurrScreen
	BNE	Return1
	MOVEM.L	D0-D7/A0-A6,-(SP)
	MOVE.L	PathPtr,A0
	MOVEQ	#19,D0
	MOVE	#1484,D1
	JSR	ShowText3
	MOVEM.L	(SP)+,D0-D7/A0-A6
	RTS

;---- File List Gadgets ----

FileNameOneUp
	TST	Action
	BEQ	Return1
	LEA	FileNamesPtr(PC),A5
	MOVE	FileNameScrollPos(PC),D0
	BEQ	Return1
	SUBQ	#1,D0
	BTST	#2,$DFF016
	BNE	RedrawFileNames
	SUBQ	#3,D0
	BPL	RedrawFileNames
	MOVEQ	#0,D0
	BRA	RedrawFileNames

FileNameOneDown
	TST	Action
	BEQ	Return1
	LEA	FileNamesPtr(PC),A5
	MOVE	FileNameScrollPos(PC),D0
	ADDQ	#1,D0
	BTST	#2,$DFF016
	BNE.S	fnod2
	ADDQ	#3,D0
fnod2	MOVE	16(A5),D1
	SUBQ	#8,D1
	BMI	Return1
	CMP	D1,D0
	BLS	RedrawFileNames
	MOVE	D1,D0
	BRA	RedrawFileNames

;---- Clicked on a filename ----

FileNamePressed
	SUB	#44,D1
	MOVE	#1,UpdateFreeMem
	TST	Action
	BEQ	Return1
	CMP	#3,D1
	BLO	Return1
	CMP	#50,D1
	BHI	Return1
	SUBQ	#3,D1
	AND.L	#$FFFF,D1
	DIVU	#6,D1
	MOVE	D1,FileNameScrollPos+2
	LEA	FileNamesPtr(PC),A5
	MOVE	FileNameScrollPos(PC),D0
	ADD	D1,D0
	CMP	16(A5),D0
	BHS	Return1
	MULU	#36,D0
	ADD.L	(A5),D0
	MOVE.L	D0,A0
	TST.L	32(A0)
	BMI.S	AddDirectory
	MOVEQ	#DirNameLength-1,D0
	LEA	DirInputName,A1
fnploop	MOVE.B	(A0)+,(A1)+
	DBF	D0,fnploop
	MOVE	Action,D6
	CMP	#1,D6
	BEQ	LoadSong
	CMP	#2,D6
	BEQ	DeleteSong
	CMP	#3,D6
	BEQ	xLoadModule
	CMP	#4,D6
	BEQ	DeleteModule
	CMP	#5,D6
	BEQ	LoadSample
	CMP	#6,D6
	BEQ	DeleteSample
	CMP	#10,D6
	BEQ	RenameFile
	RTS

xLoadModule	JMP	LoadModule

AddDirectory
	MOVE.L	A0,-(SP)
	MOVE.L	PathPtr,A0
	BSR	CopyPath
	MOVE.L	(SP)+,A0
	MOVEQ	#DirNameLength-1,D0
addplop	MOVE.B	(A0)+,(A1)+
	DBF	D0,addplop
	LEA	FileName,A0
	MOVE.L	PathPtr,A1
	MOVEQ	#62,D0
addplp2	MOVE.B	(A0)+,(A1)+
	DBF	D0,addplp2
addpdir	BSR	ShowDirPath
	MOVE	Action,D6
	CMP	#1,D6
	BEQ	LoadSongGadg
	CMP	#2,D6
	BEQ	DeleteSongGadg
	CMP	#3,D6
	BEQ	LoadModuleGadg
	CMP	#4,D6
	BEQ	DeleteModuleGadg
	CMP	#5,D6
	BEQ	LoadSampleGadg
	CMP	#6,D6
	BEQ	DeleteSampleGadg
	CMP	#10,D6
	BEQ	RenameFileGadg
	RTS

ParentDirGadg
	BSR	WaitForButtonUp
	MOVE.L	PathPtr,A0
	MOVE.L	A0,A1
pdgloop	TST.B	(A1)+
	BNE.S	pdgloop
	SUBQ.L	#1,A1
	CMP.L	A0,A1
	BLS	Return1
	SUBQ.L	#1,A1
	CMP.B	#'/',(A1)
	BNE.S	pdgskp1
	CLR.B	(A1)
pdgskp1	CMP.B	#':',(A1)
	BEQ.S	addpdir
	CMP.B	#'/',(A1)
	BEQ	pdgslsh
	CLR.B	(A1)
	CMP.L	A0,A1
	BLS.S	addpdir
	SUBQ.L	#1,A1
	BRA.S	pdgskp1

pdgslsh	CLR.B	(A1)
	BRA	addpdir

FileNamesPtr
	dc.l	0  ; A5+ 0
	dc.l	0  ;   + 4
	dc.l	0  ;   + 8
	dc.l	0  ;   +12
	dc.w	0  ;   +16
	dc.w	24 ;   +18
FileNameScrollPos
	dc.w	0
	dc.w	0

;---- Has Disk Changed ----

HasDiskChanged
	MOVE.L	DOSBase,A6
	MOVE.L	A4,D1
	MOVEQ	#-2,D2
	JSR	LVOLock(A6)
	MOVE.L	D0,FileLock
	BEQ.S	ExamineError
	MOVE.L	FileLock,D1
	MOVE.L	#FileInfoBlock,D2
	JSR	LVOExamine(A6)
	TST.L	D0
	BEQ.S	ExamineError
	LEA	FileInfoBlock,A0
	MOVE.L	ofib_DateStamp+ds_Days(A0),D0
	CMP.L	4(A5),D0
	BNE.S	DiskChanged
	MOVE.L	ofib_DateStamp+ds_Minute(A0),D0
	CMP.L	8(A5),D0
	BNE.S	DiskChanged
	MOVE.L	ofib_DateStamp+ds_Tick(A0),D0
	CMP.L	12(A5),D0
	BNE.S	DiskChanged
	MOVE.L	FileLock,D1
	JSR	LVOUnLock(A6)
	MOVEQ	#0,D0
	RTS
 
DiskChanged
	MOVE.L	ofib_DateStamp+ds_Days(A0),4(A5)
	MOVE.L	ofib_DateStamp+ds_Minute(A0),8(A5)
	MOVE.L	ofib_DateStamp+ds_Tick(A0),12(A5)
	MOVE.L	FileLock,D1
	JSR	LVOUnLock(A6)
	MOVEQ	#-1,D0
	RTS

ExamineError
	CLR.L	4(A5)
	MOVEQ	#-1,D0
	RTS

ShowFreeDiskGadg
	BSR	WaitForButtonUp
	BSR.S	LockAndGetInfo
	BSR	DirDiskUnlock
	JMP	ShowAllRight

LockAndGetInfo
	BSR	StorePtrCol
	BSR	SetDiskPtrCol
	CLR	FileNameScrollPos
	MOVE.L	DOSBase,A6
	MOVE.L	A4,D1	; Dir-path in A4
	MOVEQ	#-2,D2
	JSR	LVOLock(A6)
	MOVE.L	D0,FileLock
	BEQ	DirDiskError
	LEA	ReadingDirText,A0
	JSR	ShowStatusText
	MOVE.L	FileLock,D1
	MOVE.L	#InfoData,D2
	JSR	LVOInfo(A6)
	LEA	InfoData,A0
	MOVE.L	12(A0),D0 ; id_NumBlocks
	SUB.L	16(A0),D0 ; id_NumBlocksUsed
	MULU	22(A0),D0 ; id_BytesPerBlock + 2
	MOVE.L	D0,FreeDiskSpace
ShowDiskSpace
	MOVE	#1510,TextOffset
	MOVE.L	FreeDiskSpace,D7
	TST.B	ShowDecFlag
	BNE.S	sdsdec
	SWAP	D7
	MOVE	D7,WordNumber
	JSR	PrintHexWord
	SWAP	D7
	MOVE	D7,WordNumber
	JSR	PrintHexWord
	MOVEQ	#0,D0
	RTS

sdsdec	SUB	#2,TextOffset
	DIVU	#10000,D7
	MOVE	D7,WordNumber
	MOVEQ	#0,D0
	MOVE	D7,D0
	JSR	Print6DecDigits		;4
	SWAP	D7
	MOVE	D7,WordNumber
	JSR	Print4DecDigits
	MOVEQ	#0,D0
	RTS



;---- Get Disk Directory ----
AllocDirMem
	ADD	#50,DirEntries
	MOVE	DirEntries,D0
	MULU	#36,D0
	MOVE.L	DirAllocSize(PC),D6
	MOVE.L	D0,DirAllocSize
	MOVE.L	#MEMF_CLEAR,D1
	MOVE.L	4.W,A6
	JSR	LVOAllocMem(A6)
	MOVE.L	D0,D7
	BEQ.S	baehsj

	MOVE.L	FileNamesPtr(PC),D1
	MOVE.L	D7,FileNamesPtr
	TST.L	D1
	BEQ	Return1
	TST.L	D6
	BEQ	Return1
	MOVE.L	D1,A0
	MOVE.L	D7,A1
	MOVE.L	D6,D0
admloop	MOVE.B	(A0)+,(A1)+
	SUBQ.L	#1,D6
	BNE.S	admloop
	MOVE.L	D1,A1
	MOVE.L	4.W,A6
	JSR	LVOFreeMem(A6)
	RTS

FreeDirMem
	MOVE.L	FileNamesPtr(PC),D1
	BEQ	Return1
	MOVE.L	D1,A1
	MOVE.L	DirAllocSize(PC),D0
	MOVE.L	4.W,A6
	JSR	LVOFreeMem(A6)
	CLR.L	FileNamesPtr
	CLR	DirAllocSize
	CLR	DirEntries
	RTS

baehsj	JSR	OutOfMemErr
	MOVEQ	#-1,D0
	RTS

DirAllocSize	dc.l	0
DirEntries	dc.w	0

DirDisk	BSR	FreeDirMem
	BSR	AllocDirMem
	BSR	LockAndGetInfo
	BNE	Return1
	MOVE.L	FileLock,D1
	MOVE.L	#FileInfoBlock,D2
	JSR	LVOExamine(A6)
	TST.L	D0
	BEQ	DirDiskError
ddloop1	MOVE.L	FileLock,D1
	MOVE.L	#FileInfoBlock,D2
	MOVE.L	DOSBase,A6
	JSR	LVOExNext(A6)
	TST.L	D0
	BEQ	DirDiskUnlock
	BTST	#2,$DFF016
	BEQ.S	AbortDir
	BSR	NewDirEntry
	BRA.S	ddloop1

AbortDir
	CLR.L	4(A5)
	LEA	DirAbortedText(PC),A0
	JSR	ShowStatusText
	BSR.S	DirDiskUnlock
	BSR	WaitALittle
	JSR	ShowAllRight
	MOVEQ	#0,D0
	RTS

DirDiskUnlock
	MOVE.L	FileLock,D1
	JSR	LVOUnLock(A6)
	BSR	RestorePtrCol
	MOVEQ	#0,D0
	RTS

DirAbortedText	dc.b 'dir aborted !',0

DirDiskError
	TST.L	FileLock
	BEQ.S	ddeskip
	MOVE.L	FileLock,D1
	JSR	LVOUnLock(A6)
ddeskip	BSR	RestorePtrCol
	LEA	CantFindDirText,A0
	JSR	ShowStatusText
	BSR	SetErrorPtrCol
	MOVEQ	#-1,D0
	RTS

ClearDirTotal
	CLR	16(A5)
	RTS

CantFindDirText	dc.b "can't find dir !",0,0

 
NewDirEntry
	LEA	FIB_FileName,A0
	TST.B	ShowDirsFlag
	BNE.S	ndeok1
	TST.L	FIB_EntryType
	BPL	Return1
ndeok1	TST.L	FIB_EntryType
	BPL	ndeok2
	TST.B	ModOnlyFlag
	BEQ.S	ndeok2
	TST	DirPathNum
	BNE.S	ndeok2
	MOVE.L	(A0),D0
	AND.L	#$CFCFCFCF,D0
	CMP.L	#$4D4F440E,D0		; MOD.
	BNE	Return1
ndeok2	MOVE	16(A5),D0
	CMP	DirEntries,D0
	BLO.S	ndeok3
	MOVE.L	A0,-(SP)
	BSR	AllocDirMem
	MOVE.L	(SP)+,A0
ndeok3	MOVE	16(A5),D6
	BEQ.S	ndeadd1		; If first entry
	SUBQ	#1,D6
	MOVE.L	(A5),A1
ndeloopname
	MOVEQ	#0,D2
	MOVE.L	FIB_EntryType,D0
	MOVE.L	32(A1),D1
	TST.L	D0
	BPL.S	ndesfil	; if directory, all is well
	TST.L	D1
	BMI.S	ndenext	; was file, so skip if directory
	BRA.S	ndelopc
ndesfil	TST.L	D1	; if file
	BPL.S	ndeinse
ndelopc	MOVE.B	(A0,D2.W),D0 ; Get a character
	BEQ.S	ndeinse
	CMP.B	#96,D0  ; Lowercase?
	BLO.S	ndeskp1
	SUB.B	#32,D0	; Switch to upper
ndeskp1	MOVE.B	(A1,D2.W),D1
	BEQ.S	ndenext
	CMP.B	#96,D1
	BLO.S	ndeskp2
	SUB.B	#32,D1
ndeskp2	CMP.B	D0,D1
	BHI.S	ndeinse
	BNE.S	ndenext
	ADDQ	#1,D2
	BRA.S	ndelopc
ndenext	LEA	36(A1),A1	; next entry
	DBF	D6,ndeloopname	; loop entries
	MOVE.L	(A5),A1
	MOVE	16(A5),D0
	MULU	#36,D0
	ADD	D0,A1
	BRA.S	ndeadd2

ndeinse	MOVE.L	(A5),A2
	MOVE	16(A5),D0
	MULU	#36,D0
	ADD	D0,A2
	MOVE.L	A2,A3
	LEA	36(A3),A3
nde3loop
	MOVE	-(A2),-(A3)
	CMP.L	A2,A1
	BNE.S	nde3loop
	BRA.S	ndeadd2
 
ndeadd1	MOVE.L	(A5),A1            ; Put new filename into list
ndeadd2	LEA	FIB_FileName,A0
	MOVE.L	A1,A3
	MOVEQ	#35,D0             ; Clear old filename
nde4loop
	CLR.B	(A3)+
	DBF	D0,nde4loop
	MOVE	FIB_DateStamp+ds_Days+2,30(A1)
	MOVEQ	#-1,D0
	TST.L	FIB_EntryType
	BPL	ndefskp
	MOVE.L	FIB_FileSize,D0
ndefskp	MOVE.L	D0,32(A1)
	MOVEQ	#29,D0             ; Copy new filename
nde4loop2
	MOVE.B	(A0)+,D1
	MOVE.B	D1,(A1)+
	TST.B	D1
	BEQ.S	nde4skip
	DBF	D0,nde4loop2
nde4skip
	ADDQ	#1,16(A5)	; Files + 1
	RTS
 
RedrawFileNames
	MOVE	D0,-(SP)
	BSR	ShowDirPath
	MOVE	(SP)+,D0
	MOVE	D0,FileNameScrollPos
	TST	16(A5)
	BEQ	Return1
	MOVE.L	#1881,A6
	MOVE	A6,TextOffset
	MOVE.L	(A5),D6
	MULU	#36,D0
	ADD.L	D0,D6
	MOVE	16(A5),D0
	SUB	FileNameScrollPos,D0
	CMP	#8,D0
	BHS.S	ShowFileNames
	SUBQ	#1,D0
	MOVE	D0,D7
	BRA.S	sfnloop
 
ShowFileNames
	MOVE	#$91,D0
	BSR	WaitForVBlank
	MOVEQ	#7,D7
sfnloop	MOVE	A6,TextOffset
	MOVE.L	D6,A0
	MOVEQ	#0,D0
	MOVE	30(A0),D0
	BSR	CalculateDate
	MOVE	TheDay(PC),WordNumber
	JSR	Print2DecDigits
	MOVE	TheMonth(PC),WordNumber
	JSR	Print2DecDigits
	MOVE	TheYear(PC),WordNumber
	JSR	Print2DecDigits
	ADDQ	#1,TextOffset
	MOVE.L	D6,ShowTextPtr
	MOVE	#24,TextLength
	TST	DirPathNum
	BNE.S	sfnskip
	TST.B	ModOnlyFlag
	BEQ.S	sfnskip
	MOVE.L	D6,A0
	CMP.L	#"mod.",(A0)
	BNE.S	sfnskip
	ADDQ.L	#4,ShowTextPtr
sfnskip	JSR	SpaceShowText
	LEA	32(A6),A6
	MOVE	A6,TextOffset
	MOVE.L	D6,A0
	MOVE.L	32(A0),D1
	BMI.S	sfndir
	TST.B	ShowDecFlag
	BNE.S	sfndec
	SWAP	D1
	AND	#$000F,D1
	BSR	ShowOneDigit
	MOVE.L	D6,A0
	MOVE	34(A0),WordNumber
	JSR	PrintHexWord
sfnend	ADD.L	#36,D6
	LEA	208(A6),A6
	DBF	D7,sfnloop
	RTS

sfndec	MOVE.L	D1,D0
	SUBQ	#1,TextOffset
	JSR	Print6DecDigits
	BRA.S	sfnend

sfndir	MOVE.L	#DirText,ShowTextPtr
	SUBQ	#1,TextOffset
	MOVE	#6,TextLength
	JSR	ShowText
	BRA.S	sfnend

ClrFileText	dc.b "    "

CalculateDate
	DIVU	#1461,D0
	LSL	#2,D0
	MOVE	D0,TheYear
	CLR	D0
	SWAP	D0
	CMP	#789,D0
	BEQ.S	cadleap
	BLO.S	cadskp2
	SUBQ	#1,D0
cadskp2	DIVU	#365,D0
	MOVE.L	D0,D1
	SWAP	D1
	CMP	#4,D0
	BLO.S	cadskip
	SUBQ	#1,D0
cadskip	ADD	D0,TheYear
	LEA	MonthTable(PC),A1
	MOVEQ	#24,D0
cadloop	SUBQ	#2,D0
	MOVE	(A1,D0.W),D2
	CMP	D2,D1
	BHS.S	cadskp3
	TST	D0
	BNE.S	cadloop
cadskp3	LSR	#1,D0
	ADDQ	#1,D0
	MOVE	D0,TheMonth
	SUB	D2,D1
	ADDQ	#1,D1
	MOVE	D1,TheDay
cadend	MOVEQ	#0,D0
	MOVE	TheYear(PC),D0
	ADD	#78,D0
	DIVU	#100,D0
	SWAP	D0
	MOVE	D0,TheYear
	RTS
cadleap	ADD	#2,TheYear
	MOVE	#2,TheMonth
	MOVE	#29,TheDay
	BRA	cadend

TheYear		dc.w 0
TheMonth	dc.w 0
TheDay		dc.w 0
MonthTable	dc.w 0,31,59,90,120,151,181,212,243,273,304,334
DirText		dc.b " (DIR)"


;--------------------------- Play Song --------------------------------
PlaySong
	MOVEQ	#0,D0
SongFrom
	BSR	StopIt
	BTST	#2,$DFF016
	BNE.S	sofr1
	MOVE	PlayFromPos,D0
sofr1	MOVE	D0,ScrPattPos
	LSL	#4,D0
	AND.L	#$FFFF,D0
	MOVE.L	D0,PatternPosition
wfbu1	BTST	#6,$BFE001
	BEQ.S	wfbu1
	CLR.B	RawKeyCode
	CLR.B	SaveKey
	BSR	SetPlayPtrCol
	CLR	PatternTicks
	CLR.L	TimerTicks
	MOVE.L	#'patp',RunMode
	CLR	DidQuantize
	MOVE.L	#-1,LongFFFF
	BSR	SetScrPatternPos
SetPlayPosition
	MOVE.L	CurrPos,D0
	MOVE.L	SongDataPtr,A0
	CMP.B	sd_numofpatt(A0),D0
	BHS	SongPosToZero
	MOVE.L	CurrPos,SongPosition
	RTS

ContPlaySong
	LEA	ContPlayText(pc),A0
	JSR	ShowStatusText
	BSR	StopIt
	MOVE	ScrPattPos,D0
	LSL	#4,D0
	AND.L	#$FFFF,D0
	MOVE.L	D0,PatternPosition
	BRA	wfbu1

ContPlayPatt
	LEA	ContPattText(pc),A0
	JSR	ShowStatusText
	BSR	StopIt
	MOVE	ScrPattPos,D0
	LSL	#4,D0
	AND.L	#$FFFF,D0
	MOVE.L	D0,PatternPosition
	BRA	wfbu2

ContRecPatt
	LEA	ContRecText(pc),A0
	JSR	ShowStatusText
	TST	SamScrEnable
	BNE	Return1
	BSR	StopIt
	MOVE	ScrPattPos,D0
	LSL	#4,D0
	AND.L	#$FFF,D0
	MOVE.L	D0,PatternPosition
	BRA	wfbu3

SongPosToZero
	CLR.L	SongPosition
	CLR.L	CurrPos
	RTS

;----------------------- Play Pattern ---------------------
PlayPattern
	MOVEQ	#0,D0
PattFrom
	BSR	StopIt
	BTST	#2,$DFF016
	BNE.S	pafr1
	MOVE	PlayFromPos,D0
pafr1	MOVE	D0,ScrPattPos
	LSL	#4,D0
	AND.L	#$FFF,D0
	MOVE.L	D0,PatternPosition
wfbu2	BTST	#6,$BFE001
	BEQ.S	wfbu2
	CLR.B	RawKeyCode
	CLR.B	SaveKey
	MOVE.L	#'patt',RunMode
	BSR	SetPlayPtrCol
ResetPosition
	MOVE.L	PatternNumber,SongPosition
	RTS

;------------------- Record Pattern/Song --------------------
RecordPattern
	MOVEQ	#0,D0
RecordFrom
	TST	SamScrEnable
	BNE	Return1
	BSR	StopIt
	BTST	#2,$DFF016
	BNE.S	refr1
	MOVE	PlayFromPos,D0
refr1	MOVE	D0,ScrPattPos
	LSL	#4,D0
	AND.L	#$FFF,D0
	MOVE.L	D0,PatternPosition
wfbu3	BTST	#6,$BFE001
	BEQ.S	wfbu3
	BSR	SetEditPtrCol
	CLR.B	RawKeyCode
	CLR.B	SaveKey
	BSR	SaveUndo
	MOVE.L	#'edit',EditMode
	MOVE.L	#'patt',RunMode
	TST.B	RecordMode
	BEQ.S	ResetPosition
	MOVE.L	#'patp',RunMode
	BRA	SetPlayPosition



;------------------- Show Main Screen --------------------
DisplayMainScreen
	CLR	BlockMarkFlag
	MOVE	#1,CurrScreen
	SF	NoSampleInfo
	TST	LoadInProgress
	BNE.S	dmsskp3
	BSR	SetNormalPtrCol
	TST	RunMode
	BEQ.S	dmsskip
	BSR	SetPlayPtrCol
dmsskip	TST.L	EditMode
	BEQ.S	dmsskp2
	BSR	SetEditPtrCol
dmsskp2	BSR	StorePtrCol
dmsskp3	ST	DisableAnalyzer
	BSR	ClearAnaHeights
	BSR	ClearRightArea

	LEA	BitPlaneData+TopMenusPos,A0
	LEA	TopMenusBuffer,A1
	MOVEQ	#44-1,D0
cgloop4	MOVEQ	#25-1,D1
cgloop5	MOVE.B	(A1)+,(A0)+
	MOVE.B	1099(A1),PlaneSize-1(A0)
	DBF	D1,cgloop5
	LEA	15(A0),A0
	DBF	D0,cgloop4

	BSR	RedrawToggles
	TST.B	EdEnable
	BNE	EditOp
	MOVEQ	#0,D4
RedrawAnaScope
	MOVE	#145,D0
	BSR	WaitForVBlank
	SF	ScopeEnable
	ST	DisableAnalyzer
	BSR	ClearRightArea
	LEA	SpectrumAnaData,A0
	TST.B	AnaScopFlag
	BEQ.S	cgjojo
	LEA	ScopeData,A0

cgjojo	BSR	Decompact
	BEQ	cgjaja

	LEA	BitPlaneData+SpectrumAnaPos,A0
	MOVEQ	#1,D7
cgloop1	MOVEQ	#55-1,D6	; 55 lines in picture.
cgloop2	MOVEQ	#25-1,D5	; 25 bytes(x8)
cgloop3	MOVE.B	(A1)+,(A0)+
	DBF	D5,cgloop3
	ADDQ.L	#1,A1
	LEA	15(A0),A0
	DBF	D6,cgloop2
	LEA	$1F68(A0),A0
	DBF	D7,cgloop1

	BSR	FreeDecompMem
cgjaja					;TST.L	D4	;fuks up with this
					;BNE	Return1
	TST.B	AnaScopFlag
	BNE	cgscope
	BSR	ClearAnaHeights
	BSR	ClearRightArea
	SF	DisableAnalyzer
	BRA	SetAnalyzerColors
cgscope	ST	ScopeEnable
	BSR	ClearAnalyzerColors
	BSR	RedrawPitchCtrl
	RTS




;---- Clear Areas ----
ClearFileNames
	MOVE	#145,D0
	BSR	WaitForVBlank
	MOVE.L	TextBplPtr,A1
	LEA	1800(A1),A1
	MOVE	#550-1,D0
	MOVEQ	#0,D1
cfnloop	MOVE.L	D1,(A1)+
	DBF	D0,cfnloop
	RTS

ClearRightArea
	MOVE.L	TextBplPtr,A0
	LEA	ScreenWidth+15(A0),A0
	MOVEQ	#0,D2
	MOVEQ	#99-1,D0
cnblloop1	MOVEQ	#25-1,D1
cnblloop2	MOVE.B	D2,(A0)+
		DBF	D1,cnblloop2
	LEA	15(A0),A0
	DBF	D0,cnblloop1
	RTS

Clear100Lines
	MOVE.L	TextBplPtr,A0
	MOVE	#(ScreenWidth*25)-1,D0
	MOVEQ	#0,D1
chlloop	MOVE.L	D1,(A0)+
	DBF	D0,chlloop
	RTS

;---- Are You Sure Requester ----

AreYouSure
	MOVE.B	DisableAnalyzer,SaveDA
	MOVE.B	ScopeEnable,SaveScope
	SF	ScopeEnable
	JSR	ShowStatusText
	BSR	StorePtrCol
	BSR	SetWaitPtrCol
	JSR	Wait_4000
	CMP	#1,CurrScreen
	BNE.S	aysskip
	TST.B	DisableAnalyzer
	BNE.S	aysskip
	ST 	DisableAnalyzer
	BSR	ClearAnaHeights
	BSR	ClearRightArea
aysskip	LEA	SureBoxData,A1
	BSR	SwapBoxMem
	BSR	WaitForButtonUp
	JSR	Wait_4000
	CLR.B	RawKeyCode
surebuttoncheck
	BTST	#2,$DFF016
	BEQ.S	SureAnswerNo
	BSR	DoKeyBuffer
	MOVE.B	RawKeyCode,D0
	CMP.B	#21,D0		; Pressed Y
	BEQ	SureAnswerYes
	CMP.B	#68,D0		; Pressed Return
	BEQ	SureAnswerYes
	CMP.B	#54,D0		; Pressed N
	BEQ.S	SureAnswerNo
	CMP.B	#69,D0		; Pressed Esc
	BEQ.S	SureAnswerNo
	BTST	#6,$BFE001	; Left Mousebutton
	BNE.S	surebuttoncheck
	MOVEM.W	MouseX,D0/D1
	CMP	#$AB,D0
	BLO.S	surebuttoncheck
	CMP	#$FC,D0
	BHI.S	surebuttoncheck
	CMP	#$48,D1
	BLO.S	surebuttoncheck
	CMP	#$52,D1
	BHI.S	surebuttoncheck
	CMP	#$C5,D0
	BLO.S	SureAnswerYes
	CMP	#$EA,D0
	BLO.S	surebuttoncheck
SureAnswerNo
	LEA	SureBoxData,A1
	BSR	SwapBoxMem
	JSR	ShowAllRight
	BSR	ClearAnaHeights
	MOVE.B	SaveDA,DisableAnalyzer
	MOVE.B	SaveScope,ScopeEnable
	BSR	ErrorRestoreCol
	BSR	WaitForButtonUp
	JSR	Wait_4000
	CLR.B	RawKeyCode
	MOVEQ	#-1,D0
	RTS

SureAnswerYes
	LEA	SureBoxData,A1
	BSR	SwapBoxMem
	JSR	ShowAllRight
	BSR	ClearAnaHeights
	MOVE.B	SaveDA,DisableAnalyzer
	MOVE.B	SaveScope,ScopeEnable
	BSR	RestorePtrCol
	BSR	WaitForButtonUp
	JSR	Wait_4000
	CLR.B	RawKeyCode
	MOVEQ	#0,D0
	RTS

SwapBoxMem
	LEA	BitPlaneData+SureBoxPos,A0
	MOVEQ	#38,D0
ssbmloop1
	MOVEQ	#12,D1
ssbmloop2
	MOVE.B	PlaneSize(A0),D2
	MOVE.B	546(A1),PlaneSize(A0)
	MOVE.B	D2,546(A1)
	MOVE.B	(A0),D2
	MOVE.B	(A1),(A0)+
	MOVE.B	D2,(A1)+
	DBF	D1,ssbmloop2
	LEA	27(A0),A0
	ADDQ.L	#1,A1
	DBF	D0,ssbmloop1
	MOVE.L	TextBplPtr,A0	; Swap text...
	LEA	SureBoxPos(A0),A0
	LEA	TextDataBuffer,A1
	MOVEQ	#38,D0
ssbmloop3
	MOVEQ	#12,D1
ssbmloop4
	MOVE.B	(A0),D2
	MOVE.B	(A1),(A0)+
	MOVE.B	D2,(A1)+
	DBF	D1,ssbmloop4
	LEA	27(A0),A0
	ADDQ.L	#1,A1
	DBF	D0,ssbmloop3
	RTS
 
WaitForButtonUp
	BTST	#6,$BFE001	; Check Left Mousebutton
	BEQ.S	WaitForButtonUp
	BTST	#2,$DFF016	; Check Right Mousebutton
	BEQ.S	WaitForButtonUp
	MOVE	#$91,D0
WaitForVBlank
	MOVE.L	$DFF004,D1
	LSR.L	#8,D1
	AND	#$1FF,D1
	CMP	D1,D0
	BNE.S	WaitForVBlank
	RTS



;---- Set Pointercolors ----

SetDeletePtrCol
	MOVE.L	A6,-(SP)
	MOVE.L	CopListColorPtr,A6
	MOVE	#$077,2(A6)
	MOVE	#$044,6(A6)
	MOVE	#$0DD,10(A6)
	MOVE.L	(SP)+,A6
	RTS
 
SetNormalPtrCol
	MOVE.L	A6,-(SP)
	MOVE.L	CopListColorPtr,A6
	MOVE	#$777,2(A6)
	MOVE	#$444,6(A6)
	MOVE	#$DDD,10(A6)
	MOVE.L	(SP)+,A6
	RTS
 
SetDiskPtrCol
	MOVE.L	A6,-(SP)
	MOVE.L	CopListColorPtr,A6
	MOVE	#$070,2(A6)
	MOVE	#$040,6(A6)
	MOVE	#$0D0,10(A6)
	MOVE.L	(SP)+,A6
	RTS
 
SetPlayPtrCol
	MOVE.L	A6,-(SP)
	MOVE.L	CopListColorPtr,A6
	MOVE	#$770,2(A6)
	MOVE	#$440,6(A6)
	MOVE	#$DD0,10(A6)
	MOVE.L	(SP)+,A6
	RTS
 
SetEditPtrCol
	MOVE.L	A6,-(SP)
	MOVE.L	CopListColorPtr,A6
	MOVE	#$05A,2(A6)
	MOVE	#$006,6(A6)
	MOVE	#$08f,10(A6)
	MOVE.L	(SP)+,A6
	RTS
 
SetWaitPtrCol
	MOVE.L	A6,-(SP)
	MOVE.L	CopListColorPtr,A6
	MOVE	#$727,2(A6)
	MOVE	#$404,6(A6)
	MOVE	#$F7F,10(A6)
	MOVE.L	(SP)+,A6
	RTS
 
SetErrorPtrCol
	MOVE.L	A6,-(SP)
	MOVE.L	CopListColorPtr,A6
	MOVE	#$C02,2(A6)
	MOVE	#$400,6(A6)
	MOVE	#$F03,10(A6)
	MOVE.L	(SP)+,A6
	MOVE	#1,UpdateFreeMem
	BSR	WaitALittle
	JSR	ShowAllRight
	BSR	SetNormalPtrCol
	MOVEQ	#0,D0
	RTS

WaitALittle
	MOVE	WaitTime(PC),D1
errorwaitloop
	JSR	Wait_4000
	DBF	D1,errorwaitloop
	MOVE	#23,WaitTime
	RTS

WaitTime
	dc.w 23

StorePtrCol
	MOVE.L	A6,-(SP)
	MOVE.L	CopListColorPtr,A6
	MOVE	2(A6),PointerCol1Save
	MOVE	6(A6),PointerCol2Save
	MOVE	10(A6),PointerCol3Save
	MOVE.L	(SP)+,A6
	RTS

ErrorRestoreCol
	BSR	SetErrorPtrCol
RestorePtrCol
	MOVE.L	A6,-(SP)
	MOVE	#1,UpdateFreeMem
	MOVE.L	CopListColorPtr,A6
	MOVE	PointerCol1Save,2(A6)
	MOVE	PointerCol2Save,6(A6)
	MOVE	PointerCol3Save,10(A6)
	MOVE.L	(SP)+,A6
	RTS







;---- Check special keys ----		(SPICE)
CheckPlayKeys
	MOVE.B	RawKeyCode,D0
	CMP.B	#101,D0
	BEQ	SerialPlaySong			;-
	CMP.B	#103,D0
	BEQ	SerialPlayPattern		;-
	CMP.B	#64,D0
	BNE.S	cpkskip
	TST.L	RunMode
	BNE	SerialStopIt			;-
	TST.L	EditMode
	BEQ	.Edit				;-
		LEA	NormalStopText(pc),A0
		JSR	ShowStatusText
		BRA	StopIt
.Edit		LEA	NormalEditText(pc),A0
		JSR	ShowStatusText
		BRA	Edit
cpkskip	CMP.B	#97,D0
	BEQ	SerialRecordPattern			;-
	CMP.B	#69,D0
	BEQ	EscPressed
	CMP.B	#66,D0
	BEQ	TabulateCursor
	CMP.B	#127,D0
	BEQ	GotoCLI
	CMP.B	#48,D0
	BEQ	TurnOffVoices
	CMP.B	#60,D0
	BEQ	KillSample
	CMP.B	#13,D0
	BEQ	togglepnote

	CMP.B	#67,D0
	BEQ.S	HigherInstr
	CMP.B	#67+128,D0
	BEQ.S	LowerInstr
	MOVE	HiLowInstr,D1
	LEA	kpinstable(PC),A0
	MOVEQ	#0,D2
kpinsloop
	CMP.B	(A0,D2.W),D0
	BEQ.S	kpinsfound
	ADDQ	#1,D2
	CMP	#16,D2
	BLO.S	kpinsloop
	RTS

kpinsfound
	ADD	D2,D1
	BEQ.S	insnull
	BRA.S	redrsa2

LowerInstr
	CLR	HiLowInstr
	RTS
HigherInstr
	MOVE	#16,HiLowInstr
	MOVE	#16,D1
	BRA.S	redrsa2

redrsa3	MOVE	D1,InsNum
redrsam	CLR.B	RawKeyCode
	CLR.L	SavSamInf
	JSR	ShowSampleInfo
	JMP	RedrawSample

insnull	TST	InsNum
	BEQ.S	insnul2
	MOVE	InsNum,LastInsNum
	CLR	InsNum
	MOVEQ	#0,D1
	BRA.S	redrsa2

insnul2	JMP	ShowSampleInfo

kpinstable
	dc.b 15,90,91,92
	dc.b 93,61,62,63,74
	dc.b 45,46,47,94,29,30
	dc.b 31

redrsa2	TST.B	pnoteflag
	BEQ.S	redrsa3
	CLR.B	RawKeyCode
	TST	AltKeyStatus
	BNE.S	setpnote
	MOVE	D1,InsNum
	JSR	ShowSampleInfo
	MOVE	InsNum,D0
	ADD	D0,D0
	MOVE	pnotetable(PC,D0.W),D0
	MOVEQ	#-1,D2
	BSR	playtheinstr
	JMP	RedrawSample

pnotetable
	dc.w 24,24,24,24,24,24,24,24,24,24
	dc.w 24,24,24,24,24,24,24,24,24,24
	dc.w 24,24,24,24,24,24,24,24,24,24
	dc.w 24,24

setpnote
	ADD	D1,D1
	LEA	pnotetable(PC,D1.W),A0
	MOVE.L	A0,SplitAddress
	MOVE	#4,SamNoteType
	LEA	selnotetext(PC),A0
	JMP	ShowStatusText

selnotetext	dc.b "select note",0

togglepnote
	CLR.B	RawKeyCode
	MOVEQ	#0,D0
	MOVE.B	pnoteflag,D0
	ADDQ.B	#1,D0
	CMP.B	#3,D0
	BLO.S	tpnskp
	MOVEQ	#0,D0
tpnskp	MOVE.B	D0,pnoteflag
	LEA	pnotechar(PC,D0.W),A0
	MOVEQ	#1,D0
	MOVE	#5159,D1
	JMP	ShowText3

pnotechar	dc.b 32,128,129
pnoteflag	dc.b 0

;---- Check transpose keys ----

CheckTransKeys
	TST	LeftAmigaStatus
	BEQ	Return1
	MOVE	PattCurPos,D0
	BSR	GetPositionPtr
	MOVE.B	RawKeyCode,D1
	CLR.B	RawKeyCode
	MOVE.B	SampleAllFlag,-(SP)
	BSR.S	ctksub
	MOVE.B	(SP)+,SampleAllFlag
	RTS

ctksub	MOVEQ	#0,D0
	CLR.B	SampleAllFlag
	CMP.B	#1,D1
	BEQ	NoteUp
	CMP.B	#16,D1
	BEQ	NoteDown
	CMP.B	#32,D1
	BEQ	OctaveUp
	CMP.B	#49,D1
	BEQ	OctaveDown

	MOVE	#300,D0
	CMP.B	#2,D1
	BEQ	NoteUp
	CMP.B	#17,D1
	BEQ	NoteDown
	CMP.B	#33,D1
	BEQ	OctaveUp
	CMP.B	#50,D1
	BEQ	OctaveDown

	MOVEQ	#0,D0
	MOVE.B	#1,SampleAllFlag
	CMP.B	#3,D1
	BEQ	NoteUp
	CMP.B	#18,D1
	BEQ	NoteDown
	CMP.B	#34,D1
	BEQ	OctaveUp
	CMP.B	#51,D1
	BEQ	OctaveDown

	MOVE	#300,D0
	CMP.B	#4,D1
	BEQ	NoteUp
	CMP.B	#19,D1
	BEQ	NoteDown
	CMP.B	#35,D1
	BEQ	OctaveUp
	CMP.B	#52,D1
	BEQ	OctaveDown
	RTS

;---- Check control keys ----

CheckCtrlKeys
	TST	CtrlKeyStatus
	BEQ	Return1
	MOVEQ	#0,D0
	MOVE.B	RawKeyCode,D0
	CMP.B	#35,D0 ; F
	BEQ	ToggleFilter
	CMP.B	#33,D0 ; S
	BEQ	ToggleSplit
	CMP.B	#55,D0 ; M
	BEQ	ToggleMultiMode
	CMP.B	#16,D0 ; Q
	BEQ	UnmuteAll
	CMP.B	#32,D0 ; A
	BEQ	ToggleMute
	CMP.B	#49,D0 ; Z
	BEQ	RestoreEffects
	CMP.B	#19,D0 ; R
	BEQ	RestoreFKeyPos
	CMP.B	#20,D0 ; T
	BEQ	SwapTrack

	CMP.B	#53,D0 ; B
	BEQ	BeginBlock
	CMP.B	#51,D0 ; C
	BEQ	CopyBlock
	CMP.B	#50,D0 ; X
	BEQ	CutBlock
	CMP.B	#34,D0 ; D
	BEQ	DeleteBlock
	CMP.B	#25,D0 ; P
	BEQ	PasteBlock
	CMP.B	#23,D0 ; I
	BEQ	InsertBlock
	CMP.B	#38,D0 ; J
	BEQ	JoinPasteBlock
	CMP.B	#54,D0 ; N
	BEQ	Re_MarkBlock
	CMP.B	#21,D0 ; Y
	BEQ	BackwardsBlock
	CMP.B	#17,D0 ; W
	BEQ	PolyphonizeBlock

	CMP.B	#18,D0 ; E
	BEQ	ExpandTrack
	CMP.B	#24,D0 ; O
	BEQ	ContractTrack
	CMP.B	#37,D0 ; H
	BEQ	TransBlockUp
	CMP.B	#40,D0 ; L
	BEQ	TransBlockDown
	CMP.B	#39,D0 ; K
	BEQ	KillToEndOfTrack
	CMP.B	#22,D0 ; U
	BEQ	UndoLastChange

	CMP.B	#68,D0 ; CR
	BEQ	InsCmdTrack
	CMP.B	#65,D0 ; Del
	BEQ	DelCmdTrack
	CMP.B	#36,D0 ; G
	BEQ	BoostAll
	CMP.B	#52,D0 ; V
	BEQ	FilterAll

	CMP.B	#1,D0
	BLO	Return1
	CMP.B	#10,D0
	BHI	Return1
	BNE.S	cckskip
	MOVEQ	#0,D0
cckskip	MOVE	D0,EditMoveAdd
	CLR.B	RawKeyCode
	ADD.B	#'0',D0
	LEA	ematext(PC),A0
	MOVE.B	D0,11(A0)
	JSR	ShowStatusText
	MOVE	#10,WaitTime
	BSR	WaitALittle
	JMP	ShowAllRight

ematext	dc.b "editskip = 0",0,0

;---- Check alt keys ----

CheckAltKeys
	TST	AltKeyStatus
	BEQ	Return1
	MOVEQ	#0,D0
	MOVE.B	RawKeyCode,D0
	CMP.B	#49,D0 ; Z
	BEQ	ToggleCh1
	CMP.B	#50,D0 ; X
	BEQ	ToggleCh2
	CMP.B	#51,D0 ; C
	BEQ	ToggleCh3
	CMP.B	#52,D0 ; V
	BEQ	ToggleCh4
	CMP.B	#53,D0 ; B
	BEQ	Boost
	CMP.B	#35,D0 ; F
	BEQ	Filter
	CMP.B	#20,D0 ; T
	BEQ.S	xTuningTone
	CMP.B	#33,D0 ; S
	BEQ.S	xSamplerScreen
	CMP.B	#19,D0 ; R
	BEQ.S	xResample
	CMP.B	#18,D0 ; E
	BEQ	DoEditOp
	CMP.B	#23,D0 ; I
	BEQ.S	AutoInsert
	CMP.B	#34,D0 ; D
	BEQ	DiskOp
	CMP.B	#39,D0 ; K
	BEQ	KillInstrTrack
;	CMP.B	#17,D0 ; W
;	BEQ.S	WaitForNote
	CMP.B	#32,D0 ; A
	BEQ.S	xSampler
	CMP.B	#16,D0 ; Q
	BEQ	ChkQuit
	CMP.B	#21,D0 ; Y
	BEQ	SaveAllSamples

;	CMP.B	#24,D0 ; O
;	CMP.B	#55,D0 ; M
;	CMP.B	#25,D0 ; P
;	CMP.B	#38,D0 ; J
;	CMP.B	#54,D0 ; N
;	CMP.B	#37,D0 ; H
;	CMP.B	#40,D0 ; L
;	CMP.B	#22,D0 ; U
;	CMP.B	#36,D0 ; G
	RTS

xTuningTone	JMP	TuningTone
xSamplerScreen	JMP	SamplerScreen
xResample	JMP	Resample
xSampler	JMP	Sampler

AutoInsert
	CLR.B	RawKeyCode
	EOR.B	#1,AutoInsFlag
ShowAutoInsert
	CMP	#4,CurrScreen
	BEQ	Return1
	MOVE.B	#' ',D0
	TST.B	AutoInsFlag
	BEQ.S	auins2
	MOVE.B	#'I',D0
auins2	MOVE.B	D0,AutoInsText
	MOVE	#4561,D1
	MOVEQ	#1,D0
	LEA	AutoInsText(PC),A0
	JMP	ShowText3

AutoInsText	dc.b 0
AutoInsFlag	dc.b 0

SaveAllSamples
	LEA	SaveAllSamplesText,A0
	BSR	AreYouSure
	BNE	SetErrorPtrCol
	MOVE	InsNum,SaveInstr
	MOVE	#1,InsNum
.loop	JSR	ShowSampleInfo
	BSR	dosavesample
	ADDQ	#1,InsNum
	CMP	#32,InsNum
	BLO.S	.loop
	MOVE	SaveInstr,InsNum
	JMP	ShowSampleInfo

SaveAllSamplesText
	dc.b	"save all samples?",0
	even

;---- Jump between channels ----

TabulateCursor
	CLR.B	RawKeyCode
	TST	ShiftKeyStatus
	BNE.S	TabCurRight
	MOVE	PattCurPos,D0
	DIVU	#6,D0
	ADDQ	#1,D0
	CMP	#4,D0		;channels
	BNE.S	tacskip
	MOVEQ	#0,D0
tacskip	MULU	#6,D0
	MOVE	D0,PattCurPos
	BRA	UpdateCursorPos

TabCurRight
	MOVE	PattCurPos,D0
	ADDQ	#5,D0
	DIVU	#6,D0
	SUBQ	#1,D0
	BPL.S	tacskip
	MOVEQ	#3,D0
	BRA.S	tacskip

;---- Escape was pressed ----

EscPressed
	CLR.B	RawKeyCode
	CLR.B	SaveKey
	MOVE	CurrScreen,D0
	CMP	#2,D0
	BLO.S	BotExit
TopExit	MOVE	CurrScreen,D0
	CMP	#2,D0
	BEQ	ExitHelpScreen
	CMP	#3,D0
	BEQ	ExitFromDir
	CMP	#4,D0
	BEQ.S	pedexit
	CMP	#5,D0
	BEQ	ExitSetup
	CMP	#6,D0
	BEQ.S	plstexit
	CMP	#7,D0
	BEQ	ExitSetup
	RTS

BotExit	TST	SamScrEnable
	BNE.S	samplerexit
	TST	BlockMarkFlag
	BNE	blkunma
	CMP	#1,CurrScreen
	BNE	Return1
	TST.B	EdEnable
	BNE	ExitEditOp
	RTS

samplerexit
	 JMP	ExitFromSam
pedexit	 JMP	PED_Exit
plstexit JMP	ExitPLST

GotoCLI	CLR.B	RawKeyCode
	CLR.B	SaveKey
	TST.L	RunMode
	BNE.S	cliskp1
	BSR	StopIt
	BSR	ResetMusicInt
cliskp1	BSR	ResetVBInt
	BSR	ResetInputHandler
	BSR	ResetAutoReq
	BSR	ResetEasyReq
	BSR	ResetCopList
	MOVE.L	ExtCmdAddress,D1
	BEQ.S	gcliskp
	CLR.L	ExtCmdAddress
	MOVE.L	ExtCmdWindow,D2
	MOVEQ	#0,D3
	MOVE.L	DOSBase,A6
	JSR	LVOExecute(A6)
gcliskp	SUB.L	A0,A0
	LEA	BackToProText(PC),A1
	LEA	OKGadgetText(PC),A2
	MOVE.L	A2,A3
	MOVEQ	#0,D0
	MOVEQ	#0,D1
	MOVE	#196,D2
	MOVEQ	#50,D3
	MOVE.L	IntuitionBase,A6
	JSR	LVOAutoRequest(A6)
	ADDQ.B	#1,LastRawkey
	TST.L	RunMode
	BNE.S	cliskp2
	BSR	SetMusicInt
cliskp2	BSR	SetVBInt
	BSR	SetInputHandler
	BSR	SetAutoReq
	BSR	SetEasyReq
	BRA	SetCopList

BackToProText
	dc.b 0,1,1,0
	dc.w 14,6
	dc.l 0,btptext,0
btptext dc.b 'Back to Protracker',0,0

OKGadgetText
	dc.b 0,1,1,0
	dc.w 6,3
	dc.l 0,okgtext,0
okgtext dc.b 'OK',0,0

;---- Check Help Key ----

HelpSelectText	dc.b	'* help selected *',0
PLSTSelectText	dc.b	'* plst selected *',0
PLSTHelpFlag	dc.b	0,0 ; free 0

CheckHelpKey
	CMP.B	#95,RawKeyCode	; Help Key pressed ?
	BNE	Return1
	CLR.B	RawKeyCode
	TST	ShiftKeyStatus
	BEQ.S	realhlp
	LEA	HelpSelectText,A0
	EOR.B	#1,PLSTHelpFlag
	BEQ.S	chksel
	LEA	PLSTSelectText,A0
chksel	JSR	ShowStatusText
	BSR	WaitALittle
	JMP	ShowAllRight

gtoPLST	JMP	PLST

realhlp	TST.B	PLSTHelpFlag
	BNE.S	gtoPLST
	CMP	#2,CurrScreen
	BEQ	ExitHelpScreen
	BSR	TopExit
	MOVE	CurrScreen,SaveCurrScreen
	SF	ScopeEnable
	ST 	DisableAnalyzer
	ST	NoSampleInfo
	BSR	ClearAnalyzerColors
	BSR	SwapHelpScreen
	BEQ	exithlp
	BSR	Clear100Lines
	TST.L	HelpTextIndex+4
	BNE.S	chkskip
	BSR	GetHelpIndex
chkskip	MOVE.L	#HelpFileName,D1
	MOVE.L	#1005,D2
	MOVE.L	DOSBase,A6
	JSR	LVOOpen(A6)
	MOVE.L	D0,FileHandle
	BNE	ShowHelpPage
	LEA	PTPath,A0
	BSR	CopyPath
	LEA	HelpFileName(PC),A0
	MOVEQ	#7,D0
hefilop	MOVE.B	(A0)+,(A1)+
	DBF	D0,hefilop
	MOVE.L	#FileName,D1
	MOVE.L	#1005,D2
	MOVE.L	DOSBase,A6
	JSR	LVOOpen(A6)
	MOVE.L	D0,FileHandle
	BEQ	HelpFileError
	BRA.S	ShowHelpPage

ExitHelpScreen
	MOVE.L	FileHandle,D1
	BEQ.S	ehsskip
	MOVE.L	DOSBase,A6
	JSR	LVOClose(A6)
ehsskip	BSR	Clear100Lines
	BSR.S	SwapHelpScreen
exithlp	MOVE	SaveCurrScreen,CurrScreen
 	BRA	DisplayMainAll

SwapHelpScreen
	MOVE.L	DecompMemPtr,D0		;get decompress address
	BEQ.S	shelps2
	MOVE.L	D0,A1			;if true then de-allocate it
	BSR	ssets3
	BRA	FreeDecompMem
shelps2	LEA	HelpScreenData,A0
	BSR	Decompact
	BEQ	Return1
	BRA	ssets3

ShowHelpPage			;showpage (*helppage)<<2
	MOVE	#2,CurrScreen
	MOVE	HelpPage,D0
	AND	#$00FF,D0
	LSL	#2,D0
	LEA	HelpTextIndex,A0
	MOVE.L	FileHandle,D1
	BEQ	Return1
	MOVE.L	(A0,D0.W),D2
 movem.l a0/d0/d2,$200.w
	ADD.L	#1024,D2
	MOVEQ	#-1,D3
	MOVE.L	DOSBase,A6
	JSR	LVOSeek(A6)
	MOVE.L	FileHandle,D1
	MOVE.L	#HelpTextData,D2
	MOVE.L	#(ScreenWidth*16)+16,D3
	JSR	LVORead(A6)
	BSR	Clear100Lines
	LEA	HelpTextData+16,A6
	MOVEQ	#120,D6
	MOVEQ	#15,D7
shploop	MOVEQ	#0,D0
	MOVE.L	A6,A1
shplop2	CMP.B	#10,(A1)+
	BEQ.S	ShowHelpLine
	TST.B	-1(A1)
	BEQ.S	ShowHelpLine
	ADDQ	#1,D0
	BRA.S	shplop2
ShowHelpLine
	MOVE.L	A6,ShowTextPtr
	MOVE.L	A1,A6
	MOVE	D6,TextOffset
	MOVE	D0,TextLength
	BEQ.S	shlskip
	JSR	ShowText
shlskip	ADD	#240,D6
	DBF	D7,shploop
	JSR	Wait_4000
	JMP	Wait_4000

HelpPage	dc.w	1

HelpUp	LEA	HelpTextData+7,A0
	BRA.S	HelpMove
HelpDown
	LEA	HelpTextData+10,A0
	BRA.S	HelpMove
HelpLeft
	LEA	HelpTextData+4,A0
	BRA.S	HelpMove
HelpRight
	LEA	HelpTextData+13,A0
HelpMove
	CLR.B	RawKeyCode
	MOVEQ	#0,D0
	JSR	HexToInteger2
	TST	D0
	BEQ	Return1
	AND	#$00FF,D0
	MOVE	D0,HelpPage
	BRA	ShowHelpPage

GetHelpIndex
	MOVE.L	LaHeTx,D0
	CMP.L	HelpTextIndex,D0
	BEQ	Return1
	MOVE.L	#HelpFileName,D1
	MOVE.L	#1005,D2
	MOVE.L	DOSBase,A6
	JSR	LVOOpen(A6)
	MOVE.L	D0,FileHandle
	BNE.S	gehein
	LEA	PTPath,A0
	BSR	CopyPath
	LEA	HelpFileName(PC),A0
	MOVEQ	#7,D0
hefilp2	MOVE.B	(A0)+,(A1)+
	DBF	D0,hefilp2
	MOVE.L	#FileName,D1
	MOVE.L	#1005,D2
	MOVE.L	DOSBase,A6
	JSR	LVOOpen(A6)
	MOVE.L	D0,FileHandle
	BEQ.S	HelpFileError
gehein	MOVE.L	D0,D1
	MOVE.L	#HelpTextIndex,D2
	MOVE.L	#256*4,D3
	JSR	LVORead(A6)
	MOVE.L	FileHandle,D1
	JSR	LVOClose(A6)
	MOVE.L	HelpTextIndex,LaHeTx
	RTS

HelpFileError
	MOVE	#2,CurrScreen
	LEA	NoHelpText(PC),A0
	MOVE	#1887,D1
	MOVEQ	#24,D0
	JMP	ShowText3

NoHelpText	dc.b 'Unable to open helpfile!'
HelpFileName	dc.b 'PT.help',0


;---- Check Function Keys F6-F10 ----

CheckF6_F10
	CMP.B	#85,RawKeyCode
	BNE.S	CheckF7
	CLR.B	RawKeyCode
	TST	ShiftKeyStatus
	BEQ.S	cf6skip
	MOVE	ScrPattPos,F6pos
ShowPosSetText
	LEA	PosSetText,A0
	JSR	ShowStatusText
	MOVEQ	#8,D2
spsloop	JSR	Wait_4000
	DBF	D2,spsloop
	JMP	ShowAllRight

cf6skip	MOVE	F6pos,D0
chkalt	TST	AltKeyStatus
	BNE	PattFrom
	TST	CtrlKeyStatus
	BNE	RecordFrom
	TST	LeftAmigaStatus
	BNE	SongFrom
	TST	RunMode
	BNE	Return1
	MOVE	D0,ScrPattPos
	BRA	SetScrPatternPos
 
CheckF7	CMP.B	#86,RawKeyCode
	BNE.S	CheckF8
	CLR.B	RawKeyCode
	TST	ShiftKeyStatus
	BEQ.S	cf7skip
	MOVE	ScrPattPos,F7pos
	BRA.S	ShowPosSetText
cf7skip	MOVE	F7pos,D0
	BRA.S	chkalt

CheckF8	CMP.B	#87,RawKeyCode
	BNE.S	CheckF9
	CLR.B	RawKeyCode
	TST	ShiftKeyStatus
	BEQ.S	cf8skip
	MOVE	ScrPattPos,F8pos
	BRA	ShowPosSetText
cf8skip	MOVE	F8pos,D0
	BRA	chkalt

CheckF9	CMP.B	#88,RawKeyCode
	BNE.S	CheckF10
	CLR.B	RawKeyCode
	TST	ShiftKeyStatus
	BEQ.S	cf9skip
	MOVE	ScrPattPos,F9pos
	BRA	ShowPosSetText
cf9skip	MOVE	F9pos,D0
	BRA	chkalt

CheckF10
	CMP.B	#89,RawKeyCode
	BNE	Return1
	CLR.B	RawKeyCode
	TST	ShiftKeyStatus
	BEQ.S	cf10skip
	MOVE	ScrPattPos,F10pos
	BRA	ShowPosSetText
cf10skip
	MOVE	F10pos,D0
	BRA	chkalt

F6pos	dc.w  0
F7pos	dc.w 16
F8pos	dc.w 32
F9pos	dc.w 48
F10pos	dc.w 63

;---- Check Function Keys F3-F5 ----

CheckF3_F5
	MOVEQ	#0,D0
	MOVE.L	D0,A0
	TST	ShiftKeyStatus
	BNE	CCP4
	TST	CtrlKeyStatus
	BNE	CCP4
	TST	AltKeyStatus
	BNE	CutCopPas
	CMP.B	#68,RawKeyCode
	BEQ.S	StepPlayForward
	CMP.B	#65,RawKeyCode
	BEQ.S	StepPlayBackward
	TST	SamScrEnable
	BEQ	Return1
	CMP.B	#82,RawKeyCode
	BEQ.S	xSamCut
	CMP.B	#83,RawKeyCode
	BEQ.S	xSamCop
	CMP.B	#84,RawKeyCode
	BEQ.S	xSamPas
	RTS

xSamCut	JMP	SamCut
xSamCop	JMP	SamCopy
xSamPas	JMP	SamPaste

StepPlayForward
	MOVE	#1,StepPlayEnable
	BSR	DoStopIt
	MOVE	ScrPattPos,D0
	BRA	pafr1

StepPlayBackward
	MOVE	#1,StepPlayEnable
	BSR	DoStopIt
	MOVE	ScrPattPos,D0
	SUBQ	#1,D0
	AND	#63,D0
	BRA	pafr1

StepPlayEnable	dc.w	0

CCP4	MOVEQ	#0,D0
	MOVE	PattCurPos,D0
	DIVU	#6,D0
	AND.L	#3,D0
	LSL.L	#2,D0
	MOVE.L	D0,A0
CutCopPas
	ADD.L	SongDataPtr,A0
	LEA	sd_patterndata(A0),A0
	MOVE.L	PatternNumber,D0
	LSL.L	#8,D0
	LSL.L	#2,D0
	ADD.L	D0,A0
	TST	AltKeyStatus
	BNE.S	CutCopPasPatt
	TST	CtrlKeyStatus
	BNE.S	CutCopPasCmds
CutCopPasTrack
	CMP.B	#82,RawKeyCode
	BEQ	CutTrack
	CMP.B	#83,RawKeyCode
	BEQ	CopyTrack
	CMP.B	#84,RawKeyCode
	BEQ	PasteTrack
	CMP.B	#68,RawKeyCode
	BEQ	InsNoteTrack
	CMP.B	#65,RawKeyCode
	BEQ	DelNoteTrack
	RTS

CutCopPasPatt
	CMP.B	#82,RawKeyCode
	BEQ.S	CutPattern
	CMP.B	#83,RawKeyCode
	BEQ.S	CopyPattern
	CMP.B	#84,RawKeyCode
	BEQ	PastePattern
	CMP.B	#68,RawKeyCode
	BEQ	InsNotePattern
	CMP.B	#65,RawKeyCode
	BEQ	DelNotePattern
	RTS

CutCopPasCmds
	CMP.B	#82,RawKeyCode
	BEQ	CutCmds
	CMP.B	#83,RawKeyCode
	BEQ	CopyCmds
	CMP.B	#84,RawKeyCode
	BEQ	PasteCmds
	RTS

CutPattern
	BSR	SaveUndo
	LEA	PatternBuffer,A1
	MOVE	#255,D0
	MOVEQ	#0,D1
cupaloop
	MOVE.L	(A0),(A1)+
	MOVE.L	D1,(A0)+
	DBF	D0,cupaloop
	CLR.B	RawKeyCode
	BRA	RedrawPattern
 
CopyPattern
	LEA	PatternBuffer,A1
	MOVE	#255,D0
copaloop
	MOVE.L	(A0)+,(A1)+
	DBF	D0,copaloop
	CLR.B	RawKeyCode
	RTS
 
PastePattern
	BSR	SaveUndo
	LEA	PatternBuffer,A1
	MOVE	#255,D0
papaloop
	MOVE.L	(A1)+,(A0)+
	DBF	D0,papaloop
	CLR.B	RawKeyCode
	BRA	RedrawPattern


CutTrack
	BSR	SaveUndo
	LEA	TrackBuffer,A1
	MOVEQ	#63,D0
	MOVEQ	#0,D1
cutrloop
	MOVE.L	(A0),(A1)+
	MOVE.L	D1,(A0)
	LEA	16(A0),A0
	DBF	D0,cutrloop
	CLR.B	RawKeyCode
	BRA	RedrawPattern

CopyTrack
	LEA	TrackBuffer,A1
	MOVEQ	#63,D0
cotrloop
	MOVE.L	(A0),(A1)+
	LEA	16(A0),A0
	DBF	D0,cotrloop
	CLR.B	RawKeyCode
	RTS

PasteTrack
	BSR	SaveUndo
	LEA	TrackBuffer,A1
	MOVEQ	#63,D0
patrloop
	MOVE.L	(A1)+,(A0)
	LEA	16(A0),A0
	DBF	D0,patrloop
	CLR.B	RawKeyCode
	BRA	RedrawPattern

InsNotePattern
	BSR	SaveUndo
	MOVEQ	#0,D0
	BSR	GetPositionPtr
	BSR.S	inotr
	MOVEQ	#6,D0
	BSR	GetPositionPtr
	BSR.S	inotr
	MOVEQ	#12,D0
	BSR	GetPositionPtr
	BSR.S	inotr
	MOVEQ	#18,D0
	BSR	GetPositionPtr
	BSR.S	inotr
	BRA.S	intskip
InsNoteTrack
	BSR	SaveUndo
	BSR.S	inotr
intskip	CLR.B	RawKeyCode
	ADD	D2,ScrPattPos
	AND	#$3F,ScrPattPos
	BSR	SetScrPatternPos
	BRA	RedrawPattern

inotr	MOVE	ScrPattPos,D1
	LSL	#4,D1
	CMP	#63*16,D1
	BEQ.S	inoskip
	MOVE	#992,D0
intloop	MOVE.L	(A0,D0.W),16(A0,D0.W)
	SUB	#16,D0
	CMP	D1,D0
	BGE.S	intloop
inoskip	MOVEQ	#1,D2
	CLR.L	(A0,D1.W)
	RTS

InsCmdTrack
	BSR	SaveUndo
	MOVE	PattCurPos,D0
	BSR	GetPositionPtr
	BSR.S	icmtr
	BRA.S	intskip
icmtr	MOVE	ScrPattPos,D1
	LSL	#4,D1
	CMP	#63*16,D1
	BEQ.S	icmskip
	MOVE	#992,D0
icmloop	MOVE	2(A0,D0.W),D2
	AND	#$0FFF,D2
	AND	#$F000,18(A0,D0.W)
	OR	D2,18(A0,D0.W)
	SUB	#16,D0
	CMP	D1,D0
	BGE.S	icmloop
icmskip	MOVEQ	#1,D2
	AND	#$F000,2(A0,D1.W)
	RTS

DelNotePattern
	BSR	SaveUndo
	MOVEQ	#0,D0
	BSR	GetPositionPtr
	BSR.S	dnt
	MOVEQ	#6,D0
	BSR	GetPositionPtr
	BSR.S	dnt
	MOVEQ	#12,D0
	BSR	GetPositionPtr
	BSR.S	dnt
	MOVEQ	#18,D0
	BSR	GetPositionPtr
	BSR.S	dnt
	BRA	intskip
DelNoteTrack
	BSR	SaveUndo
	BSR.S	dnt
	BRA	intskip

dnt	MOVE	ScrPattPos,D0
	BEQ	Return1
	SUBQ	#1,D0
	LSL	#4,D0
dntloop	MOVE.L	16(A0,D0.W),(A0,D0.W)
	ADD	#16,D0
	CMP	#1024,D0
	BLO.S	dntloop
	MOVE	#1008,D1
	MOVEQ	#-1,D2
	CLR.L	(A0,D1.W)
	RTS

DelCmdTrack
	BSR	SaveUndo
	MOVE	PattCurPos,D0
	BSR	GetPositionPtr
	BSR.S	dct
	BRA	intskip
dct	MOVE	ScrPattPos,D0
	BEQ	Return1
	SUBQ	#1,D0
	LSL	#4,D0
dctloop	MOVE	18(A0,D0.W),D2
	AND	#$0FFF,D2
	AND	#$F000,2(A0,D0.W)
	OR	D2,2(A0,D0.W)
	ADD	#16,D0
	CMP	#1024,D0
	BLO.S	dctloop
	MOVE	#1008,D1
	MOVEQ	#-1,D2
	AND	#$F000,2(A0,D1.W)
	RTS

CutCmds	BSR	SaveUndo
	LEA	CmdsBuffer,A1
	CLR	D0
cucmloop
	MOVE.L	0(A0,D0.W),(A1)+
	AND.L	#$FFFFF000,(A0,D0.W)
	ADD	#16,D0
	CMP	#1024,D0
	BNE.S	cucmloop
	CLR.B	RawKeyCode
	BRA	RedrawPattern
 
CopyCmds
	LEA	CmdsBuffer,A1
	CLR	D0
cocmloop
	MOVE.L	0(A0,D0.W),(A1)+
	ADD	#16,D0
	CMP	#1024,D0
	BNE.S	cocmloop
	CLR.B	RawKeyCode
	RTS
 
PasteCmds
	BSR	SaveUndo
	LEA	CmdsBuffer,A1
	CLR	D0
pacmloop
	MOVE.L	0(A0,D0.W),D1
	AND.L	#$FFFFF000,D1
	MOVE.L	(A1)+,D2
	AND.L	#$00000FFF,D2
	OR.L	D2,D1
	MOVE.L	D1,(A0,D0.W)
	ADD	#16,D0
	CMP	#1024,D0
	BNE.S	pacmloop
	CLR.B	RawKeyCode
	BRA	RedrawPattern

;---- Swap Tracks ----

SwapTrack
	BSR	StorePtrCol
	BSR	SetWaitPtrCol
	LEA	SwapTrackText,A0
	BSR	ShowStatusText
swtloop	BSR	GetHexKey
	TST.B	D1
	BEQ.S	swtabor
	CMP.B	#4,D1
	BHI.S	swtloop
	BSR	SaveUndo
	SUBQ.L	#1,D1
	LSL.L	#2,D1
	MOVE.L	D1,D0
	MOVE.L	SongDataPtr,A0
	LEA	sd_patterndata(A0),A0
	MOVE.L	PatternNumber,D1
	LSL.L	#8,D1
	LSL.L	#2,D1
	ADD.L	D1,A0
	MOVE.L	A0,A1
	ADD.L	D0,A0
	MOVE	PattCurPos,D0
	DIVU	#6,D0
	AND.L	#$F,D0
	LSL.L	#2,D0
	ADD.L	D0,A1
	MOVEQ	#63,D1
swtloop2
	MOVE.L	(A0),D0
	MOVE.L	(A1),(A0)
	MOVE.L	D0,(A1)
	LEA	16(A0),A0
	LEA	16(A1),A1
	DBF	D1,swtloop2
	BSR	RedrawPattern
swtabor	BSR	ShowAllRight
	BRA	RestorePtrCol

SwapTrackText	dc.b 'Swap (1/2/3/4) ?',0,0

;---- Block Commands ----

BlockMarkText	dc.b 'mark block 00-00',0,0
BlockErrorText	dc.b 'no block marked !',0
BufEmptyText	dc.b 'buffer is empty !',0
BlockFromPos	dc.w 0
BlockToPos	dc.w 0
BlockMarkFlag	dc.w 0
BlockBufferFlag	dc.w 0
JoinPasteFlag	dc.w 0
PolyPasteFlag	dc.w 0
BuffFromPos	dc.w 0
BuffToPos	dc.w 0

BeginBlock
	CLR.B	RawKeyCode
	TST	BlockMarkFlag
	BEQ.S	beblskp
blkunma	CLR	BlockMarkFlag
	BRA	ShowAllRight
beblskp	MOVE	#1,BlockMarkFlag
	MOVE	ScrPattPos,BlockFromPos
	MOVE	ScrPattPos,BlockToPos
ShowBlockPos
	MOVE	BlockFromPos,D0
	MOVE	BlockToPos,D1
	CMP	D0,D1
	BHS.S	sbpskip
	EXG	D0,D1
sbpskip	LEA	BlockMarkText+12(PC),A0
	BSR	IntTo2DecAscii
	LEA	BlockMarkText+15(PC),A0
	MOVE	D1,D0
	BSR	IntTo2DecAscii
	LEA	BlockMarkText(PC),A0
	BRA	ShowStatusText

Re_MarkBlock
	CLR.B	RawKeyCode
	MOVE	#1,BlockMarkFlag
	MOVE	BlockToPos,ScrPattPos
	BSR	SetScrPatternPos
	BRA.S	ShowBlockPos

CheckBlockPos
	TST	BlockMarkFlag
	BEQ	Return1
	MOVE	ScrPattPos,D0
	CMP	BlockToPos,D0
	BEQ	Return1
	MOVE	D0,BlockToPos
	BRA.S	ShowBlockPos

IntTo2DecAscii
	AND.L	#$FF,D0
	DIVU	#10,D0
	ADD.B	#'0',D0
	MOVE.B	D0,-1(A0)
	SWAP	D0
	ADD.B	#'0',D0
	MOVE.B	D0,(A0)
	RTS

CutBlock
	CLR.B	RawKeyCode
	TST	BlockMarkFlag
	BEQ	BlockError
	BSR.S	cobldo
	MOVE	#1,BlockMarkFlag
	BRA	ClearBlock

CopyBlock
	CLR.B	RawKeyCode
	TST	BlockMarkFlag
	BEQ	BlockError
cobldo	CLR	BlockMarkFlag
	MOVE	#1,BlockBufferFlag
	MOVE	PattCurPos,D0
	BSR	GetPositionPtr
	LEA	BlockBuffer,A1
	MOVEQ	#63,D0
cobllop	MOVE.L	(A0),(A1)
	LEA	16(A0),A0
	LEA	16(A1),A1
	DBF	D0,cobllop
	MOVE	BlockFromPos,D0
	MOVE	BlockToPos,D1
	CMP	D0,D1
	BHS.S	coblskp
	EXG	D0,D1
coblskp	MOVE	D0,BuffFromPos
	MOVE	D1,BuffToPos
	BRA	ShowAllRight


PasteBlock
	CLR.B	RawKeyCode
	TST	BlockBufferFlag
	BEQ	BufferError
	BSR	SaveUndo
	MOVE	PattCurPos,D0
	BSR	GetPositionPtr
	LEA	BlockBuffer,A1
	MOVE	BuffFromPos,D0
	MOVE	BuffToPos,D1
	MOVE	ScrPattPos,D2
	LSL	#4,D0
	LSL	#4,D1
	LSL	#4,D2
pabllop	MOVE.L	(A1,D0.W),D3
	TST	JoinPasteFlag
	BEQ.S	pablskp
	MOVE.L	D3,D4
	AND.L	#$FFFFF000,D4
	BNE.S	pablskp
	MOVE.L	(A0,D2.W),D4
	AND.L	#$FFFFF000,D4
	AND.L	#$00000FFF,D3
	OR.L	D4,D3
pablskp	MOVE.L	D3,(A0,D2.W)
	CMP	D0,D1
	BEQ.S	pablend
	CMP	#63*16,D0
	BEQ.S	pablend
	CMP	#63*16,D2
	BEQ.S	pablend
	ADD	#16,D0
	ADD	#16,D2
	TST	PolyPasteFlag
	BEQ.S	pabllop
	MOVEM.L	A1/D0-D2,-(SP)
	BSR	GotoNextMulti
	MOVE	PattCurPos,D0
	BSR	GetPositionPtr
	MOVEM.L	(SP)+,A1/D0-D2
	BRA.S	pabllop
pablend	CLR	JoinPasteFlag
	CLR	PolyPasteFlag
	BSR	ShowAllRight
	BSR	RedrawPattern
	TST	ShiftKeyStatus
	BNE	Return1
	MOVE	BuffToPos,D0
	SUB	BuffFromPos,D0
	ADDQ	#1,D0
	ADD	ScrPattPos,D0
	CMP	#63,D0
	BLS.S	pablset
	MOVEQ	#0,D0
pablset	MOVE	D0,ScrPattPos
	BRA	SetScrPatternPos

PolyphonizeBlock
	MOVE	#1,PolyPasteFlag
JoinPasteBlock
	MOVE	#1,JoinPasteFlag
	BRA	PasteBlock

InsertBlock
	CLR.B	RawKeyCode
	TST	BlockBufferFlag
	BEQ	BufferError
	CMP	#63,ScrPattPos
	BEQ	PasteBlock
	MOVE	BuffToPos,D0
	SUB	BuffFromPos,D0
inbllop	MOVE.L	D0,-(SP)
	MOVE	PattCurPos,D0
	BSR	GetPositionPtr
	BSR	inotr
	MOVE.L	(SP)+,D0
	DBF	D0,inbllop
	BRA	PasteBlock

DeleteBlock
	CLR.B	RawKeyCode
	TST	BlockMarkFlag
	BEQ	BlockError
	BSR	SaveUndo
	MOVE	BlockFromPos,D0
	MOVE	BlockToPos,D1
	CMP	D0,D1
	BHS.S	deblskp
	EXG	D0,D1
deblskp	CMP	#63,D1
	BEQ.S	ClearBlock
	CLR	BlockMarkFlag
	MOVE	D0,ScrPattPos
	ADDQ	#1,ScrPattPos
	SUB	D0,D1
	MOVE	D1,D0
debllop	MOVE.L	D0,-(SP)
	MOVE	PattCurPos,D0
	BSR	GetPositionPtr
	BSR	dnt
	MOVE.L	(SP)+,D0
	DBF	D0,debllop
	SUBQ	#1,ScrPattPos
	BSR	ShowAllRight
	BRA	RedrawPattern

ClearBlock
	TST	BlockMarkFlag
	BEQ	BlockError
	BSR	SaveUndo
	CLR	BlockMarkFlag
	MOVE	PattCurPos,D0
	BSR	GetPositionPtr
	MOVE	BlockFromPos,D0
	MOVE	BlockToPos,D1
	CMP	D0,D1
	BHS.S	clblskp
	EXG	D0,D1
clblskp	LSL	#4,D0
	LSL	#4,D1
	MOVEQ	#0,D2
clbllop	MOVE.L	D2,(A0,D0.W)
	CMP	D0,D1
	BEQ.S	clblend
	ADD	#16,D0
	BRA.S	clbllop
clblend	BSR	ShowAllRight
	BRA	RedrawPattern

BackwardsBlock
	CLR.B	RawKeyCode
	TST	BlockMarkFlag
	BEQ	BlockError
	BSR	SaveUndo
	CLR	BlockMarkFlag
	MOVE	PattCurPos,D0
	BSR	GetPositionPtr
	MOVE	BlockFromPos,D0
	MOVE	BlockToPos,D1
	CMP	D0,D1
	BHS.S	bablskp
	EXG	D0,D1
bablskp	LSL	#4,D0
	LSL	#4,D1
babllop	MOVE.L	(A0,D0.W),D2
	MOVE.L	(A0,D1.W),(A0,D0.W)
	MOVE.L	D2,(A0,D1.W)
	CMP	D1,D0
	BHS.S	bablend
	ADD	#16,D0
	SUB	#16,D1
	CMP	D1,D0
	BHS.S	bablend
	BRA.S	babllop
bablend	BSR	ShowAllRight
	BRA	RedrawPattern

TransBlockUp
	SF	trblflag
	BRA.S	trbldo
TransBlockDown
	ST	trblflag
trbldo	CLR.B	RawKeyCode
	TST	BlockMarkFlag
	BEQ.S	BlockError
	BSR	SaveUndo
	MOVE	#2,NoteShift
	MOVE	BlockFromPos,D0
	MOVE	BlockToPos,D1
	CMP	D0,D1
	BHS.S	trblskp
	EXG	D0,D1
trblskp	MOVE	D0,D5
	LSL	#4,D5
	SUB	D0,D1
	MOVE	D1,D6
	MOVE	PattCurPos,D0
	BSR	GetPositionPtr
	LEA	(A0,D5.W),A3
	MOVEQ	#0,D3
	MOVE.B	SampleAllFlag,sampallsave
	ST	SampleAllFlag
	TST.B	trblflag
	BEQ.S	trblup
	BSR	sandlo2
	MOVE.B	sampallsave,SampleAllFlag
	BRA	RedrawPattern
trblup	BSR	sanulo2
	MOVE.B	sampallsave,SampleAllFlag
	BRA	RedrawPattern

trblflag	dc.b 0
sampallsave	dc.b 0

BlockError
	LEA	BlockErrorText,A0
	BSR	ShowStatusText
	BRA	SetErrorPtrCol

BufferError
	LEA	BufEmptyText,A0
	BSR	ShowStatusText
	BRA	SetErrorPtrCol

ExpandTrack
	CLR.B	RawKeyCode
	BSR	SaveUndo
	MOVE	ScrPattPos,PosSave
	ADDQ	#1,ScrPattPos
	CMP	#64,ScrPattPos
	BHS.S	extrend
extrlop	MOVE	PattCurPos,D0
	BSR	GetPositionPtr
	BSR	inotr
	ADDQ	#2,ScrPattPos
	CMP	#64,ScrPattPos
	BLO.S	extrlop
extrend	MOVE	PosSave,ScrPattPos
	BRA	RedrawPattern

ContractTrack
	CLR.B	RawKeyCode
	BSR	SaveUndo
	MOVE	ScrPattPos,PosSave
	ADDQ	#1,ScrPattPos
	CMP	#64,ScrPattPos
	BHS.S	cotrend
cotrlop	MOVE	PattCurPos,D0
	BSR	GetPositionPtr
	BSR	dnt
	ADDQ	#1,ScrPattPos
	CMP	#64,ScrPattPos
	BLO.S	cotrlop
cotrend	MOVE	PosSave,ScrPattPos
	BRA	RedrawPattern

PosSave	dc.w 0


KillToEndOfTrack
	CLR.B	RawKeyCode
	BSR	SaveUndo
	MOVE	PattCurPos,D0
	BSR	GetPositionPtr
	MOVE	ScrPattPos,D0
	MOVE	D0,D1
	MULU	#16,D1
	LEA	(A0,D1.W),A0
	TST	ShiftKeyStatus
	BNE.S	KillToStart
kteot	CLR.L	(A0)
	LEA	16(A0),A0
	ADDQ	#1,D0
	CMP	#64,D0
	BLO.S	kteot
	BRA	RedrawPattern

KillToStart
	CLR.L	(A0)
	LEA	-16(A0),A0
	TST	D0
	BEQ	RedrawPattern
	SUBQ	#1,D0
	BRA.S	KillToStart

UndoLastChange
	CLR.B	RawKeyCode
	MOVEQ	#0,D0
	BSR	GetPositionPtr
	LEA	UndoBuffer,A1
	MOVE	#255,D0
unlalop	MOVE.L	(A1),D1
	MOVE.L	(A0),(A1)+
	MOVE.L	D1,(A0)+
	DBF	D0,unlalop
	BRA	RedrawPattern

SaveUndo
	MOVEM.L	D0/A0-A1,-(SP)
	MOVEQ	#0,D0
	BSR	GetPositionPtr
	LEA	UndoBuffer,A1
	MOVE	#255,D0
saunlop	MOVE.L	(A0)+,(A1)+
	DBF	D0,saunlop
	MOVEM.L	(SP)+,D0/A0-A1
	RTS

BoostAll
	LEA	BoostAllText,A0
	BSR	AreYouSure
	BNE	SetErrorPtrCol
	MOVE	InsNum,SaveInstr
	MOVE	#1,InsNum
boallop	BSR	ShowSampleInfo
	BSR	Boost2
	ADDQ	#1,InsNum
	CMP	#32,InsNum
	BLO.S	boallop
	MOVE	SaveInstr,InsNum
	BRA	ShowSampleInfo

FilterAll
	LEA	FilterAllText,A0
	BSR	AreYouSure
	BNE	SetErrorPtrCol
	MOVE	InsNum,SaveInstr
	MOVE	#1,InsNum
fiallop	BSR	ShowSampleInfo
	BSR	Filter2
	ADDQ	#1,InsNum
	CMP	#32,InsNum
	BLO.S	fiallop
	MOVE	SaveInstr,InsNum
	BRA	ShowSampleInfo

BoostAllText	dc.b 'boost all samples',0
FilterAllText	dc.b 'filter all sampls',0
SaveInstr	dc.w 0

;---- Check Function Keys F1-F2 ----

CheckF1_F2
	CMP.B	#80,RawKeyCode
	BEQ.S	SetOctaveLow
	CMP.B	#81,RawKeyCode
	BEQ.S	SetOctaveHigh
	RTS
 
SetOctaveLow
	MOVE.L	#KbdTransTable1,KeyTransTabPtr
	CLR.B	RawKeyCode
	RTS
 
SetOctaveHigh
	MOVE.L	#KbdTransTable2,KeyTransTabPtr
	CLR.B	RawKeyCode
	RTS


;---- Get Hex Key ----

GetHexByte
	BSR	StorePtrCol
	BSR	SetWaitPtrCol
	CLR.B	RawKeyCode
	MOVEQ	#0,D0
	MOVE	TextOffset,D0
	DIVU	#40,D0
	ADDQ	#6,D0
	MOVE	D0,LineCurY
	SWAP	D0
	LSL	#3,D0
	ADDQ	#4,D0
	MOVE	D0,LineCurX
	BSR	UpdateLineCurPos
	BSR.S	GetHexKey
	MOVE.L	D1,D0
	MOVE.B	D1,D6
	LSL.B	#4,D6
	BSR	PrintHexDigit
	ADD	#8,LineCurX
	BSR	UpdateLineCurPos
	BSR.S	GetHexKey
	MOVE.L	D1,D0
	OR.B	D1,D6
	BSR	PrintHexDigit
	CLR	LineCurX
	MOVE	#270,LineCurY
	BSR	UpdateLineCurPos
	BSR	RestorePtrCol
	MOVEQ	#0,D0
	MOVE.B	D6,D0
	RTS

GetHexKey
	CLR.B	MixChar
	MOVEQ	#0,D0
	MOVEQ	#0,D1
	BTST	#2,$DFF016
	BEQ.S	ghkreturn
	BSR	DoKeyBuffer
	MOVE.B	RawKeyCode,D0
	MOVE.B	D0,MixChar
	BEQ.S	GetHexKey
	CMP.B	#68,D0 ; CR
	BEQ.S	ghkreturn
	CMP.B	#69,D0 ; Esc
	BEQ.S	ghkreturn
	CMP.B	#79,D0 ; <--
	BEQ.S	ghkleft
	CMP.B	#78,D0 ; -->
	BEQ.S	ghkright
	BSR.S	CheckHexKey
	CMP.B	#16,D1
	BEQ.S	GetHexKey
	CLR.B	RawKeyCode
ghkreturn
	MOVEQ	#0,D0
	RTS

ghkleft	MOVEQ	#-1,D0
	RTS

ghkright
	MOVEQ	#1,D0
	RTS

CheckHexKey
	LEA	RawKeyHexTable,A0
	MOVEQ	#0,D1
chxloop	CMP.B	(A0)+,D0
	BEQ	Return1
	ADDQ.B	#1,D1
	CMP.B	#16,D1
	BNE.S	chxloop
	RTS

;---- Enter Edit Commands (effects) ----

EditCommand
	TST.L	EditMode
	BEQ	Return1
	MOVEQ	#0,D0
	MOVE.B	RawKeyCode,D0
	BSR.S	CheckHexKey
	CMP.B	#16,D1
	BNE.S	DoEditCommand
	RTS

DoEditCommand
	CMP	#1,PattCurPos
	BNE.S	ChkPos2
	CMP	#1,D1
	BHI	Return1
	MOVE.L	#$FFF,D2
	CLR	CmdOffset
	LSL	#4,D1
	LSL	#8,D1
	BRA	UpdateCommand

ChkPos2	CMP	#2,PattCurPos
	BNE.S	ChkPos3
	MOVE.L	#$FFF,D2
	MOVE	#2,CmdOffset
	LSL	#4,D1
	LSL	#8,D1
	BRA	UpdateCommand

ChkPos3	CMP	#3,PattCurPos
	BNE.S	ChkPos4
	MOVE.L	#$F0FF,D2
	MOVE	#2,CmdOffset
	LSL	#8,D1
	BRA	UpdateCommand

ChkPos4	CMP	#4,PattCurPos
	BNE.S	ChkPos5
	MOVE.L	#$FF0F,D2
	MOVE	#2,CmdOffset
	LSL	#4,D1
	BRA	UpdateCommand

ChkPos5	CMP	#5,PattCurPos
	BNE.S	ChkPos7
	MOVE.L	#$FFF0,D2
	MOVE	#2,CmdOffset
	BRA	UpdateCommand

ChkPos7	CMP	#7,PattCurPos
	BNE.S	ChkPos8
	CMP	#1,D1
	BHI	Return1
	MOVE.L	#$FFF,D2
	MOVE	#4,CmdOffset
	LSL	#4,D1
	LSL	#8,D1
	BRA	UpdateCommand

ChkPos8	CMP	#8,PattCurPos
	BNE.S	ChkPos9
	MOVE.L	#$FFF,D2
	MOVE	#6,CmdOffset
	LSL	#4,D1
	LSL	#8,D1
	BRA	UpdateCommand

ChkPos9	CMP	#9,PattCurPos
	BNE.S	ChkPos10
	MOVE.L	#$F0FF,D2
	MOVE	#6,CmdOffset
	LSL	#8,D1
	BRA	UpdateCommand

ChkPos10
	CMP	#10,PattCurPos
	BNE.S	ChkPos11
	MOVE.L	#$FF0F,D2
	MOVE	#6,CmdOffset
	LSL	#4,D1
	BRA	UpdateCommand

ChkPos11
	CMP	#11,PattCurPos
	BNE.S	ChkPos13
	MOVE.L	#$FFF0,D2
	MOVE	#6,CmdOffset
	BRA	UpdateCommand

ChkPos13
	CMP	#13,PattCurPos
	BNE.S	ChkPos14
	CMP	#1,D1
	BHI	Return1
	MOVE.L	#$FFF,D2
	MOVE	#8,CmdOffset
	LSL	#4,D1
	LSL	#8,D1
	BRA	UpdateCommand

ChkPos14
	CMP	#14,PattCurPos
	BNE.S	ChkPos15
	MOVE.L	#$FFF,D2
	MOVE	#10,CmdOffset
	LSL	#4,D1
	LSL	#8,D1
	BRA	UpdateCommand

ChkPos15
	CMP	#15,PattCurPos
	BNE.S	ChkPos16
	MOVE.L	#$F0FF,D2
	MOVE	#10,CmdOffset
	LSL	#8,D1
	BRA	UpdateCommand

ChkPos16
	CMP	#16,PattCurPos
	BNE.S	ChkPos17
	MOVE.L	#$FF0F,D2
	MOVE	#10,CmdOffset
	LSL	#4,D1
	BRA	UpdateCommand

ChkPos17
	CMP	#17,PattCurPos
	BNE.S	ChkPos19
	MOVE.L	#$FFF0,D2
	MOVE	#10,CmdOffset
	BRA	UpdateCommand

ChkPos19
	CMP	#19,PattCurPos
	BNE.S	ChkPos20
	CMP	#1,D1
	BHI	Return1
	MOVE.L	#$FFF,D2
	MOVE	#12,CmdOffset
	LSL	#4,D1
	LSL	#8,D1
	BRA.S	UpdateCommand

ChkPos20
	CMP	#20,PattCurPos
	BNE.S	ChkPos21
	MOVE.L	#$FFF,D2
	MOVE	#14,CmdOffset
	LSL	#4,D1
	LSL	#8,D1
	BRA.S	UpdateCommand

ChkPos21
	CMP	#21,PattCurPos
	BNE.S	ChkPos22
	MOVE.L	#$F0FF,D2
	MOVE	#14,CmdOffset
	LSL	#8,D1
	BRA.S	UpdateCommand

ChkPos22
	CMP	#22,PattCurPos
	BNE.S	MustBePos23
	MOVE.L	#$FF0F,D2
	MOVE	#14,CmdOffset
	LSL	#4,D1
	BRA.S	UpdateCommand

MustBePos23
	MOVE.L	#$FFF0,D2
	MOVE	#14,CmdOffset
UpdateCommand
	MOVE.L	SongDataPtr,A0
	LEA	sd_patterndata(A0),A0
	MOVE.L	PatternNumber,D0
	LSL.L	#8,D0
	LSL.L	#2,D0
	ADD.L	D0,A0
	MOVEQ	#0,D0
	MOVE	ScrPattPos,D0
	LSL	#4,D0
	EXT.L	D0
	ADD.L	D0,A0
	ADD	CmdOffset,A0
	AND	D2,(A0)
	ADD	D1,(A0)
	MOVE	(A0),WordNumber
	MOVEQ	#0,D0
	MOVE	ScrPattPos,D0
	MULU	#7*40,D0
	MOVE	PattCurPos,D1
	DIVU	#6,D1
	MULU	#9,D1
	ADD.L	D1,D0
	ADD	#7528,D0
	MOVE	D0,TextOffset
	CMP	#0,CmdOffset
	BEQ.S	ShowInstrNibble
	CMP	#4,CmdOffset
	BEQ.S	ShowInstrNibble
	CMP	#8,CmdOffset
	BEQ.S	ShowInstrNibble
	CMP	#12,CmdOffset
	BEQ.S	ShowInstrNibble
	BSR	PrintHexWord
dscend	BSR	EditMoveDown
	CLR.B	RawKeyCode
	RTS

ShowInstrNibble
	SUBQ	#1,TextOffset
	MOVE	#1,TextLength
	MOVEQ	#0,D0
	MOVE	(A0),D0
	AND	#$F000,D0
	BNE.S	sinokok
	TST.B	BlankZeroFlag
	BEQ.S	sinokok
	MOVE.L	#BlankInsText,D0
	BRA.S	sinprt
sinokok	LSR	#4,D0
	LSR	#7,D0
	ADD.L	#FastHexTable+1,D0
sinprt	MOVE.L	D0,ShowTextPtr
	BSR	ShowText
	BRA.S	dscend

;---- Store/Insert Effect Commands ----

CheckStoreEffect
	MOVEQ	#0,D0
	MOVE.B	RawKeyCode,D0
	BEQ	Return1
	CMP.B	#70,D0 ; Del
	BEQ	CheckKeyboard2
	CMP.B	#10,D0
	BHI	Return1
	SUBQ.B	#1,D0
	ADD.B	D0,D0
	MOVE.L	D0,D7
	MOVE	PattCurPos,D0
	BSR	GetPositionPtr
	MOVE	ScrPattPos,D0
	LSL	#4,D0
	LEA	(A0,D0.W),A0
	MOVE	2(A0),D0
	AND	#$0FFF,D0
	LEA	EffectMacros,A0
	MOVE	D0,(A0,D7.W)
	LEA	CommandStoredText,A0
	BSR	ShowStatusText
	BSR	WaitALittle
	BRA	ShowAllRight

CommandStoredText dc.b 'command stored!',0

CheckInsertEffect
	CLR	InsEfx
	MOVEQ	#0,D0
	MOVE.B	RawKeyCode,D0
	BEQ	Return1
	CMP.B	#70,D0 ; Del
	BEQ	CheckKeyboard2
	CMP.B	#11,D0 ; -
	BEQ	DecreaseEffect
	CMP.B	#12,D0 ; = (+)
	BEQ.S	IncreaseEffect
	CMP.B	#13,D0 ; \
	BEQ.S	CopyEffect
	CMP.B	#10,D0
	BHI	Return1
	SUBQ.B	#1,D0
	ADD.B	D0,D0
	LEA	EffectMacros,A0
	MOVE	(A0,D0.W),InsEfx
DoInsEffect
	MOVE.B	#70,RawKeyCode
	BRA	CheckNoteKeys

GetLastEffect
	MOVE	PattCurPos,D0
	BSR	GetPositionPtr
	MOVE	ScrPattPos,D0
	SUBQ	#1,D0
	AND	#$3F,D0
	LSL	#4,D0
	LEA	(A0,D0.W),A0
	MOVE	2(A0),D0
	AND	#$0FFF,D0
	RTS

CopyEffect
	BSR.S	GetLastEffect
	MOVE	D0,InsEfx
	BRA.S	DoInsEffect

IncreaseEffect
	BSR.S	GetLastEffect
	MOVE	D0,D1
	AND	#$0F00,D1
	CMP	#$0E00,D1
	BEQ.S	IncECom
	ADDQ.B	#1,D0
	MOVE	D0,InsEfx
	BRA.S	DoInsEffect

IncECom	MOVE	D0,D1
	ADDQ.B	#1,D1
	AND.B	#$0F,D1
	AND	#$0FF0,D0
	OR.B	D1,D0
	MOVE	D0,InsEfx
	BRA.S	DoInsEffect

DecreaseEffect
	BSR.S	GetLastEffect
	MOVE	D0,D1
	AND	#$0F00,D1
	CMP	#$0E00,D1
	BEQ.S	DecECom
	SUBQ.B	#1,D0
	MOVE	D0,InsEfx
	BRA	DoInsEffect

DecECom	MOVE	D0,D1
	SUBQ.B	#1,D1
	AND.B	#$0F,D1
	AND	#$0FF0,D0
	OR.B	D1,D0
	MOVE	D0,InsEfx
	BRA	DoInsEffect

InsEfx	dc.w 0

;---- Check Keyboard for notekeys ----

CheckKeyboard
	TST.B	RawKeyCode
	BEQ	Return1
	TST	LeftAmigaStatus
	BNE	Return1
	TST	CtrlKeyStatus
	BNE	Return1
	TST	ShiftKeyStatus
	BNE	CheckStoreEffect
	TST	AltKeyStatus
	BNE	CheckInsertEffect
CheckKeyboard2
	MOVE	PattCurPos,D0
	BEQ.S	CheckNoteKeys
	CMP	#6,D0
	BEQ.S	CheckNoteKeys
	CMP	#12,D0
	BEQ.S	CheckNoteKeys
	CMP	#18,D0
	BEQ.S	CheckNoteKeys
	TST.L	EditMode
	BNE	EditCommand
	RTS
 
CheckNoteKeys
	LEA	RawKeyScaleTable,A0
	MOVE.B	RawKeyCode,D1
	MOVEQ	#38,D0
cnkloop	CMP.B	0(A0,D0.W),D1
	BEQ.S	NoteKeyPressed
	DBF	D0,cnkloop
	RTS

NoteKeyPressed
	CLR.B	RawKeyCode
	MOVE.L	KeyTransTabPtr,A1
	MOVE.B	(A1,D0.W),D0
	CMP	#36,D0
	BHS.S	nkpskip
	MOVE.L	SplitAddress,D1
	BEQ.S	nkpskip
	CLR.L	SplitAddress
	MOVE.L	D1,A0
	MOVE.B	D0,(A0)
	MOVE	SamNoteType,D1
	BEQ	ShowSplit
	CLR	SamNoteType
	AND	#$FF,D0
	MOVE	D0,(A0)
	CMP	#1,D1
	BEQ.S	loclab1
	CMP	#3,D1
	BEQ	ShowS2TuneNote
	CMP	#4,D1
	BEQ	ShowAllRight
	JMP	ShowResamNote
loclab1	JMP	ShowSamNote
nkpskip	MOVE	InsNum,PlayInsNum
	TST.B	SplitFlag
	BEQ.S	nkpskip2
	LEA	SplitInstrTable,A1
	MOVE.B	(A1,D0.W),D1
	BEQ.S	nkpskip3
	MOVE.B	D1,PlayInsNum+1
nkpskip3
	LEA	SplitTransTable,A1
	MOVE.B	(A1,D0.W),D0
nkpskip2
	MOVEQ	#0,D2
playtheinstr
	LEA	PeriodTable,A1 ; note in d0 here
	MOVE.L	D0,D4
	LSL	#1,D0
	MOVEQ	#0,D3
	MOVE	(A1,D0.W),D3

	MOVE.L	SongDataPtr,A0 ; This fixes finetune...
	LEA	14(A0),A0
	MOVE	InsNum,D1
	BNE.S	nkpskipit
	MOVE	LastInsNum,D1
nkpskipit
	MULU	#30,D1
	ADD.L	D1,A0
	MOVEQ	#0,D1
	MOVE.B	(A0),D1 ; get finetune
	MULU	#37*2,D1
	ADD.L	D1,A1
	MOVE	(A1,D0.W),CurrentPlayNote
	TST.L	D2
	BEQ.S	nkpnrml
	CMP.B	#2,pnoteflag
	BNE	antpskip

nkpnrml	TST.L	EditMode
	BEQ	antpskip
AddNoteToPattern
	MOVE.L	SongDataPtr,A0
	LEA	sd_patterndata(A0),A0	; Find first pattern
	MOVE.L	PatternNumber,D0
	LSL.L	#8,D0
	LSL.L	#2,D0
	ADD.L	D0,A0	; Find current pattern
	MOVEQ	#0,D0
	MOVE	ScrPattPos,D0
	BSR	QuantizeCheck
	LSL	#4,D0
	EXT.L	D0
	ADD.L	D0,A0	; Find current pos
	MOVE	PattCurPos,D0
	DIVU	#6,D0
	LSL	#2,D0
	EXT.L	D0
	ADD.L	D0,A0	; Find current channel
	TST	AltKeyStatus
	BEQ.S	antpsks
	AND.L	#$FFFFF000,(A0)
	MOVE	InsEfx,D0
	OR	D0,2(A0)
	BRA.S	antp3
antpsks	TST	ShiftKeyStatus
	BEQ.S	antpskip2
	CLR.L	(A0)
antpskip2
	MOVE	D3,(A0)	; Put note into pattern
	BEQ.S	antp2
	TST.B	AutoInsFlag
	BEQ.S	antp4
	MOVE	VolumeEfx,2(A0)
antp4	MOVEQ	#0,D0
	MOVE	PlayInsNum,D0
	LSL	#4,D0
	AND.B	#$F,2(A0)
	ADD.B	D0,2(A0)
	LSL	#4,D0
	AND	#$F000,D0
	OR	D0,(A0)
	BRA.S	antp3

antp2	AND	#$0FFF,2(A0)
antp3	MOVE	2(A0),CurrCmds
	MOVE.L	NoteNamesPtr,A0
	LSL	#2,D4
	EXT.L	D4
	ADD.L	D4,A0
	MOVE.L	A0,ShowTextPtr
	MOVE	#3,TextLength
	MOVEQ	#0,D0
	MOVE	ScrPattPos,D0
	BSR	QuantizeCheck
	MULU	#7*40,D0
	MOVEQ	#0,D1
	MOVE	PattCurPos,D1
	DIVU	#6,D1
	MULU	#9,D1
	ADD.L	D1,D0
	ADD	#7524,D0
	MOVE	D0,TextOffset
	TST	AltKeyStatus
	BEQ.S	antpnot
	ADDQ	#4,D0
	MOVE	D0,TextOffset
	BRA.S	antpalt
antpnot	BSR	ShowText	; Show notename
	BSR	PrintHiInstrNum
antpalt
	MOVE	CurrCmds,WordNumber
	BSR	PrintHexWord
	BSR	EditMoveDown
antpskip
	TST	DidQuantize
	BNE.S	testmul
	TST	CurrentPlayNote
	BNE	PlayNote
testmul	TST.B	MultiFlag
	BEQ	Return1
GotoNextMulti
	MOVEQ	#0,D0
	MOVE	PattCurPos,D0
	DIVU	#6,D0
	LEA	MultiModeNext,A0
	MOVE.B	(A0,D0.W),D0
	SUBQ	#1,D0
	AND	#3,D0
	MULU	#6,D0
	MOVE	D0,PattCurPos
	BRA	UpdateCursorPos

QuantizeCheck
	TST.L	RunMode
	BEQ.S	qcend
	MOVEQ	#0,D1
	MOVE.B	QuantizeValue,D1
	BEQ.S	qcend
	CMP	#1,D1
	BEQ.S	QuanOne
	MOVE	#1,DidQuantize
	MOVE.L	D1,D2
	LSR	#1,D2
	ADD	D0,D2
	AND	#$003F,D2
	DIVU	D1,D2
	MULU	D1,D2
	CMP	D0,D2
	BHI.S	qcskip
	CLR	DidQuantize
qcskip	MOVE	D2,D0
	RTS

QuanOne	MOVE.L	CurrSpeed,D1
	LSR.L	#1,D1
	CMP.L	Counter,D1
	BLS.S	QuantToNextNote
qcend	CLR	DidQuantize
	RTS
 
QuantToNextNote
	ADDQ	#1,D0
	AND	#$003F,D0
	MOVE	#1,DidQuantize
	RTS

PlayNote
	CMP	#18,PattCurPos
	BNE.S	ChkChan3
	LEA	$DFF0D0,A5
	LEA	audchan4temp,A4
	BRA.S	DoPlayNote

ChkChan3
	CMP	#12,PattCurPos
	BNE.S	ChkChan2
	LEA	$DFF0C0,A5
	LEA	audchan3temp,A4
	BRA.S	DoPlayNote

ChkChan2
	CMP	#6,PattCurPos
	BNE.S	ChkChan1
	LEA	$DFF0B0,A5
	LEA	audchan2temp,A4
	BRA.S	DoPlayNote

ChkChan1
	TST	PattCurPos
	BNE	Return1
	LEA	$DFF0A0,A5
	LEA	audchan1temp,A4
DoPlayNote
	MOVE.L	A5,NoteAddr
	LEA	SampleInfo,A6
	MOVE	PlayInsNum,D0
	BEQ.S	dpnplay
	LSL.L	#2,D0
	LEA	SamplePtrs,A0
	LEA	SampleInfo2,A6
	MOVE.L	0(A0,D0.W),si_pointer2
	MOVE.L	SongDataPtr,A0
	LEA	-10(A0),A0
	MOVE	PlayInsNum,D0
	MOVE.B	D0,PlayInsNum2
	MULU	#30,D0
	ADD.L	D0,A0
	MOVE.L	22(A0),SampleInfo2
	MOVE.L	26(A0),si_long2
dpnplay	MOVE.B	PlayInsNum2,n_samplenum(A4)
	MOVE	4(A6),D0		; repeat
	BNE.S	dpn2
	MOVE	(A6),D0			; length
	BRA.S	dpn3
dpn2	ADD	6(A6),D0		; add replen
dpn3	MOVEQ	#0,D1
	MOVE.B	3(A6),D1
	MOVE	D1,8(A5)		; Set volume
	MOVE.B	D1,n_volume(A4)
	MOVE	CurrentPlayNote,6(A5)	; Set period
	MOVE	CurrentPlayNote,n_period(A4)
	MOVE	n_dmabit(A4),$DFF096	; Channel DMA off
	MOVE.L	8(A6),D1
	ADD.L	StartOfs,D1
	MOVE.L	D1,(A5)			; Set sampledata pointer
	CLR.L	StartOfs
	MOVE.L	D1,n_start(A4)
	MOVE	D0,4(A5)		; Set length
	MOVE	D0,n_length(A4)
	BNE.S	dpnnz
	MOVEQ	#1,D0
	MOVE	D0,4(A5)
	MOVE	D0,n_length(A4)
dpnnz	MOVE	CurrentPlayNote,D0
	BSR	PlayNoteAnalyze

	JSR	DMAWaitLoop

	MOVE	n_dmabit(A4),D0
	AND	ActiveChannels,D0
	OR	#$8000,D0
	MOVE	D0,$DFF096	; Turn DMA back on

	JSR	DMAWaitLoop

	MOVEQ	#0,D1
	MOVE	4(A6),D1	; repeat*2
	ADD.L	D1,D1
	ADD.L	8(A6),D1	; + startptr
	MOVE.L	D1,(A5)		; Set loop pointer
	MOVE.L	D1,n_loopstart(A4)
	MOVE	6(A6),4(A5)	; Set loop length
	MOVE	6(A6),n_replen(A4)
	ST	n_trigger(A4)
	BRA	testmul

PlayInsNum2	dc.b 0,0

;---- Check Cursor Arrow Keys ----
 
ArrowKeys
	CMP.B	#4,EnterTextFlag
	BEQ	Return1
	MOVE.B	RawKeyCode,D0
	TST	GetLineFlag
	BNE.S	arkeskip
	TST	ShiftKeyStatus
	BNE.S	arkeskip
	TST	AltKeyStatus
	BNE.S	arkeskip
	CMP	#2,CurrScreen
	BEQ.S	arkeskip
	CMP.B	#78,D0
	BEQ	RightArrow
	CMP.B	#79,D0
	BEQ	LeftArrow
arkeskip
	CMP.B	#76,D0
	BEQ.S	UpArrow
	CMP.B	#77,D0
	BEQ	DownArrow
	CLR	ArrowPressed
	RTS

ArrowPressed	dc.w	0
ArrowRepCounter	dc.w	0

UpArrow	TST.L	RunMode
	BNE	Return1
	CMP	#2,CurrScreen
	BEQ	Return1
	CMP	#3,CurrScreen
	BEQ	Return1
	CMP	#4,CurrScreen
	BEQ	Return1
	CMP	#6,CurrScreen
	BEQ	Return1
	TST	ArrowPressed
	BEQ.S	MoveOneUp
	ADDQ	#1,ArrowRepCounter
	TST	AltKeyStatus
	BNE.S	AltUpArrow
	TST	ShiftKeyStatus
	BNE.S	ShiftUpArrow
	CMP	#6,ArrowRepCounter
	BPL.S	MoveOneUp
	RTS

ShiftUpArrow
	CMP	#3,ArrowRepCounter
	BPL.S	MoveOneUp
	RTS

AltUpArrow
	CMP	#1,ArrowRepCounter
	BPL.S	MoveOneUp
	RTS

MoveOneUp
	CLR	ArrowRepCounter
	MOVE	#$FFFF,ArrowPressed
	CMP.L	#'patt',RunMode
	BEQ	Return1
	SUBQ	#1,ScrPattPos
	AND	#$003F,ScrPattPos
	BRA	SetScrPatternPos

DownArrow
	TST.L	RunMode
	BNE	Return1
	CMP	#2,CurrScreen
	BEQ	Return1
	CMP	#3,CurrScreen
	BEQ	Return1
	CMP	#4,CurrScreen
	BEQ	Return1
	CMP	#6,CurrScreen
	BEQ	Return1
	TST	ArrowPressed
	BEQ.S	MoveOneDown
	ADDQ	#1,ArrowRepCounter
	TST	AltKeyStatus
	BNE.S	AltDownArrow
	TST	ShiftKeyStatus
	BNE.S	ShiftDownArrow
	CMP	#6,ArrowRepCounter
	BPL.S	MoveOneDown
	RTS

ShiftDownArrow
	CMP	#3,ArrowRepCounter
	BPL.S	MoveOneDown
	RTS
 
AltDownArrow
	CMP	#1,ArrowRepCounter
	BPL.S	MoveOneDown
	RTS
 
MoveOneDown
	CLR	ArrowRepCounter
	MOVE	#$FFFF,ArrowPressed
	TST.L	RunMode
	BNE	Return1
	ADDQ	#1,ScrPattPos
	AND	#$003F,ScrPattPos
	BRA	SetScrPatternPos

EditMoveDown
	TST.L	RunMode
	BNE	Return1
	MOVE	EditMoveAdd,D0
	ADD	D0,ScrPattPos
	AND	#$003F,ScrPattPos
	BRA	SetScrPatternPos

EditMoveAdd	dc.w 1

RightArrow
	TST	ArrowPressed
	BEQ.S	MoveOneRight
	ADDQ	#1,ArrowRepCounter
	CMP	#6,ArrowRepCounter
	BPL.S	MoveOneRight
	RTS
 
PatternOneUp
	ADDQ.L	#1,PatternNumber
	AND.L	#$3F,PatternNumber
	JSR	Wait_4000
	BRA	RedrawPattern

MoveOneRight
	CLR	ArrowRepCounter
	MOVE	#$FFFF,ArrowPressed
	ADDQ	#1,PattCurPos
	CMP	#24,PattCurPos
	BMI.S	morskip
	CLR	PattCurPos
morskip	BRA.S	UpdateCursorPos
 
LeftArrow
	TST	ArrowPressed
	BEQ.S	MoveOneLeft
	ADDQ	#1,ArrowRepCounter
	CMP	#6,ArrowRepCounter
	BPL.S	MoveOneLeft
	RTS
 
PatternOneDown
	SUBQ.L	#1,PatternNumber
	AND.L	#$3F,PatternNumber
	JSR	Wait_4000
	BRA	RedrawPattern

MoveOneLeft
	CLR	ArrowRepCounter
	MOVE	#$FFFF,ArrowPressed
	SUBQ	#1,PattCurPos
	TST	PattCurPos
	BPL	UpdateCursorPos
	MOVE	#23,PattCurPos
UpdateCursorPos
	TST	SamScrEnable
	BNE	Return1
	MOVE	PattCurPos,D0
	LEA	CursorPosTable,A0
	MOVE.B	0(A0,D0.W),D0
	LSL	#3,D0
	ADD	#9,D0
	MOVE	#$BD,D1
	MOVEQ	#14,D2 ; 14 lines
	LEA	CursorSpriteData,A0
	BRA	SetSpritePos

ArrowKeys2
	MOVE.B	RawKeyCode,D0
	CMP.B	#76,D0
	BEQ.S	UpArrow2
	CMP.B	#77,D0
	BEQ.S	DownArrow2
	CMP.B	#79,D0
	BEQ.S	LeftArrow2
	CMP.B	#78,D0
	BEQ	RightArrow2
	RTS

UpArrow2
	CMP	#2,CurrScreen
	BEQ	HelpUp
	CMP	#3,CurrScreen
	BEQ	FileNameOneUp
	CMP	#4,CurrScreen
	BNE.s	.no1up
		JMP	PED_OneUp
.no1up	CMP	#6,CurrScreen
	BNE.s	.plst1up
		JMP	PLSTOneUp
.plst1up
	RTS

DownArrow2
	CMP	#2,CurrScreen
	BEQ	HelpDown
	CMP	#3,CurrScreen
	BEQ	FileNameOneDown
	CMP	#4,CurrScreen
	BNE.s	.ped1d
		JMP	PED_OneDown
.ped1d	CMP	#6,CurrScreen
	BNE.s	.plst1d
		JMP	PLSTOneDown
.plst1d	RTS

LeftArrow2
	TST	ShiftKeyStatus
	BNE	PositionDown
	TST	AltKeyStatus
	BNE	PatternOneDown
	TST	CtrlKeyStatus
	BNE	SampleNumDown
	CMP	#2,CurrScreen
	BEQ	HelpLeft
	RTS

RightArrow2
	TST	ShiftKeyStatus
	BNE	PositionUp
	TST	AltKeyStatus
	BNE	PatternOneUp
	TST	CtrlKeyStatus
	BNE	SampleNumUp
	CMP	#2,CurrScreen
	BEQ	HelpRight
	RTS

;---- Update Line Cursor Position ----

UpdateLineCurPos
	MOVE	LineCurX,D0
	MOVE	LineCurY,D1
	SUBQ	#1,D0
	MOVEQ	#2,D2
	LEA	LineCurSpriteData,A0
	BRA	SetSpritePos

;---- Check Gadgets ----

CheckGadgets
	BSR	UpdatePointerPos
	BSR	CheckGadgets2
	BSR	CheckPitchControl

	CLR	notogfl
	CMP	#$FFFF,GadgRepeat
	BEQ.S	CgRepeat
	MOVEQ	#0,D0
cgloop	ADDQ.L	#1,D0
	TST.B	HHFlag
	BEQ.S	cgnorma
	CMP.L	#40000*5,D0
	BEQ.S	CgRepeat
	BRA.S	cgnorm2
cgnorma	CMP.L	#40000,D0
	BEQ.S	CgRepeat
cgnorm2	BTST	#6,$BFE001
	BEQ.S	cgloop
	CLR	UpOrDown
	BRA	MainLoop
 
CgRepeat
	TST.B	HHFlag
	BEQ.S	cgrepe2
	JSR	Wait_4000
cgrepe2	MOVE	#$FFFF,GadgRepeat
	BTST	#6,$BFE001
	BEQ.S	CheckGadgets
	CLR	GadgRepeat
	CLR	UpOrDown
	BRA	MainLoop
 
CheckGadgets2
	MOVE	MouseX,MouseX2
	BNE.S	cgskip
	TST	MouseY
	BNE.S	cgskip
ChkQuit	LEA	QuitPTText,A0
	BSR	AreYouSure
	BEQ	ExitCleanup	; Quit PT!
	RTS
cgskip	MOVE	MouseY,MouseY2
	CMP	#4,CurrScreen
	BEQ	CheckPresEdGadgs
	MOVE	MouseX2,D0
	MOVE	MouseY2,D1
	CMP	#122,D1
	BHS	WantedPattGadg
	CMP	#111,D1
	BHS	CheckSmplNamOrLoad
	CMP	#100,D1
	BHS	TypeInSongName
	CMP	#120,D0
	BLO.S	cgskip2
	CMP	#6,CurrScreen
	BEQ	CheckPLSTGadgs
cgskip2	CMP	#2,CurrScreen
	BEQ	Return1
	CMP	#3,CurrScreen	; Screen 3 is DirScreen...
	BEQ	CheckDirGadgets
	CMP	#5,CurrScreen
	BEQ	CheckSetupGadgs
	CMP	#7,CurrScreen
	BEQ	CheckSetup2Gadgs
	CMP	#45,D1
	BHS.S	cgskip3
	CMP	#306,D0
	BHS	CheckToggle
	CMP	#244,D0
	BHS	MainMenu3
	CMP	#211,D0
	BHS	MainMenu2b
	CMP	#181,D0
	BHS	MainMenu2
	CMP	#120,D0
	BHS	MainMenu1
cgskip3	CMP	#120,D0
	BHS.S	cgskip4
	CMP	#109,D0
	BHS	DownGadgets
	CMP	#98,D0
	BHS	UpGadgets
	CMP	#62,D0
	BHS	EnterNumGadg

	BRA	PosInsDelGadgs
cgskip4	TST.B	EdEnable
	BNE	CheckEditOpGadgs
	BSR	ToggleAnaScope
	RTS



;-----------------------------------------------------------------------
CheckPitchControl
	TST	SamScrEnable
	BNE	.not

	MOVE	MouseX,D0
	MOVE	MouseY,D1

	CMP	#PitchCtrlYPos,D1
	BLT	.not
	CMP	#PitchCtrlYPos+PitchCtrlSize,D1
	BGT	.not
	lsr	#3,d0

	btst	#10,$dff016
	bne.s	.noright
	CMP	#PitchCtrl0x,D0
	BLS	.ClrPitchCtrl0
	CMP	#PitchCtrl1x,D0
	BLS	.ClrPitchCtrl1
	CMP	#PitchCtrl2x,D0
	BLS	.ClrPitchCtrl2
	CMP	#PitchCtrl3x,D0
	BLS	.ClrPitchCtrl3

.noright
	CMP	#PitchCtrl0x,D0
	BLS	.PitchCtrl0
	CMP	#PitchCtrl1x,D0
	BLS	.PitchCtrl1
	CMP	#PitchCtrl2x,D0
	BLS	.PitchCtrl2
	CMP	#PitchCtrl3x,D0
	BLS	.PitchCtrl3
.not    RTS        

.PitchCtrl0
	bsr	PitchControlUndraw
	sub	#PitchCtrlYPos,d1
	move	d1,PitchCtrl		;set current channel <- y value
	bsr	PitchControlDraw
	rts

.PitchCtrl1
	bsr	PitchControlUndraw
	sub	#PitchCtrlYPos,d1
	move	d1,PitchCtrl+2		;set current channel <- y value
	bsr	PitchControlDraw
	rts

.PitchCtrl2
	bsr	PitchControlUndraw
	sub	#PitchCtrlYPos,d1
	move	d1,PitchCtrl+4		;set current channel <- y value
	bsr	PitchControlDraw
	rts

.PitchCtrl3
	bsr	PitchControlUndraw
	sub	#PitchCtrlYPos,d1
	move	d1,PitchCtrl+6		;set current channel <- y value
	bsr	PitchControlDraw
	rts

.ClrPitchCtrl0
	bsr	PitchControlUndraw
	move	#PitchCtrlSize>>1,PitchCtrl	;set current channel <- y value
	bsr	PitchControlDraw
	rts

.ClrPitchCtrl1
	bsr	PitchControlUndraw
	move	#PitchCtrlSize>>1,PitchCtrl+2	;set current channel <- y value
	bsr	PitchControlDraw
	rts

.ClrPitchCtrl2
	bsr	PitchControlUndraw
	move	#PitchCtrlSize>>1,PitchCtrl+4	;set current channel <- y value
	bsr	PitchControlDraw
	rts

.ClrPitchCtrl3
	bsr	PitchControlUndraw
	move	#PitchCtrlSize>>1,PitchCtrl+6	;set current channel <- y value
	bsr	PitchControlDraw
	rts




PitchUnDraw	macro
	move	PitchCtrl+(\1<<1),d0	;read pitch
	mulu	#ScreenWidth,d0
	add	#PitchCtrl\1Pos,d0
	lea	BitPlaneData,a0
	and.b	#%11000011,(a0,d0.w)
	add	#ScreenWidth,d0
	and.b	#%11000011,(a0,d0.w)
	endm
PitchDraw	macro
	move	PitchCtrl+(\1<<1),d0	;read pitch
	mulu	#ScreenWidth,d0
	add	#PitchCtrl\1Pos,d0
	lea	BitPlaneData,a0
	or.b	#%00111100,(a0,d0.w)
	add	#ScreenWidth,d0
	or.b	#%00111100,(a0,d0.w)
	endm
PitchControlUndraw
	movem.l	a0/d0,-(sp)
	PitchUnDraw	0
	PitchUnDraw	1
	PitchUnDraw	2
	PitchUnDraw	3
	movem.l	(sp)+,d0/a0
	rts

;-------------- redraw vertical bars
RedrawPitchCtrl
	TST	SamScrEnable
	BEQ	PitchControlDraw
		RTS
PitchControlDraw
	movem.l	a0/d0,-(sp)
	PitchDraw	0
	PitchDraw	1
	PitchDraw	2
	PitchDraw	3
	movem.l	(sp)+,d0/a0
	rts


;-------------- Sets hardware period value
SetPitchCtrl	macro
	move	PitchCtrl+((\1-1)<<1),d0	;read pitch offset
	sub	#PitchCtrlSize>>1,d0
	add	d0,d0				;scale pitch_ctrl range
	add	audchan\1temp+n_period,d0
	move	d0,$dff0a6+((\1-1)<<4)		;Set hardware period
	endm
SetNewPitchCtrl
	move.l	d0,-(sp)
	SetPitchCtrl	1
	SetPitchCtrl	2
	SetPitchCtrl	3
	SetPitchCtrl	4
	move.l	(sp)+,d0
	rts


PitchCtrl	dc.w    PitchCtrlSize>>1
		dc.w    PitchCtrlSize>>1
		dc.w    PitchCtrlSize>>1
		dc.w    PitchCtrlSize>>1










;----------------------------------
MainMenu3
	MOVE	MouseY2,D0
	CMP	#34,D0
	BHS	DPMGFIH
	CMP	#23,D0
	BHS	Setup
	CMP	#12,D0
	BHS	PresetEditor
	TST	D0
	BHS	PLST
	RTS

DPMGFIH	JMP	SamplerScreen

MainMenu2b
	MOVE	MouseY2,D0
	CMP	#3,CurrScreen
	BNE	mm2bskip
	CMP	#44,D0
	BHS	CheckDirGadgets2
mm2bskip
	CMP	#44,D0
	BHS	Return1
	CMP	#34,D0
	BHS	ShowDirScreen
	CMP	#23,D0
	BHS	DoEditOp
	CMP	#12,D0
	BHS	ClearAll
	TST	D0
	BHS	StopIt
	RTS

MainMenu2
	MOVE	MouseY2,D0
	CMP	#3,CurrScreen
	BNE	mm2skip
	CMP	#44,D0
	BHS	CheckDirGadgets2
mm2skip	CMP	#44,D0
	BHS	Return1
	CMP	#34,D0
	BHS	ContRecPatt
	CMP	#23,D0
	BHS	DoEditOp
	CMP	#12,D0
	BHS	ContPlayPatt
	TST	D0
	BHS	ContPlaySong
	RTS
 
MainMenu1
	MOVE	MouseY2,D0
	CMP	#3,CurrScreen
	BNE.S	mm1skip
	CMP	#44,D0
	BHS	CheckDirGadgets2
mm1skip	CMP	#44,D0
	BHS	Return1
	CMP	#34,D0
	BHS	NormalRecordPattern
	CMP	#23,D0
	BHS	NormalEdit
	CMP	#12,D0
	BHS	NormalPlayPatt
	TST	D0
	BHS	NormalPlaySong
	RTS


NormalPlaySong	LEA	NormalPlayText(pc),A0
		BSR	ShowStatusText
		BRA	PlaySong
NormalPlayPatt	LEA	NormalPattText(pc),A0
		BSR	ShowStatusText
		BRA	PlayPattern
NormalRecordPattern
		LEA	NormalRecText(pc),A0
		BSR	ShowStatusText
		BRA	RecordPattern
NormalEdit	LEA	NormalEditText(pc),A0
		BSR	ShowStatusText
		BRA	Edit


SerialPlaySong	move.b	#'1',SerialByte
		bsr	SendSerial
		bsr	PlaySong
		LEA	SerialPlayText(pc),A0
		JSR	ShowStatusText
		rts
SerialPlayPattern
		move.b	#'2',SerialByte
		bsr	SendSerial
		bsr	PlayPattern
		LEA	SerialPattText(pc),A0
		JSR	ShowStatusText
		rts
SerialRecordPattern
		move.b	#'3',SerialByte
		bsr	SendSerial
		bsr	RecordPattern
		LEA	SerialRecText(pc),A0
		JSR	ShowStatusText
		rts
SerialStopIt	move.b	#'4',SerialByte
		bsr	SendSerial
		bsr	StopIt
		LEA	SerialStopText(pc),A0
		JSR	ShowStatusText
		rts


;---- Disk Format ----
DiskFormatGadg
	BSR	WaitForButtonUp
	JSR	Wait_4000
	BSR	ClearFileNames
	BSR	SwapFormatBox
	BSR	WaitForButtonUp
	LEA	AreYouSureText,A0
	BSR	ShowStatusText
fmtbuttonchk
	BSR	DoKeyBuffer
	MOVE.B	RawKeyCode,D0
	CMP.B	#69,D0 ; ESC
	BEQ.S	fmtbend
	BTST	#6,$BFE001
	BNE.S	fmtbuttonchk
	MOVEM.W	MouseX,D0/D1
	CMP	#89,D0
	BLO.S	fmtbuttonchk
	CMP	#212,D0
	BHI.S	fmtbuttonchk
	CMP	#72,D1
	BLO.S	fmtbuttonchk
	CMP	#82,D1
	BHI.S	fmtbuttonchk
	CMP	#136,D0
	BLO.S	DiskFormat
	CMP	#166,D0
	BLO.S	fmtbuttonchk
fmtbend	BSR.S	SwapFormatBox
	BRA	SetErrorPtrCol

SwapFormatBox
	LEA	FormatBoxData,A1
	LEA	BitPlaneData+FormatBoxPos,A0
	MOVEQ	#38,D0
sfbloop1
	MOVEQ	#17,D1
sfbloop2
	MOVE.B	PlaneSize(A0),D2
	MOVE.B	702(A1),PlaneSize(A0)
	MOVE.B	D2,702(A1)
	MOVE.B	(A0),D2
	MOVE.B	(A1),(A0)+
	MOVE.B	D2,(A1)+
	DBF	D1,sfbloop2
	LEA	$0016(A0),A0
	DBF	D0,sfbloop1
	RTS

DiskFormat
	BSR	SwapFormatBox
	BSR	ShowAllRight
	BSR	ClearFileNames
	LEA	PlsEntNamText,A0
	MOVE	#2570,D1
	MOVEQ	#17,D0
	BSR	ShowText3
	LEA	OfVolumeText,A0
	MOVE.B	#'_',15(A0)
	MOVE.B	#'_',16(A0)
	MOVE	#2810,D1
	MOVEQ	#17,D0
	BSR	ShowText3
	BSR	SetWaitPtrCol
	LEA	DiskNumText1,A6
	MOVEQ	#1,D0
df_loop	CLR.B	0(A6,D0.W)
	DBF	D0,df_loop
	MOVE.L	A6,TextEndPtr
	MOVE.L	A6,ShowTextPtr
	ADDQ.L	#2,TextEndPtr
	MOVE.B	#1,EnterTextFlag
	MOVE	#2825,A4
	MOVE	#2,TextLength
	BSR	GetTextLine
	CLR.B	EnterTextFlag
	CLR.L	TextEndPtr
	BSR	ClearFileNames
	MOVE.L	4.W,A6
	MOVE.L	#5632,D0
	MOVEQ	#MEMF_CHIP,D1
	JSR	LVOAllocMem(A6)
	MOVE.L	D0,FormatDataPtr
	BEQ	df_memerr
	BSR	DoShowFreeMem
	SUB.L	A1,A1
	JSR	LVOFindTask(A6)
	MOVE.L	D0,ProcessPtr
	LEA	TrackdiskPort,A1
	JSR	LVOAddPort(A6)
	LEA	TrackdiskIOExtTD,A1
	MOVEQ	#0,D0
	MOVEQ	#0,D1
	LEA	TrackdiskName,A0
	JSR	LVOOpenDevice(A6)
	MOVE.L	#TrackdiskPort,TDPortPtr
	CLR	CylinderNumber
	LEA	TrackdiskIOExtTD,A1
	MOVE	#TD_CHANGESTATE,IO_COMMAND(A1)
	JSR	LVODoIO(A6)	; Check if disk in drive
	TST.L	IO_ACTUAL(A1)
	BEQ.S	df_indrive
	LEA	NoDiskInDriveText,A0
	BSR	ShowStatusText
	MOVE	#50,WaitTime
	BSR	SetErrorPtrCol
	BRA	df_cleanup

df_indrive
	LEA	TrackdiskIOExtTD,A1
	MOVE	#TD_PROTSTATUS,IO_COMMAND(A1)
	JSR	LVODoIO(A6)	; Check write protect
	TST.L	IO_ACTUAL(A1)
	BEQ.S	df_noprot
	LEA	WriteProtectedText,A0
	BSR	ShowStatusText
	MOVE	#50,WaitTime
	BSR	SetErrorPtrCol
	BRA	df_cleanup

df_noprot
	LEA	DiskFormatText,A0
	MOVE	#2581-7,D1
	MOVEQ	#11,D0
	BSR	ShowText3
	LEA	InProgressText,A0
	MOVE	#2821-7,D1
	MOVEQ	#11,D0
	BSR	ShowText3
	CLR.L	FmtDiskOffset
	MOVE.L	FormatDataPtr,FmtDataPtr
	MOVE.L	#$00001600,FmtDataSize
	BSR	ClearCylinder
	BSR	SetDiskPtrCol
df_formatloop
	LEA	FormattingCylText,A0
	BSR	ShowStatusText
	MOVE	CylinderNumber,D0
	LSR	#1,D0
	MOVE	D0,WordNumber
	BSR	Print2DecDigits
	MOVE.L	4.W,A6
	LEA	TrackdiskIOExtTD,A1
	MOVE	#TD_FORMAT,IO_COMMAND(A1)
	JSR	LVODoIO(A6)	; Format cylinder
	LEA	VerifyingText,A0
	BSR	ShowStatusText
	MOVE	CylinderNumber,D0
	LSR	#1,D0
	MOVE	D0,WordNumber
	BSR	Print2DecDigits
	MOVE.L	4.W,A6
	LEA	TrackdiskIOExtTD,A1
	MOVE	#CMD_READ,IO_COMMAND(A1)
	JSR	LVODoIO(A6)	; Read cylinder to verify
	TST.B	Fmt_hmmm
	BEQ.S	df_verifyok
	LEA	VerifyErrText(PC),A0
	BSR	ShowStatusText
	MOVE	#50,WaitTime
	BSR	SetErrorPtrCol
	BRA	df_cleanup

VerifyErrText	dc.b "Verify error!",0

df_verifyok
	ADD.L	#$1600,FmtDiskOffset
	ADDQ	#1,CylinderNumber
	CMP	#160,CylinderNumber
	BNE	df_formatloop

	LEA	InitDiskText,A0
	BSR	ShowStatusText
	BSR	ClearCylinder
	MOVE.L	FormatDataPtr,A2
	LEA	BootblockData(PC),A0
	MOVEQ	#12,D0
.loop	MOVE.L	(A0)+,(A2)+
	DBF	D0,.loop
	LEA	TrackdiskIOExtTD,A1
	CLR.L	IO_OFFSET(A1)
	MOVE.L	#512,IO_LENGTH(A1)
	MOVE	#CMD_WRITE,IO_COMMAND(A1)
	MOVE.L	4.W,A6
	JSR	LVODoIO(A6)	; Write bootblock
	MOVE.L	#DateStamp,D1
	MOVE.L	DOSBase,A6
	JSR	LVODateStamp(A6)
	MOVE.L	4.W,A6
	BSR	ClearCylinder
	MOVE.L	FormatDataPtr,A2
	MOVE	#2,2(A2)
	MOVE	#$0048,14(A2)
	MOVE.L	#$FFFFFFFF,$0138(A2)
	MOVE	#$0371,$013E(A2)
	MOVE.L	#$0553542D,$01B0(A2)
	MOVE	DiskNumText1,$01B4(A2)
	MOVE	#$06F7,$01E2(A2)
	MOVE	#1,$01FE(A2)
	LEA	DateStamp,A0
	MOVE.L	(A0),D0
	MOVE.L	D0,$01A4(A2)
	MOVE.L	D0,$01E4(A2)
	MOVE.L	4(A0),D0
	MOVE.L	D0,$01A8(A2)
	MOVE.L	D0,$01E8(A2)
	MOVE.L	8(A0),D0
	MOVE.L	D0,$01AC(A2)
	MOVE.L	D0,$01EC(A2)
	MOVE.L	A2,A3
	MOVE.L	A3,A4
	MOVEQ	#$7F,D1
	MOVEQ	#0,D0
	MOVE.L	D0,$0014(A4)
df_loop2
	SUB.L	(A3)+,D0
	DBF	D1,df_loop2
	MOVE.L	D0,$0014(A4)
	MOVE.L	#$C000C037,$0200(A2)
	LEA	$0204(A2),A3
	MOVEQ	#$36,D0
df_loop3
	MOVE.L	#$FFFFFFFF,(A3)+
	DBF	D0,df_loop3
	MOVE	#$3FFF,$0272(A2)
	MOVE	#$3FFF,$02DC(A2)
	LEA	TrackdiskIOExtTD,A1
	MOVE.L	#$0006E000,IO_OFFSET(A1)
	MOVE.L	#1024,IO_LENGTH(A1)
	MOVE	#CMD_WRITE,IO_COMMAND(A1)
	JSR	LVODoIO(A6)
	LEA	TrackdiskIOExtTD,A1
	MOVE	#CMD_UPDATE,IO_COMMAND(A1)
	JSR	LVODoIO(A6)	; Flush write buffer
df_cleanup
	LEA	TrackdiskIOExtTD,A1
	MOVE	#TD_MOTOR,IO_COMMAND(A1)
	CLR.L	IO_LENGTH(A1)
	JSR	LVODoIO(A6)	; Turn off the motor
	MOVE.L	Fmt_tja,A0
	MOVE.L	$0024(A0),A0
	OR.B	#2,$0040(A0)
	LEA	TrackdiskIOExtTD,A1
	MOVE.L	4.W,A6
	JSR	LVOCloseDevice(A6)
	LEA	TrackdiskPort,A1
	JSR	LVORemPort(A6)
	MOVE.L	FormatDataPtr,A1
	MOVE.L	#5632,D0
	JSR	LVOFreeMem(A6)
	CMP	#160,CylinderNumber
	BNE.S	df_skip2
	CMP	#'00',DiskNumText1
	BNE.S	df_skip2

	MOVE.L	DOSBase,A6
	MOVE.L	#150,D1	; Wait 3 sec
	JSR	LVODelay(A6)

	MOVE.L	#LockNameDF0,D1
	MOVE.L	#-2,D2
	JSR	LVOLock(A6)
	MOVE.L	D0,D6
	BEQ	df_skip3
	MOVE.L	D0,D1
	JSR	LVOCurrentDir(A6)
	MOVE.L	D0,D7
	MOVE.L	D6,D1
	JSR	LVOUnLock(A6)

	MOVE.L	#FmtSongDirName,D1
	JSR	LVOCreateDir(A6)
	MOVE.L	D0,D1
	BEQ.S	.err1
	JSR	LVOUnLock(A6)
.err1	MOVE.L	#FmtModuleDirName,D1
	JSR	LVOCreateDir(A6)
	MOVE.L	D0,D1
	BEQ.S	df_skip2
	JSR	LVOUnLock(A6)
df_skip2
	MOVE.L	D7,D1
	JSR	LVOCurrentDir(A6)
df_skip3
	BSR	SetNormalPtrCol
	BSR	ShowAllRight
	BSR	ClearFileNames
	MOVE	#1,UpdateFreeMem
	RTS

df_memerr
	BSR	OutOfMemErr
	BRA.S	df_skip2

ClearCylinder
	MOVE.L	FormatDataPtr,A0
	MOVE	#1407,D0
	MOVEQ	#0,D1
ccloop	MOVE.L	D1,(A0)+
	DBF	D0,ccloop
	RTS

BootblockData
	dc.l	$444F5300,$c0200f19,$00000370,$43fa0018
	dc.l	$4eaeffa0,$4a80670a,$20402068,$00167000
	dc.l	$4e7570ff,$60fa646f,$732e6c69,$62726172
	dc.l	$79000000

LockNameDF0	dc.b	"df0:",0
	even


;---- Clear All Data ----

ClearAll
	ADD.L	#1,LaHeTx
	MOVE.B	DisableAnalyzer,SaveDA
	MOVE.B	ScopeEnable,SaveScope
	SF	ScopeEnable
	LEA	PleaseSelectText,A0
	BSR	ShowStatusText
	BSR	StorePtrCol
	BSR	SetWaitPtrCol
	JSR	Wait_4000
	CMP	#1,CurrScreen
	BNE.S	clbskip
	TST.B	DisableAnalyzer
	BNE.S	clbskip
	ST 	DisableAnalyzer
	BSR	ClearAnaHeights
	BSR	ClearRightArea
clbskip	LEA	ClearBoxData,A1
	BSR	SwapBoxMem
	BSR	WaitForButtonUp
	JSR	Wait_4000
clearbuttoncheck
	BTST	#2,$DFF016
	BEQ	ClrCancel
	BSR	DoKeyBuffer
	MOVE.B	RawKeyCode,D0
	CMP.B	#33,D0 ; Pressed S
	BEQ	ClrSamples
	CMP.B	#24,D0 ; Pressed O
	BEQ	ClrSong
	CMP.B	#32,D0 ; Pressed A
	BEQ	ClrAll
	CMP.B	#51,D0 ; Pressed C
	BEQ	ClrCancel
	CMP.B	#69,D0 ; Pressed Esc
	BEQ	ClrCancel
	BTST	#6,$BFE001	; Left Mousebutton
	BNE.S	clearbuttoncheck
	MOVEM.W	MouseX,D0/D1
	CMP	#166,D0
	BLO.S	clearbuttoncheck
	CMP	#257,D0
	BHI.S	clearbuttoncheck
	CMP	#58,D1
	BLO.S	clearbuttoncheck
	CMP	#84,D1
	BHI.S	clearbuttoncheck
	CMP	#204,D0
	BHS.S	samporcancel
	CMP	#198,D0
	BLS.S	songorall
	BRA.S	clearbuttoncheck

songorall
	CMP	#74,D1
	BHS.S	ClrAll
	CMP	#68,D1
	BLS	ClrSong
	BRA	clearbuttoncheck

samporcancel
	CMP	#74,D1
	BHS.S	ClrCancel
	CMP	#68,D1
	BLS.S	ClrSamples
	BRA	clearbuttoncheck

RemoveClearBox
	LEA	ClearBoxData,A1
	BSR	SwapBoxMem
	BSR	ShowAllRight
	BSR	ClearAnaHeights
	MOVE.B	SaveDA,DisableAnalyzer
	MOVE.B	SaveScope,ScopeEnable
	BSR	RestorePtrCol
	CLR.B	RawKeyCode
	RTS

ClrCancel
	BSR.S	RemoveClearBox
	BRA	SetErrorPtrCol

ClrAll	BSR	DoClearSong
	BSR	ClrSampleInfo
	BSR	SetNormalPtrCol
	BSR.S	RemoveClearBox
	BRA	DisplayMainAll

ClrSamples
	BSR.S	RemoveClearBox
	BSR	StopIt
	BSR	ClrSampleInfo
	BSR	SetNormalPtrCol
	SF	EdEnable
	MOVE	#1,InsNum
	BRA	DisplayMainAll

ClrSong	BSR.S	RemoveClearBox
	BSR	DoClearSong
	BSR	SetNormalPtrCol
	BRA	DisplayMainAll

ClrSampleInfo
	BSR	GiveBackInstrMem
	MOVE.L	SongDataPtr,A0
	LEA	sd_sampleinfo(A0),A0
	MOVE	#31*30-1,D0
csiloop	CLR.B	(A0)+
	DBF	D0,csiloop
	MOVE.L	SongDataPtr,A1
	LEA	sd_sampleinfo(A1),A1
	MOVEQ	#30,D0
caloop2	MOVE	#1,28(A1)
	LEA	30(A1),A1
	DBF	D0,caloop2
	LEA	SampleLengthAdd(PC),A3
	MOVEQ	#31,D0
csilop2	CLR	(A3)+
	DBF	D0,csilop2
	JMP	RedrawSample

DoClearSong
	BSR	StopIt
	CLR.B	RawKeyCode
	MOVE.L	SongDataPtr,A0
	MOVE.L	A0,A1
	MOVEQ	#19,D0
docla2x	CLR.B	(A0)+
	DBF	D0,docla2x
	MOVE.L	A1,A2
	ADD.L	#70716,A2
	ADD.L	#950,A1
	MOVEQ	#0,D0
caloop	MOVE	D0,(A1)+
	CMP.L	A1,A2
	BNE.S	caloop
	MOVE.L	SongDataPtr,A0
	MOVE	#$017F,sd_numofpatt(A0)
	MOVE.L	#'M.K.',sd_mahokakt(A0)  ; M.K. all the way...
	SF	EdEnable
	CLR.L	CurrPos
	CLR.L	SongPosition
	CLR.L	PatternPosition
	CLR.L	PatternPtr
	CLR.L	TimerTicks
	CLR	BlockMarkFlag
	CLR.B	MetroChannel
	MOVE	#1,EditMoveAdd
	MOVEQ	#0,D0
	MOVE	DefaultSpeed,D0
	MOVE.L	D0,CurrSpeed
	MOVE	Tempo,RealTempo
	BSR	SetTempo
	BSR	RestoreEffects2
	BSR	RestoreFKeyPos2
	BSR	UnmuteAll
	MOVE	#1,InsNum
	MOVE.L	#6,CurrSpeed
	CLR.L	PatternNumber
	CLR	ScrPattPos
	BSR	SetScrPatternPos
	BRA	RedrawPattern

UnmuteAll
	MOVE	#1,audchan1toggle
	MOVE	#1,audchan2toggle
	MOVE	#1,audchan3toggle
	MOVE	#1,audchan4toggle
	MOVE	#$000F,ActiveChannels
	BRA	RedrawToggles

ToggleMute
	CLR.B	RawKeyCode
	TST	ShiftKeyStatus
	BEQ	tomuskp
	CLR	audchan1toggle
	CLR	audchan2toggle
	CLR	audchan3toggle
	CLR	audchan4toggle
tomuskp	MOVEQ	#0,D0
	MOVE	PattCurPos,D0
	DIVU	#6,D0
	MULU	#11,D0
	ADDQ	#4,D0
	BRA	DoToggleMute

RestoreEffects
	MOVEQ	#0,D0
	MOVE	DefaultSpeed,D0
	MOVE.L	D0,CurrSpeed
	MOVE	Tempo,RealTempo
	BSR	SetTempo
	BSR.S	RestoreEffects2
	CLR.B	RawKeyCode
	LEA	EfxRestoredText(PC),A0
	BSR	ShowStatusText
	BSR	WaitALittle
	BRA	ShowAllRight

RestoreEffects2
	LEA	audchan1temp,A0
	BSR.S	reefsub
	LEA	audchan2temp,A0
	BSR.S	reefsub
	LEA	audchan3temp,A0
	BSR.S	reefsub
	LEA	audchan4temp,A0
reefsub	CLR.B	n_wavecontrol(A0)
	CLR.B	n_glissfunk(A0)
	CLR.B	n_finetune(A0)
	CLR.B	n_loopcount(A0)
	RTS

RestoreFKeyPos
	CLR.B	RawKeyCode
	LEA	PosRestoredText(PC),A0
	BSR	ShowStatusText
	BSR	WaitALittle
	BSR	ShowAllRight
RestoreFKeyPos2
	MOVE	#00,F6pos
	MOVE	#16,F7pos
	MOVE	#32,F8pos
	MOVE	#48,F9pos
	MOVE	#63,F10pos
	RTS

EfxRestoredText	dc.b 'efx restored !',0
PosRestoredText	dc.b 'pos restored !',0


GiveBackInstrMem
	MOVEQ	#1,D7
	MOVE.L	4.W,A6
gbimloop
	MOVE	D7,D2
	LSL	#2,D2
	LEA	SamplePtrs,A0
	MOVE.L	0(A0,D2.W),D1
	BEQ.S	gbimskip
	MOVE.L	124(A0,D2.W),D0
	CLR.L	0(A0,D2.W)
	CLR.L	124(A0,D2.W)
	MOVE.L	D1,A1
	JSR	LVOFreeMem(A6)
gbimskip
	ADDQ	#1,D7
	CMP	#32,D7
	BNE.S	gbimloop
	MOVE	#1,UpdateFreeMem
	JMP	FreeCopyBuf

;---- Setup ---- +++

Setup	CMP	#7,LastSetupScreen
	BEQ	Setup2
	CLR	LastSetupScreen
	BSR	WaitForButtonUp
	MOVE	#5,CurrScreen
	ST	DisableAnalyzer
	ST	NoSampleInfo
	BSR	Clear100Lines
	BSR	ShowSetupScreen
	BEQ	ExitSetup
RefreshSetup
	BSR	SetScreenColors
	BSR	Show_MS
	CMP	#5,CurrScreen
	BNE	Return1
	BSR	MarkColor
	BSR	ShowSetupToggles
	BSR	ShowSplit
	BSR	ShowPrintPath
	BSR	ShowKeyRepeat
	BSR	ShowExtCommand
	BSR	ShowMultiSetup
	BSR	ShowConfigNumber
	BSR	ShowAccidental ; Always last (redraws pattern) 
	RTS


ShowSetupScreen
	MOVE.L	SetupMemPtr,D0
	BNE	DecompactSetup
	BSR	SaveMainPic
	TST.L	SetupMemPtr
	BEQ	Return1
	BRA	DecompactSetup

SaveMainPic
	MOVE.L	#8000,D0
	MOVEQ	#0,D1
	MOVE.L	4.W,A6
	JSR	LVOAllocMem(A6)
	MOVE.L	D0,SetupMemPtr
	BEQ	OutOfMemErr
	MOVE.L	D0,A1
	LEA	BitPlaneData,A0
	MOVEQ	#1,D2
sssloop1
	MOVE	#999,D0
sssloop2
	MOVE.L	(A0)+,(A1)+
	DBF	D0,sssloop2
	LEA	6240(A0),A0
	DBF	D2,sssloop1
	RTS

RestoreMainPic
	MOVE.L	SetupMemPtr,D0
	BEQ	Return1
	MOVE.L	D0,A1
	LEA	BitPlaneData,A0
	MOVEQ	#1,D2
ssxloop1
	MOVE	#1000-1,D0
ssxloop2
	MOVE.L	(A1)+,(A0)+
	DBF	D0,ssxloop2
	LEA	6240(A0),A0
	DBF	D2,ssxloop1
	MOVE.L	SetupMemPtr,A1
	CLR.L	SetupMemPtr
	MOVE.L	#8000,D0
	MOVE.L	4.W,A6
	JSR	LVOFreeMem(A6)
	RTS

SetupMemPtr	dc.l 0

DecompactSetup2
	LEA	Setup2Data,A0
	BRA.S	decoset

DecompactSetup
	LEA	SetupScreenData,A0
decoset	BSR	Decompact
	BEQ	Return1
	BSR	ssets3
	MOVEQ	#-1,D0
	RTS



; Gadgets

CheckSetupGadgs
	TST.L	SplitAddress
	BEQ.S	csgskip
	CLR.L	SplitAddress
	BSR	ShowSplit
csgskip	MOVEM.W	MouseX2,D0/D1
	CMP	#210,D0
	BHS	SetupMenu3
	CMP	#108,D0
	BHS.S	SetupMenu2
;---- Menu 1 ----
	CMP	#11,D1
	BLS	LoadConfig
	CMP	#22,D1
	BLS	SaveConfig
	CMP	#33,D1
	BLS	ResetAll
	CMP	#44,D1
	BLS	ExtCommand
	CMP	#55,D1
	BLS	MultiSetup
	CMP	#66,D1
	BLS	SetRed
	CMP	#77,D1
	BLS	SetGreen
	CMP	#88,D1
	BLS	SetBlue
	CMP	#99,D1
	BLS	ColorGadgets
	RTS

SetupMenu2
	CMP	#11,D1
	BLS	Return1
	CMP	#55,D1
	BLS	SetSplit
	CMP	#66,D1
	BLS	SetKeyRepeat
	CMP	#77,D1
	BLS	ToggleAccidental
	CMP	#88,D1
	BLS	PrintSong
	CMP	#99,D1
	BLS	EnterPrintPath
	RTS

SetupMenu3
	CMP	#11,D1
	BLS.S	ExitOrClear
	CMP	#22,D1
	BLS	ToggleSplit
	CMP	#33,D1
	BLS	ToggleFilter
	CMP	#44,D1
	BLS	ToggleTransDel
	CMP	#55,D1
	BLS	ToggleShowDec
	CMP	#66,D1
	BLS	ToggleAutoDir
	CMP	#77,D1
	BLS	ToggleAutoExit
	CMP	#88,D1
	BLS	ToggleModOnly
	CMP	#99,D1
	BLS	ToggleMIDI
	RTS

ExitOrClear
	CMP	#265,D0
	BLS	ClearSplit
	CMP	#306,D0
	BHS	Setup2
ExitSetup
	BSR	WaitForButtonUp
	MOVE	CurrScreen,LastSetupScreen
	CLR.B	RawKeyCode
	CLR.L	SplitAddress
	BSR	RestoreMainPic
	SF	NoSampleInfo
	BSR	SetupVUCols
	BSR	SetupAnaCols
	BSR	Clear100Lines
	BRA	DisplayMainAll

LastSetupScreen	dc.w 0

ToggleSplit
	EOR.B	#1,SplitFlag
	BRA	ShowSetupToggles

ToggleFilter
	BCHG	#1,$BFE001
	BRA	ShowSetupToggles

ToggleTransDel
	EOR.B	#1,TransDelFlag
	BRA.S	ShowSetupToggles

ToggleShowDec
	EOR.B	#1,ShowDecFlag
	MOVE	#1,UpdateFreeMem
	BRA.S	ShowSetupToggles

ToggleAutoDir
	EOR.B	#1,AutoDirFlag
	BRA.S	ShowSetupToggles

ToggleAutoExit
	EOR.B	#1,AutoExitFlag
	BRA.S	ShowSetupToggles

ToggleModOnly
	EOR.B	#1,ModOnlyFlag
	LEA	FileNamesPtr(PC),A0
	CLR.L	4(A0)
	BRA.S	ShowSetupToggles

ToggleMIDI
	EOR.B	#1,MIDIFlag
	BSR.S	ShowSetupToggles
tstmidi	TST.B	MIDIFlag
	BNE	OpenMIDI
	BRA	CloseMIDI

ClearSplit
	BSR	WaitForButtonUp
	LEA	ClearSplitText,A0
	BSR	AreYouSure
	BNE	Return1
	LEA	SplitData,A0
	MOVEQ	#15,D0
clsploop
	CLR.B	(A0)+
	DBF	D0,clsploop
	BRA	ShowSplit

ShowSetupToggles
	CLR.B	RawKeyCode
	BSR	Show_MS
	CMP	#5,CurrScreen
	BNE	Return1
	MOVE.B	$BFE001,D0
	LSR.B	#1,D0
	AND.B	#1,D0
	EOR.B	#1,D0
	MOVE.B	D0,FilterFlag
	LEA	SplitFlag,A4
	MOVE	#3,TextLength
	MOVEQ	#7,D7
	MOVE	#636,D6
sstloop
	MOVE	D6,TextOffset
	LEA	ToggleOFFText(PC),A0
	TST.B	(A4)+
	BEQ.S	sstskip
	LEA	ToggleONText(PC),A0
sstskip
	BSR	ShowText2
	ADD	#440,D6
	DBF	D7,sstloop
	BRA	WaitForButtonUp

ToggleONText2	dc.b ' '
ToggleONText	dc.b 'on '
ToggleOFFText	dc.b 'off '

ShowSplit
	BSR	CalculateSplit
	CMP	#5,CurrScreen
	BNE	Return1
	LEA	SplitData,A3
	MOVE.L	NoteNamesPtr,A4
	MOVEQ	#0,D5
	MOVE	#614,D6
	CLR	WordNumber
shsploop
	MOVE	D6,TextOffset
	MOVE.B	(A3,D5.W),WordNumber+1 ; instr
	BSR	PrintHexByte
	ADDQ	#4,D6
	MOVE	D6,D1
	MOVEQ	#0,D0
	MOVE.B	1(A3,D5.W),D0 ; note
	LSL	#2,D0
	LEA	(A4,D0.W),A0
	MOVEQ	#4,D0
	BSR	ShowText3
	ADDQ.L	#5,D6
	MOVE	D6,D1
	MOVEQ	#0,D0
	MOVE.B	2(A3,D5.W),D0 ; trans
	LSL	#2,D0
	LEA	(A4,D0.W),A0
	MOVEQ	#4,D0
	BSR	ShowText3
	ADD	#431,D6
	ADDQ	#4,D5
	CMP	#16,D5
	BNE.S	shsploop
	RTS

CalculateSplit
	LEA	SplitTransTable,A0
	LEA	SplitInstrTable,A1
	LEA	SplitData,A2
	MOVEQ	#0,D0
casploop
	MOVE.B	D0,(A0,D0.W)
	CLR.B	(A1,D0.W)
	ADDQ	#1,D0
	CMP	#37,D0
	BLS.S	casploop

	MOVE.B	1(A2),-(SP)
	MOVE.B	1+4(A2),-(SP)
	MOVE.B	1+8(A2),-(SP)
	MOVE.B	1+12(A2),-(SP) ; note

	MOVEQ	#3,D4
caspbigloop
	MOVEQ	#127,D0
	MOVEQ	#0,D1
	MOVEQ	#0,D2
casploop2
	CMP.B	1(A2,D1.W),D0 ; note
	BLS.S	caspskip
	MOVE.L	D1,D2
	MOVE.B	1(A2,D1.W),D0 ; note
caspskip
	ADDQ	#4,D1
	CMP	#16,D1
	BNE.S	casploop2

	MOVEQ	#0,D0
	MOVE.B	1(A2,D2.W),D0 ; note
	MOVE.B	#127,1(A2,D2.W) ; note
	MOVE.B	2(A2,D2.W),D1 ; trans
casploop3
	MOVE.B	D1,(A0,D0.W)
	MOVE.B	(A2,D2.W),(A1,D0.W) ; instr
	ADDQ	#1,D1
	CMP	#36,D1
	BLO.S	caspskip2
	MOVEQ	#35,D1
caspskip2
	ADDQ	#1,D0
	CMP	#36,D0
	BLO.S	casploop3
	DBF	D4,caspbigloop

	MOVE.B	(SP)+,1+12(A2)
	MOVE.B	(SP)+,1+8(A2)
	MOVE.B	(SP)+,1+4(A2)
	MOVE.B	(SP)+,1(A2) ; note
	RTS

SetSplit
	LEA	SplitData,A2
	SUBQ	#1,D1
	DIVU	#11,D1
	SUBQ	#1,D1
	MOVE	D1,D7
	LSL	#2,D7
	MULU	#440,D1
	ADD	#600,D1
	CMP	#176,D0
	BHS.S	SetSplitTranspose
	CMP	#136,D0
	BHS.S	SetSplitNote
	ADD	#14,D1
	MOVE	D1,TextOffset
	BSR	GetHexByte
	CMP.B	#$1F,D0
	BLS.S	setskip
	MOVE.B	#$1F,D0
setskip	MOVE.B	D0,(A2,D7.W) ; instr
	BRA	ShowSplit

SetSplitNote
	MOVE.L	D1,-(SP)
	BSR	ShowSplit
	MOVE.L	(SP)+,D1
	ADD	#18,D1
	MOVEQ	#3,D0
	LEA	SpcNoteText,A0
	BSR	ShowText3
	LEA	1(A2,D7.W),A0 ; note
	MOVE.L	A0,SplitAddress
	BRA	WaitForButtonUp

SetSplitTranspose
	MOVE.L	D1,-(SP)
	BSR	ShowSplit
	MOVE.L	(SP)+,D1
	ADD	#23,D1
	MOVEQ	#3,D0
	LEA	SpcNoteText,A0
	BSR	ShowText3
	LEA	2(A2,D7.W),A0 ; trans
	MOVE.L	A0,SplitAddress
	BRA	WaitForButtonUp

SetKeyRepeat
	CMP	#188,D0
	BHS.S	skrep2
	MOVE	#2381,TextOffset
	BSR	GetHexByte
	MOVE.B	D0,KeyRepDelay+1
	BRA.S	ShowKeyRepeat
skrep2	MOVE	#2384,TextOffset
	BSR	GetHexByte
	MOVE.B	D0,KeyRepSpeed+1
ShowKeyRepeat
	MOVE	#2381,TextOffset
	MOVE	KeyRepDelay,WordNumber
	BSR	PrintHexByte
	ADDQ	#1,TextOffset
	MOVE	KeyRepSpeed,WordNumber
	BRA	PrintHexByte

ToggleAccidental
	MOVE.L	#NoteNames1,NoteNamesPtr
	EOR.B	#1,Accidental
	BEQ.S	ShowAccidental
	MOVE.L	#NoteNames2,NoteNamesPtr
ShowAccidental
	LEA	AccidentalText(PC),A0
	TST.B	Accidental
	BEQ.S	shacskp
	LEA	AccidentalText+1(PC),A0
shacskp	MOVEQ	#1,D0
	MOVE	#2824,D1
	BSR	ShowText3
	BRA	RedrawPattern

AccidentalText	dc.b '#б'

LoadConfig
	CMP	#84,D0
	BHS	SetConfigNumber
	LEA	LoadConfigText,A0
	BSR	AreYouSure
	BNE	Return1
	BSR	WaitForButtonUp
	LEA	LoadingCfgText(PC),A0
	BSR	ShowStatusText
DoLoadConfig
	BSR	StorePtrCol
	BSR	PutConfigNumber
	MOVE.L	#ConfigName,D1
	MOVE.L	#1005,D2
	MOVE.L	DOSBase,A6
	JSR	LVOOpen(A6)
	MOVE.L	D0,D7
	BNE.S	cfgopok
	LEA	PTPath,A0
	BSR	CopyPath
	LEA	ConfigName(PC),A0
	MOVEQ	#12,D0
cfgnlop	MOVE.B	(A0)+,(A1)+
	DBF	D0,cfgnlop
	MOVE.L	#FileName,D1
	MOVE.L	#1005,D2
	MOVE.L	DOSBase,A6
	JSR	LVOOpen(A6)
	MOVE.L	D0,D7
	BEQ.S	ConfigErr
cfgopok	BSR	SetDiskPtrCol
	MOVE.L	D7,D1
	CLR.L	ConfigID
	MOVE.L	#ConfigID,D2
	MOVE.L	#4,D3
	JSR	LVORead(A6)
	CMP.L	#"PT1.",ConfigID
	BEQ.S	.okcon
	CMP.L	#"PT2.",ConfigID
	BEQ.S	.okcon
		BRA	cfgerr2		;not config file

.okcon	LEA	SetupData+4,A0
	MOVE.L	D7,D1
	MOVE.L	A0,D2
	MOVE.L	#ConfigFileSize-4,D3
	JSR	LVORead(A6)
lcfgend	MOVE.L	D7,D1
	JSR	LVOClose(A6)
	BSR	ShowAllRight
	BSR	RestorePtrCol
cfgupda	BSR	CopyCfgData
	BSR	tstmidi
	BSR	ChangeCopList
	BRA	RefreshSetup

ConfigErr
	BSET	#2,InitError
	LEA	FileNotFoundText(PC),A0
cferr	BSR	ShowStatusText
	MOVE	#50,WaitTime
	BRA	ErrorRestoreCol

cfgerr2	BSR.S	ConfigErr2
	BRA.S	lcfgend

ConfigErr2
	BSET	#3,InitError
	LEA	NotAConfFileText(PC),A0
	BRA.S	cferr

ConfigErr3
	LEA	CantCreateFiText(PC),A0
	BRA.S	cferr

FileNotFoundText dc.b "config not found!",0
NotAConfFileText dc.b "not a config file",0
CantCreateFiText dc.b "can't create file",0

SaveConfig
	CMP	#84,D0
	BHS	SetConfigNumber
	LEA	SaveConfigText,A0
	BSR	AreYouSure
	BNE	Return1
	BSR	StorePtrCol
	BSR	SetDiskPtrCol
	BSR	PutConfigNumber
	LEA	SavingCfgText(PC),A0
	BSR	ShowStatusText
	MOVE.L	DOSBase,A6
	LEA	PTPath,A0
	BSR	CopyPath
	LEA	ConfigName(PC),A0
	MOVEQ	#12,D0
cfgllop	MOVE.B	(A0)+,(A1)+
	DBF	D0,cfgllop
	MOVE.L	#FileName,D1
	MOVE.L	#1006,D2
	JSR	LVOOpen(A6)
	MOVE.L	D0,D7
	BEQ	ConfigErr3
	MOVE.L	D0,D1
	MOVE.L	#SetupData,D2
	MOVE	#ConfigFileSize,D3
	JSR	LVOWrite(A6)
	MOVE.L	D7,D1
	JSR	LVOClose(A6)
	BSR	ShowAllRight
	BRA	RestorePtrCol

SetConfigNumber
	MOVE	#611,TextOffset
	BSR	GetHexByte
	MOVE	D0,ConfigNumber
ShowConfigNumber
	MOVE	#611,TextOffset
	MOVE	ConfigNumber(PC),WordNumber
	BRA	PrintHexByte

PutConfigNumber
	MOVE	ConfigNumber(PC),D0
	LEA	ConfigName+12(PC),A0
	BRA	IntToHex2

ConfigNum=*+10
ConfigName	dc.b 'PT.config-00',0,0
ConfigNumber	dc.w 0
LoadingCfgText	dc.b 'loading config',0
SavingCfgText	dc.b 'saving config',0,0
ConfigID	dc.l 0

ResetAll
	LEA	ResetAllText,A0
	BSR	AreYouSure
	BNE	Return1
DoResetAll
	LEA	DefaultSetupData,A0
	LEA	SetupData,A1
	MOVE	#ConfigFileSize-1,D0
rsaloop	MOVE.B	(A0)+,(A1)+
	DBF	D0,rsaloop
	BRA	RefreshSetup

ExtCommand
	CMP	#11,D0
	BLO.S	excolab
	BSR	StorePtrCol
	BSR	SetWaitPtrCol
	LEA	ExtCommands,A6
	MOVE	ExtCmdNumber,D1
	MULU	#32,D1
	ADD.L	D1,A6
	MOVE.L	A6,ShowTextPtr
	MOVE.L	A6,TextEndPtr
	ADD.L	#31,TextEndPtr
	MOVE	#11,TextLength
	MOVE	#1482,A4
	BSR	GetTextLine
	BRA	RestorePtrCol

ShowExtCommand
	LEA	ExtCommands,A0
	MOVE	ExtCmdNumber,D1
	MULU	#32,D1
	ADD.L	D1,A0
	MOVEQ	#11,D0
	MOVE	#1482,D1
	BRA	ShowText3

excolab	BTST	#2,$DFF016
	BEQ.S	excorun
	ADDQ	#1,ExtCmdNumber
	AND	#7,ExtCmdNumber
	BSR.S	ShowExtCommand
	JSR	Wait_4000
	JSR	Wait_4000
	JSR	Wait_4000
	JMP	Wait_4000

excorun	LEA	ExtCommands,A0
	MOVE	ExtCmdNumber,D1
	MULU	#32,D1
	ADD.L	D1,A0
	TST.B	(A0)
	BEQ	Return1
	MOVE.L	A0,ExtCmdAddress
	MOVE.L	IntuitionBase,A6
	JSR	LVOOpenWorkbench(A6)
	JSR	LVOWBenchToFront(A6)
	MOVE.L	#ExtCmdConsole,D1
	MOVE.L	#1005,D2
	MOVE.L	DOSBase,A6
	JSR	LVOOpen(A6)
	MOVE.L	D0,ExtCmdWindow
	BEQ.S	winderr
	LSL.L	#2,D0
	MOVE.L	D0,A0
	MOVE.L	PTProcess,A1
	MOVE.L	8(A0),$A4(A1)
	BSR	GotoCLI
	MOVE.L	ExtCmdWindow,D1
	BEQ	Return1
	MOVE.L	DOSBase,A6
	JSR	LVOClose(A6)
	CLR.L	ExtCmdWindow
	RTS

winderr	LEA	ConsoleErrText,A0
	BSR	ShowStatusText
	BRA	SetErrorPtrCol

ExtCmdNumber	dc.w 0
ExtCmdAddress	dc.l 0
ExtCmdWindow	dc.l 0
ExtCmdConsole	dc.b "CON:0/0/640/150/Protracker Output Window",0
ConsoleErrText	dc.b "Can't open window",0,0

MultiSetup
	CMP	#44,D0
	BLO	Return1
	BSR	StorePtrCol
	BSR	SetWaitPtrCol
	MOVE	#1,GetLineFlag
	SUB	#44,D0
	LSR	#4,D0
	MOVE.B	D0,musepos
museset	MOVEQ	#0,D0
	MOVE.B	musepos,D0
	MOVE.L	D0,D1
	LSL	#4,D1
	MOVE	#52,LineCurX
	MOVE	#53,LineCurY
	ADD	D1,LineCurX
	LEA	MultiModeNext,A1
	LEA	(A1,D0.W),A1
	BSR	UpdateLineCurPos
muselop	BSR	GetHexKey
	TST.B	D1
	BEQ.S	musenul
	CMP.B	#4,D1
	BHI.S	muselop
	MOVE.B	D1,(A1)
	BSR	ShowMultiSetup
	MOVEQ	#1,D0
musenul	TST.B	D0
	BEQ.S	museabo
	ADD.B	D0,musepos
	AND.B	#3,musepos
	JSR	Wait_4000
	JSR	Wait_4000
	JSR	Wait_4000
	BRA.S	museset

museabo	BSR	RestorePtrCol
	CLR	GetLineFlag
	MOVE	#0,LineCurX
	MOVE	#270,LineCurY
	BSR	UpdateLineCurPos
ShowMultiSetup
	MOVE	#1926,TextOffset
	MOVE.B	MultiModeNext,D0
	BSR	PrintHexDigit
	MOVE	#1928,TextOffset
	MOVE.B	MultiModeNext+1,D0
	BSR	PrintHexDigit
	MOVE	#1930,TextOffset
	MOVE.B	MultiModeNext+2,D0
	BSR	PrintHexDigit
	MOVE	#1932,TextOffset
	MOVE.B	MultiModeNext+3,D0
	BRA	PrintHexDigit

musepos	dc.b 0,0

SetRed	CMP	#82,D0
	BHS	SelectColor
setr2	BSR	GetColPos
	AND	#$0F00,D2
	LSR	#8,D2
	CMP.B	D2,D0
	BEQ.S	setrskp
	AND	#$00FF,D1
	LSL	#8,D0
	OR	D0,D1
	MOVE	D1,(A0)
	BSR	ShowColSliders
	BSR	SetScreenColors
setrskp	BTST	#6,$BFE001
	BEQ.S	setr2
	RTS

SetGreen
	CMP	#82,D0
	BHS	SelectColor
setg2	BSR.S	GetColPos
	AND	#$00F0,D2
	LSR	#4,D2
	CMP.B	D2,D0
	BEQ.S	setgskp
	AND	#$0F0F,D1
	LSL	#4,D0
	OR	D0,D1
	MOVE	D1,(A0)
	BSR	ShowColSliders
	BSR	SetScreenColors
setgskp	BTST	#6,$BFE001
	BEQ.S	setg2
	RTS

SetBlue	CMP	#82,D0
	BHS	SelectColor
setb2	BSR.S	GetColPos
	AND	#$000F,D2
	CMP.B	D2,D0
	BEQ.S	setbskp
	AND	#$0FF0,D1
	OR	D0,D1
	MOVE	D1,(A0)
	BSR	ShowColSliders
	BSR	SetScreenColors
setbskp	BTST	#6,$BFE001
	BEQ.S	setb2
	RTS

GetColPos
	MOVEQ	#0,D0
	MOVE	MouseX,D0
	CMP	#26,D0
	BHS.S	gcpskp2
	MOVEQ	#0,D0
	BRA.S	gcpskip
gcpskp2	SUB	#26,D0
	DIVU	#3,D0
	AND.L	#$FF,D0
	CMP	#15,D0
	BLS.S	gcpskip
	MOVEQ	#15,D0
gcpskip	CMP	#7,CurrScreen
	BEQ	GetColAddr
	LEA	ColorTable,A0
	MOVE	CurrColor,D1
	ADD	D1,D1
	LEA	(A0,D1.W),A0
	MOVE	(A0),D1
	MOVE	D1,D2
	RTS

ShowColSliders
	LEA	ColSliders(PC),A2
	MOVE.L	TextBplPtr,A1
	ADD.L	#3282,A1
	BSR.S	gcpskip
	AND	#$000F,D1
	BSR.S	ShowOneSlider
	MOVE.L	TextBplPtr,A1
	ADD.L	#2842,A1
	BSR.S	gcpskip
	AND	#$00F0,D1
	LSR	#4,D1
	BSR.S	ShowOneSlider
	MOVE.L	TextBplPtr,A1
	ADD.L	#2402,A1
	BSR.S	gcpskip
	AND	#$0F00,D1
	LSR	#8,D1
ShowOneSlider
	CLR.L	(A1)
	CLR.L	4(A1)
	CLR.L	40(A1)
	CLR.L	44(A1)
	CLR.L	80(A1)
	CLR.L	84(A1)
	MOVE	D1,D3
	ADD	D3,D3
	ADD	D3,D3
	MOVE	2(A2,D3.W),D4
	MOVE.B	0(A2,D3.W),00(A1,D4.W)
	MOVE.B	1(A2,D3.W),01(A1,D4.W)
	MOVE.B	0(A2,D3.W),40(A1,D4.W)
	MOVE.B	1(A2,D3.W),41(A1,D4.W)
	MOVE.B	0(A2,D3.W),80(A1,D4.W)
	MOVE.B	1(A2,D3.W),81(A1,D4.W)
	RTS

ColSliders
	dc.w %0000000001111100,0
	dc.w %0000111110000000,1
	dc.w %0000000111110000,1
	dc.w %0000000000111110,1
	dc.w %0000011111000000,2
	dc.w %0000000011111000,2
	dc.w %0000000000011111,2
	dc.w %0000001111100000,3
	dc.w %0000000001111100,3
	dc.w %0000111110000000,4
	dc.w %0000000111110000,4
	dc.w %0000000000111110,4
	dc.w %0000011111000000,5
	dc.w %0000000011111000,5
	dc.w %0000000000011111,5
	dc.w %0000001111100000,6

SelectColor
	CMP	#84,D1
	BHS	Return1
	MOVE.L	TextBplPtr,A0
	LEA	2410(A0),A0
	MOVEQ	#24,D2
slcloop	CLR.L	(A0)
	LEA	40(A0),A0
	DBF	D2,slcloop

	SUB	#82,D0
	DIVU	#13,D0
	SUB	#60,D1
	DIVU	#6,D1
	MOVE	D0,D2
	LSL	#2,D2
	ADD	D1,D2
	MOVE	D2,CurrColor
MarkColor
	BSR	gcpskip
	MOVE.L	A0,UndoColAddr
	MOVE	D1,UndoCol
	BSR	ShowColSliders
	BSR.S	BlockColors
	MOVE	CurrColor,D0
	MOVE	D0,D1
	AND	#$0003,D1
	MULU	#6*40,D1
	MOVE.L	TextBplPtr,A0
	ADD.L	D1,A0
	LEA	2410(A0),A0
	BTST	#2,D0
	BNE.S	slcskip
	MOVE	#$3FF0,(A0)
	MOVE	#$3FF0,240(A0)
	MOVEQ	#4,D0
slclop2	LEA	40(A0),A0
	MOVE	#$2010,(A0)
	DBF	D0,slclop2
	BRA	WaitForButtonUp

slcskip	MOVE.L	#$0001FF80,(A0)
	MOVE.L	#$0001FF80,240(A0)
	MOVEQ	#4,D0
slclop3	LEA	40(A0),A0
	MOVE.L	#$0001FF80,(A0)
	DBF	D0,slclop3
	BRA	WaitForButtonUp

BlockColors
	MOVE.L	TextBplPtr,A0
	LEA	2452(A0),A0
	MOVEQ	#3,D1
suploop2
	MOVEQ	#4,D0
suploop3
	MOVE.B	#$FF,(A0)
	ADD.L	#40,A0
	DBF	D0,suploop3
	ADD.L	#40,A0
	DBF	D1,suploop2
	RTS

ColorGadgets
	CMP	#79,D0
	BHS	SetDefaultCol
	CMP	#33,D0
	BHS.S	CancelCol
	MOVE.L	UndoColAddr,A0
	MOVE	UndoCol,D0
	MOVE	(A0),UndoCol
	MOVE	D0,(A0)
	BSR	ShowColSliders
	BRA	SetScreenColors

CancelCol
	LEA	CanCols(PC),A0
	LEA	ColorTable,A1
	MOVEQ	#7,D0
cacolop	MOVE	(A0)+,(A1)+
	DBF	D0,cacolop
	BSR	ShowColSliders
	BRA	SetScreenColors

CopyCfgData
	LEA	ColorTable,A0
	LEA	CanCols(PC),A1
	MOVEQ	#7,D0
cocclop	MOVE	(A0)+,(A1)+
	DBF	D0,cocclop
	LEA	ModulesPath2,A0
	MOVE	#195,D0
cocclp2	CLR.B	(A0)+
	DBF	D0,cocclp2
	LEA	ModulesPath,A0
	LEA	ModulesPath2,A1
	BSR.S	cocclp3
	LEA	SongsPath,A0
	LEA	SongsPath2,A1
	BSR.S	cocclp3
	LEA	SamplePath,A0
	LEA	SamplePath2,A1
cocclp3	MOVE.B	(A0)+,(A1)+
	BNE.S	cocclp3
	LEA	VUMeterColors,A0
	LEA	SaveColors,A1
	MOVEQ	#40+48-1,D0
cocclp4	MOVE	(A0)+,(A1)+
	DBF	D0,cocclp4
	RTS

UndoCol		dc.w 0
UndoColAddr	dc.l 0
CanCols		dc.w 0,0,0,0,0,0,0,0

SetDefaultCol
	LEA	DefCol,A0
	LEA	ColorTable,A1
	MOVEQ	#7,D0
sdcloop	MOVE	(A0)+,(A1)+
	DBF	D0,sdcloop
	BSR	ShowColSliders
SetScreenColors
	BSR	SetupAnaCols
SetScreenColors2
	LEA	ColorTable,A0
	LEA	CopCol0,A1
	MOVE	(A0),(A1)
	MOVE	2(A0),4(A1)
	MOVE	4(A0),8(A1)
	MOVE	6(A0),12(A1)
	MOVE	8(A0),16(A1)
	MOVE	10(A0),20(A1)
	MOVE	12(A0),24(A1)
	MOVE	14(A0),28(A1)
	MOVE	14(A0),D0
	TST	SamScrEnable
	BEQ.S	sscnosc
	MOVE	8(A0),D0
sscnosc	MOVE	D0,NoteCol
	MOVE	10(A0),D0
	MOVE	D0,D4
	MOVE	#3,FadeX
	BSR.S	FadeCol
	MOVE	D0,32(A1)
	MOVE	D4,36(A1)
	MOVE	D4,D0
	MOVE	#-3,FadeX
	BSR.S	FadeCol
	MOVE	D0,40(A1)
	RTS

FadeCol	MOVE	D0,D1
	MOVE	D0,D2
	MOVE	D0,D3
	LSR	#8,D1
	ADD	FadeX(PC),D1
	BPL.S	redskp
	MOVEQ	#0,D1
redskp	CMP	#15,D1
	BLS.S	redskp2
	MOVEQ	#15,D1
redskp2	AND	#$00F0,D2
	LSR	#4,D2
	ADD	FadeX(PC),D2
	BPL.S	grnskp
	MOVEQ	#0,D2
grnskp	CMP	#15,D2
	BLS.S	grnskp2
	MOVEQ	#15,D2
grnskp2	AND	#$000F,D3
	ADD	FadeX(PC),D3
	BPL.S	bluskp
	MOVEQ	#0,D3
bluskp	CMP	#15,D3
	BLS.S	bluskp2
	MOVEQ	#15,D3
bluskp2	MOVE	D3,D0
	LSL	#4,D2
	OR	D2,D0
	LSL	#8,D1
	OR	D1,D0
	RTS

CurrColor	dc.w	0
FadeX		dc.w	-3

EnterPrintPath
	BSR	StorePtrCol
	BSR	SetWaitPtrCol
	LEA	PrintPath,A6
	MOVE.L	A6,ShowTextPtr
	MOVE.L	A6,TextEndPtr
	ADD.L	#31,TextEndPtr
	MOVE	#12,TextLength
	MOVE	#3694,A4
	BSR	GetTextLine
	BRA	RestorePtrCol

ShowPrintPath
	LEA	PrintPath,A0
	MOVE	#3694,D1
	MOVEQ	#12,D0
	BRA	ShowText3

; Print Song

PrintSong
	LEA	PrintSongText,A0
	BSR	AreYouSure
	BNE	Return1
	BSR	StorePtrCol
	MOVE.L	#PrintPath,D1
	MOVE.L	#1006,D2
	MOVE.L	DOSBase,A6
	JSR	LVOOpen(A6)
	MOVE.L	D0,FileHandle
	BEQ	CantOpenFile
	BSR	SetDiskPtrCol
	LEA	PrintingSongText,A0
	BSR	ShowStatusText
	MOVE.L	FileHandle,D1
	MOVE.L	#SongDumpText,D2
	MOVEQ	#68,D3
	MOVE.L	DOSBase,A6
	JSR	LVOWrite(A6)
	MOVE.L	FileHandle,D1
	MOVE.L	SongDataPtr,D2
	MOVEQ	#20,D3
	JSR	LVOWrite(A6)
	BSR	PrintCRLF
	BSR	PrintCRLF
	BSR	PrintSong2
	BSR	PrintCRLF
	BSR	PrintSong4
	BSR	PrintFormFeed
	MOVE.L	SongDataPtr,A0
	MOVEQ	#0,D0
	MOVE.B	sd_numofpatt(A0),D0
	LEA	sd_pattpos(A0),A0
	MOVEQ	#0,D7
ps_loop	CMP.B	(A0,D0.W),D7
	BGT.S	ps_skip
	MOVE.B	(A0,D0.W),D7
ps_skip	SUBQ	#1,D0
	BPL.S	ps_loop
	MOVEQ	#0,D1
ps_loop2
	MOVEM.L	D1-D7/A0-A6,-(SP)
	BSR	PrintPattern
	MOVEM.L	(SP)+,D1-D7/A0-A6
	TST.L	D0
	BNE.S	ps_skip2
	MOVEM.L	D1/D7,-(SP)
	BSR	PrintFormFeed
	MOVEM.L	(SP)+,D1/D7
	ADDQ	#1,D1
	CMP	D7,D1
	BLO.S	ps_loop2
ps_skip2
	MOVE.L	DOSBase,A6
	MOVE.L	FileHandle,D1
	JSR	LVOClose(A6)
	BSR	ShowAllRight
	BRA	RestorePtrCol

PrintSong2
	MOVEQ	#1,D7
ps2_2	MOVE.L	D7,D0
	LSR.B	#4,D0
	CMP.B	#9,D0
	BLS.S	spujk
	ADDQ.B	#7,D0
spujk	ADD.B	#'0',D0
	MOVE.B	D0,PattXText1
	MOVE.B	D7,D0
	AND.B	#$0F,D0
	CMP.B	#9,D0
	BLS.S	spujk2
	ADDQ.B	#7,D0
spujk2	ADD.B	#'0',D0
	MOVE.B	D0,PattXText2

	MOVE.L	SongDataPtr,A0
	MOVE	D7,D0
	MULU	#30,D0
	LEA	-10(A0,D0.W),A0
	LEA	PpText,A1
	MOVEQ	#21,D0
ps2_loop
	MOVE.B	#' ',(A1)+
	DBF	D0,ps2_loop
	LEA	PpText,A1

	MOVE.L	A0,SavIt
ps2_loop2
	MOVE.B	(A0)+,D0
	BEQ	PrintSong3
	MOVE.B	D0,(A1)+
	BRA.S	ps2_loop2

SavIt	dc.l	0

PrintSong3
	MOVE.L	D7,-(SP)			; pattnum
	MOVE.L	SavIt(PC),A0
	MOVE	22(A0),D0
	ADD	D0,D0
	LEA	Prafs+2+4,A0
	BSR	IntToHexASCII
	MOVE.L	SavIt(PC),A0
	MOVE	26(A0),D0
	ADD	D0,D0
	LEA	Prafs+8+4,A0
	BSR	IntToHexASCII
	MOVE.L	SavIt(PC),A0
	MOVE	28(A0),D0
	ADD	D0,D0
	LEA	Prafs+14+4,A0
	BSR	IntToHexASCII
	MOVE.L	DOSBase,A6
	MOVE.L	FileHandle,D1
	MOVE.L	#PtotText,D2
	MOVEQ	#52,D3
	JSR	LVOWrite(A6)
	MOVE.L	(SP)+,D7
	ADDQ	#1,D7
	CMP	#$0020,D7
	BNE	ps2_2
	RTS

PrintSong4
	MOVE.L	SongDataPtr,A0
	MOVEQ	#0,D7
	MOVE.B	sd_numofpatt(A0),D7
	LEA	sd_pattpos(A0),A0
	MOVEQ	#0,D5
ps4_loop1
	MOVEQ	#0,D6
ps4_loop2
	MOVEQ	#0,D0
	MOVE.B	(A0)+,D0
	MOVE	D0,D1
	LSR	#4,D1
	ADD.B	#$30,D1
	CMP.B	#$39,D1
	BLS.S	ps4_skip
	ADDQ.B	#7,D1
ps4_skip
	AND.B	#15,D0
	ADD.B	#$30,D0
	CMP.B	#$39,D0
	BLS.S	ps4_skip2
	ADDQ.B	#7,D0
ps4_skip2
	LEA	PnText,A1
	MOVE.B	D1,(A1)+
	MOVE.B	D0,(A1)
	MOVEM.L	D5-D7/A0,-(SP)
	MOVE.L	DOSBase,A6
	MOVE.L	FileHandle,D1
	MOVE.L	#PnText,D2
	MOVEQ	#4,D3
	JSR	LVOWrite(A6)
	MOVEM.L	(SP)+,D5-D7/A0
	ADDQ	#1,D5
	CMP	D5,D7
	BEQ	Return1
	ADDQ	#1,D6
	CMP	#$0010,D6
	BNE.S	ps4_loop2
	MOVEM.L	D5-D7/A0,-(SP)
	BSR.S	PrintCRLF
	MOVEM.L	(SP)+,D5-D7/A0
	BRA.S	ps4_loop1

PrintCRLF
	MOVE.L	DOSBase,A6
	MOVE.L	FileHandle,D1
	MOVE.L	#CRLF_Text,D2
	MOVEQ	#2,D3
	JSR	LVOWrite(A6)
	RTS

PrintFormFeed
	MOVE.L	DOSBase,A6
	MOVE.L	FileHandle,D1
	MOVE.L	#FF_Text,D2
	MOVEQ	#1,D3
	JSR	LVOWrite(A6)
	RTS

PrintPattern
	MOVE.L	D1,D6 ; D1=pattern number
	DIVU	#10,D6
	ADD.B	#'0',D6
	MOVE.B	D6,PattNumText1
	SWAP	D6
	ADD.B	#'0',D6
	MOVE.B	D6,PattNumText2
	MOVEM.L	D0-D7/A0-A6,-(SP)
	MOVE.L	FileHandle,D1
	MOVE.L	#PatternNumText,D2
	MOVEQ	#18,D3
	MOVE.L	DOSBase,A6
	JSR	LVOWrite(A6)
	MOVEM.L	(SP)+,D0-D7/A0-A6

	MOVE.L	D1,D6
	MOVE.L	SongDataPtr,A6
	LEA	sd_patterndata(A6),A6
	LSL.L	#8,D6
	LSL.L	#2,D6
	ADD.L	D6,A6
	CLR.L	PPattPos
	MOVEQ	#0,D6
pp_posloop
	MOVEQ	#0,D7
	MOVE	#2,TextLength
	MOVE.L	PPattPos,D1
	LEA	PattPosText,A5
	DIVU	#10,D1
	ADD.B	#'0',D1
	MOVE.B	D1,(A5)+
	CLR	D1
	SWAP	D1
	ADD.B	#'0',D1
	MOVE.B	D1,(A5)+
	ADDQ.L	#5,A5
pp_noteloop
	MOVEQ	#0,D0
	MOVEQ	#0,D1
	MOVE	#3,TextLength
	MOVE	(A6),D1
	AND	#$0FFF,D1
	LEA	PeriodTable,A0
pp_findloop
	CMP	0(A0,D0.L),D1
	BEQ	PrintNote
	ADDQ.L	#2,D0
	BRA.S	pp_findloop

PrintNote
	ADD.L	D0,D0
	ADD.L	NoteNamesPtr,D0
	MOVE.L	D0,A0
	MOVE.L	(A0),(A5)+
	CMP.B	#'б',-3(A5)
	BNE.S	prnoxyz
	MOVE.B	#'b',-3(A5)
prnoxyz	ADDQ.L	#1,A5
	MOVEQ	#0,D0
	MOVE	(A6),D0
	AND	#$F000,D0
	LSR	#8,D0
	LSL.L	#1,D0
	LEA	FastHexTable,A0
	ADD.L	D0,A0
	MOVE.B	(A0),(A5)+
	MOVEQ	#0,D0
	MOVE.B	2(A6),D0
	LSL.L	#1,D0
	LEA	FastHexTable,A0
	ADD.L	D0,A0
	MOVE	(A0),(A5)+
	MOVEQ	#0,D0
	MOVE.B	3(A6),D0
	LSL.L	#1,D0
	LEA	FastHexTable,A0
	ADD.L	D0,A0
	MOVE	(A0),(A5)+
	ADDQ.L	#4,A5
	ADDQ.L	#4,A6
	ADDQ.L	#1,D7
	CMP.L	#4,D7
	BNE	pp_noteloop
	ADDQ.L	#1,PPattPos
	MOVEM.L	D0-D7/A0-A6,-(SP)
	MOVE.L	DOSBase,A6
	MOVE.L	FileHandle,D1
	MOVE.L	#PnText2,D2
	MOVEQ	#68,D3
	JSR	LVOWrite(A6)
	BSR	PrintCRLF
	MOVEM.L	(SP)+,D0-D7/A0-A6
	BTST	#2,$DFF016
	BEQ.S	NegativeReturn
	ADDQ.L	#1,D6
	CMP.L	#64,D6
	BNE	pp_posloop
	MOVEQ	#0,D0
	RTS

NegativeReturn
	MOVEQ	#-1,D0
	RTS

PositiveReturn
	MOVEQ	#0,D0
	RTS

;---- Setup2 ----

Setup2	BSR	WaitForButtonUp
	MOVE	#7,CurrScreen
	CLR	LastSetupScreen
	ST	DisableAnalyzer
	ST	NoSampleInfo
	BSR	Clear100Lines
	MOVE.L	SetupMemPtr,D0
	BNE	set2skp
	BSR	SaveMainPic
	BEQ	ExitSetup
set2skp	BSR	DecompactSetup2
	BSR	SetScreenColors
refrsh2	BSR	ShowIntMode
	BSR	ShowTempo
	BSR	ShowSpeed
	BSR	ShowColEdit
	BSR	ShowRainbow
	BSR	GetColPos
	BSR	ShowColSliders
	BSR	ShowS2Modules
	BSR	ShowS2Songs
	BSR	ShowS2Samples
	BSR	ShowS2PTPath
	BSR	ShowS2MaxPLST
	BSR	ShowS2DMAWait
	BSR	ShowS2TuneNote
	BSR	ShowS2SalvAddr
	BRA	ShowS2T

CheckSetup2Gadgs
	MOVEM.W	MouseX2,D0/D1
	CMP	#210,D0
	BHS	Setup2Menu3
	CMP	#108,D0
	BHS.S	Setup2Menu2
;---- Menu 1 ----
	CMP	#11,D1
	BLS	ToggleIntMode
	CMP	#22,D1
	BLS	ChangeTempo
	CMP	#33,D1
	BLS	ChangeSpeed
	CMP	#44,D1
	BLS	ToggleColEdit
	CMP	#55,D1
	BLS	RotOrSpread
	CMP	#66,D1
	BLS	SetRed2
	CMP	#77,D1
	BLS	SetGreen2
	CMP	#88,D1
	BLS	SetBlue2
	CMP	#99,D1
	BLS	ColorGadgets2
	RTS

Setup2Menu2
	CMP	#11,D1
	BLS	Set2ModPath
	CMP	#22,D1
	BLS	Set2SongPath
	CMP	#33,D1
	BLS	Set2SamPath
	CMP	#44,D1
	BLS	Set2PTPath
	CMP	#55,D1
	BLS	SetS2MaxPLST
	CMP	#66,D1
	BLS	SetS2DMAWait
	CMP	#77,D1
	BLS	SetS2TuneNote
	CMP	#88,D1
	BLS	SetS2SalvAddr
	CMP	#99,D1
	BLS	RecoverSong
	RTS

Setup2Menu3
	CMP	#11,D1
	BLS	ExitOrDefault
	CMP	#22,D1
	BLS	ToggleOverride
	CMP	#33,D1
	BLS	ToggleNosamples
	CMP	#44,D1
	BLS	ToggleBlankZero
	CMP	#55,D1
	BLS	ToggleShowDirs
	CMP	#66,D1
	BLS	ToggleShowPublic
	CMP	#77,D1
	BLS	ToggleCutToBuf
	CMP	#88,D1
	BLS	ToggleIFFLoop
	CMP	#99,D1
	BLS	ToggleHH
	RTS

ExitOrDefault
	CMP	#265,D0
	BLS.S	SetS2Default
	CMP	#306,D0
	BHS	Setup
	BRA	ExitSetup

SetS2Default
	LEA	SetDefaultsText(PC),A0
	BSR	AreYouSure
	BNE	Return1
	LEA	DefaultSetupData,A0
	LEA	DefaultSongsPath,A2
	LEA	SongsPath,A1
	MOVEQ	#95,D0
ss2dela	MOVE.B	(A2)+,(A1)+
	DBF	D0,ss2dela
	LEA	DefaultPTPath,A2
	LEA	PTPath,A1
	MOVEQ	#31,D0
ss2delb	MOVE.B	(A2)+,(A1)+
	DBF	D0,ss2delb
	LEA	DefaultMaxPLSTEntries,A2
	MOVE	(A2),MaxPLSTEntries
	LEA	DefaultDMAWait,A2
	MOVE	(A2),DMAWait
	LEA	DefaultTuneNote,A2
	MOVE.L	(A2),TuneNote
	LEA	DefaultSalvageAddress,A2
	LEA	SalvageAddress,A1
	MOVE.L	(A2)+,(A1)+
	MOVE.L	(A2),(A1)
	BRA	refrsh2

SetDefaultsText
	dc.b "Set defaults?",0

ToggleIntMode
	BSR	ResetMusicInt
	EOR.B	#1,IntMode
	BSR	SetMusicInt
	BSR	SetTempo
	BSR	WaitForButtonUp
ShowIntMode
	LEA	VBlankText(PC),A0
	TST.B	IntMode
	BEQ.S	simskip
	LEA	CIAText(PC),A0
simskip	MOVEQ	#6,D0
	MOVE	#167,D1
	BRA	ShowText3

VBlankText	dc.b "VBLANK"
CIAText		dc.b " CIA  "

ChangeSpeed
	MOVEQ	#0,D1
	CMP	#94,D0
	BHS.S	SpeedDown
	CMP	#80,D0
	BHS.S	SpeedUp
	RTS

SpeedUp	MOVE	DefaultSpeed,D1
	ADDQ.B	#1,D1
	CMP.B	#$FF,D1
	BLS.S	spedup2
	MOVE	#$FF,D1
spedup2	MOVE	D1,DefaultSpeed
	MOVE.L	D1,CurrSpeed
	BSR.S	ShowSpeed
	JSR	Wait_4000
	JMP	Wait_4000
ShowSpeed
	MOVE	#608+440,TextOffset
	MOVE	DefaultSpeed,WordNumber
	JMP	PrintHexByte

SpeedDown
	MOVE	DefaultSpeed,D1
	SUB.B	#1,D1
	CMP.B	#1,D1
	BHS.S	spedup2
	MOVEQ	#1,D1
	BRA.S	spedup2


ToggleOverride
	EOR.B	#1,OverrideFlag
	BRA.S	ShowS2T
ToggleNosamples
	EOR.B	#1,NosamplesFlag
	BRA.S	ShowS2T
ToggleBlankZero
	EOR.B	#1,BlankZeroFlag
	BSR.S	ShowS2T
	BRA	RedrawPattern
ToggleShowDirs
	EOR.B	#1,ShowDirsFlag
	BRA.S	ShowS2T
ToggleShowPublic
	EOR.B	#1,ShowPublicFlag
	MOVE	#1,UpdateFreeMem
	BRA.S	ShowS2T
ToggleCutToBuf
	EOR.B	#1,CutToBufFlag
	BRA.S	ShowS2T
ToggleIFFLoop
	EOR.B	#1,IFFLoopFlag
	BRA.S	ShowS2T
ToggleHH
	EOR.B	#1,HHFlag

ShowS2T	CLR.B	RawKeyCode
	CMP	#7,CurrScreen
	BNE	Return1
	LEA	OverrideFlag,A4
	MOVE	#3,TextLength
	MOVEQ	#7,D7
	MOVE	#636,D6
sstloop2
	MOVE	D6,TextOffset
	LEA	ToggleOFFText,A0
	TST.B	(A4)+
	BEQ.S	sstskip2
	LEA	ToggleONText,A0
sstskip2
	BSR	ShowText2
	ADD	#440,D6
	DBF	D7,sstloop2
	BRA	WaitForButtonUp

ShowS2Modules
	MOVE	#177,D1
	LEA	ModulesPath,A0
s2path	MOVEQ	#9,D0
	BRA	ShowText3

ShowS2Songs
	MOVE	#177+440,D1
	LEA	SongsPath,A0
	BRA.S	s2path

ShowS2Samples
	MOVE	#177+880,D1
	LEA	SamplePath,A0
	BRA.S	s2path

ShowS2PTPath
	MOVE	#177+1320,D1
	LEA	PTPath,A0
	BRA.S	s2path


Set2ModPath
	BSR	StorePtrCol
	BSR	SetWaitPtrCol
	LEA	ModulesPath,A6
	MOVE.L	A6,ShowTextPtr
	MOVE.L	A6,TextEndPtr
	ADD.L	#31,TextEndPtr
	MOVE	#9,TextLength
	MOVE	#177,A4
	BSR	GetTextLine
	BRA	RestorePtrCol

Set2SongPath
	BSR	StorePtrCol
	BSR	SetWaitPtrCol
	LEA	SongsPath,A6
	MOVE.L	A6,ShowTextPtr
	MOVE.L	A6,TextEndPtr
	ADD.L	#31,TextEndPtr
	MOVE	#9,TextLength
	MOVE	#177+440,A4
	BSR	GetTextLine
	BRA	RestorePtrCol

Set2SamPath
	BSR	StorePtrCol
	BSR	SetWaitPtrCol
	LEA	SamplePath,A6
	MOVE.L	A6,ShowTextPtr
	MOVE.L	A6,TextEndPtr
	ADD.L	#31,TextEndPtr
	MOVE	#9,TextLength
	MOVE	#177+880,A4
	BSR	GetTextLine
	BRA	RestorePtrCol

Set2PTPath
	BSR	StorePtrCol
	BSR	SetWaitPtrCol
	LEA	PTPath,A6
	MOVE.L	A6,ShowTextPtr
	MOVE.L	A6,TextEndPtr
	ADD.L	#31,TextEndPtr
	MOVE	#9,TextLength
	MOVE	#177+1320,A4
	BSR	GetTextLine
	BRA	RestorePtrCol

SetS2MaxPLST
	CMP	#199,D0
	BHS.S	S2PLSTd
	CMP	#188,D0
	BHS.S	S2PLSTu
	RTS
S2PLSTu	MOVE	MaxPLSTEntries,D0
	ADD	#100,D0
	CMP	#9999,D0
	BLS.S	s2pu
	MOVE	#9999,D0
s2pu	MOVE	D0,MaxPLSTEntries
	BSR.S	ShowS2MaxPLST
	JMP	Wait_4000

S2PLSTd	MOVEQ	#0,D0
	MOVE	MaxPLSTEntries,D0
	ADDQ	#1,D0
	DIVU	#100,D0
	SUBQ	#1,D0
	BPL.S	s2pd
	MOVEQ	#0,D0
	BRA.S	s2pu
s2pd	MULU	#100,D0
	BRA.S	s2pu

ShowS2MaxPLST
	MOVE	MaxPLSTEntries,WordNumber
	MOVE	#1939,TextOffset
	BRA	Print4DecDigits

SetS2DMAWait
	CMP	#199,D0
	BHS.S	S2dwd
	CMP	#188,D0
	BHS.S	S2dwu
	RTS
S2dwu	MOVE	DMAWait,D0
	ADDQ	#1,D0
	BTST	#2,$DFF016
	BNE.S	s2npu
	ADD	#9,D0
s2npu	CMP	#9999,D0
	BLS.S	s2du
	MOVE	#9999,D0
s2du	MOVE	D0,DMAWait
	BSR.S	ShowS2DMAWait
	JMP	Wait_4000

S2dwd	MOVE	DMAWait,D0
	SUBQ	#1,D0
	BTST	#2,$DFF016
	BNE.S	s2npd
	SUB	#9,D0
s2npd	TST	D0
	BPL.S	s2du
	MOVEQ	#0,D0
	BRA.S	s2du

ShowS2DMAWait
	MOVE	DMAWait,WordNumber
	MOVE	#2379,TextOffset
	BRA	Print4DecDigits

SetS2TuneNote
	CMP	#187,D0
	BHS.S	ss2tvol
	MOVE	#2820,D1
	MOVEQ	#3,D0
	LEA	SpcNoteText,A0
	BSR	ShowText3
	MOVE	#3,SamNoteType
	MOVE.L	#TuneNote,SplitAddress
	BRA	WaitForButtonUp

ShowS2TuneNote
	CMP	#7,CurrScreen
	BNE	Return1
	MOVE.L	NoteNamesPtr,A4
	MOVE	TuneNote,D0
	LSL	#2,D0
	LEA	(A4,D0.W),A0
	MOVEQ	#4,D0
	MOVE	#2820,D1
	BSR	ShowText3
	MOVE	TToneVol,WordNumber
	MOVE	#2824,TextOffset
	BRA	PrintHexByte

ss2tvol	MOVE	#2824,TextOffset
	BSR	GetHexByte
	MOVE	D0,TToneVol
	BRA.S	ShowS2TuneNote

SetS2SalvAddr
	BRA	ShowNotImpl
	BSR	StorePtrCol
	BSR	SetWaitPtrCol
	LEA	SalvageAddress,A6
	MOVE.L	A6,ShowTextPtr
	MOVE.L	A6,TextEndPtr
	ADD.L	#6,TextEndPtr
	MOVE	#6,TextLength
	MOVE	#3260,A4
	MOVE.B	#5,EnterTextFlag
	BSR	GetTextLine
	CLR.B	EnterTextFlag
	BSR	RestorePtrCol
ShowS2SalvAddr
	LEA	SalvageAddress,A0
	MOVEQ	#6,D0
	MOVE	#3260,D1
	BRA	ShowText3

RecoverSong
	BRA	ShowNotImpl
	LEA	RecoverSongText(PC),A0
	BSR	AreYouSure
	BNE	Return1
	BSR	DoClearSong
	BSR	ClrSampleInfo
	BSR.S	FindAdr
	MOVE.L	D0,A0
	MOVE.L	SongDataPtr,A1
	MOVE.L	#70716,D0
recloop	MOVE.B	(A0)+,(A1)+
	SUBQ.L	#1,D0
	BNE.S	recloop
	BRA	RedrawPattern

FindAdr	LEA	SalvageAddress+6,A0
	BSR	HexToInteger
	MOVE	D0,D3
	MOVEQ	#0,D0
	BSR	HexToInteger2
	SWAP	D0
	OR	D3,D0
	RTS

RecoverSongText	dc.b	"Recover Song?",0

ToggleColEdit
	CMP	#79,D0
	BHS	SelectColor2
	CLR	SpreadFlag
	LEA	VUMeterColors,A0
	MOVEQ	#48,D0
	CMP.L	TheRightColors(PC),A0
	BNE.S	tced2
	LEA	AnalyzerColors,A0
	MOVEQ	#36,D0
tced2	MOVE.L	A0,TheRightColors
	MOVE	D0,ColorsMax
	CMP	RainbowPos(PC),D0
	BHI.S	tced3
	CLR	RainbowPos
tced3	BSR	ShowRainbow
	BSR.S	ShowColEdit
	BRA	WaitForButtonUp
ShowColEdit
	LEA	cedtxt1(PC),A0
	LEA	VUMeterColors,A1
	CMP.L	TheRightColors(PC),A1
	BEQ.S	shcoed
	LEA	cedtxt2(PC),A0
shcoed	MOVEQ	#6,D0
	MOVE	#1483,D1
	BRA	ShowText3

cedtxt1	dc.b "VU-MTR"
cedtxt2 dc.b "ANALYZ"

RotOrSpread
	CMP	#16,D0
	BLO.S	RotColUp
	CMP	#32,D0
	BLO.S	RotColDown
	CMP	#79,D0
	BHS	SelectColor2
	BRA	SpreadColors

RotColUp
	CLR	SpreadFlag
	MOVE.L	TheRightColors(PC),A0
	MOVE	(A0),D0
	MOVE	ColorsMax(PC),D1
	SUBQ	#2,D1
rocoup1	MOVE	2(A0),(A0)+
	DBF	D1,rocoup1
	MOVE	D0,(A0)
rocoup2	BSR	GetColPos
	BSR	ShowColSliders
	BSR	ShowRainbow
	BRA	SetupVUCols

RotColDown
	CLR	SpreadFlag
	MOVE.L	TheRightColors(PC),A0
	MOVE	ColorsMax(PC),D1
	ADD	D1,A0
	ADD	D1,A0
	MOVE	-(A0),D0
	SUBQ	#2,D1
rocodn1	MOVE	-2(A0),(A0)
	SUBQ.L	#2,A0
	DBF	D1,rocodn1
	MOVE	D0,(A0)
	BRA.S	rocoup2

SpreadColors
	MOVE	RainbowPos,SpreadFrom
	MOVE	#1,SpreadFlag
	RTS

SpreadFrom	dc.w 0
SpreadFlag	dc.w 0

ColorGadgets2
	CLR	SpreadFlag
	CMP	#79,D0
	BHS.S	SetDefaultCol2
	CMP	#33,D0
	BHS.S	CancelCol2
	MOVE.L	UndoColAddr,A0
	MOVE	UndoCol,D1
	MOVE	(A0),UndoCol
	MOVE	D1,(A0)
	BRA	rocoup2

SetDefaultCol2
	MOVE.L	TheRightColors(PC),A0
	MOVE.L	A0,A1
	SUB.L	#SetupData,A1
	ADD.L	#DefaultSetupData,A1
sedeco4	MOVE	ColorsMax,D0
	BRA.S	sedeco3
sedeco2	MOVE	(A1)+,(A0)+
sedeco3	DBF	D0,sedeco2
	BRA	rocoup2

CancelCol2
	MOVE.L	TheRightColors(PC),A0
	MOVE.L	A0,A1
	SUB.L	#VUMeterColors,A1
	ADD.L	#SaveColors,A1
	BRA.S	sedeco4

GetColAddr
	MOVE.L	TheRightColors(PC),A0
	MOVE	RainbowPos,D1
	ADD	D1,D1
	LEA	(A0,D1.W),A0
	MOVE	(A0),D1
	MOVE	D1,D2
	RTS

SetRed2	CMP	#79,D0
	BHS	SelectColor2
set2r2	BSR	GetColPos
	AND	#$0F00,D2
	LSR	#8,D2
	CMP.B	D2,D0
	BEQ.S	setrsk2
	AND	#$00FF,D1
	LSL	#8,D0
	OR	D0,D1
	MOVE	D1,(A0)
	BSR	ShowColSliders
	BSR	ShowRainbow
	BSR	SetupVUCols
setrsk2	BTST	#6,$BFE001
	BEQ.S	set2r2
	RTS

SetGreen2
	CMP	#79,D0
	BHS	SelectColor2
set2g2	BSR	GetColPos
	AND	#$00F0,D2
	LSR	#4,D2
	CMP.B	D2,D0
	BEQ.S	setgsk2
	AND	#$0F0F,D1
	LSL	#4,D0
	OR	D0,D1
	MOVE	D1,(A0)
	BSR	ShowColSliders
	BSR	ShowRainbow
	BSR	SetupVUCols
setgsk2	BTST	#6,$BFE001
	BEQ.S	set2g2
	RTS

SetBlue2
	CMP	#79,D0
	BHS.S	SelectColor2
set2b2	BSR	GetColPos
	AND	#$000F,D2
	CMP.B	D2,D0
	BEQ.S	setbsk2
	AND	#$0FF0,D1
	OR	D0,D1
	MOVE	D1,(A0)
	BSR	ShowColSliders
	BSR	ShowRainbow
	BSR	SetupVUCols
setbsk2	BTST	#6,$BFE001
	BEQ.S	set2b2
	RTS

SelectColor2
	MOVEQ	#0,D7
setcolp	BTST	#6,$BFE001
	BNE.S	ChkSpread
	MOVE	ColorsMax(PC),D0
	MOVE	MouseY,D1
	CMP	D7,D1
	BEQ.S	setcolp
	MOVE	D1,D7
	CMP	#37,D1
	BHS.S	setcoly
	MOVEQ	#37,D1
setcoly	SUB	#37,D1
	CMP	D0,D1
	BLT.S	setcol2
	MOVE	D0,D1
	SUBQ	#1,D1
setcol2	MOVE	D1,RainbowPos
	BSR	ShowRainbow
	BSR	GetColPos
	MOVE.L	A0,UndoColAddr
	MOVE	D1,UndoCol
	BSR	ShowColSliders
	BRA	setcolp

ChkSpread
	TST	SpreadFlag
	BEQ	Return1
	CLR	SpreadFlag
	BSR	GetColPos
	MOVE	SpreadFrom,D0
	MOVE	RainbowPos,D1
	CMP	D1,D0
	BLO.S	chkspr2
	EXG	D0,D1
chkspr2	MOVE	D1,D4
	SUB	D0,D4
	CMP	#1,D4
	BLS	Return1
	MOVE.L	D4,A2
	ADD	D4,D4
	MOVE.L	TheRightColors(PC),A0
	MOVE.L	A0,A1
	ADD	D0,D0
	ADD	D1,D1
	LEA	(A0,D0.W),A0	; 1st col
	MOVE	(A0),D2
	LEA	(A1,D1.W),A1
	MOVE	(A1),D3		; 2nd col
	MOVEQ	#0,D5

sprdlop	MOVE	D2,D0 ; red
	LSR	#8,D0
	MOVE	D3,D1
	LSR	#8,D1
	BSR	ColCrossfade
	LSL	#8,D0
	MOVE	D0,D7
	MOVE	D2,D0 ; green
	LSR	#4,D0
	AND	#$000F,D0
	MOVE	D3,D1
	LSR	#4,D1
	AND	#$000F,D1
	BSR	ColCrossfade
	LSL	#4,D0
	OR	D0,D7
	MOVE	D2,D0 ; blue
	AND	#$000F,D0
	MOVE	D3,D1
	AND	#$000F,D1
	BSR	ColCrossfade
	OR	D0,D7
	ADDQ	#2,D5
	MOVE	D7,(A0)+
	CMP.L	A1,A0
	BLO	sprdlop
	BRA	rocoup2

ColCrossfade
	MOVE	D4,D6
	SUB	D5,D6
	MULU	D6,D0
	ADD.L	A2,D0
	MULU	D5,D1
	ADD	D1,D0
	DIVU	D4,D0
	CMP	#15,D0
	BLS	Return1
	MOVEQ	#15,D0
	RTS

ShowRainbow
	MOVE.L	TextBplPtr,A0
	LEA	1490(A0),A0
	MOVEQ	#0,D1
	MOVE.L	#$00FFE000,D2
	MOVE	RainbowPos,D3
rainlop	MOVE.L	D2,D0
	CMP	D3,D1
	BNE.S	rainsk1
	MOVE.L	#$1EFFEF00,D0
rainsk1	MOVE.L	D0,(A0)
	LEA	40(A0),A0
	ADDQ	#1,D1
	CMP	#48,D1
	BLO.S	rainlop
	LEA	CopListAnalyzer,A0
	MOVE.L	TheRightColors(PC),A1
	MOVE	#$5107,D0
	MOVEQ	#47,D1
	MOVEQ	#0,D2
rainlp2	MOVE	D0,(A0)+
	MOVE	#$FFFE,(A0)+
	MOVE	#$018E,(A0)+
	CMP	ColorsMax(PC),D2
	BLO.S	rainsk2
	CLR	(A0)+
	BRA.S	rainsk3
rainsk2	MOVE	(A1)+,(A0)+
rainsk3	ADD	#$0100,D0
	ADDQ	#1,D2
	DBF	D1,rainlp2
	MOVEQ	#63,D0
rainlp3	MOVE.L	#$01B80000,(A0)+
	DBF	D0,rainlp3
	RTS

RainbowPos	dc.w	0
TheRightColors	dc.l	0
ColorsMax	dc.w	48






;---- PT Decompacter ----
; A0...source packed screen		| A1...pointer to raw screen
; D0...length of packed data
;
Decompact
	MOVE.L	A0,CompPtr
	MOVE.L	D0,CompLen
	BSR.S	FreeDecompMem
	MOVE.L	CompPtr(PC),A0
	CMP.L	#'FORM',(A0)		;if IFF doit else old pak format
	BEQ	DecompactIFF
	MOVE.L	(A0),D0
	MOVE.L	D0,DecompMemSize
	MOVEQ	#0,D1
	MOVE.L	4.W,A6
	JSR	LVOAllocMem(A6)
	MOVE.L	D0,DecompMemPtr
	BEQ	OutOfMemErr
	MOVE.L	D0,A1
	MOVE.L	CompPtr(PC),A0
	MOVE.L	CompLen(PC),D0
	ADDQ.L	#4,A0
	SUBQ.L	#4,D0
dcmloop	MOVE.B	(A0)+,D1
	CMP.B	#181,D1
	BEQ.S	DecodeIt
	MOVE.B	D1,(A1)+
decom2	SUBQ.L	#1,D0
	CMP.L	#0,D0
	BGT.S	dcmloop
	MOVE.L	DecompMemPtr,A1
	MOVEQ	#-1,D0
	RTS

DecodeIt
	MOVEQ	#0,D1
	MOVE.B	(A0)+,D1
	MOVE.B	(A0)+,D2
dcdloop	MOVE.B	D2,(A1)+
	DBF	D1,dcdloop
	SUBQ.L	#2,D0
	BRA.S	decom2

FreeDecompMem
	MOVE.L	DecompMemPtr,D0
	BEQ	.nomem
	MOVE.L	D0,A1
	MOVE.L	DecompMemSize,D0
	MOVE.L	4.W,A6
	JSR	LVOFreeMem(A6)
	CLR.L	DecompMemPtr
.nomem	RTS

CompPtr	dc.l	0
CompLen	dc.l	0

; --- if crunched IFF then go 4 it!!

DecompactIFF
	MOVE.L	A0,pic_buf
	MOVEM.L	D0-7/A0-A6,-(SP)
	BSR	iff_search
	MOVEM.L	(SP)+,D0-7/A0-6
	MOVE	width_bytes(pc),D0
	MULU	height(pc),D0
	MULU	planes_num(pc),D0
	MOVE.L	D0,DecompMemSize
	MOVE.L	#$10000,D1
	MOVE.L	4.W,A6
	JSR	LVOAllocMem(A6)
	MOVE.L	D0,DecompMemPtr
	BEQ	OutOfMemErr
	MOVE.L	D0,bitplane		;store where to decompact into
	BSR	colors_init
	BSR	unpacker
	MOVE.L	DecompMemPtr,A1
	MOVEQ	#-1,D0
	RTS

*-------------------------------------------------------------------*
;   this de-packs an iff file into bitmap using pic_buf

doiff	bsr	iff_search
	bsr	colors_init
	bsr	unpacker
	rts

********************** resulting output info..
width		dc.w	320		;pixels
height		dc.w	200
modes		dc.l	$12345678
planes		dcb.l	6,0
bitplane	dc.l	$40000		;start address of output bitmap
color_map	dcb.w	64,0

**********************
iff_search
	move.l	pic_buf(pc),a0		;address of IFF file
	add.l	#4+8,a0
	move.l	a0,bmhd_chunk
	move.l	4(a0),d0
	add.l	d0,a0
	addq.l	#8,a0
	move.l	a0,cmap_chunk
iff_l1
	move.l	4(a0),d0
	add.l	d0,a0
	addq.l	#8,a0
	move.l	#"BODY",d1
	cmp.l	(a0),d1
	bne.s	iff_l1
	move.l	a0,body_chunk
	move.l	bmhd_chunk(pc),a2
	move.l	a2,a1
	add.l	#16,a1
	moveq	#0,d0
	move.b	(a1),d0
	cmp	#6,d0
	blt.s	iff_cont
	moveq	#6,d0
iff_cont
	move	d0,planes_num
	move.l	a2,a1
	add.l	#18,a1
	move.b	(a1),comp_flag
	move.l	a2,a1
	addq.l	#8,a1
	moveq	#0,d0
	move	(a1)+,d0
	move	d0,width
	moveq	#0,d3
	cmp	#640,d0
	blt.s	iff_cont3
	or.w	#$8000,d3
iff_cont3
	move	d0,d1
	and	#7,d1
	beq.s	iff_cont2
	or	#8,d0
iff_cont2
	lsr	#3,d0			;divu #8,D0
	move	d0,width_bytes
	moveq	#0,d0
	move	(a1),d0
	move	d0,height
	cmp	#400,d0
	blt.s	iff_cont4
	or	#4,d3
iff_cont4
	move	d3,modes
	rts

******** colors initialize ********
colors_init
	move.l	cmap_chunk(pc),a0
	addq.l	#8,a0
	lea	color_map(pc),a1
	moveq	#31,d7			;number of colors!!
co_loop1
	moveq	#0,d0
	move.b	(a0)+,d0
	and.b	#$f0,d0
	lsl.w	#4,d0
	move.b	(a0)+,d0
	and.w 	#$0ff0,d0
	moveq	#0,d1
	move.b	(a0)+,d1
	lsr.b	#4,d1
	and.b	#$0f,d1
	or.b	d1,d0
	move.w	d0,(a1)+
	dbf	d7,co_loop1
	rts

*****************************************************************
*нннннннннннн         U N P A C K E R  (fast) ннннннннннннннннннн
*****************************************************************
unpacker
	lea	planes(pc),a2
	moveq	#5,d7
	move.l	bitplane(pc),d6
	moveq	#0,d0
	move	width_bytes(pc),d0
	mulu	height(pc),d0
fillad	move.l	d6,(a2)+
	add.l	d0,d6
	dbf	d7,fillad

	lea	planes(pc),a2
	move.l	body_chunk(pc),a0
	lea	4(a0),a0
	move.l	(a0),d7
	move.l	a0,a3
	add.l	d7,a3
	lea	2(a3),a3
	lea	4(a0),a0
	move	planes_num(pc),d2	;number of planes loop cntr
unp_loop	cmp.l	a3,a0
		bgt.s	unpacker-2
		moveq	#0,d3
pic_loop1	move.l	d3,d4
		lsl	#2,d4		;mulu #4,d4
		move.l	(a2,d4.w),a5
		bsr.s	unpack_row
		move.l	a5,(a2,d4.w)
		addq	#1,d3		;add 1 to plane count
		cmp	d2,d3		;if hit max then stop end
		blt.s	pic_loop1
		move.l	bmhd_chunk(pc),a5
		and.b	#1,17(a5)
		beq.s	unp_loop
		lea	mask_dummy(pc),a5
		bsr.s	unpack_row
		bra.s	unp_loop
unpack_row	move.l	d2,-(sp)
		move	width_bytes(pc),d2
unp_loop1	cmp.l	a3,a0
		bgt.s	unpack_row_end
		tst	d2
		beq.s	unpack_row_end
		moveq	#0,d0
		tst	comp_flag
		bne.s	unp_comp
		move	width_bytes(pc),d0
		subq	#1,d0
		bra.s	unp_loop2

unp_comp	move.b	(a0)+,d0	;copy it
		bmi.s	packed
		and	#$7f,d0
unp_loop2	sub	d0,d2
		subq	#1,d2
unp_loop2a	move.b	(a0)+,(a5)+
		dbf	d0,unp_loop2a
		bra.s	unp_loop1

packed		neg.b	d0		;fill it
		and	#$7f,d0
		move.b	(a0)+,d1
unp_loop3	sub	d0,d2
		subq	#1,d2
unp_loop3a	move.b	d1,(a5)+
		dbf	d0,unp_loop3a
		bra.s	unp_loop1
unpack_row_end	move.l (sp)+,d2
unpack_end	rts

*------------- chunk-Data ---------------*
bmhd_chunk	dc.l 0			;address of IFF file + 12
cmap_chunk	dc.l 0			;address of Color MAP
body_chunk	dc.l 0			;address of the packed BitMAP
planes_num	dc.l 0
comp_flag	dc.l 0
width_bytes	dc.w 0			;width of screen   pixels/8
pic_buf		dc.l 0
mask_dummy	dcb.l 	32,0



;---- Position Insert/Delete Gadgets ----

PosInsDelGadgs
	MOVE	MouseY2,D0
	CMP	#11,D0
	BHS	.ret
	MOVE	MouseX2,D0
	CMP	#62,D0
	BHS	.ret
	CMP	#51,D0
	BHS.S	PosDelete
	CMP	#40,D0
	BHS.S	PosInsert
.ret	RTS

PosInsert
	MOVE.L	SongDataPtr,A0
	LEA	sd_pattpos(A0),A0
	ADD.L	#126,A0
	MOVEQ	#127,D0
	MOVE.L	CurrPos,D1
	AND.L	#127,D1
posinloop
	MOVE.B	(A0),1(A0)
	SUBQ.L	#1,A0
	SUBQ.L	#1,D0
	CMP.L	D1,D0
	BHI.S	posinloop
	MOVE.B	PatternNumber+3,1(A0)
	BSR	PositionUp
	CLR	UpOrDown
	BSR	SongLengthGadg
	BRA	WaitForButtonUp

PosDelete
	MOVE.L	SongDataPtr,A0
	LEA	sd_pattpos(A0),A0
	MOVE.L	CurrPos,D0
	AND.L	#127,D0
	ADD.L	D0,A0
posdeloop
	MOVE.B	1(A0),(A0)
	ADDQ.L	#1,A0
	ADDQ.L	#1,D0
	CMP.L	#127,D0
	BLS.S	posdeloop
	CLR.B	-1(A0)
	BSR	ShowPosition
	MOVE	#-1,UpOrDown
	BSR	SongLengthGadg
	BRA	WaitForButtonUp

;---- Enter number gadg ----

EnterNumGadg
	MOVE	MouseY2,D1
	CMP	#11,D1
	BLO	EnterPosGadg
	CMP	#22,D1
	BLO	EnterPattGadg
	CMP	#33,D1
	BLO	EnterLenGadg
	RTS

EnterPosGadg
	CLR.B	RawKeyCode
	MOVE	#76,LineCurX
	MOVE	#10,LineCurY
	MOVE	#169,TextOffset
	BSR	GetDec3Dig
	TST	AbortDecFlag
	BNE	pogskip
	CMP	#127,D0
	BLS.S	eposgok
	MOVEQ	#127,D0
eposgok	MOVE.L	D0,CurrPos
	BRA	pogskip

EnterPattGadg
	CLR.B	RawKeyCode
	MOVE	#84,LineCurX
	MOVE	#21,LineCurY
	MOVE	#610,TextOffset
	BSR	GetDecByte
	TST	AbortDecFlag
	BNE	pogskip
	CMP.B	#63,D0
	BLS.S	epgok
	MOVEQ	#63,D0
epgok	MOVE.L	SongDataPtr,A0
	LEA	sd_pattpos(A0),A0
	ADD.L	CurrPos,A0
	MOVE.B	D0,(A0)
	BRA	pogskip

EnterLenGadg
	CLR.B	RawKeyCode
	MOVE	#76,LineCurX
	MOVE	#32,LineCurY
	MOVE	#1049,TextOffset
	BSR	GetDec3Dig
	TST	AbortDecFlag
	BNE	ShowSongLength
	CMP	#128,D0
	BLS.S	elengok
	MOVE.B	#128,D0
elengok	MOVE.L	SongDataPtr,A0
	LEA	sd_numofpatt(A0),A0
	MOVE.B	D0,(A0)
	BRA	ShowSongLength

GetDec3Dig
	MOVE	#1,AbortDecFlag
	BSR	StorePtrCol
	BSR	SetWaitPtrCol
	BSR	UpdateLineCurPos
gd3loop	BSR	GetKey0_9
	CMP	#68,D1
	BEQ.S	gd3exit
	CMP	#2,D1
	BHI.S	gd3loop
	MOVE	D1,D0
	MULU	#100,D0
	MOVE	D0,gd3temp
	BSR	ShowOneDigit
	ADDQ	#8,LineCurX
	BSR	UpdateLineCurPos
	BSR	GetKey0_9
	CMP.B	#68,D1
	BEQ.S	gd3exit
	MOVE	D1,D0
	MULU	#10,D0
	ADD	D0,gd3temp
	BSR	ShowOneDigit
	ADDQ	#8,LineCurX
	BSR	UpdateLineCurPos
	BSR	GetKey0_9
	CMP.B	#68,D1
	BEQ.S	gd3exit
	ADD	D1,gd3temp
	CLR	AbortDecFlag
gd3exit	CLR	LineCurX
	MOVE	#270,LineCurY
	BSR	UpdateLineCurPos
	BSR	RestorePtrCol
	MOVEQ	#0,D0
	MOVE	gd3temp(PC),D0
	RTS

gd3temp	dc.w	0

;----  Up/Down Gadgets ----

DownGadgets
	MOVE	#1,UpdateFreeMem
	MOVE	#-1,UpOrDown
	BRA.S	ug2

UpGadgets
	MOVE	#1,UpdateFreeMem
	CLR	UpOrDown
ug2	MOVE	MouseY2,D0
			;CMP	#100,D0	 *** to ikky
			;BHS	Return1
	CMP	#100,D0
	BLT.s	.not
		rts
.not	CMP	#89,D0
	BHS	RepLenGadg
	CMP	#78,D0
	BHS	RepeatGadg
	CMP	#67,D0
	BHS	SampleLengthGadg
	CMP	#56,D0
	BHS	VolumeGadg
	CMP	#45,D0
	BHS	SampleNumGadg
	CMP	#34,D0
	BHS	FineTuneGadg
	CMP	#23,D0
	BHS	SongLengthGadg
	CMP	#12,D0
	BHS	PatternGadg
	TST	MouseY2
	BHS.S	PositionGadg
	RTS

PositionGadg
	TST	UpOrDown
	BMI.S	PositionDown
PositionUp
	ADDQ.L	#1,CurrPos
	BTST	#2,$DFF016
	BNE.S	pogskp2
	ADD.L	#9,CurrPos
pogskp2	CMP.L	#127,CurrPos
	BLS.S	pogskip
	MOVE.L	#127,CurrPos
pogskip	MOVE.L	CurrPos,SongPosition
	BSR	ShowPosition
	JSR	Wait_4000
	JSR	Wait_4000
	JMP	Wait_4000

PositionDown
	SUBQ.L	#1,CurrPos
	BTST	#2,$DFF016
	BNE.S	pogskp3
	SUB.L	#9,CurrPos
pogskp3	TST.L	CurrPos
	BPL.S	pogskip
	CLR.L	CurrPos
	BRA.S	pogskip

PatternGadg
	MOVE.L	SongDataPtr,A0
	LEA	sd_pattpos(A0),A0
	TST	UpOrDown
	BMI.S	PatternDown
PatternUp
	ADD.L	CurrPos,A0
	ADDQ.B	#1,(A0)
	BTST	#2,$DFF016
	BNE.S	pagaskp
	ADD.B	#9,(A0)
pagaskp	CMP.B	#63,(A0)
	BLS.S	pogskip
	MOVE.B	#63,(A0)
	BRA.S	pogskip
 
PatternDown
	ADD.L	CurrPos,A0
	SUBQ.B	#1,(A0)
	BTST	#2,$DFF016
	BNE.S	padoskp
	SUB.B	#9,(A0)
padoskp	TST.B	(A0)
	BPL	pogskip
	CLR.B	(A0)
	BRA	pogskip


SongLengthGadg
	MOVE.L	SongDataPtr,A0
	LEA	sd_numofpatt(A0),A0
	TST	UpOrDown
	BMI.S	SongLengthDown
SongLengthUp
	ADDQ.B	#1,(A0)
	BTST	#2,$DFF016
	BNE.S	slupskp
	ADD.B	#9,(A0)
slupskp	CMP.B	#127,(A0)
	BMI.S	solgskip
	MOVE.B	#127,(A0)
solgskip
	BSR	ShowSongLength
	JSR	Wait_4000
	JSR	Wait_4000
	JMP	Wait_4000
 
SongLengthDown
	SUBQ.B	#1,(A0)
	BTST	#2,$DFF016
	BNE.S	sldoskp
	SUB.B	#9,(A0)
sldoskp	CMP.B	#1,(A0)
	BGE.S	solgskip
	MOVE.B	#1,(A0)
	BRA.S	solgskip


SampleNumGadg
	BTST	#2,$DFF016	; Check Right Mousebutton
	BNE.S	SampleNum2
	TST	InsNum
	BEQ	ShowSampleInfo
	MOVE	InsNum,LastInsNum
	CLR	InsNum
	BRA	ShowSampleInfo
 
SampleNum2
	TST	UpOrDown
	BMI.S	SampleNumDown
SampleNumUp
	ADDQ	#1,InsNum
	CMP	#31,InsNum
	BMI.S	snuskip
	MOVE	#31,InsNum
snuskip	BSR	redrsam
	JSR	Wait_4000
	JMP	Wait_4000

SampleNumDown
	TST	InsNum
	BEQ.S	snuskip
	SUBQ	#1,InsNum
	CMP	#1,InsNum
	BPL.S	snuskip
	MOVE	#1,InsNum
	BRA.S	snuskip

FineTuneGadg
	MOVE.L	SongDataPtr,A0
	LEA	12(A0),A0
	MOVE	InsNum,D0
	BNE.s	.true
                RTS
.true	MULU	#30,D0
	ADD.L	D0,A0
	BTST	#2,$DFF016
	BNE.S	ftgskip
	CLR.B	2(A0)
	BRA.S	ftuskip
ftgskip	TST	UpOrDown
	BMI.S	FineTuneDown
FineTuneUp
	AND.B	#$0F,2(A0)
	CMP.B	#7,2(A0)
	BEQ.S	ftuskip
	ADDQ.B	#1,2(A0)
	AND.B	#$0F,2(A0)
ftuskip	BSR	ShowSampleInfo
	JSR	Wait_4000
	JMP	Wait_4000

FineTuneDown
	AND.B	#$0F,2(A0)
	CMP.B	#8,2(A0)
	BEQ.S	ftuskip
	SUBQ.B	#1,2(A0)
	AND.B	#$0F,2(A0)
	BRA.S	ftuskip


VolumeGadg
	MOVE.L	SongDataPtr,A0
	LEA	12(A0),A0
	MOVE	InsNum,D0
	BNE.s	.notret
		rts
.notret	MULU	#30,D0
	ADD.L	D0,A0
	TST	UpOrDown
	BMI.S	VolumeDown
VolumeUp
	ADDQ.B	#1,3(A0)
	BTST	#2,$DFF016
	BNE.S	voupskp
	ADD.B	#15,3(A0)
voupskp	CMP.B	#$40,3(A0)
	BLS.S	ftuskip
	MOVE.B	#$40,3(A0)
	BRA.S	ftuskip

VolumeDown
	SUBQ.B	#1,3(A0)
	BTST	#2,$DFF016
	BNE.S	vodoskp
	SUB.B	#15,3(A0)
vodoskp	TST.B	3(A0)
	BPL	ftuskip
	CLR.B	3(A0)
	BRA	ftuskip

SampleLengthGadg
	MOVE	#1,SampleLengthFlag
	MOVE.L	SongDataPtr,A0
	LEA	12(A0),A0
	MOVEQ	#0,D0
	MOVE	InsNum,D0
	BEQ	ShowSampleInfo
	MULU	#30,D0
	ADD.L	D0,A0
	TST	UpOrDown
	BMI.S	SampleLengthDown
SampleLengthUp
	ADDQ	#1,(A0)
	BTST	#2,$DFF016
	BNE.S	sluskip
	CMP	#$7FF0,(A0)
	BHS.S	sluskip
	ADDQ	#7,(A0)
sluskip	CMP	#$7FFF,(A0)
	BLO	ShowSampleInfo
	MOVE	#$7FFF,(A0)
	BRA	ShowSampleInfo
 
SampleLengthDown
	MOVE	4(A0),D0
	ADD	6(A0),D0
	SUBQ	#1,(A0)
	BTST	#2,$DFF016
	BNE.S	sldskip
	SUBQ	#7,(A0)
sldskip	BMI.S	sldskip2
	CMP	(A0),D0
	BLS	ShowSampleInfo
	MOVE	D0,(A0)
	BRA	ShowSampleInfo
sldskip2
	CLR	(A0)
	BRA	ShowSampleInfo

SampleLengthFlag dc.w 0

CheckSampleLength
	TST	SampleLengthFlag
	BEQ	.Return
	CLR	SampleLengthFlag
	MOVEQ	#0,D0
	MOVE	InsNum,D0
	BEQ	.Return
	MOVE.L	SongDataPtr,A0
	LEA	12(A0),A0
	MOVE.L	D0,D1
	LSL	#2,D1
	MULU	#30,D0
	ADD.L	D0,A0
	LEA	SamplePtrs,A1
	LEA	(A1,D1.W),A1
	MOVE.L	A0,PlaySamPtr
	MOVE.L	A1,RealSamPtr
	MOVE.L	124(A1),D0
	LSR.L	#1,D0
	MOVE	(A0),D1
	CMP	D0,D1
	BHI.S	ItsTooMuch
.Return	RTS

ItsTooMuch
	LEA	AddWorkSpaceText(PC),A0
	BSR	AreYouSure
	BNE.S	RestoreLength
	BSR	TurnOffVoices
	MOVE.L	PlaySamPtr,A0
	MOVEQ	#0,D0
	MOVE	(A0),D0
	LSL.L	#1,D0
	MOVE.L	D0,SamAllocLen
	MOVE.L	#MEMF_CHIP!MEMF_CLEAR,D1
	MOVE.L	4.W,A6
	JSR	LVOAllocMem(A6)
	MOVE.L	D0,SamAllocPtr
	BEQ.S	RestoreLength
	MOVE.L	D0,A1
	MOVE.L	RealSamPtr,A0
	MOVE.L	(A0),D0
	BEQ.S	nosamth
	MOVE.L	D0,A2
	MOVE.L	124(A0),D1
	BEQ.S	nosamth
	SUBQ.L	#1,D1
cpsalop	MOVE.B	(A2)+,(A1)+
	DBF	D1,cpsalop
	MOVE.L	(A0),A1
	MOVE.L	124(A0),D0
	MOVE.L	4.W,A6
	JSR	LVOFreeMem(A6)
nosamth	MOVE.L	RealSamPtr,A0
	MOVE.L	SamAllocPtr,(A0)
	MOVE.L	SamAllocLen,124(A0)
	BSR	ShowSampleInfo
	BSR	RedrawSample
	BRA	WaitForButtonUp

RestoreLength
	MOVE.L	PlaySamPtr,A0
	MOVE.L	RealSamPtr,A1
	MOVE.L	124(A1),D0
	LSR.L	#1,D0
	MOVE	D0,(A0)
	BRA	ShowSampleInfo

AddWorkSpaceText dc.b 'add workspace ?',0
PlaySamPtr  dc.l 0
RealSamPtr  dc.l 0
SamAllocPtr dc.l 0
SamAllocLen dc.l 0

RepeatGadg
	MOVE.L	SongDataPtr,A0
	LEA	12(A0),A0
	MOVEQ	#0,D0
	MOVE	InsNum,D0
	BEQ	ShowSampleInfo
	MULU	#30,D0
	ADD.L	D0,A0
	TST	UpOrDown
	BMI.S	RepeatDown
RepeatUp
	ADDQ	#1,4(A0)
	BTST	#2,$DFF016
	BNE.S	ruskip
	ADDQ	#7,4(A0)
ruskip	MOVE	(A0),D0		;   Length
	BEQ.S	ruskip2
	SUB	6(A0),D0	; - RepLen
	CMP	4(A0),D0
	BHI.S	ruskip2
	MOVE	D0,4(A0)
ruskip2	BSR	ShowSampleInfo
	BSR	UpdateRepeats
	BRA	SetLoopSprites2

RepeatDown
	SUBQ	#1,4(A0)
	BTST	#2,$DFF016
	BNE.S	rdskip
	SUBQ	#7,4(A0)
rdskip	TST	4(A0)
	BPL.S	ruskip2
	CLR	4(A0)
	BRA.S	ruskip2


RepLenGadg
	MOVE.L	SongDataPtr,A0
	LEA	12(A0),A0
	MOVEQ	#0,D0
	MOVE	InsNum,D0
	BEQ	ShowSampleInfo
	MULU	#30,D0
	ADD.L	D0,A0
	TST	UpOrDown
	BMI.S	RepLenDown
RepLenUp
	ADDQ	#1,6(A0)
	BTST	#2,$DFF016	; Check Right Mousebutton
	BNE.S	rluskip
	ADDQ	#7,6(A0)
rluskip	MOVE	(A0),D0
	BEQ.S	ruskip2
	SUB	4(A0),D0
	CMP	6(A0),D0
	BHI.S	ruskip2
	BRA.S	rldskip
 
RepLenDown
	MOVEQ	#0,D0
	MOVE	6(A0),D0
	SUBQ.L	#1,D0
	BTST	#2,$DFF016
	BNE.S	rldskip
	SUBQ.L	#7,D0
rldskip	CMP.L	#1,D0
	BGE.S	rldskp2
	MOVEQ	#1,D0
rldskp2	MOVE	D0,6(A0)
	BRA	ruskip2

UpdateRepeats
	LEA	audchan1temp,A1
	LEA	$DFF0A0,A2
	LEA	ScopeInfo,A3
	BSR.S	upre2
	LEA	audchan2temp,A1
	LEA	$DFF0B0,A2
	LEA	ScopeInfo+20,A3
	BSR.S	upre2
	LEA	audchan3temp,A1
	LEA	$DFF0C0,A2
	LEA	ScopeInfo+40,A3
	BSR.S	upre2
	LEA	audchan4temp,A1
	LEA	$DFF0D0,A2
	LEA	ScopeInfo+60,A3
upre2	MOVE	InsNum,D0
	CMP.B	n_samplenum(A1),D0
	BNE	Return1b
	MOVE.L	n_start(A1),A1
	MOVEQ	#0,D0
	MOVE	4(A0),D0	; repeat
	ADD.L	D0,A1
	ADD.L	D0,A1
	MOVE.L	A1,(A2)
	MOVE	6(A0),D0
	MOVE	D0,4(A2)	; replen
	MOVE.L	A1,ns_repeatptr(A3)
	ADD.L	D0,A1
	ADD.L	D0,A1
	MOVE.L	A1,ns_rependptr(A3)
Return1b
	RTS

SetPatternPos
	MOVE.L	PatternPosition,D0
	LSR.L	#4,D0
	BRA.S	ssppskip
 
SetScrPatternPos
	MOVE	ScrPattPos,D0
ssppskip
	TST	SamScrEnable
	BNE	Return1b
	MOVE	D0,PlayFromPos
	MULU	#7*40,D0
	MOVE.L	TextBplPtr,A0
	LEA	5560(A0),A0
	ADD.L	A0,D0
	MOVE.L	CopListBpl4Ptr,A1
	MOVE	D0,6(A1)
	SWAP	D0
	MOVE	D0,2(A1)
	RTS

PlayFromPos	dc.w 0

WantedPattGadg
	TST	SamScrEnable
	BNE	CheckSamGadgets
TypeInWantedPatt
	CMP	#138,D1
	BHI.S	.tiwp2
		CMP	#25,D0
		BHI	TempoGadg
.tiwp2	CMP	#25,d0
	BHS	twexit
	CMP.L	#'patp',RunMode	; not if a song is playing... 
	BEQ	Return1b
	CLR.B	RawKeyCode
	MOVE	#12,LineCurX
	MOVE	#$0086,LineCurY
	MOVE	#5121,TextOffset
	BSR	GetDecByte
	TST	AbortDecFlag
	BNE.S	twexit
	MOVE.B	D0,PatternNumber+3
	CMP.L	#63,PatternNumber
	BLS.S	twexit
	MOVE.L	#63,PatternNumber
twexit	BRA	RedrawPattern



GetKey0_9
	BTST	#2,$DFF016
	BEQ.S	gk_ret
	MOVEQ	#0,D0
	BSR	DoKeyBuffer
	MOVE.B	RawKeyCode,D0
	BEQ.S	GetKey0_9
	CLR.B	RawKeyCode
	CMP.B	#68,D0
	BEQ.S	gk_ret
	CMP.B	#69,D0
	BEQ.S	gk_ret
	CMP.B	#10,D0
	BEQ.S	gk_end
	BHI.S	GetKey0_9
	CMP.B	#1,D0
	BLO.S	GetKey0_9
	MOVE.L	D0,D1
	RTS

gk_end	MOVEQ	#0,D1
	RTS

gk_ret	MOVEQ	#68,D1
	RTS

ShowOneDigit
	ADD.B	#'0',D1
	MOVE.B	D1,NumberText
	CLR	D1
	SWAP	D1
	MOVE	#1,TextLength
	MOVE.L	#NumberText,ShowTextPtr
	BSR	ShowText
	CLR.L	NumberText
	CLR	WordNumber
	RTS

;---- Get Text Line ----

GetTextLine
	MOVEQ	#0,D0
	MOVE	A4,D0
	DIVU	#40,D0
	ADDQ	#5,D0
	MOVE	D0,LineCurY
	SWAP	D0
	LSL	#3,D0
	ADDQ	#4,D0
	MOVE	D0,LineCurX
	BSR	UpdateLineCurPos
	MOVE.L	ShowTextPtr,DSTPtr
	CLR.L	DSTOffset
	CLR.L	DSTPos
	MOVE	#1,GetLineFlag
	MOVE.L	A4,A5
	MOVE	LineCurX,D5
	CLR.B	RawKeyCode
	BSR	UpdateText
WaitForKey
	BTST	#2,$DFF016
	BEQ	AbortGetLine
	BTST	#6,$BFE001
	BEQ	LineClicked
	BSR	DoKeyBuffer
	MOVEQ	#0,D1
	MOVE.B	RawKeyCode,D1
	BEQ.S	WaitForKey
	CMP.B	#78,D1
	BEQ	MoveCharRight
	CMP.B	#79,D1
	BEQ	MoveCharLeft
	CMP.B	#70,D1
	BEQ	DeleteChar
	CMP.B	#65,D1
	BEQ	BackspaceChar
	CMP.B	#68,D1
	BEQ	GetLineReturn
	CMP.B	#69,D1
	BEQ	GetLineReturn
	BTST	#7,D1
	BNE.S	WaitForKey
	LEA	UnshiftedKeymap,A4
	TST	ShiftKeyStatus
	BEQ.S	gtlskip
	LEA	ShiftedKeymap,A4
gtlskip	AND	#$007F,D1
	CMP.B	#64,D1
	BHI.S	WaitForKey
	MOVE.B	(A4,D1.W),D1
	BEQ.S	WaitForKey
	TST.B	EnterTextFlag
	BEQ.S	TextLineKey
	CMP.B	#'0',D1
	BLO	WaitForKey
	CMP.B	#'f',D1
	BHI	WaitForKey
	CMP.B	#'a',D1
	BHS.S	TextLineKey
	CMP.B	#'9',D1
	BHI	WaitForKey
TextLineKey
	CMP.L	TextEndPtr,A6
	BEQ	WaitForKey
	MOVE.L	TextEndPtr,A4
tlkloop	MOVE.B	-(A4),1(A4)
	CMP.L	A4,A6
	BNE.S	tlkloop
	MOVE.L	TextEndPtr,A4
	CLR.B	(A4)
	MOVE.B	D1,(A6)+
	BSR	PosMoveRight
	BSR	UpdateText
	CLR.B	RawKeyCode
	BRA	WaitForKey

LineClicked
	MOVE	MouseY,D1
	SUB	LineCurY,D1
	CMP	#2,D1
	BGT	GetLineReturn
	CMP	#-8,D1
	BLT	GetLineReturn
	MOVE	MouseX,D1
	SUB	LineCurX,D1
	ADDQ	#4,D1
	ASR	#3,D1
	BEQ	WaitForKey
	BPL.S	linclri

	CMP.L	DSTPtr(PC),A6
	BEQ	WaitForKey
	SUBQ.L	#1,A6
	BSR	PosMoveLeft
upwake2	BSR	UpdateText
	BRA	WaitForKey

linclri	CMP.L	TextEndPtr,A6
	BEQ	WaitForKey
	TST.B	(A6)
	BEQ	WaitForKey
	ADDQ.L	#1,A6
	BSR	PosMoveRight
	BRA.S	upwake2

PosMoveRight
	MOVE.L	DSTPos,D0
	MOVEQ	#0,D1
	MOVE	TextLength,D1
	TST.B	EnterTextFlag
	BNE.S	pmrskip
	SUBQ	#1,D1
pmrskip	CMP.L	D1,D0
	BLO.S	posrok
	ADDQ.L	#1,DSTOffset
	BRA	UpdateLineCurPos
posrok	ADDQ.L	#1,DSTPos
	ADDQ	#8,LineCurX
	BRA	UpdateLineCurPos

PosMoveLeft
	TST.L	DSTPos
	BNE.S	poslok
	SUBQ.L	#1,DSTOffset
	BRA	UpdateLineCurPos
poslok	SUBQ.L	#1,DSTPos
	SUBQ	#8,LineCurX
	BRA	UpdateLineCurPos

BackspaceChar
	CMP.L	DSTPtr(PC),A6
	BEQ	WaitForKey
	SUBQ.L	#1,A6
	MOVE.L	A6,A4
dobaloop
	MOVE.B	1(A4),(A4)+
	CMP.L	TextEndPtr,A4
	BNE.S	dobaloop
	BSR	PosMoveLeft
upwake	BSR	UpdateText
	JSR	Wait_4000
	JSR	Wait_4000
	JSR	Wait_4000
	BRA	WaitForKey
 
DeleteChar
	MOVE.L	A6,A4
dechloop
	MOVE.B	1(A4),(A4)+
	CMP.L	TextEndPtr,A4
	BLO.S	dechloop
	BRA.S	upwake
 
MoveCharRight
	CMP.L	TextEndPtr,A6
	BEQ	WaitForKey
	TST.B	(A6)
	BEQ	WaitForKey
	ADDQ.L	#1,A6
	BSR	PosMoveRight
	BRA.S	upwake

MoveCharLeft
	CMP.L	DSTPtr(PC),A6
	BEQ	WaitForKey
	SUBQ.L	#1,A6
	BSR	PosMoveLeft
	BRA.S	upwake

GetLineReturn
	MOVE.L	DSTPtr,A6
	CMP.B	#1,EnterTextFlag
	BNE.S	gtl_rskip
	TST.B	DiskNumText2
	BEQ	WaitForKey
gtl_rskip
	CMP.B	#3,EnterTextFlag
	BNE.S	gtl_rskip2
	TST.B	SndDiskNum1
	BEQ	WaitForKey
gtl_rskip2
	MOVE.L	A6,A4
dlrloop	TST.B	(A4)+
	BNE.S	dlrloop
	SUBQ.L	#1,A4
dlrloop2
	CMP.L	TextEndPtr,A4
	BHS.S	dlrexit
	CLR.B	(A4)+
	BRA.S	dlrloop2

dlrexit	CLR	LineCurX
	MOVE	#270,LineCurY
	BSR	UpdateLineCurPos
	CLR	GetLineFlag
	MOVE.B	RawKeyCode,MixChar
	CLR.B	RawKeyCode
	CLR.L	DSTOffset
	BSR.S	UpdateText
	BRA	WaitForButtonUp

AbortGetLine
	MOVE.L	DSTPtr,A6
	MOVE.L	A6,A4
clliloop
	CLR.B	(A4)+
	CMP.L	TextEndPtr,A4
	BNE.S	clliloop
	BSR.S	UpdateText
	BRA	GetLineReturn
 
UpdateText
	MOVE	A5,TextOffset
	MOVE.L	DSTPtr,A0
	ADD.L	DSTOffset,A0
	BRA	ShowText2

DSTPtr		dc.l	0
DSTPos		dc.l	0
DSTOffset	dc.l	0

;----

TypeInSongName
	BSR	StorePtrCol
	BSR	SetWaitPtrCol
	CLR.L	EditMode
	MOVE.L	SongDataPtr,A6
	MOVE.L	A6,TextEndPtr
	MOVE.L	A6,ShowTextPtr
	ADD.L	#19,TextEndPtr
	MOVE	#20,TextLength
	MOVE	#4133,A4
	BSR	GetTextLine
	CLR.L	TextEndPtr
	BRA	RestorePtrCol

CheckSmplNamOrLoad
	CMP	#287,MouseX2
	BHS	LoadNamedSample
TypeInSampleName
	BSR	StorePtrCol
	BSR	SetWaitPtrCol
	CLR.L	EditMode
	MOVE.L	SongDataPtr,A6
	LEA	-10(A6),A6
	MOVE	InsNum,D7
	BNE.S	tisnskip
	MOVE	LastInsNum,D7
tisnskip
	MULU	#30,D7
	ADD.L	D7,A6
	MOVE.L	A6,TextEndPtr
	MOVE.L	A6,ShowTextPtr
	ADD.L	#21,TextEndPtr
	MOVE	#22,TextLength
	MOVE	#4573,A4
	BSR	GetTextLine
	CLR.L	TextEndPtr
	BRA	RestorePtrCol

LoadSample
	TST	InsNum
	BEQ	NotSampleNull
	BSR	StorePtrCol
	LEA	SamplePath2,A0
	BSR	CopyPath
	LEA	DirInputName,A0
	MOVEQ	#DirNameLength-1,D0
lsloop	MOVE.B	(A0)+,(A1)+
	DBF	D0,lsloop
	MOVE.L	SongDataPtr,A0
	MOVE	InsNum,D0
	MULU	#30,D0
	LEA	-10(A0),A0
	ADD.L	D0,A0
	LEA	DirInputName,A1
	MOVEQ	#21,D0
lsloop2	MOVE.B	(A1)+,(A0)+
	DBF	D0,lsloop2
	BSR	SetDiskPtrCol
	MOVE.L	#FileName,D1
	BSR	ExamineAndAlloc
	BEQ	ErrorRestoreCol
	MOVE.L	#FileName,D1
	BRA	lnssec2

CheckForIFF2 ; load loop		;load IFF sample!!!
	MOVEQ	#-1,D2
	BRA.S	ciff2
CheckForIFF
	MOVEQ	#0,D2
ciff2	MOVEQ	#0,D1
	CMP.L	#'FORM',(A0)
	BNE.S	wiskip
	CMP.L	#'8SVX',8(A0)
	BNE.S	wiskip
	MOVE.L	A0,A2
	MOVE.L	A1,D0
	ADD.L	A0,A1
	TST.L	D2
	BEQ.S	cfiloop
	BSR.S	CheckIFFLoop
cfiloop	CMP.L	#'BODY',(A0)
	BEQ.S	wasIFF
	ADDQ.L	#2,A0
	CMP.L	A1,A0
	BLS.S	cfiloop
	RTS

wasIFF	ADDQ.L	#8,A0
	ADD.L	A2,D0
	SUB.L	A0,D0
wiloop	MOVE.B	(A0)+,(A2)+
	CMP.L	A1,A0
	BLS.S	wiloop
	MOVE.L	SampleInstrSave(PC),A3
	LSR	#1,D0
	MOVE	22(A3),D1
	SUB	D0,D1
	MOVE	D0,22(A3)
wiskip	LEA	SampleLengthAdd(PC),A3
	MOVE	InsNum,D0
	LSL	#1,D0
	MOVE	D1,(A3,D0.W)
	RTS

CheckIFFLoop
	TST.B	IFFLoopFlag
	BEQ	Return2
	MOVEM.L	A0/D0,-(SP)
cilloop	CMP.L	#'VHDR',(A0)
	BEQ.S	wasvhdr
	ADDQ.L	#2,A0
	CMP.L	A1,A0
	BLS.S	cilloop
cilend	MOVEM.L	(SP)+,A0/D0
	RTS

wasvhdr	MOVE.L	SampleInstrSave(PC),A3
	MOVE.L	12(A0),D0
	BEQ.S	cilend
	LSR	#1,D0
	MOVE	D0,28(A3)
	MOVE.L	8(A0),D0
	BNE.S	wsvhdr2
	MOVEQ	#2,D0
wsvhdr2	LSR	#1,D0
	MOVE	D0,26(A3)
	BRA.S	cilend


SampleInstrSave	dc.l	0
SampleLengthAdd	dcb.w	32,0

ExamineAndAlloc
	MOVEQ	#-2,D2
	MOVE.L	DOSBase,A6
	JSR	LVOLock(A6)
	MOVE.L	D0,FileLock
	BEQ	CantFindFile
	MOVE.L	D0,D1
	MOVE.L	#FileInfoBlock,D2
	JSR	LVOExamine(A6)
	TST.L	FIB_EntryType
	BPL	CantExamFile
	MOVE.L	FileLock,D1
	JSR	LVOUnLock(A6)
	MOVE.L	FIB_FileSize,D0
	BEQ	FileIsEmpty
	BSR	TurnOffVoices
	BSR	FreeSample
	MOVE.L	FIB_FileSize,D0
	CMP.L	#$FFFE,D0
	BLS.S	exalloc
	MOVE.L	#$FFFE,D0
exalloc	LEA	SamplePtrs,A4
	MOVE	InsNum,D1
	LSL	#2,D1
	ADD	D1,A4
	MOVE.L	D0,124(A4)
	MOVE.L	D0,DiskDataLength
	MOVE.L	4.W,A6
	MOVE.L	#MEMF_CHIP!MEMF_CLEAR,D1
	JSR	LVOAllocMem(A6)
	MOVE.L	D0,DiskDataPtr
	MOVE.L	D0,(A4)
	BEQ	OutOfMemErr
	LEA	LoadingSampleText(PC),A0
	BSR	ShowStatusText
	MOVE.L	SongDataPtr,A0
	MOVE	InsNum,D0
	MULU	#30,D0
	LEA	-10(A0),A0
	ADD.L	D0,A0
	MOVE.L	A0,SampleInstrSave
	MOVE.L	DiskDataLength,D0
	LSR.L	#1,D0
	MOVE	D0,22(A0)
	MOVE.L	#$400000,24(A0)
	MOVE	#1,28(A0)
	BSR	ShowSampleInfo
	MOVEQ	#-1,D0
	RTS

LoadNamedSample
	TST	InsNum
	BEQ	NotSampleNull
	BSR	StorePtrCol
	BSR	CreateSampleName
	BSR	SetDiskPtrCol
	MOVE.L	FileNamePtr,D1
	BSR	ExamineAndAlloc
	BEQ	Return2
	MOVE.L	FileNamePtr,D1
lnssec2	MOVE.L	DOSBase(PC),A6
	MOVE.L	#1005,D2
	JSR	LVOOpen(A6)
	MOVE.L	D0,D7
	BEQ	CantOpenFile
	MOVE.L	D0,D1
	MOVE.L	DiskDataPtr,D2
	MOVE.L	DiskDataLength,D3
	JSR	LVORead(A6)
	MOVE.L	D7,D1
	JSR	LVOClose(A6)
	MOVE.L	DiskDataPtr,A0
	MOVE.L	DiskDataLength,A1
	BSR	CheckForIFF2
	BSR	ValidateLoops
	BSR	ShowSampleInfo
	MOVE.L	DiskDataPtr,A0
	CLR	(A0)
	BSR	RedrawSample
	CLR.L	SavSamInf
	BSR	ShowAllRight
	BRA	RestorePtrCol

CreateSampleName
	LEA	SampleFileName,A0
	MOVEQ	#27,D0
csnloop	CLR.B	(A0)+
	DBF	D0,csnloop
	MOVE.L	SongDataPtr,A0
	MOVE	InsNum,D0
	MULU	#30,D0
	LEA	-10(A0),A0
	ADD.L	D0,A0
	MOVE.L	A0,SampleInstrSave
	MOVEQ	#0,D0
	MOVE	22(A0),D0
	ADD.L	D0,D0
	MOVE.L	D0,DiskDataLength
	MOVE.L	D0,IFFBODY+4
	ADD.L	#IFFEND-IFFFORM-8,D0
	MOVE.L	D0,IFFFORM+4

	MOVEQ	#0,D0
	MOVE	22(A0),D0
	ADD.L	D0,D0
	MOVEQ	#0,D1
	MOVE	28(A0),D1
	CMP	#1,D1
	BLS.S	csnskp2
	ADD.L	D1,D1
	MOVEQ	#0,D0
	MOVE	26(A0),D0
	ADD.L	D0,D0
	BRA.S	csnskp3
csnskp2	MOVEQ	#0,D1
csnskp3	MOVE.L	D0,IFFVHDR+8
	MOVE.L	D1,IFFVHDR+12

	LEA	SampleFileName,A1
	LEA	IFFNAME+8,A2
	MOVEQ	#21,D0
csnloop2
	MOVE.B	(A0),(A1)+
	MOVE.B	(A0)+,(A2)+
	DBF	D0,csnloop2
	MOVE.L	#SampleFileName,D1
	MOVE.L	D1,FileNamePtr
	BSR.S	FindColon
	BEQ.S	CheckOverride
	LEA	SamplePath2,A0
	BSR	CopyPath
	MOVE.L	#SampleFileName,A0
csnloop3
	MOVE.B	(A0)+,(A1)+
	BNE.S	csnloop3
	MOVE.L	#FileName,FileNamePtr
	RTS

FindColon
	MOVE.L	D1,A0
fcloop	MOVE.B	(A0)+,D0
	BEQ.S	FindColonFail
	CMP.B	#':',D0
	BEQ.S	FindColonSuccess
	BRA.S	fcloop

FindColonFail
	MOVEQ	#-1,D0
	RTS

FindColonSuccess
	MOVEQ	#0,D0
	RTS

CheckOverride
	TST.B	OverrideFlag
	BEQ	Return2
	MOVE.L	#SampleFileName,A0
	MOVE.L	A0,A1
	LEA	21(A1),A1
	MOVE.L	A1,A2
chkovlp	MOVE.B	-(A1),D0
	CMP.B	#':',D0
	BEQ.S	chkovok
	CMP.B	#'/',D0
	BEQ.S	chkovok
	MOVE.L	A1,A2
	CMP.L	A0,A1
	BHI.S	chkovlp
chkovok	LEA	SamplePath2,A0
	BSR	CopyPath
chkovl2	MOVE.B	(A2)+,(A1)+
	BNE.S	chkovl2
	MOVE.L	#FileName,FileNamePtr
	RTS

ValidateLoops
	MOVE.L	SongDataPtr,A0
	LEA	20(A0),A0
	MOVEQ	#30,D0
valolop	MOVE	22(A0),D1
	MOVE	26(A0),D2
	MOVE	28(A0),D3
	CMP	D1,D2
	BHS.S	valosk1
	ADD	D2,D3
	CMP	D1,D3
	BHI.S	valosk2
valoque	TST	28(A0)
	BNE.S	valosk3
	MOVE	#1,28(A0)
valosk3	LEA	30(A0),A0
	DBF	D0,valolop
	RTS
valosk2	SUB	D2,D1
	MOVE	D1,28(A0)
	BRA.S	valoque
valosk1	MOVEQ	#1,D1
	MOVE.L	D1,26(A0)
	BRA.S	valoque



;--- preset selection

UsePreset
	BSR	StorePtrCol
	TST.L	PLSTmem
	BEQ.S	upend
	TST	InsNum
	BEQ.S	upend
	CLR.B	RawKeyCode
	MOVE	CurrentPreset,D0
	SUBQ	#1,D0
	MULU	#30,D0
	MOVE.L	PLSTmem,A0
	ADD.L	D0,A0
	MOVE	InsNum,D0
	MULU	#30,D0
	MOVE.L	SongDataPtr,A1
	LEA	-10(A1,D0.W),A1
	MOVE.L	A1,A2
	MOVE.L	A1,TempInsPtr
	MOVEQ	#29,D0
	LEA	TempIns,A2
uploop	MOVE.B	(A1),(A2)+
	MOVE.B	(A0)+,(A1)+
	DBF	D0,uploop
	MOVE.L	(A2),D0
	AND.L	#$DFDFFFFF,D0
	CMP.L	#$53540000,D0 ;ST__
	BNE.S	upok
	CLR	(A2)
	CLR.L	22(A2)
	MOVE.L	#1,26(A2)
upok	BSR	LoadPreset
upend	BSR	ShowSampleInfo
	BRA	RestorePtrCol

LoadPreset
	BSR	LoadNamedSample
	BEQ	LdError
	MOVE	#1,UpdateFreeMem
	RTS

LdError
	MOVE.L	TempInsPtr(PC),A1
	LEA	TempIns,A2
	MOVEQ	#29,D0
.loop	MOVE.B	(A2)+,(A1)+
	DBF	D0,.loop
	MOVEQ	#0,D0
	RTS

TempInsPtr	dc.l	0
TempIns		dc.b	32,0



AllocSample
	MOVE.L	D0,-(SP)
	MOVE.L	#MEMF_CHIP!MEMF_CLEAR,D1
	MOVE.L	4.W,A6
	JSR	LVOAllocMem(A6)
	MOVE.L	D0,DiskDataPtr
	LEA	SamplePtrs,A0
	MOVE	InsNum(PC),D1
	LSL	#2,D1
	LEA	(A0,D1.W),A0
	MOVE.L	DiskDataPtr,(A0)
	MOVE.L	(SP)+,124(A0)
	RTS

FreeSample
	LEA	SamplePtrs,A0
	MOVE	InsNum(PC),D0
	BEQ	Return2
	LSL	#2,D0
	LEA	(A0,D0.W),A0
	MOVE.L	(A0),D1
	BEQ	Return2
	CLR.L	(A0)
	MOVE.L	124(A0),D0
	CLR.L	124(A0)
	MOVE.L	D1,A1
	MOVE.L	4.W,A6
	JSR	LVOFreeMem(A6)
	RTS

NotSampleNull
	LEA	NotSample0Text(PC),A0
	BSR	ShowStatusText
	BRA	SetErrorPtrCol

NotSample0Text	dc.b 'not sample 0 !',0,0

;----

DeleteSong
	LEA	DeleteSongText,A0
	BSR	AreYouSure
	BNE	Return2
	LEA	DeletingSongText(PC),A0
	BSR	ShowStatusText
	LEA	SongsPath2,A0
	BSR	CopyPath
	LEA	DirInputName,A0
	MOVEQ	#DirNameLength-1,D0
dsloop	MOVE.B	(A0)+,(A1)+
	DBF	D0,dsloop
	MOVE	#1,Action
Delete3	MOVE.L	#FileName,FileNamePtr
	MOVE.L	DOSBase(PC),A6
	MOVE.L	FileNamePtr(PC),D1
	MOVE.L	D1,A0
	JSR	LVODeleteFile(A6)
	BSR	ClearFileNames
	BSR	ShowAllRight
	BSR	SetNormalPtrCol
	BSR	StorePtrCol
	BRA	DoAutoDir

DeleteModule
	LEA	DeleteModuleText,A0
	BSR	AreYouSure
	BNE	Return2
	LEA	DeletingModuleText(PC),A0
	BSR	ShowStatusText
	LEA	ModulesPath2,A0
	BSR	CopyPath
	LEA	DirInputName,A0
	MOVEQ	#DirNameLength-1,D0
dmdloop	MOVE.B	(A0)+,(A1)+
	DBF	D0,dmdloop
	MOVE	#3,Action
	BRA.S	Delete3

DeleteSample
	LEA	DeleteSampleText,A0
	BSR	AreYouSure
	BNE	Return2
	LEA	DeletingSampleText(PC),A0
	BSR	ShowStatusText
	LEA	SamplePath2,A0
	BSR	CopyPath
	LEA	DirInputName,A0
	MOVEQ	#DirNameLength-1,D0
dsaloop	MOVE.B	(A0)+,(A1)+
	DBF	D0,dsaloop
	MOVE	#5,Action
	BRA	Delete3

RenameFile
	LEA	RenamingFileText(PC),A0
	BSR	ShowStatusText
	LEA	DirInputName,A0
	LEA	NewInputName,A1
	MOVEQ	#23,D0
rnfloop	MOVE.B	(A0)+,(A1)+
	BNE.S	rnfskip
	SUBQ.L	#1,A0
rnfskip	DBF	D0,rnfloop
	BSR	StorePtrCol
	BSR	SetWaitPtrCol
	LEA	NewInputName,A6
	MOVE.L	A6,ShowTextPtr
	MOVE.L	A6,TextEndPtr
	ADD.L	#23,TextEndPtr
	MOVE	#24,TextLength
	MOVE	FileNameScrollPos+2,D0
	MULU	#240,D0
	MOVE	#1888,A4
	ADD	D0,A4
	BSR	GetTextLine
	TST.B	NewInputName
	BEQ.S	rnfend
	CMP.B	#69,MixChar
	BEQ.S	rnfend

	MOVE.L	PathPtr,A0
	BSR	CopyPath
	LEA	NewInputName,A0
	MOVEQ	#23,D0
rnfloop2
	MOVE.B	(A0)+,(A1)+
	DBF	D0,rnfloop2

	LEA	FileName,A0
	LEA	NewFileName,A1
rnfloop3
	MOVE.B	(A0)+,(A1)+
	BNE.S	rnfloop3

	MOVE.L	PathPtr,A0
	BSR	CopyPath
	LEA	DirInputName,A0
	MOVEQ	#DirNameLength-1,D0
rnfloop4
	MOVE.B	(A0)+,(A1)+
	DBF	D0,rnfloop4

	MOVE.L	#FileName,D1
	MOVE.L	#NewFileName,D2
	MOVE.L	DOSBase(PC),A6
	JSR	LVORename(A6)

rnfend	BSR	ClearFileNames
	CLR	Action
	BSR	RestorePtrCol
	BRA	ShowAllRight

LoadSong
	MOVE	#1,LoadInProgress
	BSR	DoClearSong
	BSR	ClrSampleInfo
	LEA	SongsPath2,A0
	BSR	CopyPath
	LEA	DirInputName,A0
	MOVEQ	#DirNameLength-1,D0
losoloop2
	MOVE.B	(A0)+,(A1)+
	DBF	D0,losoloop2
	MOVE.L	SongDataPtr(PC),DiskDataPtr
	MOVE.L	#FileName,FileNamePtr
	MOVE.L	#70716,DiskDataLength
	LEA	LoadingSongText(PC),A0
	BSR	ShowStatusText
	BSR	DoLoadData
	BEQ	lososkip3
	MOVE.L	SongDataPtr(PC),A0
	CMP.L	#'PACK',(A0)
	BNE.S	lososkip
	MOVE.L	4(A0),CrunchedSongLength
	MOVE.L	8(A0),RealSongLength
	MOVE.L	SongDataPtr(PC),D0
	ADD.L	#70716,D0
	SUB.L	RealSongLength(PC),D0
	MOVE.L	D0,EndOfSongPtr
	LEA	DecrunchingText(PC),A0
	BSR	ShowStatusText
	BSR	Decruncher
	BSR	ShowAllRight
lososkip
	MOVE.L	SongDataPtr(PC),A0
	CMP.L	#'M.K.',sd_mahokakt(A0)		;M.K. again...
	BEQ.S	lososkip2
	BSR	MahoneyAndKaktus		;Was 16 instr, so move up...
lososkip2
	LEA	LoadingSongText(PC),A0
	BSR	ShowStatusText
	BSR	CheckAbort
	BEQ.S	lososkip3
	TST.B	AutoExitFlag
	BEQ.S	NoSongAutoExit
	BSR	ExitFromDir
NoSongAutoExit
	CLR.L	PatternNumber
	CLR.L	CurrPos
	BSR	RedrawPattern
	CLR	ScrPattPos
	BSR	SetScrPatternPos
	BSR	SortDisks
	LEA	SampleSortList(PC),A0
	MOVEQ	#30,D0
losoloop3
	TST.B	NosamplesFlag
	BNE.S	lososkip3
	BSR	CheckAbort
	BEQ.S	lososkip3
	MOVE	InsNum(PC),TuneUp
	JSR	DoShowFreeMem
	MOVE.L	(A0)+,D1
	MOVE	D1,InsNum
	MOVEM.L	D0/D1/A0,-(SP)
	BSR	LoadPreset
	BSR	ShowSampleInfo
	MOVEM.L	(SP)+,D0/D1/A0
	DBF	D0,losoloop3
lososkip3
	MOVE	#1,InsNum
	MOVE.L	#6,CurrSpeed
	CLR	LoadInProgress
	BSR	ShowAllRight
	BSR	SetNormalPtrCol
	JSR	DoShowFreeMem
	BSR	CheckInstrLengths
	BSR	ShowSampleInfo
	BRA	RedrawSample

SortDisks
	MOVEM.L	D0-D4/A0-A1,-(SP)
	MOVE.L	SongDataPtr(PC),A0
	LEA	23(A0),A0
	LEA	SampleSortList(PC),A1
	MOVEQ	#1,D0
losoloop4
	MOVE.B	(A0)+,(A1)+	; ST-(0)1
	MOVE.B	(A0),(A1)+	; ST-0(1)
	MOVE	D0,(A1)+	; insnum
	LEA	29(A0),A0
	ADDQ.L	#1,D0
	CMP.L	#32,D0
	BLO.S	losoloop4
losoloop5
	CLR	MoreInstrFlag
	LEA	SampleSortList(PC),A0
	MOVEQ	#29,D2
losoloop6
	MOVE	(A0),D0
	MOVE	4(A0),D1
	CMP	D0,D1 ; if next disk greater
	BHS.S	loso2_2
	MOVE	#1,MoreInstrFlag
	MOVE.L	(A0),D3 ; swap disks
	MOVE.L	4(A0),D4
	MOVE.L	D4,(A0)
	MOVE.L	D3,4(A0)
loso2_2	ADDQ.L	#4,A0
	DBF	D2,losoloop6
	TST	MoreInstrFlag
	BNE.S	losoloop5
	LEA	SampleSortList(PC),A0
	MOVEQ	#30,D0
losoloop7
	CLR	(A0)
	ADDQ.L	#4,A0
	DBF	D0,losoloop7
	MOVEM.L	(SP)+,D0-D4/A0-A1
	RTS

MahoneyAndKaktus
	LEA	Loadas31Text(PC),A0
	BSR	AreYouSure
	BEQ.S	putmk
	MOVE.L	SongDataPtr(PC),A0	; M.K. 32 samples format!
	LEA	466(A0),A1
	ADD.L	#66006,A0
makloop	MOVE.L	(A0),484(A0)
	CLR.L	(A0)
	SUBQ.L	#4,A0
	CMP.L	A0,A1
	BNE.S	makloop
	MOVE.L	SongDataPtr(PC),A0
	LEA	sd_mahokakt(A0),A1
	LEA	sd_numofpatt(A0),A0
makloop2
	MOVE	4(A0),(A0)+
	CMP.L	A0,A1
	BNE.S	makloop2
	MOVE.L	#'M.K.',(A0)			;M.K. again!
	MOVEQ	#0,D0
	RTS

putmk	MOVE.L	SongDataPtr(PC),A0
	MOVE.L	#'M.K.',sd_mahokakt(A0)		;put M.K.
	MOVEQ	#-1,D0
	RTS

Loadas31Text	dc.b	"Load as 31 instr?",0

CheckInstrLengths
	MOVE.L	SongDataPtr(PC),A0
	ADD.L	#20,A0
	MOVEQ	#30,D1
xilloop	MOVE	26(A0),D0
	ADD	28(A0),D0
	CMP	22(A0),D0
	BLS.S	xilskip
	MOVE	26(A0),D0
	LSR	#1,D0
	MOVE	D0,26(A0)
xilskip	ADD.L	#30,A0
	DBF	D1,xilloop
	RTS

CheckAbort
	BTST	#2,$DFF016
	BNE	Return2
	MOVEM.L	D0-D7/A0-A6,-(SP)
	LEA	AbortLoadText,A0
	BSR	AreYouSure
	BNE.S	chabno
	MOVEM.L	(SP)+,D0-D7/A0-A6
	MOVEQ	#0,D7
	RTS

chabno	MOVEM.L	(SP)+,D0-D7/A0-A6
	MOVEQ	#-1,D7
	RTS

StopIt	BSR.S	DoStopIt
TurnOffVoices
	MOVEM.L	A0-A1,-(SP)
	MOVE	#$000F,$DFF096
	CLR	$DFF0A8
	CLR	$DFF0B8
	CLR	$DFF0C8
	CLR	$DFF0D8
	CLR.B	RawKeyCode
	LEA	ScopeInfo,A0
	LEA	BlankSample,A1
	MOVE.L	A1,(A0)
	MOVE.L	A1,20(A0)
	MOVE.L	A1,40(A0)
	MOVE.L	A1,60(A0)
	MOVEM.L	(SP)+,A0-A1
	RTS

DoStopIt
	BSR	SetNormalPtrCol
	CLR.L	EditMode
	CLR.L	RunMode
	CLR.B	PattDelayTime
	CLR.B	PattDelayTime2
	BRA	RestoreEffects2


;---- Edit ----

Edit	TST	SamScrEnable
	BNE	Return2
	BSR	StopIt
	CLR.B	RawKeyCode
	BSR	SetEditPtrCol
	BSR	SetScrPatternPos
	MOVE.L	#'edit',EditMode
	BRA	WaitForButtonUp

;---- Edit Op. ----

DoEditOp
	CLR.B	RawKeyCode
	CMP	#1,CurrScreen
	BNE	Return2
	TST.B	EdEnable
	BEQ.S	EditOp
	ADDQ.B	#1,EdScreen
	CMP.B	#4,EdScreen
	BLO.S	EditOp
	MOVE.B	#1,EdScreen
EditOp	BSR	WaitForButtonUp
	ST	EdEnable
	ST	DisableAnalyzer
	JSR	ClearAnalyzerColors
	BSR	ClearRightArea
	BRA	DrawEditMenu

EdEnable	dc.b	0
EdScreen	dc.b	1

DrawEditMenu
	CMP.B	#1,EdScreen
	BNE.S	demskip
	MOVE.L	#EditOpText1,ShowTextPtr
	LEA	Edit1Data,A0
	BRA.S	demit
demskip
	CMP.B	#2,EdScreen
	BNE.S	demskip2
	MOVE.L	#EditOpText2,ShowTextPtr
	LEA	Edit2Data,A0
	BRA.S	demit
demskip2
	CMP.B	#3,EdScreen
	BNE	Return2
	MOVE.L	#EditOpText3,ShowTextPtr
	LEA	Edit3Data,A0
demit	BSR	Decompact
	BEQ	ExitEditOp
	LEA	BitPlaneData+SpectrumAnaPos,A0
	MOVEQ	#54,D0
demloop1
	MOVEQ	#24,D1
demloop2
	MOVE.B	1430(A1),PlaneSize(A0)
	MOVE.B	(A1)+,(A0)+
	DBF	D1,demloop2
	LEA	15(A0),A0
	ADDQ.L	#1,A1
	DBF	D0,demloop1
	BSR	FreeDecompMem
	MOVE	#1936,TextOffset
	MOVE	#22,TextLength
	BSR	ShowText
	CMP.B	#1,EdScreen
	BEQ	ShowSampleAll
	CMP.B	#2,EdScreen
	BNE.S	demskip3
	BSR	ShowTrackPatt
	BSR	ShowFrom
	BSR	ShowTo
	BSR	ShowRecordMode
	BSR	ShowQuantize
	BSR	ShowMetronome
	BRA	ShowMultiMode
demskip3
	CMP.B	#3,EdScreen
	BNE	Return2
	BSR	ShowHalfClip
	BSR	ShowPos
	BSR	ShowMod
	BRA	ShowVol

EditOpText1	dc.b	'  track      pattern  '
EditOpText2	dc.b	'  record     samples  '
EditOpText3	dc.b	'    sample editor     '

CheckEditOpGadgs
	MOVE	PattCurPos(PC),D0
	BSR.S	GetPositionPtr
	MOVEM.W	MouseX2,D0/D1
	CMP	#306,D0
	BHS.S	CheckEdSwap
	CMP.B	#1,EdScreen
	BEQ	CheckEdGadg1
	CMP.B	#2,EdScreen
	BEQ	CheckEdGadg2
	CMP.B	#3,EdScreen
	BEQ	CheckEdGadg3
	RTS

GetPositionPtr
	MOVE.L	SongDataPtr(PC),A0
	LEA	sd_patterndata(A0),A0
	MOVE.L	PatternNumber(PC),D2
	LSL.L	#8,D2
	LSL.L	#2,D2
	ADD.L	D2,A0
	MOVEQ	#0,D2
	MOVE	D0,D2
	DIVU	#6,D2
	LSL	#2,D2
	ADD	D2,A0
	RTS

CheckEdSwap
	CMP	#55,D1
	BLS	Return2
	MOVEQ	#1,D2
	CMP	#66,D1
	BLS.S	SetEditOpScreen
	MOVEQ	#2,D2
	CMP	#77,D1
	BLS.S	SetEditOpScreen
	MOVEQ	#3,D2
	CMP	#88,D1
	BLS.S	SetEditOpScreen
	CMP	#99,D1
	BLS.S	ExitEditOp
	RTS

SetEditOpScreen
	MOVE.B	D2,EdScreen
	BRA	EditOp

ExitEditOp
	SF	EdEnable
	CLR.B	RawKeyCode
	BRA	DisplayMainScreen

CheckEdGadg1
	CMP	#55,D1
	BLS	ToggleSampleAll
	CMP	#66,D1
	BLS	NoteUp
	CMP	#77,D1
	BLS	NoteDown
	CMP	#88,D1
	BLS	OctaveUp
	CMP	#99,D1
	BLS	OctaveDown
	RTS

CheckEdGadg2
	CMP	#55,D1
	BLS	ToggleTrackPatt
	CMP	#213,D0
	BLS.S	ceg2left
	CMP	#66,D1
	BLS	DeleteOrKill
	CMP	#77,D1
	BLS	ExchangeOrCopy
	CMP	#88,D1
	BLS	SetSampleFrom
	CMP	#99,D1
	BLS	SetSampleTo
	RTS

ceg2left
	CMP	#66,D1
	BLS	ToggleRecordMode
	CMP	#77,D1
	BLS	SetQuantize
	CMP	#88,D1
	BLS	SetMetronome
	CMP	#99,D1
	BLS	ToggleMultiMode
	RTS

CheckEdGadg3
	MOVE.L	SongDataPtr(PC),A5
	LEA	-10(A5),A5
	MOVE	InsNum(PC),D2
	BNE.S	ceg3skip
	MOVE	LastInsNum,D2
ceg3skip
	MULU	#30,D2
	ADD.L	D2,A5
	CMP	#55,D1
	BLS	ToggleHalfClip
	CMP	#213,D0
	BLS.S	ceg3mid
	CMP	#66,D1
	BLS	SetSamplePos
	CMP	#77,D1
	BLS	SetModSpeed
	CMP	#88,D1
	BLS	CutBeg
	CMP	#99,D1
	BLS	ChangeVolume
	RTS

ceg3mid	CMP	#165,D0
	BLS.S	ceg3left
	CMP	#66,D1
	BLS	Echo
	CMP	#77,D1
	BLS	Filter
	CMP	#88,D1
	BLS	Backwards
	CMP	#99,D1
	BLS	DownSample
	RTS

ceg3left
	CMP	#66,D1
	BLS	Mix
	CMP	#77,D1
	BLS	Boost
	CMP	#88,D1
	BLS	XFade
	CMP	#99,D1
	BLS	UpSample
	RTS

ToggleSampleAll
	BSR	WaitForButtonUp
	EOR.B	#1,SampleAllFlag
ShowSampleAll
	LEA	BitPlaneData+1838,A1
	LEA	S_BoxData,A2
	TST.B	SampleAllFlag
	BEQ	rtdoit2
	LEA	S_BoxData+A_BoxData,A2
rtdoit2	JMP	rtdoit

OctaveUp
	MOVE	#24,NoteShift
	BRA.S	nup2

NoteUp	MOVE	#2,NoteShift
nup2	BSR	SaveUndo
	CMP	#214,D0
	BLS.S	nup3
	MOVEQ	#0,D0
	BSR	GetPositionPtr
	BSR.S	SampleNoteUp
	MOVEQ	#6,D0
	BSR	GetPositionPtr
	BSR.S	SampleNoteUp
	MOVEQ	#12,D0
	BSR	GetPositionPtr
	BSR.S	SampleNoteUp
	MOVEQ	#18,D0
	BSR	GetPositionPtr
nup3	BSR.S	SampleNoteUp
	BRA	RedrawPattern

SampleNoteUp
	MOVEQ	#63,D6
	MOVE.L	A0,A3
	MOVE	InsNum(PC),D3
	TST.B	SampleAllFlag
	BEQ.S	sanulo2
	MOVEQ	#0,D3
sanulo2	MOVE.L	D6,D0
	MOVE.L	A3,A0
sanuloop
	MOVE.B	2(A0),D1
	LSR.B	#4,D1
	MOVE.B	(A0),D2
	AND.B	#$F0,D2
	OR.B	D2,D1
	CMP.B	D3,D1
	BNE.S	sanuskip
	MOVE	(A0),D1
	MOVE	D1,D2
	AND	#$F000,D2
	AND	#$0FFF,D1
	BEQ.S	sanuskip
	BSR	CheckPeriod
	BNE.S	sanuskip
	ADD	NoteShift(PC),D5
	CMP	#$0048,D5
	BLO.S	sanuok
	TST.B	TransDelFlag
	BEQ.S	sanuskip
	AND.L	#$00000FFF,(A0)
	BRA.S	sanuskip
sanuok	MOVE	0(A2,D5.W),D1
	OR	D2,D1
	MOVE	D1,(A0)
sanuskip
	LEA	16(A0),A0
	DBF	D0,sanuloop
	TST.B	SampleAllFlag
	BEQ	Return2
	ADDQ	#1,D3
	CMP	#32,D3
	BLO.S	sanulo2
	RTS

OctaveDown
	MOVE	#24,NoteShift
	BRA.S	ndown2

NoteDown
	MOVE	#2,NoteShift
ndown2	BSR	SaveUndo
	CMP	#214,D0
	BLS.S	ndown3
	MOVEQ	#0,D0
	BSR	GetPositionPtr
	BSR.S	SampleNoteDown
	MOVEQ	#6,D0
	BSR	GetPositionPtr
	BSR.S	SampleNoteDown
	MOVEQ	#12,D0
	BSR	GetPositionPtr
	BSR.S	SampleNoteDown
	MOVEQ	#18,D0
	BSR	GetPositionPtr
ndown3	BSR.S	SampleNoteDown
	BRA	RedrawPattern

SampleNoteDown
	MOVEQ	#63,D6
	MOVE.L	A0,A3
	MOVE	InsNum(PC),D3
	TST.B	SampleAllFlag
	BEQ.S	sandlo2
	MOVEQ	#0,D3
sandlo2	MOVE	D6,D0
	MOVE.L	A3,A0
sandloop
	MOVE.B	2(A0),D1
	LSR.B	#4,D1
	MOVE.B	(A0),D2
	AND.B	#$F0,D2
	OR.B	D2,D1
	CMP.B	D1,D3
	BNE.S	sandskip
	MOVE	(A0),D1
	MOVE	D1,D2
	AND	#$F000,D2
	AND	#$0FFF,D1
	BEQ.S	sandskip
	BSR.S	CheckPeriod
	BNE.S	sandskip
	SUB	NoteShift(PC),D5
	BPL.S	sandok
	TST.B	TransDelFlag
	BEQ.S	sandskip
	AND.L	#$00000FFF,(A0)
	BRA.S	sandskip
sandok	MOVE	0(A2,D5.W),D1
	OR	D2,D1
	MOVE	D1,(A0)
sandskip
	LEA	16(A0),A0
	DBF	D0,sandloop
	TST.B	SampleAllFlag
	BEQ	Return2
	ADDQ	#1,D3
	CMP	#$20,D3
	BLO.S	sandlo2
	RTS

NoteShift
	dc.w	0

CheckPeriod
	LEA	PeriodTable(PC),A2
	MOVEQ	#-2,D5
chpeloop
	ADDQ.L	#2,D5
	MOVE	0(A2,D5.W),D4
	BEQ.S	PeriodNotOk
	CMP	D4,D1
	BEQ.S	PeriodOk
	BRA.S	chpeloop

PeriodOk
	MOVEQ	#0,D4
	RTS

PeriodNotOk
	MOVEQ	#-1,D4
	RTS

ToggleTrackPatt
	BSR	WaitForButtonUp
	ADDQ.B	#1,TrackPattFlag
	CMP.B	#3,TrackPattFlag
	BLO.S	ShowTrackPatt
	CLR.B	TrackPattFlag
ShowTrackPatt
	LEA	BitPlaneData+1838,A1
	LEA	S_BoxData+T_BoxData,A2
	TST.B	TrackPattFlag
	BEQ	rtdoit2
	LEA	S_BoxData+P_BoxData,A2
	CMP.B	#1,TrackPattFlag
	BEQ	rtdoit2
	LEA	S_BoxData,A2
	BRA	rtdoit2

KillInstrTrack
	BSR	SaveUndo
	MOVE	PattCurPos(PC),D0
	BSR	GetPositionPtr
	BRA.S	dst2

DeleteOrKill
	CMP	#260,D0
	BHS	KillSample
DelSampleTrack
	BSR	SaveUndo
	TST.B	TrackPattFlag
	BEQ.S	dst2
	MOVEQ	#0,D0
	BSR	GetPositionPtr
	BSR.S	dstdoit
	MOVEQ	#6,D0
	BSR	GetPositionPtr
	BSR.S	dstdoit
	MOVEQ	#12,D0
	BSR	GetPositionPtr
	BSR.S	dstdoit
	MOVEQ	#18,D0
	BSR	GetPositionPtr
dst2	BSR.S	dstdoit
	BRA	RedrawPattern

dstdoit	CLR.B	RawKeyCode
	MOVEQ	#63,D0
	MOVE	InsNum(PC),D3
	BEQ	NotSampleNull
ksloop	MOVE.B	2(A0),D1
	LSR.B	#4,D1
	MOVE.B	(A0),D2
	AND.B	#$F0,D2
	OR.B	D2,D1
	CMP.B	D1,D3
	BNE.S	ksskip
	CLR.L	(A0)
ksskip	LEA	16(A0),A0
	DBF	D0,ksloop
	RTS

KillSample
	LEA	KillSampleText,A0
	BSR	AreYouSure
	BNE	Return2
Destroy	BSR	StorePtrCol
	MOVE	InsNum(PC),D0
	BEQ	ErrorRestoreCol
	BSR	TurnOffVoices
	BSR	FreeSample
	MOVE.L	SongDataPtr(PC),A0
	MOVE	InsNum(PC),D0
	MULU	#30,D0
	LEA	-10(A0),A0
	ADD.L	D0,A0
	MOVE.L	A0,A1
	MOVEQ	#29,D0
kisalop	CLR.B	(A0)+
	DBF	D0,kisalop
	MOVE	#1,28(A1)
	BSR	ShowSampleInfo
	BSR	RedrawSample
	BRA	RestorePtrCol

ExchangeOrCopy
	MOVEQ	#-1,D4
	CMP	#260,D0
	BHS.S	CopySampleTrack
ExchSampleTrack
	CMP.B	#2,TrackPattFlag
	BEQ	ExchSamples
	MOVEQ	#0,D4
	BRA.S	mstskip
CopySampleTrack
	CMP.B	#2,TrackPattFlag
	BEQ	CopySamples
mstskip	TST.B	TrackPattFlag
	BEQ.S	mst2
	MOVEQ	#0,D0
	BSR	GetPositionPtr
	BSR.S	mstdoit
	MOVEQ	#6,D0
	BSR	GetPositionPtr
	BSR.S	mstdoit
	MOVEQ	#12,D0
	BSR	GetPositionPtr
	BSR.S	mstdoit
	MOVEQ	#18,D0
	BSR	GetPositionPtr
mst2	BSR.S	mstdoit
	BRA	RedrawPattern

mstdoit	MOVEQ	#63,D0
esloop	MOVE.B	2(A0),D1
	LSR.B	#4,D1
	MOVE.B	(A0),D2
	AND.B	#$F0,D2
	OR.B	D2,D1
	CMP.B	SampleFrom(PC),D1
	BNE.S	esskip2
	AND.L	#$0FFF0FFF,(A0)
	MOVE.B	SampleTo(PC),D2
	MOVE.B	D2,D3
	AND.B	#$F0,D2
	OR.B	D2,(A0)
	LSL.B	#4,D3
	OR.B	D3,2(A0)
	BRA.S	esskip3
esskip2	TST.B	D4
	BNE.S	esskip3
	CMP.B	SampleTo(PC),D1
	BNE.S	esskip3
	AND.L	#$0FFF0FFF,(A0)
	MOVE.B	SampleFrom(PC),D2
	MOVE.B	D2,D3
	AND.B	#$F0,D2
	OR.B	D2,(A0)
	LSL.B	#4,D3
	OR.B	D3,2(A0)
esskip3	LEA	16(A0),A0
	DBF	D0,esloop
	RTS

ExchSamples
	BSR	StorePtrCol
	MOVEQ	#0,D0
	MOVE.B	SampleFrom(PC),D0
	BEQ	ErrorRestoreCol
	MOVEQ	#0,D1
	MOVE.B	SampleTo(PC),D1
	BEQ	ErrorRestoreCol
	MOVE	D0,D2
	MOVE	D1,D3
	LEA	SampleLengthAdd+2,A2
	LSL	#1,D2
	LSL	#1,D3
	LEA	(A2,D2.W),A0
	LEA	(A2,D3.W),A1
	MOVE	(A0),D4
	MOVE	(A1),(A0)
	MOVE	D4,(A1)
	LEA	SamplePtrs,A2
	LSL	#1,D2
	LSL	#1,D3
	LEA	(A2,D2.W),A0
	LEA	(A2,D3.W),A1
	MOVE.L	(A0),D4
	MOVE.L	(A1),(A0)
	MOVE.L	D4,(A1)
	MOVE.L	124(A0),D4
	MOVE.L	124(A1),124(A0)
	MOVE.L	D4,124(A1)
	SUBQ	#1,D0
	SUBQ	#1,D1
	MULU	#30,D0
	MULU	#30,D1
	MOVE.L	SongDataPtr(PC),A2
	LEA	20(A2),A2
	LEA	(A2,D0.W),A0
	LEA	(A2,D1.W),A1
	MOVEQ	#29,D0
exsalop	MOVE.B	(A0),D1
	MOVE.B	(A1),(A0)+
	MOVE.B	D1,(A1)+
	DBF	D0,exsalop
	BSR	ShowSampleInfo
	BSR	RedrawSample
	BRA	RestorePtrCol

CopySamples
	BSR	StorePtrCol
	MOVEQ	#0,D0
	MOVE.B	SampleFrom(PC),D0
	BEQ	ErrorRestoreCol
	MOVEQ	#0,D1
	MOVE.B	SampleTo(PC),D1
	BEQ	ErrorRestoreCol
	LEA	SamplePtrs(PC),A2
	LSL	#2,D0
	LSL	#2,D1
	LEA	(A2,D0.W),A3
	LEA	(A2,D1.W),A4
	MOVE.L	(A3),D0
	BEQ	ErrorRestoreCol
	MOVE.L	124(A3),D0
	MOVEQ	#MEMF_CHIP,D1
	MOVE.L	4.W,A6
	JSR	LVOAllocMem(A6)
	TST.L	D0
	BEQ	OutOfMemErr
	MOVE.L	D0,A5
	MOVEQ	#0,D0
	MOVE.B	SampleTo(PC),D0
	MOVE	D0,InsNum
	BSR	Destroy
	MOVE.L	A5,(A4)
	MOVE.L	124(A3),D0
	MOVE.L	D0,124(A4)
	MOVE.L	(A3),A0
cosalp2	MOVE.B	(A0)+,(A5)+
	SUBQ.L	#1,D0
	BNE.S	cosalp2
	MOVEQ	#0,D0
	MOVEQ	#0,D1
	MOVE.B	SampleFrom(PC),D0
	MOVE.B	SampleTo(PC),D1
	MOVE	D1,InsNum
	MULU	#30,D0
	MULU	#30,D1
	MOVE.L	SongDataPtr(PC),A2
	LEA	-10(A2),A2
	LEA	(A2,D0.W),A0
	LEA	(A2,D1.W),A1
	MOVEQ	#29,D0
cosalop	MOVE.B	(A0)+,(A1)+
	DBF	D0,cosalop
	BSR	ShowSampleInfo
	BSR	RedrawSample
	BRA	RestorePtrCol

SetSampleFrom
	MOVE	InsNum(PC),D2
	CMP	#283,D0
	BLS.S	sesfskip
	MOVE.B	SampleFrom(PC),D2
	CMP	#295,D0
	BLS.S	sesfup
	SUBQ.B	#1,D2
	BPL.S	sesfskip
	MOVEQ	#0,D2
sesfskip
	MOVE.B	D2,SampleFrom
	JSR	Wait_4000
	BRA.S	ShowFrom
sesfup	ADDQ.B	#1,D2
	CMP.B	#$1F,D2
	BLS.S	sesfskip
	MOVE.B	#$1F,SampleFrom
ShowFrom
	MOVE	#3273,TextOffset
	CLR	WordNumber
	MOVE.B	SampleFrom(PC),WordNumber+1
	BRA	PrintHexByte

SetSampleTo
	MOVE	InsNum(PC),D2
	CMP	#283,D0
	BLS.S	sestskip
	MOVE.B	SampleTo(PC),D2
	CMP	#295,D0
	BLS.S	sestup
	SUBQ.B	#1,D2
	BPL.S	sestskip
	MOVEQ	#0,D2
sestskip
	MOVE.B	D2,SampleTo
	JSR	Wait_4000
	BRA.S	ShowTo
sestup	ADDQ.B	#1,D2
	CMP.B	#$1F,D2
	BLS.S	sestskip
	MOVE.B	#$1F,SampleTo
ShowTo	MOVE	#3713,TextOffset
	CLR	WordNumber
	MOVE.B	SampleTo(PC),WordNumber+1
	BRA	PrintHexByte

SampleFrom	dc.b 0
SampleTo	dc.b 0

ToggleRecordMode
	BSR	WaitForButtonUp
	EOR.B	#1,RecordMode
ShowRecordMode
	MOVE	#2382,D1
	LEA	PattText,A0
	TST.B	RecordMode
	BEQ.S	srmskip
	LEA	SongText,A0
srmskip	MOVEQ	#4,D0
	BRA	ShowText3

PattText	dc.b 'patt'
SongText	dc.b 'song'
RecordMode	dc.b 0
QuantizeValue	dc.b 1
MetroSpeed	dc.b 4
MetroChannel	dc.b 0
MultiFlag	dc.b 0
SampleAllFlag	dc.b 0
TrackPattFlag	dc.b 0
ClipHalveFlag	dc.b 0
AbortDecFlag	dc.w 0

GetDecByte
	MOVE	#1,AbortDecFlag
	BSR	StorePtrCol
	BSR	SetWaitPtrCol
	BSR	UpdateLineCurPos
	BSR	GetKey0_9
	CMP.B	#68,D1
	BEQ.S	gdbexit
	MOVE.B	D1,D0
	MULU	#10,D0
	MOVE.B	D0,GetDecTemp
	BSR	ShowOneDigit
	ADDQ	#8,LineCurX
	BSR	UpdateLineCurPos
	BSR	GetKey0_9
	CMP.B	#68,D1
	BEQ.S	gdbexit
	ADD.B	D1,GetDecTemp
	CLR	AbortDecFlag
gdbexit	CLR	LineCurX
	MOVE	#270,LineCurY
	BSR	UpdateLineCurPos
	BSR	RestorePtrCol
	MOVE.B	GetDecTemp,D0
	RTS

SetQuantize
	CLR.B	RawKeyCode
	MOVE	#196,LineCurX
	MOVE	#76,LineCurY
	MOVE	#2824,TextOffset
	BSR	GetDecByte
	TST	AbortDecFlag
	BNE	ShowQuantize
	CMP.B	#63,D0
	BLS.S	tqskip
	MOVEQ.B	#63,D0
tqskip	MOVE.B	D0,QuantizeValue
ShowQuantize
	MOVE	#2824,TextOffset
	CLR	WordNumber
	MOVE.B	QuantizeValue,WordNumber+1
	BRA	Print2DecDigits

SetMetronome
	CLR.B	RawKeyCode
	CMP	#188,D0
	BHS.S	smchan
	MOVE	#3261,TextOffset
	MOVE	#172,LineCurX
	MOVE	#87,LineCurY
	BSR	GetDecByte
	TST	AbortDecFlag
	BNE	ShowMetronome
	CMP.B	#64,D0
	BLS.S	smexit
	MOVEQ.B	#64,D0
smexit	MOVE.B	D0,MetroSpeed
	BRA.S	ShowMetronome

smchan	MOVE	#3264,TextOffset
	BSR	GetHexByte
	CMP	#4,D0
	BLS.S	smexit2
	MOVEQ	#4,D0
smexit2	MOVE.B	D0,MetroChannel
ShowMetronome
	MOVE	#3261,TextOffset
	CLR	WordNumber
	MOVE.B	MetroSpeed,WordNumber+1
	BSR	Print2DecDigits
	MOVE	#3264,TextOffset
	CLR	WordNumber
	MOVE.B	MetroChannel,WordNumber+1
	BRA	Print2DecDigits

ToggleMultiMode
	BSR	WaitForButtonUp
	CLR.B	RawKeyCode
	EOR.B	#1,MultiFlag
ShowMultiMode
	BSR.S	Show_MS
	CMP	#1,CurrScreen
	BNE	Return2
	CMP.B	#2,EdScreen
	BNE	Return2
	TST.B	EdEnable
	BEQ	Return2
	MOVE	#3700,D1
	LEA	SingleText(PC),A0
	TST.B	MultiFlag
	BEQ.S	smmskip
	LEA	MultiText(PC),A0
smmskip	MOVEQ	#6,D0
	BRA	ShowText3

SingleText	dc.b 'single'
MultiText	dc.b ' multi'

Show_MS	CMP	#4,CurrScreen
	BEQ	Return2
	MOVE.B	#' ',D0
	TST.B	MultiFlag
	BEQ.S	smsskp1
	MOVE.B	#'M',D0
smsskp1	MOVE.B	#' ',D1
	TST.B	SplitFlag
	BEQ.S	smsskp2
	MOVE.B	#'S',D1
smsskp2	MOVE.B	D0,mstext
	MOVE.B	D1,mstext+1
	MOVE	#4121,D1
	MOVEQ	#2,D0
	LEA	mstext(PC),A0
	BSR	ShowText3
	BRA	ShowAutoInsert

mstext	dc.b '__'

;---- Edit Op. 3 ----

ToggleHalfClip
	BSR	WaitForButtonUp
	EOR.B	#1,HalfClipFlag
ShowHalfClip
	LEA	BitPlaneData+1838,A1
	LEA	S_BoxData+H_BoxData,A2		;&&
	TST.B	HalfClipFlag
	BEQ.S	ogaoga
	LEA	S_BoxData+C_BoxData,A2
ogaoga	JMP	rtdoit

SetSamplePos
	MOVE.L	SamplePos(PC),D2
	CMP	#283,D0
	BLS	Return2
	CMP	#295,D0
	BLS.S	shpoup
	SUBQ.L	#1,D2
	BTST	#2,$DFF016
	BNE.S	shposkip
	SUB.L	#15,D2
shposkip
	BPL.S	shposkip2
	MOVEQ	#0,D2
shposkip2
	MOVE.L	D2,SamplePos
	BRA.S	ShowPos
shpoup	ADDQ.L	#1,D2
	BTST	#2,$DFF016
	BNE.S	shposkip3
	ADD.L	#15,D2
shposkip3
	MOVEQ	#0,D3
	MOVE	22(A5),D3
	LSL.L	#1,D3
	CMP.L	D3,D2
	BLS.S	shposkip2
	MOVE.L	D3,SamplePos
ShowPos	CMP	#1,CurrScreen
	BNE	Return2
	TST.B	EdEnable
	BEQ	Return2
	CMP.B	#3,EdScreen
	BNE	Return2
	MOVE	#2391,TextOffset
	MOVE	SamplePos+2(PC),WordNumber
	BSR	PrintHexWord
	RTS

SetModSpeed
	CMP	#243,D0
	BLS	DoMod
	MOVEQ	#0,D2
	BTST	#2,$DFF016
	BEQ.S	semoskp
	MOVE.B	ModSpeed,D2
	CMP	#283,D0
	BLS	Return2
	CMP	#295,D0
	BLS.S	semoup
	SUB.B	#1,D2
	CMP.B	#127,D2
	BNE.S	semoskp
	MOVE.B	#128,D2
	BRA.S	semoskp
semoup	ADD.B	#1,D2
	CMP.B	#128,D2
	BNE.S	semoskp
	MOVEQ	#127,D2
semoskp	MOVE.B	D2,ModSpeed
	JSR	Wait_4000
ShowMod	LEA	PlusMinusText(PC),A0
	MOVEQ	#0,D6
	MOVE.B	ModSpeed,D6
	BPL.S	shmoskp
	NEG.B	D6
	ADDQ.L	#1,A0
shmoskp	MOVEQ	#1,D0
	MOVE	#2831,D1
	BSR	ShowText3
	MOVE	D6,WordNumber
	BRA	Print3DecDigits

PlusMinusText	dc.b ' -'

DoMod	BSR	WaitForButtonUp
	BSR	StorePtrCol
	BSR	SetWaitPtrCol
	MOVEQ	#0,D2
	MOVE	SampleInfo(PC),D2
	BEQ	ErrorRestoreCol
	LSL	#1,D2
	SUBQ	#1,D2
	MOVE.L	si_pointer,D0
	BEQ	ErrorRestoreCol
	BSR	AllocBuffer
	MOVE.L	D0,A2
	MOVE.L	D0,A3
	MOVE.L	A1,A4
	ADD.L	D2,A3
	CLR.L	ModOffset
	CLR.L	ModPos
dmoloop	CMP.L	A3,A2
	BHS.S	dmoskip
	MOVE.B	(A1),(A2)+
	BSR.S	UpdateMod
	BRA.S	dmoloop
dmoskip	MOVE.L	si_pointer(PC),A1
	CLR	(A1)
	BSR	FreeBuffer
	BSR	RestorePtrCol
	BRA	DisplaySample

UpdateMod
	MOVE.B	ModSpeed(PC),D0
	BEQ.S	upmplus
	EXT	D0
	EXT.L	D0
	MOVE.L	ModPos(PC),D1
	ADD.L	D0,D1
	MOVE.L	D1,ModPos
	ASR.L	#8,D1
	ASR.L	#4,D1
	MOVE.L	D1,D3
	AND	#$1F,D1
	LEA	VibratoTable,A0
	MOVEQ	#0,D0
	MOVE.B	(A0,D1.W),D0
	LSR.B	#2,D0
	MOVE.L	ModOffset(PC),D1
	BTST	#5,D3
	BEQ.S	upmskip
	SUB.L	D0,D1
	BRA.S	upmskp2
upmskip	ADD.L	D0,D1
upmskp2	ADD.L	#$800,D1
	MOVE.L	D1,ModOffset
	ASR.L	#8,D1
	ASR.L	#3,D1
	BPL.S	upmskp3
	MOVEQ	#0,D1
upmskp3	CMP.L	D2,D1
	BLO.S	upmskp4
	MOVE.L	D2,D1
upmskp4	MOVE.L	A4,A1
	ADD.L	D1,A1
	RTS
upmplus	ADDQ.L	#1,A1
	RTS

CutBeg	CMP	#283,D0
	BHI	FadeDown
	CMP	#259,D0
	BHI	FadeUp
	BSR	WaitForButtonUp
	BSR	StorePtrCol
	BSR	SetWaitPtrCol
	MOVEQ	#0,D3
	MOVE	SampleInfo(PC),D3
	BEQ	ErrorRestoreCol
	LSL	#1,D3
	SUBQ	#1,D3
	MOVE.L	si_pointer,D0
	BEQ	ErrorRestoreCol
	MOVE.L	D0,A1
	MOVE.L	D0,A2
	MOVE.L	D0,A3
	ADD.L	SamplePos(PC),A2
	ADD.L	D3,A3
cbeloop	CMP.L	A3,A2
	BHS.S	cbeskip
	MOVE.B	(A2),D0
	CLR.B	(A2)+
	MOVE.B	D0,(A1)+
	BRA.S	cbeloop
cbeskip	MOVE.L	si_pointer(PC),A2
	CLR	(A2)
	SUB.L	A2,A1
	MOVE.L	A1,D0
	LSR.L	#1,D0
	ADDQ.L	#1,D0
	AND	#$7FFF,D0
	MOVE	D0,22(A5)
	BSR	ShowSampleInfo
	BSR	RestorePtrCol
	BRA	DisplaySample

FadeUp	BSR	WaitForButtonUp
	BSR	StorePtrCol
	BSR	SetWaitPtrCol
	MOVEQ	#0,D3
	MOVE	SampleInfo(PC),D3
	BEQ	ErrorRestoreCol
	MOVEQ	#0,D1
	MOVE.L	SamplePos(PC),D2
	BEQ	ErrorRestoreCol
	MOVE.L	si_pointer,D0
	BEQ	ErrorRestoreCol
	MOVE.L	D0,A0
	LSR	#1,D2
	BEQ	ErrorRestoreCol
	MOVEQ	#0,D4
fuloop	MOVE.B	(A0),D0
	EXT	D0
	MULS	D1,D0
	DIVS	D2,D0
	MOVE.B	D0,(A0)+
	ADDQ	#1,D4
	MOVE	D4,D1
	LSR	#1,D1
	CMP	D2,D1
	BLO.S	fuloop
	BSR	RestorePtrCol
	BRA	DisplaySample

FadeDown
	BSR	WaitForButtonUp
	BSR	StorePtrCol
	BSR	SetWaitPtrCol
	MOVEQ	#0,D3
	MOVE	SampleInfo(PC),D3
	BEQ	ErrorRestoreCol
	LSL.L	#1,D3
	SUBQ.L	#1,D3 ;Length-1
	MOVE.L	SamplePos(PC),D2
	CMP.L	D3,D2
	BHS	ErrorRestoreCol
	MOVE.L	D3,D4 ; Copy length to D4
	SUB.L	D2,D3 ; Length-pos
	MOVE.L	D3,D2 ; Copy offset to D2
	MOVE.L	si_pointer,D0
	BEQ	ErrorRestoreCol
	MOVE.L	D0,A0
	LEA	(A0,D4.L),A0 ;Start at end of sample
	LSR	#1,D2
	BEQ	ErrorRestoreCol
	MOVEQ	#0,D1
	MOVEQ	#0,D4
fdloop	MOVE.B	(A0),D0
	EXT	D0
	MULS	D1,D0
	DIVS	D2,D0
	MOVE.B	D0,(A0)
	SUBQ.L	#1,A0
	ADDQ	#1,D4
	MOVE	D4,D1
	LSR	#1,D1
	CMP	D2,D1
	BLO.S	fdloop
	BSR	RestorePtrCol
	BRA	DisplaySample

ChangeVolume
	MOVE	SampleVol(PC),D2
	CMP	#243,D0
	BLS	DoChangeVol
	CMP	#283,D0
	BLS	Return2
	CMP	#295,D0
	BLS	shvoup
	SUBQ	#1,D2
	BTST	#2,$DFF016
	BNE.S	shvoskip
	SUB	#9,D2
shvoskip
	BPL.S	shvoskip2
	MOVEQ	#0,D2
shvoskip2
	MOVE	D2,SampleVol
	JSR	Wait_4000
	BRA.S	ShowVol
shvoup	ADDQ.L	#1,D2
	BTST	#2,$DFF016
	BNE.S	shvoskip3
	ADD	#9,D2
shvoskip3
	CMP	#999,D2
	BLS.S	shvoskip2
	MOVE	#999,SampleVol
	JSR	Wait_4000
ShowVol	MOVE	#3711,TextOffset
	MOVE	SampleVol(PC),WordNumber
	BSR	Print3DecDigits
	LEA	PercentText(PC),A0
	MOVE	#1,TextLength
	BRA	ShowText2

PercentText	dc.b '%',0

DoChangeVol
	BSR	WaitForButtonUp
	BSR	StorePtrCol
	BSR	SetWaitPtrCol
	MOVEQ	#0,D3
	MOVE	SampleInfo(PC),D3
	BEQ	ErrorRestoreCol
	LSL	#1,D3
	SUBQ	#1,D3
	MOVE.L	si_pointer,D0
	BEQ	ErrorRestoreCol
	MOVE.L	D0,A1
	MOVE	SampleVol(PC),D0
dcvloop	MOVE.B	(A1),D1
	EXT	D1
	MULS	D0,D1
	DIVS	#100,D1
	CMP	#127,D1
	BLE.S	dcvskip
	MOVEQ	#127,D1
dcvskip	CMP	#-128,D1
	BGE.S	dcvskp2
	MOVEQ	#-128,D1
dcvskp2	MOVE.B	D1,(A1)+
	DBF	D3,dcvloop
	MOVE.L	si_pointer(PC),A1
	CLR	(A1)
	BSR	RestorePtrCol
	BRA	DisplaySample

Mix	BTST	#2,$DFF016
	BEQ	OldMix
	BSR	WaitForButtonUp
	BSR	StorePtrCol
	BSR	SetWaitPtrCol
	MOVE	#1,GetLineFlag
	MOVE	#4,MixCurPos
mixlopx	BSR	DisplayMix
	BSR	GetHexKey
	TST.B	D0
	BNE.S	mixnzro
	CMP.B	#68,MixChar
	BEQ	Mix2
	CMP.B	#69,MixChar
	BEQ	EndMix
	BTST	#2,$DFF016
	BEQ	EndMix
mixpchr	LEA	MixText(PC),A0
	LEA	FastHexTable+1,A1
	LSL	#1,D1
	MOVE	MixCurPos(PC),D0
	MOVE.B	(A1,D1.W),(A0,D0.W)
MixMoveRight
	MOVE	MixCurPos,D0
	ADDQ	#1,D0
	CMP	#6,D0
	BEQ.S	mmrp1
	CMP	#9,D0
	BEQ.S	mmrp2
	CMP	#15,D0
	BHS.S	mmrp3
mmrok	MOVE	D0,MixCurPos
	BRA	mixlopx
mmrp1	MOVEQ	#7,D0
	BRA.S	mmrok
mmrp2	MOVEQ	#13,D0
	BRA.S	mmrok
mmrp3	MOVEQ	#14,D0
	BRA.S	mmrok

mixnzro	CMP.B	#1,D0
	BEQ.S	MixMoveRight
MixMoveLeft
	MOVE	MixCurPos,D0
	SUBQ	#1,D0
	CMP	#4,D0
	BLO.S	mmlp1
	CMP	#6,D0
	BEQ.S	mmlp2
	CMP	#12,D0
	BEQ.S	mmlp3
	BRA.S	mmrok
mmlp1	MOVEQ	#4,D0
	BRA.S	mmrok
mmlp2	MOVEQ	#5,D0
	BRA.S	mmrok
mmlp3	MOVEQ	#8,D0
	BRA.S	mmrok

DisplayMix
	MOVE	#53,LineCurY
	MOVE	MixCurPos,D0
	LSL	#3,D0
	ADD	#132,D0
	MOVE	D0,LineCurX
	BSR	UpdateLineCurPos
	LEA	MixText(PC),A0
	MOVE	#1936,D1
	MOVEQ	#22,D0
	BSR	ShowText3
	JSR	Wait_4000
	JSR	Wait_4000
	JMP	Wait_4000

MixText	dc.b 'mix 01+02 to 03       '
MixChar	dc.b 0,0
MixCurPos dc.w 0
ToSam		dc.w 0
FromPtr1	dc.l 0
FromPtr2	dc.l 0
ToPtr		dc.l 0
MixPtr		dc.l 0
MixLength	dc.l 0

EndMix	CLR.B	RawKeyCode
	BSR	RestoreMix
	BRA	RestorePtrCol

RestoreMix
	CLR	GetLineFlag
	MOVE	#270,LineCurY
	CLR	LineCurX
	BSR	UpdateLineCurPos
	LEA	EditOpText3(PC),A0
	MOVE	#1936,D1
	MOVEQ	#22,D0
	BRA	ShowText3

Mix2	BSR	RestoreMix
	BSR	TurnOffVoices
	LEA	SamplePtrs,A2
	MOVEQ	#0,D0
	LEA	MixText+4(PC),A0
	BSR	HexToInteger2
	TST	D0
	BEQ	SamOutOfRange
	CMP	#$1F,D0
	BHI	SamOutOfRange
	LSL	#2,D0
	LEA	(A2,D0.W),A3
	MOVE.L	A3,FromPtr1

	MOVEQ	#0,D0
	LEA	MixText+7(PC),A0
	BSR	HexToInteger2
	TST	D0
	BEQ	SamOutOfRange
	CMP	#$1F,D0
	BHI	SamOutOfRange
	LSL	#2,D0
	LEA	(A2,D0.W),A3
	MOVE.L	A3,FromPtr2

	MOVEQ	#0,D0
	LEA	MixText+13(PC),A0
	BSR	HexToInteger2
	MOVE	D0,ToSam
	BEQ	SamOutOfRange
	CMP	#$1F,D0
	BHI	SamOutOfRange
	LSL	#2,D0
	LEA	(A2,D0.W),A3
	MOVE.L	A3,ToPtr

	MOVE.L	FromPtr1,A1
	MOVE.L	FromPtr2,A2
	MOVE.L	124(A1),D1
	MOVE.L	124(A2),D2
	CMP.L	D1,D2
	BLO.S	mixnswp
	EXG	D1,D2
mixnswp	TST.L	D1
	BEQ	SamEmptyError ; Both samples had length=0
	MOVE.L	D1,D0
	AND.L	#$FFFF,D0
	MOVE.L	D0,MixLength
	MOVE.L	#MEMF_CHIP!MEMF_CLEAR,D1
	MOVE.L	4.W,A6
	JSR	LVOAllocMem(A6)
	MOVE.L	D0,MixPtr
	BEQ	SamMemError ; No memory for new sample...

	LEA	mixingtext(PC),A0
	BSR	ShowStatusText
	MOVE.L	FromPtr1(PC),A1
	MOVE.L	124(A1),D1
	MOVE.L	(A1),A1
	MOVE.L	FromPtr2(PC),A2
	MOVE.L	124(A2),D2
	MOVE.L	(A2),A2
	MOVE.L	MixPtr(PC),A3
	MOVE.L	MixLength,D3
	TST	D1
	BEQ.S	mixnd1
	SUBQ	#1,D1
mixnd1	TST	D2
	BEQ.S	mixnd2
	SUBQ	#1,D2
mixnd2	SUBQ	#1,D3

mixlop2	MOVE.B	(A1),D4
	EXT	D4
	MOVE.B	(A2),D0
	EXT	D0
	ADD	D4,D0
	TST.B	HalfClipFlag
	BEQ	mixhalf
	CMP	#127,D0
	BLE.S	mixnbig
	MOVEQ	#127,D0
mixnbig	CMP	#-128,D0
	BGE	mixokok
	MOVEQ	#-128,D0
	BRA	mixokok
mixhalf	ASR	#1,D0
mixokok	MOVE.B	D0,(A3)+

	TST	D1
	BEQ.S	zerd1
	ADDQ.L	#1,A1
	SUBQ	#1,D1
	BNE.S	zerd1
	SUB.L	A1,A1

zerd1	TST	D2
	BEQ.S	zerd2
	ADDQ.L	#1,A2
	SUBQ	#1,D2
	BNE.S	zerd2
	SUB.L	A2,A2

zerd2	DBF	D3,mixlop2
	MOVE	ToSam(PC),InsNum
	BSR	FreeSample
	MOVE.L	ToPtr(PC),A0
	MOVE.L	MixPtr(PC),A1
	CLR	(A1)
	MOVE.L	A1,(A0)
	MOVE.L	MixLength(PC),124(A0)
	MOVE.L	SongDataPtr(PC),A0
	MOVE	ToSam(PC),D0
	SUBQ	#1,D0
	MULU	#30,D0
	LEA	20(A0,D0.W),A0
	MOVE.L	MixLength(PC),D0
	LSR	#1,D0
	MOVE	D0,22(A0)
	MOVE	#$0040,24(A0)
	MOVE	#$0000,26(A0)
	MOVE	#$0001,28(A0)
	BSR	RestorePtrCol
	BSR	ShowAllRight
	BSR	ShowSampleInfo
	BRA	DisplaySample

SamOutOfRange
	LEA	mixerrtext1(PC),A0
	BSR	ShowStatusText
	BRA	ErrorRestoreCol
SamEmptyError
	LEA	mixerrtext2(PC),A0
	BSR	ShowStatusText
	BRA	ErrorRestoreCol
SamMemError
	LEA	mixerrtext3(PC),A0
	BSR	ShowStatusText
	BRA	ErrorRestoreCol
OutOfMemErr
	LEA	mixerrtext3(PC),A0
	BSR	ShowStatusText
	BSR	SetErrorPtrCol
	MOVEQ	#0,D0
	RTS

mixerrtext1	dc.b 'not range 01-1F !',0
mixerrtext2	dc.b 'empty samples !!!',0
mixerrtext3	dc.b 'out of memory !!!',0
mixingtext	dc.b 'mixing samples...',0

OldMix	MOVE.L	SamplePos(PC),FlangePos
DoMix	BSR	StorePtrCol
	BSR	SetWaitPtrCol
	MOVEQ	#0,D2
	MOVE	SampleInfo(PC),D2 ; 22(A0)
	BEQ	Return2
	LSL	#1,D2
	MOVE.L	si_pointer(PC),D0
	BEQ	ErrorRestoreCol
	BSR	AllocBuffer
	MOVE.L	D0,A2
	MOVE.L	D0,A3
	MOVE.L	A1,A4
	ADD.L	D2,A3
	ADD.L	FlangePos(PC),A2
	CLR.L	ModOffset
	CLR.L	ModPos
	MOVEQ	#-1,D7
mixloop	ADDQ.L	#1,D7
	CMP.L	A3,A2
	BHS	mixskip
	MOVE.L	MarkStartOfs(PC),D0
	BMI.S	omxget
	MOVE.L	MarkEndOfs(PC),D1
	CMP.L	D0,D1
	BEQ.S	omxget
	CMP.L	D0,D7
	BLO.S	omxok2
	CMP.L	D1,D7
	BHI.S	omxok2
omxget	MOVE.B	(A2),D0
	EXT	D0
	MOVE.B	(A1),D1
	EXT	D1
	ADD	D1,D0
	TST.B	HalfClipFlag
	BEQ.S	omxhalf
	CMP	#127,D0
	BLE.S	omxnbig
	MOVEQ	#127,D0
omxnbig	CMP	#-128,D0
	BGE.S	omxokok
	MOVEQ	#-128,D0
	BRA.S	omxokok
omxhalf	ASR	#1,D0
omxokok	MOVE.B	D0,(A2)+
	BSR	UpdateMod
	BRA.S	mixloop
omxok2	ADDQ.L	#1,A2
	BSR	UpdateMod
	BRA.S	mixloop

mixskip	MOVE.L	si_pointer(PC),A1
	CLR	(A1)
	BSR	FreeBuffer
	BSR	RestorePtrCol
	BSR	WaitForButtonUp
	TST	DispOrRedraw
	BEQ	DisplaySample
	CLR	DispOrRedraw
	BRA	RedrawSample

DispOrRedraw	dc.w 0

AllocBuffer
	MOVE.L	D0,D7
	MOVE.L	D2,D0
	MOVE.L	D2,BufMemSize
	MOVE.L	#MEMF_CLEAR,D1
	MOVE.L	4.W,A6
	JSR	LVOAllocMem(A6)
	MOVE.L	D0,BufMemPtr
	BEQ	OutOfMemErr
	MOVE.L	D7,A0
	MOVE.L	D0,A1
	MOVE.L	BufMemSize(PC),D0
	SUBQ.L	#1,D0
albloop	MOVE.B	(A0)+,(A1)+
	DBF	D0,albloop
	MOVE.L	BufMemPtr(PC),A1
	MOVE.L	D7,D0
	RTS

FreeBuffer
	MOVE.L	BufMemPtr(PC),D0
	BEQ	Return2
	MOVE.L	D0,A1
	MOVE.L	BufMemSize(PC),D0
	MOVE.L	4.W,A6
	JSR	LVOFreeMem(A6)
	CLR.L	BufMemPtr
	RTS

Echo	MOVE.L	SamplePos(PC),FlangePos
	BSR	WaitForButtonUp
	BSR	StorePtrCol
	BSR	SetWaitPtrCol
	MOVEQ	#0,D2
	MOVE	SampleInfo(PC),D2 ; 22(A0)
	BEQ	ErrorRestoreCol
	LSL	#1,D2
	MOVE.L	si_pointer(PC),D0
	BEQ	ErrorRestoreCol
	MOVE.L	D0,A1
	MOVE.L	D0,A2
	MOVE.L	D0,A3
	MOVE.L	D0,A4
	ADD.L	D2,A3
	ADD.L	FlangePos(PC),A2
	CLR.L	ModOffset
	CLR.L	ModPos
flaloop	CMP.L	A3,A2
	BHS	flaskip
	MOVE.B	(A2),D0
	EXT	D0
	MOVE.B	(A1),D1
	EXT	D1
	ADD	D1,D0
	ASR	#1,D0
	MOVE.B	D0,(A2)+
	BSR	UpdateMod
	BRA	flaloop
flaskip	MOVE.L	si_pointer(PC),A1
	CLR	(A1)
	BSR	RestorePtrCol
	TST.B	HalfClipFlag
	BEQ	DisplaySample
	MOVE	SampleVol,-(SP)
	MOVE	#200,SampleVol
	BSR	DoChangeVol
	MOVE	(SP)+,SampleVol
	BRA	DisplaySample

Filter2	MOVE	#1,DispOrRedraw
Filter	CLR.B	RawKeyCode
	LEA	FilteringText,A0
	BSR	ShowStatusText
	MOVE.L	#1,FlangePos
	MOVE.B	ModSpeed(PC),-(SP)
	MOVE.B	HalfClipFlag,-(SP)
	CLR.B	ModSpeed
	CLR.B	HalfClipFlag
	BSR	DoMix
	MOVE.B	(SP)+,HalfClipFlag
	MOVE.B	(SP)+,ModSpeed
	BRA	ShowAllRight

FilteringText	dc.b 'filtering',0

Boost	BSR.S	Boost3
	BRA	DisplaySample
Boost2	BSR.S	Boost3
	BRA	RedrawSample
Boost3	CLR.B	RawKeyCode
	BSR	WaitForButtonUp
	BSR	StorePtrCol
	BSR	SetWaitPtrCol
	LEA	BoostingText,A0
	BSR	ShowStatusText
	MOVEQ	#0,D3
	MOVE	SampleInfo(PC),D3
	BEQ	booend
	LSL	#1,D3
	SUBQ	#1,D3
	MOVE.L	si_pointer(PC),D0
	BEQ	booend
	MOVE.L	D0,A1
	MOVE.L	MarkStartOfs(PC),D0
	BMI.S	booskp1
	MOVE.L	MarkEndOfs(PC),D1
	SUB.L	D0,D1
	BEQ.S	booskp1
	MOVE.L	D1,D3
	MOVE.L	SamStart(PC),A1
	ADD.L	D0,A1
booskp1	MOVEQ	#0,D0
booloop	MOVE.B	(A1),D1
	EXT	D1
	MOVE	D1,D2
	SUB	D0,D1
	MOVE	D2,D0
	TST	D1
	BMI	booneg
	ASR	#2,D1
	ADD	D1,D2
	BRA	booskip
booneg	NEG	D1
	ASR	#2,D1
	SUB	D1,D2
booskip	CMP	#127,D2
	BLE	booskp2
	MOVEQ	#127,D2
booskp2	CMP	#-128,D2
	BGE	booskp3
	MOVEQ	#-128,D2
booskp3	MOVE.B	D2,(A1)+
	DBF	D3,booloop
	MOVE.L	si_pointer(PC),A1
	CLR	(A1)
booend	BSR	ShowAllRight
	BRA	RestorePtrCol

BoostingText	dc.b 'boosting',0,0

XFade	JSR	WaitForButtonUp
	BSR	StorePtrCol
	BSR	SetWaitPtrCol
	MOVEQ	#0,D2
	MOVE	SampleInfo(PC),D2 ; 22(A0)
	BEQ	ErrorRestoreCol
	ADD	D2,D2
	MOVE.L	si_pointer(PC),D0
	BEQ	ErrorRestoreCol
	MOVE.L	D0,A1
	MOVE.L	D0,A2
	ADD.L	D2,A2
xfaloop	MOVE.B	(A1),D0
	EXT	D0
	MOVE.B	-(A2),D1
	EXT	D1
	ADD	D1,D0
	TST.B	HalfClipFlag
	BEQ	xfahalf
	CMP	#127,D0
	BLE	xfanbig
	MOVEQ	#127,D0
xfanbig	CMP	#-128,D0
	BGE	xfaokok
	MOVEQ	#-128,D0
	BRA	xfaokok
xfahalf	ASR	#1,D0
xfaokok	MOVE.B	D0,(A1)+
	MOVE.B	D0,(A2)
	CMP.L	A2,A1
	BLO.S	xfaloop
	MOVE.L	si_pointer(PC),A1
	CLR	(A1)
	BSR	RestorePtrCol
	BRA	DisplaySample

Backwards
	JSR	WaitForButtonUp
	JSR	StorePtrCol
	JSR	SetWaitPtrCol
	MOVEQ	#0,D2
	MOVE	22(A5),D2
	BEQ	ErrorRestoreCol
	MOVE.L	si_pointer(PC),D0
	BEQ	ErrorRestoreCol
	MOVE.L	D0,A1
	MOVE.L	D0,A2
	ADD.L	D2,D2
	ADD.L	D2,A2
	MOVE.L	MarkStartOfs(PC),D0
	BMI.S	bacloop
	MOVE.L	MarkEndOfs(PC),D1
	SUB.L	D0,D1
	BEQ.S	bacloop
	MOVE.L	SamStart(PC),A1
	ADD.L	D0,A1
	MOVE.L	A1,A2
	ADD.L	D1,A2
bacloop	MOVE.B	(A1),D0
	MOVE.B	-(A2),(A1)+
	MOVE.B	D0,(A2)
	CMP.L	A2,A1
	BLO.S	bacloop
	MOVE.L	si_pointer(PC),A1
	CLR	(A1)
	BSR	RestorePtrCol
	BRA	DisplaySample

UpSample
	JSR	WaitForButtonUp
	LEA	UpsampleText,A0
	JSR	AreYouSure
	BNE	Return2
	BSR	TurnOffVoices
	JSR	StorePtrCol
	JSR	SetWaitPtrCol
	MOVE	InsNum(PC),D0
	LSL	#2,D0
	LEA	SamplePtrs(PC),A0
	LEA	(A0,D0.W),A0
	MOVE.L	124(A0),D3
	CMP.L	#2,D3
	BLS	ErrorRestoreCol2
	MOVE.L	(A0),D0
	BEQ	ErrorRestoreCol2
	MOVE.L	D0,A2
	MOVE.L	D0,A4
	MOVE.L	D3,D4
	LSR.L	#1,D3
	BCLR	#0,D3
	MOVE.L	D3,D0
	MOVEQ	#MEMF_CHIP,D1
	MOVE.L	4.W,A6
	JSR	LVOAllocMem(A6)
	TST.L	D0
	BEQ.S	upserro
	MOVE.L	D0,A3
	MOVE.L	D0,D2
	MOVE.L	D3,D5
	SUBQ.L	#1,D3
upsloop	MOVE.B	(A2)+,(A3)+
	ADDQ.L	#1,A2
	DBF	D3,upsloop
	MOVE.L	A4,A1
	MOVE.L	D4,D0
	MOVE.L	4.W,A6
	JSR	LVOFreeMem(A6)
	MOVE	InsNum(PC),D0
	LSL	#2,D0
	LEA	SamplePtrs(PC),A0
	LEA	(A0,D0.W),A0
	MOVE.L	D2,(A0)
	MOVE.L	D5,124(A0)
	MOVE.L	D2,A0
	CLR	(A0)
	MOVE	22(A5),D0
	LSR	#1,D0
	MOVE	D0,22(A5)
	MOVE	26(A5),D0
	LSR	#1,D0
	MOVE	D0,26(A5)
	MOVE	28(A5),D0
	LSR	#1,D0
	BNE	upsskip2
	MOVEQ	#1,D0
upsskip2
	MOVE	D0,28(A5)
	BSR	ShowSampleInfo
	JSR	WaitForButtonUp
	JSR	RestorePtrCol
	BRA	RedrawSample

upserro	JSR	RestorePtrCol
	BRA	OutOfMemErr

DownSample
	JSR	WaitForButtonUp
	TST	InsNum
	BEQ	NotSampleNull
	LEA	DownSampleText,A0
	JSR	AreYouSure
	BNE	Return2
	BSR	TurnOffVoices
	JSR	StorePtrCol
	JSR	SetWaitPtrCol
	MOVE.L	si_pointer(PC),D0
	BEQ	ErrorRestoreCol2
	MOVEQ	#0,D0
	MOVE	SampleInfo(PC),D0
	BEQ	ErrorRestoreCol2
	LSL.L	#1,D0
	CMP.L	#$FFFE,D0
	BHI	ErrorRestoreCol2
	LSL.L	#1,D0
	CMP.L	#$FFFE,D0
	BLS	dnsskip
	MOVE.L	#$FFFE,D0
dnsskip	MOVE.L	D0,BufMemSize
	MOVEQ	#MEMF_CHIP,D1
	MOVE.L	4.W,A6
	JSR	LVOAllocMem(A6)
	MOVE.L	D0,BufMemPtr
	BEQ	SamMemError
	MOVE.L	si_pointer(PC),A1
	MOVE.L	D0,A2
	MOVE.L	BufMemSize,D3
	LSR.L	#1,D3
	SUBQ.L	#1,D3
dnsloop	MOVE.B	(A1)+,D0
	MOVE.B	D0,(A2)+
	MOVE.B	D0,(A2)+
	DBF	D3,dnsloop
	BSR	FreeSample
	LEA	SamplePtrs,A0
	MOVE	InsNum(PC),D0
	LSL	#2,D0
	MOVE.L	BufMemPtr,(A0,D0.W)
	MOVE.L	BufMemSize,124(A0,D0.W)
	MOVE	22(A5),D0
	LSL	#1,D0
	CMP	#$7FFF,D0
	BLS	dnsok1
	MOVE	#$7FFF,D0
dnsok1	MOVE	D0,22(A5)
	MOVE	26(A5),D0
	LSL	#1,D0
	CMP	#$7FFF,D0
	BLS	dnsok2
	MOVE	#$7FFF,D0
dnsok2	MOVE	D0,26(A5)
	MOVE	28(A5),D0
	CMP	#1,D0
	BEQ	dnsok3
	LSL	#1,D0
	CMP	#$7FFF,D0
	BLS	dnsok3
	MOVE	#$7FFF,D0
dnsok3	MOVE	D0,28(A5)
	BSR	ShowSampleInfo
	JSR	WaitForButtonUp
	JSR	RestorePtrCol
	BSR	RedrawSample
	RTS

SamplePos	dc.l	0
SampleVol	dc.w	100
FlangePos	dc.l	0
ModSpeed	dc.b	0
HalfClipFlag	dc.b	0
ModPos		dc.l	0
ModOffset	dc.l	0
BufMemPtr	dc.l	0
BufMemSize	dc.l	0




ErrorRestoreCol2
	JMP	ErrorRestoreCol



;---- Save Song ----
SaveSong
	BSR	StopIt
	CLR.B	RawKeyCode
	MOVE.L	SongDataPtr(PC),A0
	LEA	SampleLengthAdd(PC),A1
	MOVEQ	#0,D0
	MOVEQ	#2,D1
sadloop	MOVE	(A1,D1.W),D2
	ADD	D2,42(A0,D0.W)
	ADD	#30,D0
	ADDQ	#2,D1
	CMP	#62,D1
	BNE	sadloop

	LEA	sd_pattpos(A0),A0
	MOVEQ	#0,D0
	MOVEQ	#0,D1
	MOVEQ	#0,D2
	CLR	HighPattNum
ssloop	MOVE.B	0(A0,D0.W),D1
	ADDQ	#1,D0
	CMP	#128,D0
	BHI	DoSaveSong
	MOVE	HighPattNum(PC),D2
	CMP	D2,D1
	BLS	ssloop
	MOVE	D1,HighPattNum
	BRA	ssloop

DoSaveSong
	LEA	SongsPath2,A0
	JSR	CopyPath
	MOVE.L	SongDataPtr(PC),A0
	MOVEQ	#19,D0
dssloop	MOVE.B	(A0)+,(A1)+
	DBF	D0,dssloop
	MOVE.L	#FileName,FileNamePtr
	MOVE.L	SongDataPtr(PC),DiskDataPtr
	MOVE.L	#1084,DiskDataLength
	MOVEQ	#0,D0
	MOVE	HighPattNum,D0
	ADDQ.L	#1,D0
	LSL.L	#8,D0
	LSL.L	#2,D0
	ADD.L	D0,DiskDataLength
	MOVE.B	PackMode,D0
	BTST	#0,D0
	BEQ	dssnocr
	LEA	CrunchingText(PC),A0
	BSR	ShowStatusText
	BSR	Cruncher
dssnocr	BSR	DoSaveData
	MOVE.B	PackMode,D0
	BTST	#0,D0
	BEQ	dssnoc2
	LEA	DecrunchingText(PC),A0
	BSR	ShowStatusText
	BSR	Decruncher
dssnoc2	MOVE.L	SongDataPtr(PC),A0
	LEA	SampleLengthAdd(PC),A1
	MOVEQ	#0,D0
	MOVEQ	#2,D1
ssuloop	MOVE	(A1,D1.W),D2
	SUB	D2,42(A0,D0.W)
	ADD	#30,D0
	ADD	#2,D1
	CMP	#62,D1
	BNE	ssuloop
	BSR	ShowAllRight
SetNormalPtrCol2
	JMP	SetNormalPtrCol

Cruncher
	BSR	SetNormalPtrCol2
	MOVE.L	SongDataPtr(PC),A0
	MOVE.L	A0,A1
	LEA	12(A1),A1
	MOVE.L	A1,SongPlus12Ptr
	MOVE.L	A0,A1
	ADD.L	#70716,A1	; hoeh...
	MOVE.L	A1,SongPlus70kPtr
	MOVE.L	A0,A1
	ADD.L	#70716,A1
	SUB.L	DiskDataLength(PC),A1
	MOVE.L	A1,EndOfSongPtr
	MOVE.L	DiskDataLength(PC),RealSongLength
	MOVE.L	SongDataPtr(PC),A0
	ADD.L	DiskDataLength(PC),A0
	MOVE.L	SongDataPtr(PC),A1
	ADD.L	#70716,A1
	MOVE.L	DiskDataLength(PC),D0
cloop	MOVE.B	-(A0),-(A1)
	SUBQ.L	#1,D0
	BNE	cloop
	BSR	DoCrunch
	SUB.L	SongPlus12Ptr(PC),A2
	MOVE.L	A2,D0
	MOVE.L	D0,CrunchedSongLength
	MOVE.L	D0,D1
	ADD.L	SongPlus12Ptr(PC),D1
	MOVE.L	D1,DontKnowWhat
	MOVE.L	SongDataPtr(PC),A0
	MOVE.L	#'PACK',(A0)
	MOVE.L	CrunchedSongLength,4(A0)
	MOVE.L	RealSongLength(PC),8(A0)
	MOVE.L	SongDataPtr(PC),DiskDataPtr
	MOVE.L	CrunchedSongLength(PC),D0
	ADD.L	#12,D0
	MOVE.L	D0,DiskDataLength
	RTS
 
EndOfSongPtr		dc.l	0
SongPlus70kPtr		dc.l	0
RealSongLength		dc.l	0
SongPlus12Ptr		dc.l	0
DontKnowWhat		dc.l	0
CrunchedSongLength	dc.l	0

DoCrunch
	MOVE.L	EndOfSongPtr(PC),A0
	MOVE.L	SongPlus70kPtr(PC),A1
	MOVE.L	SongPlus12Ptr(PC),A2
	MOVEQ	#1,D2
	CLR	D1
dcloop	BSR	DoCrunch2
	TST.B	D0
	BEQ	dcskip
	ADDQ	#1,D1
	CMP	#$0108,D1
	BNE	dcskip
	BSR	DoCrunch6
dcskip	CMP.L	A0,A1
	BGT	dcloop
	BSR	DoCrunch6
	BRA	DoCrunch8
 
DoCrunch2
	MOVE.L	A0,A3
	LEA	127(A3),A3
	CMP.L	A1,A3
	BLE	dc2skip
	MOVE.L	A1,A3
dc2skip	MOVEQ	#1,D5
	MOVE.L	A0,A5
	ADDQ.L	#1,A5
dc2_1	MOVE.B	(A0),D3
	MOVE.B	1(A0),D4
	MOVE	D3,$DFF1A2
dc2loop	CMP.B	(A5)+,D3
	BNE	dc2skip2
	CMP.B	(A5),D4
	BEQ	DoCrunch3
dc2skip2
	CMP.L	A5,A3
	BGT	dc2loop
	BRA	dc4_3
 
DoCrunch3
	SUBQ.L	#1,A5
	MOVE.L	A0,A4
dc3loop	MOVE.B	(A4)+,D3
	CMP.B	(A5)+,D3
	BNE	dc3skip
	CMP.L	A5,A3
	BGT	dc3loop
dc3skip	MOVE.L	A4,D3
	SUB.L	A0,D3
	SUBQ.L	#1,D3
	CMP.L	D3,D5
	BGE	dc4_2
	MOVE.L	A5,D4
	SUB.L	A0,D4
	SUB.L	D3,D4
	SUBQ.L	#1,D4
	CMP.L	#4,D3
	BLE	DoCrunch4
	MOVEQ	#6,D6
	CMP.L	#$00000101,D3
	BLT	dc3skip2
	MOVE	#$0100,D3
dc3skip2
	BRA	dc4_1
 
DoCrunch4
	MOVE	D3,D6
	SUBQ	#2,D6
	LSL	#1,D6
dc4_1	LEA	CrunchData3(PC),A6
	CMP	0(A6,D6.W),D4
	BGE	dc4_2
	MOVE.L	D3,D5
	MOVE.L	D4,CrunchData1
	MOVE.B	D6,CrunchData2
dc4_2	CMP.L	A5,A3
	BGT	dc2_1
dc4_3	CMP.L	#1,D5
	BEQ	DoCrunch5
	BSR	DoCrunch6
	MOVE.B	CrunchData2(PC),D6
	MOVE.L	CrunchData1(PC),D3
	MOVE	8(A6,D6.W),D0
	BSR	DoCrunch7
	MOVE	$0010(A6,D6.W),D0
	BEQ	dc4skip
	MOVE.L	D5,D3
	SUBQ	#1,D3
	BSR	DoCrunch7
dc4skip	MOVE	$0018(A6,D6.W),D0
	MOVE	$0020(A6,D6.W),D3
	BSR	DoCrunch7
	ADDQ	#1,$0028(A6,D6.W)
	ADD.L	D5,A0
	CLR.B	D0
	RTS
 
DoCrunch5
	MOVE.B	(A0)+,D3
	MOVEQ	#8,D0
	BSR	DoCrunch7
	MOVEQ	#1,D0
	RTS
 
CrunchData1	dc.l	0
CrunchData2	dc.b	0,0
CrunchData3	dc.w	$0100,$0200,$0400,$1000,8,9,10,8
		dc.w	0,0,0,8,2,3,3,3,1,4,5,6,0,0,0,0
CrunchData4	dc.w	0
CrunchData5	dc.w	0

DoCrunch6
	TST	D1
	BEQ	Return2
	MOVE	D1,D3
	CLR	D1
	CMP	#9,D3
	BGE	dc6_2
	ADDQ	#1,CrunchData4
	SUBQ	#1,D3
	MOVEQ	#5,D0
	BRA	DoCrunch7
 
dc6_2	ADDQ	#1,CrunchData5
	SUB	#9,D3
	OR	#$0700,D3
	MOVEQ	#11,D0
DoCrunch7
	SUBQ	#1,D0
dc7loop	LSR.L	#1,D3
	ROXL.L	#1,D2
	BCS	dc8_2
	DBF	D0,dc7loop
	RTS
 
DoCrunch8
	CLR	D0
dc8_2	MOVE.L	D2,(A2)+
	MOVEQ	#1,D2
	DBF	D0,dc7loop
	RTS


Decruncher
	MOVE.L	SongDataPtr(PC),A0
	LEA	12(A0),A0
	MOVE.L	EndOfSongPtr(PC),A1
	MOVE.L	CrunchedSongLength(PC),D0
	MOVE.L	RealSongLength(PC),D1
	BSR	DoDecrunch
	MOVE.L	EndOfSongPtr(PC),A0
	MOVE.L	SongDataPtr(PC),A1
	MOVE.L	RealSongLength(PC),D0
ddcloop	MOVE.B	(A0)+,(A1)+
	SUBQ.L	#1,D0
	BNE	ddcloop
	MOVE.L	SongDataPtr(PC),A0
	ADD.L	#$0001143C,A0
	MOVE.L	SongDataPtr(PC),A1
	ADD.L	RealSongLength(PC),A1
	SUB.L	A1,A0
	MOVE.L	A0,D0
ddcloop2
	CLR.B	(A1)+
	SUBQ.L	#1,D0
	BNE	ddcloop2
	RTS

DoDecrunch
	ADD.L	D0,A0
	MOVE.L	D1,A2
	ADD.L	A1,A2
	MOVE.L	-(A0),D0
dec_1	LSR.L	#1,D0
	BNE.S	decskip
	BSR.S	dec5
decskip	BCS.S	dec3
	MOVEQ	#8,D1
	MOVEQ	#1,D3
	LSR.L	#1,D0
	BNE.S	decskip2
	BSR.S	dec5
decskip2
	BCS.S	dec4_1
	MOVEQ	#3,D1
	CLR	D4
dec_2	BSR.S	dec6
	MOVE	D2,D3
	ADD	D4,D3
decloop1
	MOVEQ	#7,D1
decloop2
	LSR.L	#1,D0
	BNE.S	decskip3
	BSR.S	dec5
decskip3
	ROXL.L	#1,D2
	DBF	D1,decloop2
	MOVE.B	D2,-(A2)
	DBF	D3,decloop1
	BRA.S	dec4_3
 
dec2	MOVEQ	#8,D1
	MOVEQ	#8,D4
	BRA.S	dec_2
 
dec3	MOVEQ	#2,D1
	BSR.S	dec6
	CMP.B	#2,D2
	BLT.S	dec4
	CMP.B	#3,D2
	BEQ.S	dec2
	MOVEQ	#8,D1
	BSR.S	dec6
	MOVE	D2,D3
	MOVE	#8,D1
	BRA.S	dec4_1
 
dec4	MOVE	#9,D1
	ADD	D2,D1
	ADDQ	#2,D2
	MOVE	D2,D3
dec4_1	BSR.S	dec6
dec4_2	SUBQ	#1,A2
	MOVE.B	0(A2,D2.W),(A2)
	DBF	D3,dec4_2
dec4_3	CMP.L	A2,A1
	BLT.S	dec_1
	RTS
 
dec5	MOVE.L	-(A0),D0
	MOVE	D0,$DFF1A2
	MOVE	#$10,CCR
	ROXR.L	#1,D0
	RTS
 
dec6	SUBQ	#1,D1
	CLR	D2
dec6loop
	LSR.L	#1,D0
	BNE.S	dec6skip
	MOVE.L	-(A0),D0
	MOVE	D0,$DFF1A2
	MOVE	#$10,CCR
	ROXR.L	#1,D0
dec6skip
	ROXL.L	#1,D2
	DBF	D1,dec6loop
	RTS
 
LoadModule
	MOVE	#1,LoadInProgress
	BSR	DoClearSong
	BSR	ClrSampleInfo
	JSR	SetDiskPtrCol
	LEA	ModulesPath2,A0
	JSR	CopyPath
	LEA	DirInputName,A0
	MOVEQ	#DirNameLength-1,D0
lmloop2	MOVE.B	(A0)+,(A1)+
	DBF	D0,lmloop2
	LEA	LoadingModuleText(PC),A0
	BSR	ShowStatusText
	MOVE.L	DOSBase(PC),A6
	MOVE.L	#FileName,D1
	MOVE.L	#1005,D2
	JSR	LVOOpen(A6)
	MOVE.L	D0,FileHandle
	TST	D0
	BEQ	CantOpenFile
	MOVE.L	D0,D1
	MOVE.L	SongDataPtr(PC),D2
	MOVE.L	#1084,D3
	JSR	LVORead(A6)
	MOVE.L	SongDataPtr(PC),A0
	CMP.L	#'PP20',(A0)
	BEQ	PowerPacked
	MOVE.B	#127,sd_numofpatt+1(A0) ; Set maxpatt to 127
	CMP.L	#'M.K.',sd_mahokakt(A0)	; M.K. again...
	BEQ	lmskip
	BSR	MahoneyAndKaktus
	BNE	lmskip
	MOVE.L	FileHandle(PC),D1
	MOVE.L	#600,D2
	MOVEQ	#-1,D3
	JSR	LVOSeek(A6)
lmskip	LEA	LoadingModuleText(PC),A0
	BSR	ShowStatusText
	MOVE.L	SongDataPtr(PC),A0
	LEA	sd_pattpos(A0),A0
	MOVEQ	#0,D0
	MOVE.B	-1(A0),D0
	MOVEQ	#0,D3
lmloop3	CMP.B	(A0)+,D3
	BHI	lmskip2
	MOVE.B	-1(A0),D3
lmskip2	DBF	D0,lmloop3
	ADDQ	#1,D3
	MULU	#1024,D3
	MOVE.L	FileHandle(PC),D1
	MOVE.L	SongDataPtr(PC),D2
	ADD.L	#1084,D2
	MOVE.L	DOSBase,A6
	JSR	LVORead(A6)
	CLR.L	PatternNumber
	CLR.L	CurrPos
	BSR	RedrawPattern
	CLR	ScrPattPos
	BSR	SetScrPatternPos
	MOVE	#1,InsNum
	BSR	CheckAbort
	BEQ	rmiend
	TST.B	AutoExitFlag
	BEQ	readinstrloop
	JSR	ExitFromDir
readinstrloop
	TST.B	NosamplesFlag
	BNE	rmiend
	BSR	CheckAbort
	BEQ	rmiend
	BSR	ShowSampleInfo
	MOVE	InsNum(PC),TuneUp
	JSR	DoShowFreeMem
	MOVE.L	SongDataPtr(PC),A0
	MOVE	InsNum(PC),D7
	MULU	#30,D7
	MOVEQ	#0,D0
	MOVE	12(A0,D7.W),D0
	BEQ	rminext
	ADD.L	D0,D0
	MOVE.L	4.W,A6
	MOVE.L	#MEMF_CHIP!MEMF_CLEAR,D1
	MOVE.L	D0,-(SP)
	JSR	LVOAllocMem(A6)
	MOVE.L	(SP)+,D6
	TST.L	D0
	BNE	ReadModInstrument
	BSR	OutOfMemErr
	MOVE.L	DOSBase(PC),A6
	MOVE.L	FileHandle(PC),D1
	MOVE.L	D6,D2
	MOVEQ	#0,D3
	BRA	rminext
 
ReadModInstrument
	MOVE	InsNum(PC),D7
	LSL	#2,D7
	LEA	SamplePtrs(PC),A0
	MOVE.L	D0,0(A0,D7.W)
	MOVE.L	D6,124(A0,D7.W)
	MOVE.L	DOSBase(PC),A6
	MOVE.L	FileHandle(PC),D1
	MOVE.L	D0,D2
	MOVE.L	D6,D3
	JSR	LVORead(A6)
	BSR	RedrawSample
rminext	ADDQ	#1,InsNum
	CMP	#32,InsNum
	BNE	readinstrloop
rmiend	MOVE.L	FileHandle(PC),D1
	MOVE.L	DOSBase(PC),A6
	JSR	LVOClose(A6)
	MOVE	#1,InsNum
	MOVE.L	#6,CurrSpeed
	CLR	LoadInProgress
	BSR	ShowAllRight
	JSR	SetNormalPtrCol
	BSR	CheckInstrLengths
	BSR	ShowSampleInfo
	BSR	RedrawSample
	JMP	DoShowFreeMem

PowerPacked
	LEA	PowerPackedText,A0
	BSR	ShowStatusText
	JSR	SetErrorPtrCol
	BSR	DoClearSong
	BSR	ClrSampleInfo
	BRA	rmiend

PowerPackedText	dc.b "Powerpacker mod.!",0

; --- save module to device!!

SaveModule
	JSR	StorePtrCol
	JSR	SetDiskPtrCol
	MOVE.L	SongDataPtr(PC),A0
	LEA	sd_pattpos(A0),A0
	MOVEQ	#0,D0
	MOVEQ	#0,D1
	MOVEQ	#0,D2
	CLR	HighPattNum
smloop	MOVE.B	0(A0,D0.W),D1
	ADDQ	#1,D0
	CMP	#128,D0
	BHI	DoSaveModule
	MOVE	HighPattNum(PC),D2
	CMP	D2,D1
	BLS	smloop
	MOVE	D1,HighPattNum
	BRA	smloop
 
DoSaveModule
	LEA	ModulesPath2,A0
	JSR	CopyPath
	MOVE.B	#'m',(A1)+
	MOVE.B	#'o',(A1)+
	MOVE.B	#'d',(A1)+
	MOVE.B	#'.',(A1)+
	MOVE.L	SongDataPtr(PC),A0
	MOVEQ	#19,D0
dsmloop2
	MOVE.B	(A0)+,(A1)+
	DBF	D0,dsmloop2
	MOVE.L	SongDataPtr(PC),A0
	MOVE.L	A0,DiskDataPtr
	MOVE.L	#1084,DiskDataLength
	MOVEQ	#0,D0
	MOVE	HighPattNum(PC),D0
	ADDQ.L	#1,D0
	LSL.L	#8,D0
	LSL.L	#2,D0
	ADD.L	D0,DiskDataLength	; Add 1024 x NumOfPatt
	MOVE.B	#127,sd_numofpatt+1(A0) ; Set maxpatt to 127
	MOVE.L	#'M.K.',sd_mahokakt(A0)	; M.K. again...
	LEA	SavingModuleText(PC),A0
	BSR	ShowStatusText
	BTST	#2,$DFF016
	BEQ	CantOpenFile
	BSR	OpenModForWrite
	BNE	CantOpenFile
	BSR	WriteModuleData
	BNE	WriteModError
	BTST	#2,$DFF016
	BEQ	WriteModError
	MOVE	InsNum(PC),SaveInstrNum
	MOVEQ	#1,D6
saveinstrloop
	MOVE	D6,InsNum
	BSR	ShowSampleInfo
	BSR	WriteInstrument
	TST.L	D0
	BNE.S	WriteModError
	ADDQ.B	#1,D6
	CMP.B	#32,D6
	BNE	saveinstrloop

	BSR	CloseWriteMod
	MOVE	SaveInstrNum(PC),InsNum
	BSR	ShowSampleInfo
	BSR	ShowAllRight
	JMP	RestorePtrCol

SaveInstrNum	dc.w 0

WriteModError
	BSR	CloseWriteMod
	BRA	CantSaveFile

WriteInstrument
	MOVE	D6,D0
	LSL	#2,D0
	LEA	SamplePtrs(PC),A0
	MOVE.L	0(A0,D0.W),D1
	BEQ	Zreturn
	MOVE.L	124(A0,D0.W),D0
	BEQ	Return2
	MOVE.L	D1,DiskDataPtr
	MOVE.L	SongDataPtr(PC),A0
	LEA	12(A0),A0
	MOVE	D6,D0
	MULU	#30,D0
	ADD.L	D0,A0
	MOVEQ	#0,D0
	MOVE	(A0),D0
	LSL.L	#1,D0
	MOVE.L	D0,DiskDataLength
	BNE.S	WriteModuleData
	RTS

Zreturn	MOVEQ	#0,D0			;a quasar addition
	RTS

OpenModForWrite
	MOVE.L	DOSBase(PC),A6
	MOVE.L	#FileName,D1
	MOVE.L	#1006,D2
	JSR	LVOOpen(A6)
	MOVE.L	D0,D7
	BEQ.S	wmfailed
	MOVEQ	#0,D0
	RTS

WriteModuleData
	MOVE.L	DOSBase(PC),A6
	MOVE.L	D7,D1
	MOVE.L	DiskDataPtr(PC),D2
	MOVE.L	DiskDataLength(PC),D3
	BEQ	.okok
	JSR	LVOWrite(A6)
	CMP.L	DiskDataLength(PC),D3
	BNE.S	wmfailed
;	JSR	LVOIoErr(A6)
;	TST.L	D0
;	BNE.S	wmfailed
	MOVEQ	#0,D0
.okok	RTS

wmfailed
	MOVEQ	#-1,D0
	RTS

CloseWriteMod
	MOVE.L	DOSBase(PC),A6
	MOVE.L	D7,D1
	JMP	LVOClose(A6)

;---- Load PLST ----

LoadPLST
	LEA	LoadPLSTText,A0
	JSR	AreYouSure
	BNE	Return2
	JSR	WaitForButtonUp
	LEA	LoadingPLSTText(PC),A0
	BSR	ShowStatusText
DoLoadPLST
	JSR	StorePtrCol
	LEA	PTPath,A0
	JSR	CopyPath
	LEA	PLSTName(PC),A0
	MOVEQ	#4,D0
dlploop	MOVE.B	(A0)+,(A1)+
	DBF	D0,dlploop
	MOVE.L	#FileName,D1
	MOVE.L	#1005,D2
	MOVE.L	DOSBase(PC),A6
	JSR	LVOOpen(A6)
	MOVE.L	D0,D7
	BEQ	PLSTOpenErr
	JSR	SetDiskPtrCol
	CLR.L	PresetTotal
	BSR.S	AllocPLST
	MOVE.L	PLSTmem(PC),D2
	BEQ	PLSTMemErr2
	MOVE.L	D7,D1
	MOVE.L	PLSTAllocSize,D3
	MOVE.L	DOSBase(PC),A6
	JSR	LVORead(A6)
	MOVE.L	D0,MaxPLSTOffset
	DIVU	#30,D0
	MOVE	D0,PresetTotal
cloplst	MOVE.L	D7,D1
	MOVE.L	DOSBase(PC),A6
	JSR	LVOClose(A6)
;	BSR	PLSTCheckNum
;	BSR	ShowAllRight
	JMP	RestorePtrCol

PLSTName	dc.b	'PLST',0,0

AllocPLST
	BSR.S	FreePLST
	MOVE	MaxPLSTEntries,D0
	BEQ	Return2
	MULU	#30,D0
	MOVE.L	D0,PLSTAllocSize
	MOVE.L	#MEMF_CLEAR,D1
	MOVE.L	4.W,A6
	JSR	LVOAllocMem(A6)
	MOVE.L	D0,PLSTmem
	MOVE	MaxPLSTEntries,MaxPLSTEntries2
	RTS

FreePLST
	CLR	MaxPLSTEntries2
	CLR.L	MaxPLSTOffset
	CLR	PresetTotal
	MOVE.L	PLSTmem,D0
	BEQ	Return2
	MOVE.L	D0,A1
	MOVE.L	PLSTAllocSize,D0
	MOVE.L	4.W,A6
	JSR	LVOFreeMem(A6)
	CLR.L	PLSTmem
	RTS

PLSTMemErr2
	BSR.S	PLSTMemErr
	BRA	cloplst

PLSTMemErr
	TST	MaxPLSTEntries
	BEQ.S	reptrco
	BSET	#0,InitError
	LEA	PLSTMemText,A0
plster	BSR.S	ShowStatusText
	MOVE	#50,WaitTime
	JMP	ErrorRestoreCol
reptrco	JMP	RestorePtrCol
PLSTOpenErr
	TST	MaxPLSTEntries
	BEQ.S	reptrco
	BSET	#1,InitError
	LEA	PLSTOpenText,A0
	BRA.S	plster

PLSTMemText	dc.b 'no mem for plst !',0
PLSTOpenText	dc.b 'plst not found ! ',0
InitError	dc.b 0,0


ShowAllRight
	MOVEM.L	D0-D7/A0-A6,-(SP)
	LEA	AllRightText(PC),A0
	BSR.S	ShowStatusText
	MOVEM.L	(SP)+,D0-D7/A0-A6
	RTS
 
ShowStatusText
	MOVE.L	TextBplPtr(PC),A1
	ADD.L	#5131,A1
	MOVEQ	#4,D0
stloop1	MOVEQ	#16,D1
stloop2	CLR.B	(A1)+
	DBF	D1,stloop2
	LEA	23(A1),A1
	DBF	D0,stloop1
	MOVE.L	A0,A1
	MOVE	#5131,D1
	MOVEQ	#-1,D0
stloop3	ADDQ	#1,D0
	TST.B	(A1)+
	BNE.S	stloop3
	BRA	ShowText3

;---- Redraw Pattern ----

RedrawPattern
	TST	SamScrEnable
	BNE	Return2
	SF	PattRfsh
	MOVE	#5121,TextOffset
	MOVE	PatternNumber+2(PC),WordNumber
	BSR	Print2DecDigits ; Print PatternNumber
	MOVE.L	SongDataPtr(PC),A6
	LEA	$43C(A6),A6
	MOVE.L	PatternNumber,D6
	LSL.L	#8,D6
	LSL.L	#2,D6
	ADD.L	D6,A6
	MOVE	#7521,TextOffset
	CLR.L	PPattPos
	LEA	PeriodTable(PC),A2
	LEA	RedrawBuffer(PC),A3
	LEA	FastHexTable(PC),A4
	MOVEQ	#'0',D4
	MOVE.B	BlankZeroFlag,D5
	MOVEQ	#63,D6
rpnxpos	MOVEQ	#3,D7
	MOVE	PPattPos+2(PC),WordNumber
	BSR	Print2DecDigits ; Print PatternPosition
	ADDQ	#1,TextOffset
	ADDQ.L	#1,PPattPos
rploop	MOVEQ	#0,D0
	MOVEQ	#0,D1
	MOVE	(A6),D1
	AND	#$0FFF,D1
	BNE.S	rpfind
	MOVE.L	#'--- ',(A3)
	BRA.S	rpskip
rpfind	MOVEQ	#36,D2
rpfindloop
	CMP	(A2,D0.W),D1
	BEQ.S	rpfound
	ADDQ.L	#2,D0
	DBF	D2,rpfindloop
	MOVE.L	#'??? ',(A3)
	BRA.S	rpskip
rpfound	LSL.L	#1,D0
	ADD.L	NoteNamesPtr(PC),D0
	MOVE.L	D0,A0
	MOVE.L	(A0),(A3)
rpskip	MOVE.B	(A6)+,D0
	LSR.B	#4,D0
	ADD.B	#'0',D0
	MOVE.B	D0,3(A3)
	MOVE.B	(A6)+,D0
	MOVEQ	#0,D0
	MOVE.B	(A6)+,D0
	ADD	D0,D0
	MOVE	(A4,D0.W),4(A3)
	MOVEQ	#0,D0
	MOVE.B	(A6)+,D0
	ADD	D0,D0
	MOVE	(A4,D0.W),6(A3)

	TST.B	D5
	BEQ.S	rpskp3
	CMP.B	3(A3),D4
	BNE.S	rpskp3
	MOVE.B	#' ',3(A3)
rpskp3	MOVE	#9,TextLength
	MOVE.L	A3,ShowTextPtr
	BSR	ShowText
	DBF	D7,rploop  ; Next Channel
	ADD	#241,TextOffset
	DBF	D6,rpnxpos ; Next PattPos
	RTS

RedrawBuffer	dc.b '---00000 ',0


ShowPosition
	MOVE.L	SongDataPtr(PC),A0
	LEA	952(A0),A0
	ADD.L	CurrPos(PC),A0
	MOVE.B	(A0),WordNumber+1
	MOVE.B	(A0),PattRfshNum+3
	MOVEQ	#0,D1
	MOVE.B	(A0),D1
	CMP.B	LongFFFF+3(PC),D1
	BEQ.S	spskip2
	ST	PattRfsh
spskip2	MOVE	#608,TextOffset
	MOVE.B	(A0),LongFFFF+3
	CMP	#0,CurrScreen
	BEQ.S	spokok
	CMP	#1,CurrScreen
	BEQ.S	spokok
	CMP	#6,CurrScreen
	BEQ.S	spokok
	RTS
spokok	BSR	Print4DecDigits
	MOVE	CurrPos+2,WordNumber
	MOVE	#168,TextOffset
	BRA	Print4DecDigits


ShowSongLength
	CMP	#2,CurrScreen
	BEQ.S	ShowSongName
	CMP	#3,CurrScreen
	BEQ.S	ShowSongName
	CMP	#4,CurrScreen
	BEQ	Return2
	CMP	#5,CurrScreen
	BEQ.S	ShowSongName
	MOVE.L	SongDataPtr(PC),A0
	LEA	sd_numofpatt(A0),A0
	MOVE.L	A0,CurrCmds
	CLR	WordNumber
	MOVE.B	(A0),WordNumber+1
	MOVE	#1048,TextOffset
	BSR	Print4DecDigits
	MOVE.L	CurrCmds(PC),A0
ShowSongName
	MOVE.L	SongDataPtr(PC),A0
	MOVE	#4133,D1
	MOVEQ	#20,D0
	BRA	ShowText3


ShowSampleInfo
	MOVEQ	#0,D0
	MOVE	InsNum(PC),D0
	MOVE	D0,PlayInsNum
	BNE.S	ssiskipit
	MOVE	LastInsNum(PC),D0
ssiskipit
	MOVE	D0,D1
	LSL.L	#2,D0
	LEA	SamplePtrs(PC),A0
	MOVE.L	(A0,D0.W),si_pointer
	MOVE.L	SongDataPtr(PC),A0
	LEA	-10(A0),A0
	MOVE	D1,D0
	MULU	#30,D0
	ADD.L	D0,A0
	MOVE.L	A0,CurrCmds
	MOVE.L	22(A0),SampleInfo
	MOVE.L	26(A0),si_long
	TST.B	NoSampleInfo
	BNE	ssiskip

	MOVE.L	A0,-(SP)
	MOVE.B	#' ',FineTuneSign
	MOVE.B	24(A0),D0
	BEQ.S	dopfitu
	MOVE.B	#'+',FineTuneSign
	BTST	#3,D0
	BEQ.S	dopfitu
	MOVE.B	#'-',FineTuneSign
	MOVEQ	#16,D1
	SUB.B	D0,D1
	MOVE.B	D1,D0
dopfitu	MOVE	#1491,TextOffset
	BSR	PrintHexDigit  ; FineTune
	LEA	FineTuneSign(PC),A0
	MOVE	#1490,D1
	MOVEQ	#1,D0
	BSR	ShowText3  ; FineTuneSign
	MOVE.L	(SP)+,A0

	CLR	WordNumber
	MOVE.B	25(A0),WordNumber+1
	MOVE	WordNumber,VolumeEfx
	OR	#$0C00,VolumeEfx
	MOVE	#2368,TextOffset
	BSR	PrintHexWord  ; Volume

	MOVEQ	#0,D0
	MOVE	SampleInfo(PC),D0
	LSL.L	#1,D0
	MOVE	D0,WordNumber
	MOVE.L	SamplePos,D2
	CMP.L	D0,D2
	BLS.S	ShowLen
	MOVE.L	D0,SamplePos
	BSR	ShowPos
	MOVEQ	#0,D0
	MOVE	SampleInfo(PC),D0
	LSL.L	#1,D0
	MOVE	D0,WordNumber
ShowLen	MOVE	#2808,TextOffset
	BSR	PrintHexWord  ; Length

	MOVE	si_long,D0
	ADD	D0,D0
	MOVE	D0,WordNumber
	MOVE	#3248,TextOffset
	BSR	PrintHexWord  ; Repeat

	MOVE	si_long+2,D0
	ADD	D0,D0
	MOVE	D0,WordNumber
	MOVE	#3688,TextOffset
	BSR	PrintHexWord  ; RepLen

	BSR.S	ssiinst

ssiskip	TST.B	NoSampleInfo
	BEQ.S	ssiskp2
	CMP	#5,CurrScreen
	BEQ.S	ssiskp2
	CMP	#3,CurrScreen
	BNE	Return2
ssiskp2	MOVE.L	CurrCmds(PC),A0
	MOVE	#4573,D1
	MOVEQ	#22,D0
	BRA	ShowText3  ; SampleName

ssiinst	TST.B	NoSampleInfo
	BNE	Return2
	MOVE	InsNum(PC),WordNumber
	MOVE	#1928,TextOffset
	BRA	PrintHexWord  ; SampleNumber

FineTuneSign	dc.b ' ',0
VolumeEfx	dc.w 0

;---- Print Decimal Digits ----
 
Print2DecDigits
	MOVE	#2,TextLength
	MOVEQ	#0,D1
	MOVE	WordNumber(PC),D1
	LEA	NumberText(PC),A0
	BRA.S	pdig
 
Print3DecDigits
	MOVE	#3,TextLength
	MOVEQ	#0,D1
	MOVE	WordNumber(PC),D1
	LEA	NumberText(PC),A0
	BRA.S	pdig100

Print4DecDigits
	MOVE	#4,TextLength
	MOVEQ	#0,D1
	MOVE	WordNumber(PC),D1
	LEA	NumberText(PC),A0
	DIVU	#1000,D1
	BSR.S	DoOneDigit
pdig100	DIVU	#100,D1
	BSR.S	DoOneDigit
pdig	DIVU	#10,D1
	BSR.S	DoOneDigit
	BSR.S	DoOneDigit
	MOVE.L	#NumberText,A0
	BRA	ShowText2

DoOneDigit
	ADD.B	#'0',D1
	MOVE.B	D1,(A0)+
	CLR	D1
	SWAP	D1
	RTS

Print6DecDigits
	LEA	NumberText,A0
	MOVE.L	D0,D1
	CMP.L	#1000000,D1
	BHS	toobig

	SWAP	D1
	CLR	D1
	SWAP	D1
	DIVU	#10,D1
	SWAP	D1
	ADD.B	#'0',D1
	MOVE.B	D1,5(A0)
	CMP.L	#10,D0
	BLO.S	p6zero1

	DIVU	#100,D0
	MOVE.L	D0,D1
	CLR	D0
	SWAP	D0
	DIVU	#10,D0
	ADD.B	#'0',D0
	MOVE.B	D0,4(A0)
	AND.L	#$FFFF,D1
	BEQ.S	p6zero2
	DIVU	#10,D1
	SWAP	D1
	ADD.B	#'0',D1
	MOVE.B	D1,3(A0)
	CLR	D1
	SWAP	D1
	TST	D1
	BEQ.S	p6zero3
	DIVU	#10,D1
	SWAP	D1
	ADD.B	#'0',D1
	MOVE.B	D1,2(A0)
	CLR	D1
	SWAP	D1
	TST	D1
	BEQ.S	p6zero4
	DIVU	#10,D1
	SWAP	D1
	ADD.B	#'0',D1
	MOVE.B	D1,1(A0)
	CLR	D1
	SWAP	D1
	TST	D1
	BEQ.S	p6zero5
	DIVU	#10,D1
	SWAP	D1
	ADD.B	#'0',D1
	MOVE.B	D1,(A0)
	BRA.S	p6end

p6zero1	MOVE.B	#' ',4(A0)
p6zero2	MOVE.B	#' ',3(A0)
p6zero3	MOVE.B	#' ',2(A0)
p6zero4	MOVE.B	#' ',1(A0)
p6zero5	MOVE.B	#' ',0(A0)
p6end	MOVE	#6,TextLength
	BRA	ShowText2

toobig	MOVE.B	#' ',D0
	BSR.S	toobig2
	DIVU	#1000,D0
	MOVE	D0,WordNumber
	BSR	Print4DecDigits
	MOVE.B	#'K',D0
toobig2	LEA	NumberText(PC),A0
	MOVE.B	D0,(A0)
	MOVE	#1,TextLength
	BRA	ShowText2

NumberText	dcb.b	6,0

;---- Print Hex Digits ----

PrintHiInstrNum
	MOVEQ	#0,D0
	TST	CurrentPlayNote
	BEQ.S	phin2
	MOVE	InsNum(PC),D0
	LSR	#4,D0
	BNE.S	PrintHexDigit
phin2	TST.B	BlankZeroFlag
	BEQ.S	PrintHexDigit
	LEA	BlankInsText(PC),A0
	BRA.S	phd2
PrintHexDigit
	AND.L	#$0F,D0
	ADD.L	D0,D0
	LEA	FastHexTable+1(PC),A0
	ADD.L	D0,A0
phd2	MOVE	#1,TextLength
	BRA.S	ShowText2

BlankInsText	dc.b " ",0

PrintHexWord
	LEA	WordNumber(PC),A0
	MOVEQ	#0,D0
	MOVE.B	(A0),D0
	LSL.L	#1,D0
	LEA	FastHexTable(PC),A0
	ADD.L	D0,A0
	MOVE	#2,TextLength
	BSR.S	ShowText2
PrintHexByte
	LEA	WordNumber(PC),A0
	MOVEQ	#0,D0
	MOVE.B	1(A0),D0
	LSL.L	#1,D0
	MOVE.L	#FastHexTable,A0
	ADD.L	D0,A0
	MOVE	#2,TextLength
	BSR.S	ShowText2
	CLR	WordNumber
	RTS

;---- Text Output Routines ----

ShowText3
	MOVE	D0,TextLength
	MOVE	D1,TextOffset
ShowText2
	MOVE.L	A0,ShowTextPtr
ShowText
	MOVEM.L	A2-A4,-(SP)
	LEA	TextTable(PC),A3
	LEA	FontData,A4
	MOVE	TextLength(PC),D0
	MOVE.L	TextBplPtr(PC),A1
	MOVE	TextOffset(PC),D1
	LEA	(A1,D1.W),A1
	ADD	D0,TextOffset
	MOVE.L	ShowTextPtr(PC),A0
	BRA.S	dstlope
dstloop	MOVEQ	#0,D1
	MOVE.B	(A0)+,D1
	BNE.S	dstskip
	MOVE.B	ShowZeroFlag(PC),D1
dstskip	MOVE.B	(A3,D1.W),D1
	LSL	#3,D1
	MOVE.L	A4,A2
	ADD.L	D1,A2
	MOVE.B	(A2)+,(A1)+
	MOVE.B	(A2)+,40-1(A1)
	MOVE.B	(A2)+,80-1(A1)
	MOVE.B	(A2)+,120-1(A1)
	MOVE.B	(A2),160-1(A1)
dstlope	DBF	D0,dstloop
	MOVEM.L	(SP)+,A2-A4
	RTS

SpaceShowText
	MOVE	ShowZeroFlag(PC),-(SP)
	MOVE.B	#' ',ShowZeroFlag
	BSR.S	ShowText
	MOVE	(SP)+,ShowZeroFlag
	RTS
 
ShowZeroFlag	dc.b	95,0

TextTable
	dc.b 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; 0
	dc.b 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	dc.b 00,01,02,03,04,05,06,07,08,09,10,11,12,13,14,15 ; 32
	dc.b 16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
	dc.b 32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47 ; 64
	dc.b 48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63
	dc.b 69,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47 ; 96
	dc.b 48,49,50,51,52,53,54,55,56,57,58,65,66,67,68,63
	dc.b 69,70,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; 128
	dc.b 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	dc.b 0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; 160
	dc.b 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	dc.b 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; 192
	dc.b 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	dc.b 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; 224
	dc.b 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0


;---- Set Sprite Position ----

SetSpritePos
	ADD	#$2C,D1
	ADD	D1,D2
	ROL.W	#7,D2
	ASL	#1,D2
	BCC.S	sppskip
	OR	#2,D2
sppskip	ROL.W	#7,D1
	ASL	#1,D1
	BCC.S	sppskip2
	OR	#4,D2
sppskip2
	ADD	#$7D,D0
	ASR	#1,D0
	BCC.S	sppskip3
	OR	#1,D2
sppskip3
	OR	D0,D1
	MOVE	D1,(A0)
	MOVE	D2,2(A0)
	RTS
 

;---- DoLoad / DoSave Data ----

DoLoadData
	TST.L	DiskDataLength
	BEQ.S	dlsend
	TST.L	DiskDataPtr
	BEQ.S	dlsend
	JSR	SetDiskPtrCol
	LEA	LoadingText(PC),A0
	BSR	ShowStatusText
	MOVE.L	DOSBase(PC),A6
	MOVE.L	FileNamePtr(PC),D1
	MOVE.L	#1005,D2
	JSR	LVOOpen(A6)
	MOVE.L	D0,FileHandle
	BEQ.S	CantOpenFile
	MOVE.L	FileHandle(PC),D1
	MOVE.L	DiskDataPtr(PC),D2
	MOVE.L	DiskDataLength(PC),D3
	JSR	LVORead(A6)
	MOVE.L	FileHandle(PC),D1
	JSR	LVOClose(A6)
dlsend	CLR.L	FileHandle
	JSR	SetNormalPtrCol
	MOVEQ	#-1,D0
	RTS

CantOpenFile
	LEA	CantOpenFileText(PC),A0
caopfil	BSR	ShowStatusText
	JSR	SetErrorPtrCol
 	MOVEQ	#0,D0
	RTS

CantSaveFile
	LEA	CantSaveFileText(PC),A0
	BRA.S	caopfil
CantExamFile
	LEA	CantExamFileText(PC),A0
	BRA.S	caopfil
CantFindFile
	LEA	CantFindFileText(PC),A0
	BRA.S	caopfil
FileIsEmpty
	LEA	FileIsEmptyText(PC),A0
	BRA.S	caopfil

CantOpenFileText	dc.b "can't open file !",0
CantSaveFileText	dc.b "can't save file !",0
CantExamFileText	dc.b "examine error !",0
CantFindFileText	dc.b "can't find file !",0
FileIsEmptyText		dc.b "file is empty !",0

DoSaveData
	JSR	SetDiskPtrCol
	LEA	SavingText(PC),A0
	BSR	ShowStatusText
	MOVE.L	DOSBase(PC),A6
	MOVE.L	FileNamePtr(PC),D1
	MOVE.L	#1006,D2
	JSR	LVOOpen(A6)
	MOVE.L	D0,FileHandle
	BEQ	CantOpenFile
	MOVE.L	FileHandle(PC),D1
	MOVE.L	DiskDataPtr(PC),D2
	MOVE.L	DiskDataLength(PC),D3
	JSR	LVOWrite(A6)
	MOVE.L	FileHandle(PC),D1
	JSR	LVOClose(A6)
	CLR.L	FileHandle
	JMP	SetNormalPtrCol

;---- PLST ----

PLST	CLR.B	RawKeyCode
	CMP	#6,CurrScreen
	BEQ	ExitPLST
	CMP	#1,CurrScreen
	BNE	Return2
	JSR	WaitForButtonUp
	MOVE	#6,CurrScreen
	JSR	ClearRightArea
	JSR	ClearAnalyzerColors
	BSR.S	DrawPLSTScreen
	BEQ	ExitPLST
	BSR	RedrawPLST
PLST_rts
	RTS

DrawPLSTScreen
	LEA	PLSTData,A0
	BSR	Decompact
	BEQ	Return2

	LEA	BitPlaneData+TopMenusPos,A0
	MOVEQ	#98,D0
dplstloop1
	MOVEQ	#24,D1
dplstloop2
	MOVE.B	2574(A1),PlaneSize(A0)
	MOVE.B	(A1)+,(A0)+
	DBF	D1,dplstloop2
	LEA	15(A0),A0
	ADDQ.L	#1,A1
	DBF	D0,dplstloop1

	BSR	FreeDecompMem
	MOVEQ	#-1,D0
	RTS

ShowDiskNames
	MOVE	#616,TextOffset
	MOVE	#5,TextLength
	MOVE.L	#STText1,A0
	BSR	ShowText2
	ADDQ	#1,TextOffset
	MOVE.L	#STText2,A0
	BSR	ShowText2
	ADDQ	#1,TextOffset
	MOVE.L	#STText3,A0
	BRA	ShowText2

PLSTCheckNum
	TST.L	PLSTmem
	BEQ	NoPLST
	TST.L	MaxPLSTOffset
	BEQ	NoPLST
	MOVE.L	PLSTmem(PC),A0
	MOVE	PresetTotal(PC),D7
	SUBQ	#1,D7
	TST.B	STText1Number
	BNE	plstsskip
	TST.B	STText2Number
	BNE	plstsskip
	TST.B	STText3Number
	BEQ	PLSTMarkAll
plstsskip
	MOVE.L	STText1Number-1(PC),A3
	MOVE.L	STText2Number-1(PC),A4
	MOVE.L	STText3Number-1(PC),A5
	MOVEQ	#0,D6
PLSTmarkloop
	MOVE	#'st',(A0)	; Set lowercase 'st'
	MOVE.B	3(A0),D0
	CMP.B	#'a',D0
	BLO.S	pmlskp1
	SUB.B	#32,D0
pmlskp1	MOVE.B	D0,3(A0)
	MOVE.B	4(A0),D0
	CMP.B	#'a',D0
	BLO.S	pmlskp2
	SUB.B	#32,D0
pmlskp2	MOVE.B	D0,4(A0)
	MOVE.L	2(A0),D0	; Get number ('-01:' etc)
PLSTchk1
	CMP.L	A3,D0
	BNE	PLSTchk2
	MOVE	#'ST',(A0)
	ADDQ	#1,D6
	BRA	PLSTmarknext

PLSTchk2
	CMP.L	A4,D0
	BNE	PLSTchk3
	MOVE	#'ST',(A0)
	ADDQ	#1,D6
	BRA	PLSTmarknext

PLSTchk3
	CMP.L	A5,D0
	BNE	PLSTmarknext
	MOVE	#'ST',(A0)
	ADDQ	#1,D6
PLSTmarknext
	ADD.L	#30,A0
	DBF	D7,PLSTmarkloop
	MOVE	D6,PresetMarkTotal
	CLR	PLSTpos
	CLR.L	PLSTOffset
	RTS

PLSTMarkAll
	MOVE	#'ST',(A0)	; Set uppercase 'ST'
	LEA	30(A0),A0
	DBF	D7,PLSTMarkAll
	MOVE	PresetTotal(PC),PresetMarkTotal
	CLR	PLSTpos
	CLR.L	PLSTOffset
	RTS

NoPLST	CLR	PresetMarkTotal
	CLR	PLSTpos
	CLR.L	PLSTOffset
	RTS

RedrawPLST
	MOVE	PresetMarkTotal(PC),WordNumber
	MOVE	#189,TextOffset
	BSR	Print4DecDigits
	BSR	ShowDiskNames
	TST.L	PLSTmem
	BEQ	PLST_rts
	TST.L	MaxPLSTOffset
	BEQ	PLST_rts

	MOVE.L	PLSTOffset(PC),D6
	MOVE.L	PLSTmem(PC),A6
	MOVE	#976,A5		; TextOffset
	LEA	PLSTOffset(PC),A4
	MOVEQ	#11,D7		; Number of lines to print
	TST.L	D6
	BMI	EndOfPLST
dtplstloop
	CMP	#'ST',(A6,D6.L)	; Check for 'ST'
	BNE	PLSTNext
	MOVE.L	D6,(A4)+
	MOVE	A5,TextOffset
	MOVE	#19,TextLength
	LEA	(A6,D6.L),A3
	ADDQ.L	#3,A3
	MOVE.L	A3,ShowTextPtr
	MOVEM.L	D0-D7/A0-A6,-(SP)
	BSR	SpaceShowText
	MOVEM.L	(SP)+,D0-D7/A0-A6
	MOVE	22(A6,D6.L),WordNumber
	MOVE	WordNumber,D0
	LSL	#1,D0
	MOVE	D0,WordNumber
	MOVEM.L	D0-D7/A0-A6,-(SP)
	BSR	PrintHexWord
	MOVEM.L	(SP)+,D0-D7/A0-A6
	ADD.L	#30,D6
	CMP.L	MaxPLSTOffset(PC),D6
	BHI	EndOfPLST
	ADD	#240,A5		; Next Screen position
	DBF	D7,dtplstloop
	RTS

PLSTNext
	ADD.L	#30,D6
	CMP.L	MaxPLSTOffset(PC),D6
	BHI	EndOfPLST
	BRA	dtplstloop

EndOfPLST
	MOVE.L	#$FFFFFFFF,(A4)+
	MOVE	A5,TextOffset
	MOVE	#23,TextLength
	MOVE.L	#EmptyLineText,ShowTextPtr
	MOVEM.L	D0-D7/A0-A6,-(SP)
	BSR	SpaceShowText
	MOVEM.L	(SP)+,D0-D7/A0-A6
	ADD	#240,A5
	DBF	D7,EndOfPLST
	RTS

TypeInDisk1
	LEA	STText1Number(PC),A6
	MOVE	#156,LineCurX
	BRA	DoTypeInDisk

TypeInDisk2
	LEA	STText2Number(PC),A6
	MOVE	#204,LineCurX
	BRA	DoTypeInDisk

TypeInDisk3
	LEA	STText3Number(PC),A6
	MOVE	#252,LineCurX
DoTypeInDisk
	CLR.B	(A6)
	CLR.B	1(A6)
	JSR	StorePtrCol
	JSR	SetWaitPtrCol
	BSR	ShowDiskNames
	MOVE	#20,LineCurY
	BSR	UpdateLineCurPos
	BSR	GetHexKey
	TST.B	RawKeyCode
	BNE	ClearDiskNum
	BTST	#2,$DFF016
	BEQ	ClearDiskNum
	ADD	D1,D1
	LEA	FastHexTable+1(PC),A0
	MOVE.B	(A0,D1.W),(A6)
	ADDQ	#8,LineCurX
	BSR	ShowDiskNames
	BSR	UpdateLineCurPos
	JSR	GetHexKey
	TST.B	RawKeyCode
	BNE	ClearDiskNum
	BTST	#2,$DFF016
	BEQ	ClearDiskNum
	ADD	D1,D1
	LEA	FastHexTable+1(PC),A0
	MOVE.B	(A0,D1.W),1(A6)
	JSR	RestorePtrCol
	BSR	PLSTCheckNum
	BSR	RedrawPLST
	CLR	LineCurX
	MOVE	#270,LineCurY
	BRA	UpdateLineCurPos

ClearAllDisks
	BSR	DoClearDisks
	BSR	PLSTCheckNum
	BRA	RedrawPLST

DoClearDisks
	MOVEQ	#0,D0
	MOVE.B	D0,STText1Number
	MOVE.B	D0,STText1Number+1
	MOVE.B	D0,STText2Number
	MOVE.B	D0,STText2Number+1
	MOVE.B	D0,STText3Number
	MOVE.B	D0,STText3Number+1
	MOVE.B	D0,STText4Number
	MOVE.B	D0,STText4Number+1
	RTS

MountList
	JSR	StorePtrCol
	JSR	SetDiskPtrCol
	BSR	DoClearDisks
	MOVE	#1,MountFlag
	LEA	df0text(PC),A4
	BSR	DoMountList
	LEA	STText1(PC),A0
	BSR	CheckMountName
	LEA	df1text(PC),A4
	BSR	DoMountList
	LEA	STText2(PC),A0
	BSR	CheckMountName
	LEA	df2text(PC),A4
	BSR	DoMountList
	LEA	STText3(PC),A0
	BSR	CheckMountName
;	LEA	df3text(PC),A4
;	BSR	DoMountList
;	LEA	STText4(PC),A0
;	BSR	CheckMountName
	CLR	MountFlag
	JSR	RestorePtrCol
	BRA	cdisknum2

DoMountList
	CLR.L	FIB_FileName
	CLR.L	FIB_FileName+4
	CLR.L	FIB_FileName+8
	MOVE.L	DOSBase(PC),A6
	MOVE.L	A4,D1
	MOVEQ	#-2,D2
	JSR	LVOLock(A6)
	MOVE.L	D0,FileLock
	BEQ	MountError
	MOVE.L	FileLock(PC),D1
	MOVE.L	#FileInfoBlock,D2
	JSR	LVOExamine(A6)
	TST.L	D0
	BEQ	MountError
	MOVE.L	FileLock(PC),D1
	JSR	LVOUnLock(A6)
MountError
	MOVEQ	#-1,D0
	RTS

CheckMountName
	MOVE	FIB_FileName,D0
	BEQ	MountError
	MOVE	#'ST',D1	; Check for ST
	AND	#$1F1F,D0
	AND	#$1F1F,D1
	CMP	D0,D1
	BNE	ClearDiskNum
	MOVE.B	FIB_FileName+3,D0
	LSL	#8,D0
	MOVE.B	FIB_FileName+4,D0
	CMP	#'00',D0
	BEQ	ClearDiskNum
	MOVE.B	D0,4(A0)	; Put disk number into ST-xx
	LSR	#8,D0
	MOVE.B	D0,3(A0)
	MOVEQ	#0,D0
	RTS

ClearDiskNum
	CLR.B	RawKeyCode
	JSR	RestorePtrCol
	CLR.B	(A6)
	CLR.B	1(A6)
	CLR	LineCurX
	MOVE	#270,LineCurY
	BSR	UpdateLineCurPos
cdisknum2
	BSR	PLSTCheckNum
	BRA	RedrawPLST

df0text	dc.b 'DF0:',0,0
df1text	dc.b 'DF1:',0,0
df2text	dc.b 'DF2:',0,0
df3text	dc.b 'DF3:',0,0

CheckPLSTGadgs
	MOVEM.W	MouseX2(PC),D0/D1
	CMP	#120,D0
	BLO	cplstend
	CMP	#23,D1
	BHS	PLSTPressed
	CMP	#12,D1
	BHS	PLSTLine2
PLSTLine1
	CMP	#268,D0
	BHS	ExitPLST
	CMP	#168,D0
	BHS	cplstend
	CMP	#120,D0
	BHS	ClearAllDisks
	RTS

PLSTLine2
	CMP	#268,D0
	BHS	MountList
	CMP	#218,D0
	BHS	TypeInDisk3
	CMP	#168,D0
	BHS	TypeInDisk2
	BRA	TypeInDisk1
cplstend
	RTS

ExitPLST
	JSR	WaitForButtonUp
	CLR.B	RawKeyCode
	JSR	ClearRightArea
	JMP	DisplayMainScreen

PLSTOneUp
	TST	PresetMarkTotal
	BEQ	Return2
	BTST	#6,$BFE001
	BEQ	PLST_rts
	MOVE	PLSTpos,D0
	MOVE	D0,D2
	SUBQ	#1,D0
	TST	ShiftKeyStatus
	BNE.S	pouski2
	BTST	#2,$DFF016
	BNE	pouskip
pouski2	SUB	#9,D0
pouskip	TST	D0
	BPL	DoPLSTUpDown
	CLR	D0
	BRA	DoPLSTUpDown

PLSTOneDown
	TST	PresetMarkTotal
	BEQ	Return2
	BTST	#6,$BFE001
	BEQ	PLST_rts
	MOVE	PLSTpos(PC),D0
	MOVE	D0,D2
	ADDQ	#1,D0
	TST	ShiftKeyStatus
	BNE.S	podski2
	BTST	#2,$DFF016
	BNE	podskip
podski2	ADD	#9,D0
podskip	MOVE	PresetMarkTotal(PC),D1
	SUB	#12,D1
	CMP	D0,D1
	BHS	DoPLSTUpDown
	MOVE	D1,D0
DoPLSTUpDown
	BSR	UpdateOffset
	BRA	RedrawPLST

UpdateOffset
	MOVE	PLSTpos(PC),D1
	MOVE	D0,PLSTpos
	CMP	D0,D1
	BEQ	Return2
	TST	D0
	BEQ	ZeroPLSTOffset
	SUBQ	#1,D0
	MOVE.L	PLSTmem(PC),A0
	MOVEQ	#0,D6
cpoloop	CMP	#'ST',(A0,D6.L)	; Check for 'ST'
	BEQ	NextPLSTOffset
	ADD.L	#30,D6
	BRA	cpoloop
NextPLSTOffset
	ADD.L	#30,D6
	DBF	D0,cpoloop
	MOVE.L	D6,PLSTOffset
	RTS

ZeroPLSTOffset
	CLR.L	PLSTOffset
	RTS

PLSTPressed
	CMP	#24,D1
	BLO	Return2
	CMP	#95,D1
	BHI	Return2
	SUB	#24,D1
	AND.L	#$0000FFFF,D1
	DIVU	#6,D1
	LSL	#2,D1
	LEA	PLSTOffset(PC),A0
	MOVE.L	(A0,D1.W),D1
	BMI	Return2
	DIVU	#30,D1
	ADDQ	#1,D1
	MOVE	D1,CurrentPreset
	JSR	WaitForButtonUp
	BRA	UsePreset

;---- Preset Editor/PED ----

PresetEditor
	JSR	WaitForButtonUp
	MOVE	#4,CurrScreen
	ST 	DisableAnalyzer
	ST	NoSampleInfo
	BSR	SwapPresEdScreen
	BEQ	pedexi2
PED_Refresh
	CLR	PED_Action
	MOVE.L	TextBplPtr(PC),A0
	MOVE	#1219,D0
pedloop	CLR.L	(A0)+
	DBF	D0,pedloop
	JSR	SetNormalPtrCol
	JSR	ClearAnalyzerColors
	BSR	ShowPEDnumbers
	BRA	ShowPresetNames

SwapPresEdScreen
	MOVE.L	DecompMemPtr,D0
	BEQ	speds2
	MOVE.L	D0,A1
	BSR	speds3
	BRA	FreeDecompMem
speds2	LEA	PresetEdData,A0
	BSR	Decompact
	BEQ	Return2
speds3	LEA	BitPlaneData,A0
	MOVEQ	#1,D2
spesloop1
	MOVE	#1219,D0
spesloop2
	MOVE.L	(A0),D1
	MOVE.L	(A1),(A0)+
	MOVE.L	D1,(A1)+
	DBF	D0,spesloop2
	LEA	$14F0(A0),A0
	DBF	D2,spesloop1
	MOVEQ	#-1,D0
	RTS

CheckPresEdGadgs
	MOVEM.W	MouseX2(PC),D0/D1
	CMP	#45,D1
	BHS	CheckPEDnames
	CLR	PED_Action
	JSR	SetNormalPtrCol
	CMP	#307,D0
	BHS	PED_GotoPLST
PED_Menu1
	CMP	#101,D0
	BHS	PED_Menu2
	CMP	#34,D1
	BHS	PED_DeleteDisk
	CMP	#23,D1
	BHS	PED_Delete
	CMP	#12,D1
	BHS	PED_Insert
	BRA	PED_AddPathGadg

PED_Menu2
	CMP	#209,D0
	BHS	PED_Menu3
	CMP	#34,D1
	BHS	PED_ClearPLST
 	CMP	#23,D1
	BHS	Return2
 	CMP	#12,D1
	BHS	PED_Disk
	BRA	PED_EnterPath

PED_Menu3
	CMP	#34,D1
	BHS	PED_Print
	CMP	#23,D1
	BHS	WritePLST
	CMP	#12,D1
	BHS.S	xLoadPLST
	BRA	PED_EnterPath

xLoadPLST
	BSR	LoadPLST
	MOVE	#1,PEDPos
	BRA	PED_Refresh

PED_GotoPLST
	BSR	PED_Exit
	BRA	PLST

PED_Exit
	JSR	WaitForButtonUp
	BSR	PLSTCheckNum
	BSR	SwapPresEdScreen
	MOVE.L	TextBplPtr(PC),A0
	MOVE	#1219,D0
pedeloop	CLR.L	(A0)+
	DBF	D0,pedeloop
	CLR.B	RawKeyCode
pedexi2	JSR	ClearAnalyzerColors
	JMP	DisplayMainAll

PED_AddPathGadg
	TST.L	PLSTmem
	BNE	pedawok
	BSR	AllocPLST
	TST.L	PLSTmem
	BEQ	PLSTMemErr
pedawok	MOVE.L	DOSBase(PC),A6
	MOVE.L	#PEdDefaultPath,D1
	MOVEQ	#-2,D2
	JSR	LVOLock(A6)
	MOVE.L	D0,FileLock
	BEQ	UnlockReadPath
	JSR	SetDiskPtrCol
	LEA	AddingPathText(PC),A0
	BSR	ShowStatusText
	MOVE.L	DOSBase(PC),A6
	MOVE.L	FileLock(PC),D1
	MOVE.L	#FileInfoBlock,D2
	JSR	LVOExamine(A6)
	TST.L	D0
	BPL	UnlockReadPath
	TST.L	FIB_EntryType
	BPL	CheckPathDirName
	BSR	AddPreset
	BRA	IsPLSTFull

CheckPathDirName
	CMP.B	#'-',FIB_FileName+2
	BNE	IsPLSTFull
	MOVE.B	FIB_FileName+3,SndDiskNum0
	MOVE.B	FIB_FileName+4,SndDiskNum1
	BSR	ShowPEDnumbers
IsPLSTFull
	MOVE	PresetTotal(PC),D0
	CMP	MaxPLSTEntries,D0
	BLO	ReadPathNext
	BSR	PLSTisFull
	BRA	ReadPathEnd

ReadPathNext
	MOVE.L	DOSBase,A6
	MOVE.L	FileLock(PC),D1
	MOVE.L	#FileInfoBlock,D2
	JSR	LVOExNext(A6)
	TST.L	D0
	BPL	ReadPathEnd
	BTST	#2,$DFF016
	BEQ	ReadPathEnd
	TST.L	FIB_EntryType
	BPL	IsPLSTFull
	CMP.L	#'.inf',FIB_FileName
	BEQ	IsPLSTFull
	CMP.L	#'.inf',FIB_FileName+4
	BEQ	IsPLSTFull
;	LEA	FIB_FileName,A0
;	MOVEQ	#28,D0
;repalop	CMP.B	#'.',(A0)+
;	BEQ	CouldBeInfo
;	DBF	D0,repalop
rpnskip	CLR	PresetRepeat
	MOVE	#1,PresetReplen
;	TST.B	IFFLoopFlag	; name is ok, test for IFF
	BRA	rpnskp2
;	LEA	PEDDefaultPath,A0
	JSR	CopyPath
	LEA	FIB_FileName,A0
rpncpfn	MOVE.B	(A0)+,(A1)+
	BNE.S	rpncpfn
	MOVE.L	#FileName,D1
	MOVE.L	#1005,D2
	MOVE.L	DOSBase(PC),A6
	JSR	LVOOpen(A6)
	MOVE.L	D0,FileHandle
	BEQ.S	rpnskp2
	MOVE.L	D0,D1
	LEA	chkiffbuffer(PC),A2
	CLR.L	(A2)
	MOVE.L	A2,D2
	MOVEQ	#12,D3
	JSR	LVORead(A6)
	CMP.L	#"FORM",(A2)
	BNE.S	rpnclse
	CMP.L	#"8SVX",8(A2)
	BNE.S	rpnclse
rpnvhdr	MOVE.L	FileHandle(PC),D1
	MOVE.L	A2,D2
	MOVEQ	#4,D3
	JSR	LVORead(A6)
	TST.L	D0
	BEQ.S	rpnclse
	CMP.L	#"VHDR",(A2)
	BNE.S	rpnvhdr
	MOVE.L	FileHandle(PC),D1
	MOVE.L	A2,D2
	MOVEQ	#12,D3
	JSR	LVORead(A6)
	MOVE.L	8(A2),D0
	BEQ.S	rpnclse
	LSR	#1,D0
	MOVE	D0,PresetReplen
	MOVE.L	4(A2),D0
	LSR	#1,D0
	MOVE	D0,PresetRepeat
rpnclse	MOVE.L	FileHandle(PC),D1
	JSR	LVOClose(A6)
rpnskp2	BSR	AddPreset
	BSR	ShowPEDnumbers
	BRA	IsPLSTFull

chkiffbuffer
	dc.l	0,0,0

CouldBeInfo
	CMP.B	#'i',(A0)+
	BNE	rpnskip
	CMP.B	#'n',(A0)+
	BNE	rpnskip
	CMP.B	#'f',(A0)+
	BNE	rpnskip
	CMP.B	#'o',(A0)+
	BNE	rpnskip
	CMP.B	#0,(A0)+
	BNE	rpnskip
	BRA	IsPLSTFull

ReadPathEnd
	MOVE.L	DOSBase(PC),A6
	MOVE.L	FileLock(PC),D1
	BEQ	rpeskip
	JSR	LVOUnLock(A6)
rpeskip	JSR	SetNormalPtrCol
	BSR	ShowPresetNames
	BRA	ShowAllRight

UnlockReadPath
	MOVE.L	DOSBase(PC),A6
	MOVE.L	FileLock(PC),D1
	BEQ	urpend
	JSR	LVOUnLock(A6)
urpend	JMP	SetErrorPtrCol

AddPreset
	LEA	PEdDefaultVol(PC),A0
	LEA	PresetName(PC),A1
	MOVEQ	#21,D0
.loop	CLR.B	(A1)+
	DBF	D0,.loop
	LEA	PresetName(PC),A1
	MOVEQ	#5,D0	; Disk ST-XX:
aploop	MOVE.B	(A0)+,(A1)+
	DBF	D0,aploop

	LEA	FIB_FileName,A0
	MOVEQ	#14,D0	; Name 16 letters.
aploop2	MOVE.B	(A0)+,D1
	BEQ	.skip
	MOVE.B	D1,(A1)+
	DBF	D0,aploop2
.skip	CLR.B	(A1)

	MOVE.L	FIB_FileSize,D0
	CMP.L	#$FFFE,D0
	BLS.S	apskip2
	MOVE	#$FFFE,D0
apskip2	LSR	#1,D0
	MOVE	D0,PresetLength
	CLR	PresetFineTune
	LEA	PresetName(PC),A6
	BSR	PED_CheckAdd
	ADDQ	#1,PresetTotal
	ADD.L	#30,MaxPLSTOffset
	RTS

PED_Insert
	TST.L	PLSTmem
	BNE	pediwok
	BSR	AllocPLST
	TST.L	PLSTmem
	BEQ	PLSTMemErr
pediwok	MOVE	PresetTotal(PC),D0
	CMP	MaxPLSTEntries2,D0
	BHS	PLSTisFull
	LEA	InsertPsetText(PC),A0
	LEA	PresetName(PC),A1
	MOVEQ	#39,D0
pediloop
	MOVE.B	(A0)+,(A1)+
	DBF	D0,pediloop
PossibleEdit
	JSR	StorePtrCol
	JSR	SetWaitPtrCol
	MOVE.L	TextBplPtr(PC),A0
	LEA	2320(A0),A0
	MOVEQ	#59,D0
pediloop2
	CLR.L	(A0)+
	DBF	D0,pediloop2
	LEA	EnterDataText(PC),A0
	BSR	ShowStatusText
	MOVE	#63,LineCurY
	LEA	PresetName(PC),A6
	MOVEQ	#3,D7
	MOVE.B	#4,EnterTextFlag
ShowPsetText
	LEA	PresetName+3(PC),A0
	MOVEQ	#37,D0
	MOVE	#2321,D1
	BSR	ShowText3
	MOVE	D7,D0
	SUBQ	#3,D0
	ASL	#3,D0
	ADD	#12,D0
	MOVE	D0,LineCurX
	BSR	UpdateLineCurPos
pediwaitkey
	JSR	DoKeyBuffer
	MOVE.B	RawKeyCode(PC),D0
	BEQ	pediwaitkey
	CLR.B	RawKeyCode
	BTST	#7,D0
	BNE	pediwaitkey
	AND	#$FF,D0
	CMP.B	#69,D0
	BEQ	PED_ESCkey
	CMP.B	#65,D0
	BEQ	PED_BkspaceKey
	CMP.B	#68,D0
	BEQ	PED_ReturnKey
	CMP.B	#79,D0
	BEQ	PED_LeftArrowKey
	CMP.B	#78,D0
	BEQ	PED_RightArrowKey
	CMP.B	#64,D0
	BHI	pediwaitkey
	CMP	#40,D7
	BEQ	pediwaitkey
	CMP	#22,D7
	BEQ	pediwaitkey
	LEA	UnshiftedKeymap(PC),A0
	TST	ShiftKeyStatus
	BEQ	ShiftKeySkip
	LEA	ShiftedKeymap(PC),A0
ShiftKeySkip
	MOVE.B	0(A0,D0.W),D1
	BEQ	pediwaitkey

	CMP	#6,D7
	BLO.S	hexchk2
	CMP	#25,D7
	BLO	PED_PrintChar
hexchk2	CMP.B	#'0',D1
	BLO	pediwaitkey
	CMP.B	#'f',D1
	BHI	pediwaitkey
	CMP.B	#'9',D1
	BLS	PED_PrintChar
	CMP.B	#'a',D1
	BHS	PED_PrintChar
	BRA	pediwaitkey

PED_PrintChar
	MOVE.B	D1,(A6,D7.W)
	BRA	PED_RightArrowKey

PED_ReturnKey
	CMP.B	#' ',PsetNameText
	BEQ	PED_ESCkey
	LEA	PsetVolText(PC),A0
	LEA	fitutexttab+32(PC),A1
	MOVE.B	(A0)+,D1
	LSL	#8,D1
	MOVE.B	(A0),D1
	MOVEQ	#15,D0
vofloop	CMP	-(A1),D1
	BEQ.S	vofound
	DBF	D0,vofloop
	MOVEQ	#0,D0
vofound	MOVE	D0,PresetFineTune
	LEA	PsetLenText(PC),A0
	BSR	HexToInteger
	LSR	#1,D0
	MOVE	D0,PresetLength
	LEA	PsetRepeatText(PC),A0
	BSR	HexToInteger
	LSR	#1,D0
	MOVE	D0,PresetRepeat
	LEA	PsetReplenText(PC),A0
	BSR	HexToInteger
	LSR	#1,D0
	MOVE	D0,PresetReplen
	BSR	PED_CheckAdd
	ADDQ	#1,PresetTotal
PED_ESCkey
	CLR	LineCurX
	MOVE	#270,LineCurY
	BSR	UpdateLineCurPos
	BSR	ShowPresetNames
	BSR	ShowPEDnumbers
	BSR	ShowAllRight
	CLR.B	EnterTextFlag
	JMP	RestorePtrCol

PED_BkspaceKey
	CMP	#23,D7
	BHS	pedbsend
	CMP	#6,D7
	BLS	pedbsend
	SUBQ	#1,D7
	MOVE.B	#' ',(A6,D7.W)
pedbsend
	BRA	ShowPsetText

PED_LeftArrowKey
	SUBQ	#1,D7
	CMP	#2,D7
	BLS	pedlakskip2
	CMP	#5,D7
	BEQ	pedlakskip
	CMP	#22,D7
	BEQ	pedlakskip
	CMP	#25,D7
	BEQ	pedlakskip
	CMP	#30,D7
	BEQ	pedlakskip
	CMP	#35,D7
	BEQ	pedlakskip
	BRA	ShowPsetText

pedlakskip
	SUBQ	#1,D7
	BRA	ShowPsetText

pedlakskip2
	MOVEQ	#3,D7
	BRA	ShowPsetText

PED_RightArrowKey
	ADDQ	#1,D7
	CMP	#5,D7
	BEQ	pedrakskip
	CMP	#22,D7
	BEQ	pedrakskip
	CMP	#25,D7
	BEQ	pedrakskip
	CMP	#30,D7
	BEQ	pedrakskip
	CMP	#35,D7
	BEQ	pedrakskip
	CMP	#40,D7
	BHS	pedrakskip2
	BRA	ShowPsetText

pedrakskip
	ADDQ	#1,D7
	BRA	ShowPsetText

pedrakskip2
	MOVEQ	#39,D7
	BRA	ShowPsetText

PED_CheckAdd
	MOVEQ	#23,D0
pedcaloop
	SUBQ	#1,D0
	CMP.B	#' ',0(A6,D0.W)
	BEQ	pedcaloop
	CLR.B	1(A6,D0.W)
	MOVE.L	PLSTmem(PC),A5
	LEA	30(A5),A5
pedccnextloop
	MOVEQ	#6,D0
	TST.B	6(A5)
	BEQ	PED_AddPreset
PED_ConvertLoop
	MOVE.B	0(A5,D0.W),D2
	BNE	PED_ConvertCase
	TST.B	0(A6,D0.W)
	BNE	PED_ConvertCase
	CLR.B	6(A5)
	SUBQ	#1,PresetTotal
	BRA	PED_AddPreset

PED_ConvertCase
	CMP.B	#'A',D2
	BLO	pedccskip
	CMP.B	#'Z',D2
	BHI	pedccskip
	ADD.B	#32,D2
pedccskip
	MOVE.B	0(A6,D0.W),D1
	CMP.B	#' ',D1
	BEQ	pedccskip3
	CMP.B	#'A',D1
	BLO	pedccskip2
	CMP.B	#'Z',D1
	BHI	pedccskip2
	ADD.B	#32,D1
pedccskip2
	CMP.B	D2,D1
	BEQ	pedccnext
	BHI	pedccskip3
	BRA	PED_AddPreset

pedccnext
	ADDQ	#1,D0
	CMP	#22,D0
	BNE	PED_ConvertLoop
pedccskip3
	LEA	30(A5),A5
	BRA	pedccnextloop

PED_AddPreset
	TST.B	6(A5)
	BEQ	pedapskip
	MOVE.L	PLSTmem(PC),A1
	MOVE	PresetTotal(PC),D0
	CMP	#1,D0
	BEQ	pedapskip
	MULU	#30,D0
	ADD.L	D0,A1
	LEA	30(A1),A1
	CLR.B	31(A1)
pedaploop
	MOVE	(A1),30(A1)
	SUBQ.L	#2,A1
	CMP.L	A1,A5
	BLS	pedaploop
pedapskip
	MOVEQ	#21,D0
pedaploop2
	MOVE.B	0(A6,D0.W),D1
	CMP.B	#'A',D1
	BLO	pedapskip2
	CMP.B	#'Z',D1
	BHI	pedapskip2
	ADD.B	#32,D1
pedapskip2
	CMP.B	#' ',D1
	BNE	pedapskip3
	MOVEQ	#0,D1
pedapskip3
	MOVE.B	D1,0(A5,D0.W)
	DBF	D0,pedaploop2
	MOVE	PresetLength(PC),22(A5)
	MOVE.B	PresetFineTune+1(PC),24(A5)
	MOVE.B	#$40,25(A5)
	MOVE	PresetRepeat(PC),26(A5)
	MOVE	PresetReplen(PC),28(A5)
	RTS

HexToInteger
	MOVEQ	#0,D0
	BSR	Single_hti
	LSL	#8,D1
	LSL	#4,D1
	OR	D1,D0
	BSR	Single_hti
	LSL	#8,D1
	OR	D1,D0
HexToInteger2
	BSR	Single_hti
	LSL	#4,D1
	OR	D1,D0
	BSR	Single_hti
	OR	D1,D0
	RTS

Single_hti
	MOVEQ	#0,D1
	MOVE.B	(A0)+,D1
	CMP.B	#$60,D1
	BLO	shtiskip
	SUB.B	#$20,D1
shtiskip
	SUB.B	#$30,D1
	CMP.B	#9,D1
	BLS	Return2
	SUBQ.B	#7,D1
	RTS

PED_Delete
	JSR	SetDeletePtrCol
	MOVE	#1,PED_Action
	LEA	SelectEntryText(PC),A0
	BRA	ShowStatusText

PED_ClearPLST
	LEA	ClearPLSTText,A0
	JSR	AreYouSure
	BNE	Return2
	BSR	FreePLST
	BRA	PED_Refresh

ClearPLSTText	dc.b 'clear plst ?',0,0

PED_Print
	LEA	PrintPLSTText,A0
	JSR	AreYouSure
	BNE	Return2
	JSR	StorePtrCol
	MOVE.L	DOSBase(PC),A6
	MOVE.L	#PrintPath,D1
	MOVE.L	#1006,D2
	JSR	LVOOpen(A6)
	MOVE.L	D0,FileHandle
	BEQ	CantOpenFile
	JSR	SetDiskPtrCol
	MOVE.L	D0,D1
	MOVE.L	#PsetPLSTtext,D2
	MOVEQ	#56,D3
	JSR	LVOWrite(A6)
	LEA	PrintingPLSTText(PC),A0
	BSR	ShowStatusText
	CLR	PsetNumTemp
pedpmainloop
	MOVE	PsetNumTemp(PC),D0
	LEA	PsetPrtNumText(PC),A0
	BSR	IntToDecASCII
	MOVE.L	PLSTmem(PC),A0
	MOVE	PsetNumTemp(PC),D0
	MULU	#30,D0
	ADD.L	D0,A0
	MOVE.L	A0,PsetPtrTemp
	LEA	PsetPrtNameText(PC),A1
	MOVE.L	A1,A2
	MOVEQ	#19,D1
FillSpaceLoop
	MOVE.B	#' ',(A2)+
	DBF	D1,FillSpaceLoop
	MOVEQ	#19,D1
pedploop
	TST.B	(A0)
	BEQ	pedpskip
	MOVE.B	(A0)+,(A1)+
	DBF	D1,pedploop
pedpskip
	MOVE.L	PsetPtrTemp(PC),A1
	MOVE	22(A1),D0
	LEA	PsetPrtLenText(PC),A0
	BSR	IntToHexASCII
	MOVE.L	PsetPtrTemp(PC),A1
	MOVE	26(A1),D0
	LEA	PsetPrtRepeatText(PC),A0
	BSR	IntToHexASCII
	MOVE.L	PsetPtrTemp(PC),A1
	MOVE	28(A1),D0
	ADD	D0,D0
	LEA	PsetPrtRepLenText(PC),A0
	BSR	IntToHexASCII
	MOVE.L	FileHandle(PC),D1
	MOVE.L	#PsetPrtNumText,D2
	MOVEQ	#53,D3
	JSR	LVOWrite(A6)
	BTST	#2,$DFF016
	BEQ	AbortPLSTPrint
	ADDQ	#1,PsetNumTemp
	MOVE	PsetNumTemp(PC),D0
	CMP	PresetTotal(PC),D0
	BNE	pedpmainloop
	BRA	pedpend

AbortPLSTPrint
	LEA	OprAbortedText(PC),A0
	BSR	ShowStatusText
	JSR	SetErrorPtrCol
pedpend	MOVE.L	FileHandle(PC),D1
	JSR	LVOClose(A6)
	BSR	ShowAllRight
	JMP	RestorePtrCol

IntToDecASCII
	MOVEQ	#3,D3
	MOVE.L	#1000,D2
itdloop	EXT.L	D0
	DIVU	D2,D0
	ADD.B	#'0',D0
	MOVE.B	D0,(A0)+
	DIVU	#10,D2
	SWAP	D0
	DBF	D3,itdloop
	RTS

IntToHex2
	MOVEQ	#1,D2
	BRA	ithaloop

IntToHexASCII
	MOVEQ	#3,D2
ithaloop
	MOVE	D0,D1
	AND.B	#15,D1
	CMP.B	#10,D1
	BLO	ithaskip
	ADDQ.B	#7,D1
ithaskip
	ADD.B	#'0',D1
	MOVE.B	D1,-(A0)
	ROR	#4,D0
	DBF	D2,ithaloop
	RTS

WritePLST
	LEA	SavePLSTText,A0
	JSR	AreYouSure
	BNE	Return2
	JSR	StorePtrCol
	JSR	SetDiskPtrCol
	LEA	SavingPLSTText(PC),A0
	BSR	ShowStatusText
	LEA	PTPath,A0
	JSR	CopyPath
	LEA	PLSTName(PC),A0
	MOVEQ	#4,D0
dsploop	MOVE.B	(A0)+,(A1)+
	DBF	D0,dsploop
	MOVE.L	#FileName,D1
	MOVE.L	#1006,D2
	MOVE.L	DOSBase(PC),A6
	JSR	LVOOpen(A6)
	MOVE.L	D0,D7
	BEQ	CantOpenFile
	MOVE.L	D0,D1
	MOVE.L	PLSTmem(PC),D2
	MOVE	PresetTotal(PC),D3
	MULU	#30,D3
	JSR	LVOWrite(A6)
	MOVE.L	D7,D1
	JSR	LVOClose(A6)
	BSR	ShowAllRight
	JMP	RestorePtrCol

CheckPEDnames
	CMP	#307,D0
	BLO	PED_PsetHit
	CLR	PED_Action
	JSR	SetNormalPtrCol
	CMP	#122,D1
	BHS	Return2
	CMP	#111,D1
	BHS	PED_Bottom
	CMP	#100,D1
	BHS.S	PED_OneDown
	CMP	#67,D1
	BHS	PED_Exit
	CMP	#56,D1
	BHS.S	PED_OneUp
	BRA.S	PED_Top

PED_OneUp
	SUBQ	#1,PEDPos
	TST	ShiftKeyStatus
	BNE.S	poup2
	BTST	#2,$DFF016
	BNE.S	pedouskip
poup2	SUBQ	#7,PEDPos
pedouskip
	CMP	#1,PEDPos
	BGE	ShowPresetNames
PED_Top	MOVE	#1,PEDPos
	BRA	ShowPresetNames

PED_OneDown
	CMP	#9,PresetTotal
	BLO	ShowPresetNames
	ADDQ	#1,PEDPos
	TST	ShiftKeyStatus
	BNE.S	podn2
	BTST	#2,$DFF016
	BNE.S	pedodskip
podn2	ADDQ	#7,PEDPos
pedodskip
	MOVE	PresetTotal,D0
	SUB	#10,D0
	CMP	PEDPos,D0
	BHS	ShowPresetNames
pedodsx	MOVE	D0,PEDPos
	BRA	ShowPresetNames

PED_Bottom
	MOVE	PresetTotal(PC),D0
	SUB	#11,D0
	BMI.S	PED_Top
	ADDQ	#1,D0
	BRA.S	pedodsx

ShowPresetNames
	MOVE	#2321,D6
	MOVEQ	#9,D7
	MOVE.L	PLSTmem(PC),D0
	BEQ	Return2
	MOVE.L	D0,A5
	MOVE	PEDPos(PC),D0
	MULU	#30,D0
	ADD.L	D0,A5
spndploop
	TST.B	(A5)
	BEQ	Return2
	LEA	PresetNameText,A1
	MOVEQ	#21,D0
spnloop	MOVE.B	#' ',(A1)+
	DBF	D0,spnloop
	MOVE.L	A5,A0
	ADDQ.L	#3,A0
	LEA	-22(A1),A1
spnloop2
	MOVE.B	(A0)+,D0
	BEQ.S	DisplayPreset
	MOVE.B	D0,(A1)+
	BRA.S	spnloop2

fitutexttab
	dc.b " 0+1+2+3+4+5+6+7-8-7-6-5-4-3-2-1"

DisplayPreset
	MOVEQ	#19,D0
	LEA	PresetNameText,A0
	MOVE	D6,D1
	BSR	ShowText3
	ADD	#20,D6
	MOVE	D6,TextOffset
	MOVEQ	#0,D0
	MOVE.B	24(A5),D0
	AND.B	#$0F,D0
	ADD	D0,D0
	LEA	fitutexttab(PC,D0.W),A0
	MOVE	#2,TextLength
	BSR	ShowText2
	MOVE	22(A5),D0
	ADD	D0,D0
	MOVE	D0,WordNumber
	ADDQ	#1,TextOffset
	BSR	PrintHexWord
	MOVE	26(A5),D0
	ADD	D0,D0
	MOVE	D0,WordNumber
	ADDQ	#1,TextOffset
	BSR	PrintHexWord
	MOVE	28(A5),D0
	ADD	D0,D0
	MOVE	D0,WordNumber
	ADDQ	#1,TextOffset
	BSR	PrintHexWord
	ADD	#220,D6   ; 218
	LEA	30(A5),A5
	DBF	D7,spndploop
	RTS

PED_EnterPath
	JSR	StorePtrCol
	JSR	SetWaitPtrCol
	CLR.L	EditMode
	LEA	PEdDefaultPath(PC),A6
	JSR	UpdateLineCurPos
	MOVE.L	A6,TextEndPtr
	MOVE.L	A6,ShowTextPtr
	ADD.L	#31,TextEndPtr
	MOVE	#20,TextLength
	MOVE.L	#178,A4
	BSR	GetTextLine
	CLR.L	TextEndPtr
	JMP	RestorePtrCol

PED_Disk
	JSR	StorePtrCol
	JSR	SetWaitPtrCol
	CLR.L	EditMode
	CLR.B	SndDiskNum0
	CLR.B	SndDiskNum1
	LEA	SndDiskNum0(PC),A6
	MOVE.L	A6,TextEndPtr
	MOVE.L	A6,ShowTextPtr
	ADDQ.L	#2,TextEndPtr
	MOVE	#2,TextLength
	MOVE.L	#621,A4
	MOVE.B	#3,EnterTextFlag
	BSR	GetTextLine
	LEA	SndDiskNum0(PC),A6
	MOVE.B	#':',2(A6)
	CLR.B	EnterTextFlag
	CLR.L	TextEndPtr
	JMP	RestorePtrCol

ShowPEDnumbers
	MOVE	PresetTotal,WordNumber
	MOVE	#1061,TextOffset
	BSR	Print4DecDigits
	LEA	PEdDefaultPath,A0
	MOVE	#178,D1
	MOVEQ	#20,D0
	BSR	ShowText3
	LEA	PEdDefaultVol,A0
	MOVE	#618,D1
	MOVEQ	#6,D0
	BRA	ShowText3

PED_PsetHit
	CMP	#1,PresetTotal
	BEQ.S	pedphend
	MOVE	MouseY2(PC),D0
	CMP	#59,D0
	BLO.S	pedphend
	CMP	#119,D0
	BHS.S	pedphend
	SUB	#59,D0
	DIVU	#6,D0
	MOVE.L	D0,D1
	SWAP	D1
	CMP	#5,D1
	BEQ.S	pedphend
	MOVE	D0,D2
	ADD	PEDPos(PC),D2
	CMP	PresetTotal(PC),D2
	BHI.S	pedphend
	MULU	#30,D0
	MOVE.L	PLSTmem(PC),A5
	ADD.L	D0,A5
	MOVE	PEDPos(PC),D0
	MULU	#30,D0
	ADD.L	D0,A5
	TST	PED_Action
	BEQ.S	PED_CopyName
	CMP	#1,PED_Action
	BEQ	PED_DoDelete
pedphend
	RTS

PED_CopyName
	LEA	PresetName(PC),A0
	MOVEQ	#21,D0
pedcnloop
	MOVE.B	(A5)+,D1
	BNE	pedcnskip
	MOVE.B	#' ',D1
pedcnskip
	MOVE.B	D1,(A0)+
	DBF	D0,pedcnloop
	MOVEQ	#0,D0
	MOVE.B	2(A5),D0
	AND.B	#$0F,D0
	ADD	D0,D0
	LEA	fitutexttab(PC),A1
	LEA	(A1,D0.W),A1
	LEA	PsetVolText(PC),A0
	MOVE.B	#' ',-1(A0)
	MOVE.B	(A1)+,(A0)+
	MOVE.B	(A1),(A0)
	MOVE	(A5),D0
	ADD	D0,D0
	LEA	6(A0),A0
	BSR	IntToHexASCII
	MOVE	4(A5),D0
	ADD	D0,D0
	LEA	9(A0),A0
	BSR	IntToHexASCII
	LEA	9(A0),A0
	MOVE	6(A5),D0
	ADD	D0,D0
	BSR	IntToHexASCII
	BRA	PossibleEdit

PED_DoDelete
	CLR	PED_Action
	LEA	DeletePresetText,A0
	JSR	AreYouSure
	BNE	Return2
	MOVE.L	PLSTmem(PC),A1
	MOVE	PresetTotal(PC),D0
	MULU	#30,D0
	ADD.L	D0,A1
pedddloop
	MOVE	30(A5),(A5)
	ADDQ.L	#2,A5
	CMP.L	A5,A1
	BHI.S	pedddloop
	CLR.B	(A5)
	SUBQ	#1,PresetTotal
	SUB.L	#30,MaxPLSTOffset
	MOVE	PEDPos(PC),D0
	ADD	#9,D0
	CMP	PresetTotal(PC),D0
	BHI.S	pedddskip
	SUBQ	#1,PEDPos
pedddskip
	BSR	ShowPEDnumbers
	BSR	ShowPresetNames
	JSR	SetNormalPtrCol
	JMP	StorePtrCol

sepc	JMP	SetErrorPtrCol

PLSTisFull
	LEA	PLSTFullText(PC),A0
	BSR	ShowStatusText
	JMP	SetErrorPtrCol

PED_DeleteDisk
	LEA	DelDiskText(PC),A0
	MOVE.B	SndDiskNum0(PC),10(A0)
	MOVE.B	SndDiskNum1(PC),11(A0)
	JSR	AreYouSure
	BNE	Return2
	JSR	StorePtrCol
	JSR	SetWaitPtrCol
	MOVE.L	PLSTmem(PC),A0
	MOVE.L	A0,A1
	MOVE	PresetTotal(PC),D0
	MULU	#30,D0
	ADD.L	D0,A1
	MOVE.L	SndDiskNum0-1(PC),D1
	MOVE.L	#$FF5F5FFF,D2
	AND.L	D2,D1
peddslo	MOVE.L	2(A0),D0
	AND.L	D2,D0
	CMP.L	D1,D0
	BNE.S	peddsno
	MOVE.L	A0,A2
peddslp	MOVE	30(A0),(A0)+
	CMP.L	A1,A0
	BLO.S	peddslp
	SUBQ	#1,PresetTotal
	SUB.L	#30,MaxPLSTOffset
	MOVE.L	A2,A0
	BRA.S	peddsn1
peddsno	LEA	30(A0),A0
peddsn1	CMP.L	A1,A0
	BLO.S	peddslo
	MOVE	#1,PEDPos
	BSR	ShowPEDnumbers
	BSR	ShowPresetNames
	JMP	RestorePtrCol

DelDiskText	dc.b "Delete ST-.. ?",0,0

;************  MIDI Routines  ************

*  Apollon MIDI Routines V0.2               *
*  V0.2 04/07-1991 First version            *

_RVOAllocMiscResource =  -6
_RVOFreeMiscResource  = -12

OpenMIDI
	TST.L	MIDIinBuffer
	BNE.S	omidisk
	MOVE.L	#256,D0
	MOVE.L	#MEMF_PUBLIC!MEMF_CLEAR,D1
	MOVE.L	4.W,A6
	JSR	LVOAllocMem(A6)
	MOVE.L	D0,MIDIinBuffer
	BEQ	Return2
omidisk	CLR.B	MIDIinTo
	CLR.B	MIDIinFrom

	BSR.S	.GetSer2		;got the port?
	BEQ.S	.end			;yes
	MOVE.L	4.W,A6			;no..try to flush serial.device:
	JSR	LVOForbid(A6)
	LEA	DeviceList(A6),A0	;ExecBase->DeviceList
	LEA	SerDevName(PC),a1	;"serial.device"
	JSR	LVOFindName(A6)
	TST.L	D0
	BEQ.S	.notfnd			;no serial.device!!
	MOVE.L	D0,A1
	JSR	LVORemDevice(A6)
.notfnd	JSR	LVOPermit(A6)
	BSR.S	.GetSer2		;now try it again...
.end	RTS

.GetSer2
	MOVE.L	4.W,A6
	MOVEQ	#0,D0
	LEA	MiscResName(PC),a1
	JSR	LVOOpenResource(A6)
	MOVE.L	D0,MiscResBase
	BEQ	.gs_err
	MOVE.L	D0,A6
	LEA	rb_ProgName,A1
	MOVEQ	#0,D0		;serial port
	JSR	_RVOAllocMiscResource(A6)
	TST.L	D0
	BNE.S	.gs_err
	ST.B	SerPortAlloc
	CLR	PrevBits
	MOVE	$DFF01C,D0
	BTST	#0,D0
	SNE.B	PrevBits
	BTST	#11,D0
	SNE.B	PrevBits+1
	MOVEQ	#0,D0		;TBE
	LEA	MIDIOutInterrupt(PC),A1
	MOVE.L	4.W,A6
	JSR	LVOSetIntVector(A6)
	MOVE.L	D0,PrevTBE
	MOVEQ	#11,D0		;RBF
	LEA	MIDIInInterrupt(pc),A1
	JSR	LVOSetIntVector(A6)
	MOVE.L	D0,PrevRBF
	MOVE	#114,$DFF032	;set baud rate 114/31250 (SERPER)
	MOVE	#$8801,$DFF09A	;RBF & TBE on!!

	MOVE	#30000,D0
.lolo	MOVE	#$0F0,$DFF180
	DBF	D0,.lolo
	MOVEQ	#0,D0
	RTS

.gs_err	MOVE	#30000,D0
.lplp	MOVE	#$F00,$DFF180
	DBF	D0,.lplp
	MOVEQ	#-1,D0
	RTS


;----- Close MIDI and release serial port -----

CloseMIDI
	MOVE.L	MIDIinBuffer(PC),D0
	BEQ.S	clmskip
	MOVE.L	D0,A1
	MOVE.L	#256,D0
	MOVE.L	4.W,A6
	JSR	LVOFreeMem(A6)
	CLR.L	MIDIinBuffer
clmskip
	TST.L	MiscResBase
	BEQ.S	.fs_end
	TST.B	SerPortAlloc
	BEQ.S	.fs_end
	MOVE	#$0801,$dff09a	;disable RBF & TBE
	MOVE.L	PrevTBE(PC),a1
	MOVEQ	#0,D0
	MOVE.L	4.W,A6
	JSR	LVOSetIntVector(A6)
	MOVE.L	PrevRBF(PC),a1
	MOVEQ	#11,D0
	JSR	LVOSetIntVector(A6)
	MOVE	#$8000,D0
	TST.B	PrevBits
	BEQ.S	.fs1
	BSET	#0,D0
.fs1	TST.B	PrevBits+1
	BEQ.S	.fs2
	BSET	#11,D0
.fs2	MOVE	D0,$DFF09A	;set RBF & TBE to their prev. values
	MOVE.L	MiscResBase(PC),A6
	MOVEQ	#0,D0		;serial port
	JSR	_RVOFreeMiscResource(A6)
	CLR.B	SerPortAlloc
	CLR.B	lastcmdbyte
.fs_end	RTS

mintflag dc.w 0


;----- Every time we receive a MIDI byte -----

MIDIInIntHandler
	MOVE	$DFF018,D0 ; read from serdatr
	MOVE	#$0800,$DFF09C ;intreq

	MOVE	#$F00,$DFF180

	MOVEM.L	D1-D2,-(SP)
gmiskip	MOVEQ	#0,D1
	MOVE.B	4(A1),D1 ; in to
	MOVE.L	D1,D2
	ADDQ.B	#1,D2
	CMP.B	5(A1),D2 ; in from
	BEQ	gmiexit	; Buffer overflow
	MOVE.L	(A1),A0 ; midi in buffer
	MOVE.B	D0,(A0,D1.W)
	MOVE.B	D2,4(A1); MIDIinTo
gmiexit	MOVEM.L	(SP)+,D1-D2
	RTS


;----- MIDI Transmit Buffer Empty Interrupt (Output) -----

MIDIOutIntHandler
	MOVE	#$4000,intena(A0)	;disable int.
	ADDQ.B	#1,IDNestCnt(A6)	;turn off multitasking
	MOVE	#1,intreq(A0)		;clear intreq bit
	MOVE.B	bytesinbuff(PC),D0
	BEQ.S	exsih			;buffer empty
	MOVE.L	4(A1),A5		;get buffer read pointer
	MOVE	#$100,D1		;Stop bit
	MOVE.B	(A5),D1			;get byte
	MOVE	D1,$030(A0)		;and push it out!!
	ADDQ.L	#1,A5			;add 1
	CMP.L	A1,A5			;shall we reset ptr??
	BNE.S	nbufptr			;not yet..
	LEA	sendbuffer(PC),A5
nbufptr	SUBQ.B	#1,D0			;one less bytes in buffer
	MOVE.B	D0,bytesinbuff		;remember it
	MOVE.L	A5,4(A1)		;push new read pointer back
exsih	SUBQ.B	#1,IDNestCnt(A6)	;multitasking back on
	BGE.S	exsih0
	MOVE	#$C000,intena(A0)
exsih0	RTS

;----- Send data to MIDI Out or to output buffer -----
; A0=ptr to data, D0=length

AddMIDIData
	TST.B	SerPortAlloc
	BEQ.S	retamd
	MOVE.L	A2,-(SP)
	MOVE.L	4.W,A6
	MOVE	#$4000,$DFF09A	;Disable interrupts
	ADDQ.B	#1,IDNestCnt(A6)
	MOVE.B	bytesinbuff(pc),D1
	BNE.S	noTBEreq
	MOVE	#$8001,$DFF09C	;request TBE
noTBEreq
	LEA	buffptr(PC),A2	;end of buffer (ptr)
	MOVE.L	(A2),A1		;buffer pointer
adddataloop
	MOVE.B	(A0)+,D1	;get byte
	BPL.S	norscheck	;this isn't a status byte
	CMP.B	#$EF,D1		;forget system messages
	BHI.S	norscheck
	CMP.B	lastcmdbyte(PC),D1 ;same as previos status byte??
	BEQ.S	samesb		;yes, skip
	MOVE.B	D1,lastcmdbyte	;no, don't skip but remember!!
norscheck
	MOVE.B	D1,(A1)+	;push it to midi send buffer
	ADDQ.B	#1,bytesinbuff
samesb	CMP.L	A2,A1	;end of buffer??
	BNE.S	noresbuffptr	;no, no!!
	LEA	sendbuffer(pc),a1 ;better reset it to avoid trashing
noresbuffptr
	SUBQ.B	#1,D0
	BNE.S	adddataloop
	MOVE.L	A1,(A2)		;push new buffer ptr back
overflow
	SUBQ.B	#1,IDNestCnt(A6)
	BGE.S	retamd1
	MOVE	#$C000,$DFF09A	;enable interrupts again
retamd1	MOVE.L	(SP)+,A2
retamd	RTS

PrevTBE		dc.l	0
PrevRBF		dc.l	0	
PrevBits	dc.b	0,0

MIDIOutInterrupt
	dc.l	0,0
	dc.b	2,0
	dc.l	MIDIOutName,buffptr,MIDIOutIntHandler

MIDIInInterrupt
	dc.l	0,0
	dc.b	2,0
	dc.l	MIDIInName,MIDIinBuffer,MIDIInIntHandler

buffptr		dc.l	sendbuffer
readbuffptr	dc.l	sendbuffer
sendbuffer	ds.b	128

SerPortAlloc	dc.b	0
bytesinbuff	dc.b	0
MiscResBase	dc.l	0
lastcmdbyte	dc.b	0
		even

MIDIOutName	dc.b	'PT MIDI Out',0
MIDIInName	dc.b	'PT MIDI In',0
MiscResName	dc.b	'misc.resource',0
SerDevName	dc.b	'serial.device',0
		even


;----- read from input buffer -----

MIDIin	MOVE.B	MIDIinFrom(PC),D0
	CMP.B	MIDIinTo(PC),D0
	BNE	migetbyt
	MOVEQ	#2,D1
	RTS
migetbyt
	MOVE.L	MIDIinBuffer(PC),A0
	MOVE.L	A0,$7FFF0
	MOVE.B	(A0,D0.W),D0
	ADDQ.B	#1,MIDIinFrom
	MOVEQ	#0,D1
	RTS

CheckMIDIin
	TST.B	MIDIFlag
	BEQ	Return2
	BSR	MIDIin
	TST.L	D1
	BEQ	mic_ok
	MOVE.B	#1,MIDIError
	RTS

mic_ok	CLR.B	MIDIError
	TST.B	D0
	BPL	mic_databyte
;statusbyte here
	CMP.B	#$F0,D0
	BHS	MIDISysMessage
	MOVE.B	D0,MIDIRunStatus
	MOVE.B	D0,D1
	AND.B	#$F0,D1
	MOVE.B	D1,MIDIRunCommand
	AND.B	#$0F,D0
	MOVE.B	D0,MIDIRunChannel
	CLR.B	MIDIByteCount
	RTS

mic_databyte
	MOVE.B	MIDIRunCommand(PC),D1
	CMP.B	#$80,D1
	BEQ	M_NoteOff
	CMP.B	#$90,D1
	BEQ	M_NoteOn
	CMP.B	#$A0,D1
	BEQ	M_PolyTouch
	CMP.B	#$B0,D1
	BEQ	M_Control
	CMP.B	#$C0,D1
	BEQ	M_ProgChange
	CMP.B	#$D0,D1
	BEQ	M_MonoTouch
	CMP.B	#$E0,D1
	BEQ	M_PitchBend
	CMP.B	#$F0,D1
	BEQ	M_SysExData
	RTS

M_NoteOff
	TST.B	MIDIByteCount
	BNE	mnf_veloc
	MOVE.B	D0,MIDINote
	ADD.B	#1,MIDIByteCount
	RTS
mnf_veloc
	CLR.B	MIDIByteCount
	MOVE.B	D0,MIDIVelocity
;	BSR	MidiPlay
	RTS

M_NoteOn
	MOVE	#$F0F,$DFF180
	TST.B	MIDIByteCount
	BNE	mno_veloc
	MOVE.B	D0,MIDINote
	ADD.B	#1,MIDIByteCount
	RTS
mno_veloc
	CLR.B	MIDIByteCount
	MOVE.B	D0,MIDIVelocity
	BEQ	mnf_veloc
;* MidiPlay *
	MOVE.B	MIDINote,D0
	CMP.B	MIDIinTrans,D0
	BLO	miplskip
	SUB.B	MIDIinTrans(PC),D0
	CMP.B	#36,D0
	BLS	J_nkp
	RTS
miplskip
	CMP.B	XMIDI_Play,D0
	BEQ	J_PlaySong
	CMP.B	XMIDI_Pattern,D0
	BEQ	J_PlayPattern
	CMP.B	XMIDI_Edit,D0
	BEQ	J_Edit
	CMP.B	XMIDI_Record,D0
	BEQ	J_RecordPattern
	CMP.B	XMIDI_Stop,D0
	BEQ	J_StopIt
	RTS

J_nkp	JMP	nkpskip
J_PlaySong
	JMP	PlaySong
J_PlayPattern
	JMP	PlayPattern
J_Edit	JMP	Edit
J_RecordPattern
	JMP	RecordPattern
J_StopIt
	JMP	StopIt

MIDIinTrans	dc.b 60,0

XMIDI_Play	dc.b 40 ; E
XMIDI_Pattern	dc.b 38 ; D
XMIDI_Edit	dc.b 43 ; G
XMIDI_Record	dc.b 41 ; F
XMIDI_Stop	dc.b 36 ; C
		dc.b 0 ; free 0

M_PolyTouch
	TST.B	MIDIByteCount
	BNE	mpt_touch
	MOVE.B	D0,MIDINote
	ADD.B	#1,MIDIByteCount
	RTS
mpt_touch
	CLR.B	MIDIByteCount
	MOVE.B	D0,MIDITouch
	RTS

M_Control
	TST.B	MIDIByteCount
	BNE	mc_value
	MOVE.B	D0,MIDIController
	ADD.B	#1,MIDIByteCount
	RTS
mc_value
	CLR.B	MIDIByteCount
	MOVE.B	D0,MIDIlsb
	RTS

M_ProgChange
	MOVE.B	D0,MIDIProgram
	RTS
;	ADDQ.B	#1,D0
;	AND.B	#$1F,D0
;	BNE	mpchskip
;	TST	InsNum
;	BEQ	mpchskip
;	MOVE	InsNum(PC),LastInsNum
;mpchskip
;	MOVE.B	D0,InsNum+1
;	BRA	ShowSampleInfo

M_MonoTouch
	MOVE.B	D0,MIDITouch
	RTS

M_PitchBend
	TST.B	MIDIByteCount
	BNE	mp_msb
	MOVE.B	D0,MIDIlsb
	ADD.B	#1,MIDIByteCount
	RTS
mp_msb	CLR.B	MIDIByteCount
	MOVE.B	D0,MIDImsb
	EXT	D0
	SUB	#128,D0
	MOVE	CurrentPlayNote,D1
	SUB	D0,D1
	CMP	#113,D1
	BLS.S	mp_2
	MOVE	#113,D1
mp_2	MOVE.L	NoteAddr,A0
	MOVE	D1,6(A0)
	RTS

NoteAddr	dc.l 0

M_rts	RTS

MIDISysMessage
	CMP.B	#$F0,D0
	BEQ	M_SysEx		; System Exclusive
	CMP.B	#$F1,D0
	BEQ	M_rts	; Quarter Frame (MIDI Time Code)
	CMP.B	#$F2,D0
	BEQ	M_SongPos	; Song Position Pointer
	CMP.B	#$F3,D0
	BEQ	M_SongSelect	; Song Select
	CMP.B	#$F4,D0
	BEQ	M_rts	; -Reserved-
	CMP.B	#$F5,D0
	BEQ	M_rts	; -Reserved-
	CMP.B	#$F6,D0
	BEQ	M_rts	; -Reserved-
	CMP.B	#$F7,D0
	BEQ	M_EOX		; End of System Exclusive
	CMP.B	#$F8,D0
	BEQ	M_rts	; MIDI Timing Clock
	CMP.B	#$F9,D0
	BEQ	M_rts	; -Reserved-
	CMP.B	#$FA,D0
	BEQ	M_Start		; Start Message
	CMP.B	#$FB,D0
	BEQ	M_Continue	; Continue Message
	CMP.B	#$FC,D0
	BEQ	M_Stop		; Stop Message
	CMP.B	#$FD,D0
	BEQ	M_rts	; --- Reserved ---
	CMP.B	#$FE,D0
	BEQ	M_rts	; Active Sensing (Each 300ms if on)
	CMP.B	#$FF,D0
	BRA	M_rts	; System Reset Message

M_SysEx		RTS
M_SysExData	RTS
M_SongPos	RTS
M_SongSelect	RTS
M_EOX		RTS

M_Start		JMP	PlaySong
M_Continue	RTS
M_Stop		JMP	StopIt

MIDIinBuffer	dc.l 0
MIDIinTo	dc.b 0
MIDIinFrom	dc.b 0

MIDIRunStatus	dc.b $80
MIDIRunChannel	dc.b 0
MIDIRunCommand	dc.b $08
MIDIByteCount	dc.b 0

MIDINote	dc.b 0
MIDIVelocity	dc.b 0
MIDITouch	dc.b 0
MIDIController	dc.b 0
MIDImsb		dc.b 0
MIDIlsb		dc.b 0
MIDIProgram	dc.b 0
MIDIError	dc.b 0


;---- Sampler Screen ----

SamplerScreen
	CLR.B	RawKeyCode
	JSR	WaitForButtonUp
	TST	SamScrEnable
	BNE	ExitFromSam
	MOVE	#1,SamScrEnable
	MOVE.L	EditMode(PC),SaveEditMode
	CLR.L	EditMode

	MOVE.L	TextBplPtr(PC),A0
	LEA	5560(A0),A0
	MOVE.L	A0,D0
	LEA	CopList2Bpl4Ptr,A1
	MOVE	D0,6(A1)
	SWAP	D0
	MOVE	D0,2(A1)

	MOVEQ	#0,D0
	MOVE	#270,D1
	MOVEQ	#14,D2
	LEA	CursorSpriteData,A0
	BSR	SetSpritePos
	JSR	SetSamSpritePtrs
	MOVE	CopCol0+16,CopList2+18
	BSR	SwapSamScreen
	BEQ	exisam2
	BSR	ClearSamScr
	JSR	DoShowFreeMem
	BSR	ShowSamNote
	BSR	ShowResamNote
	BRA	RedrawSample

ExitFromSam
	JSR	WaitForButtonUp
	MOVE.L	SamMemPtr,D0
	BEQ	exisam2
	MOVE.L	D0,A1
	BSR	Bjarne
	BSR.S	FreeDecompMem2
exisam2	JSR	SetDefSpritePtrs
	CLR.B	RawKeyCode
	CLR	SamScrEnable
	MOVEQ	#-1,D0
	MOVE.L	D0,MarkStartOfs
	MOVE.L	SaveEditMode(PC),EditMode
	BSR	SetScreenColors2
	JSR	SetupVUCols
	BSR	SetScrPatternPos
	BSR	ClearSamScr
	JSR	UpdateCursorPos
	JSR	SetTempo
	BRA	RedrawPattern

FreeDecompMem2
	MOVE.L	SamMemPtr,D0
	BEQ	Return2
	MOVE.L	D0,A1
	MOVE.L	SamMemSize,D0
	CLR.L	SamMemPtr
	MOVE.L	4.W,A6
	JSR	LVOFreeMem(A6)
	RTS

DecompactSam
	MOVE.L	A0,CompPtr
	MOVE.L	D0,CompLen
	BSR.S	FreeDecompMem2
	MOVE.L	CompPtr(PC),A0
	CMP.L	#'FORM',(A0)
	BEQ	DecompactSIFF
	MOVE.L	(A0),D0
	MOVE.L	D0,SamMemSize
	MOVEQ	#0,D1
	MOVE.L	4.W,A6
	JSR	LVOAllocMem(A6)
	MOVE.L	D0,SamMemPtr
	BEQ	OutOfMemErr
	MOVE.L	D0,A1
	MOVE.L	CompPtr(PC),A0
	MOVE.L	CompLen(PC),D0
	ADDQ.L	#4,A0
	SUBQ.L	#4,D0
dcmlop3	MOVE.B	(A0)+,D1
	CMP.B	#181,D1
	BEQ.S	DecodeIt3
	MOVE.B	D1,(A1)+
decom3	SUBQ.L	#1,D0
	CMP.L	#0,D0
	BGT.S	dcmlop3
	MOVE.L	SamMemPtr(PC),A1
	MOVEQ	#-1,D0
	RTS

DecodeIt3
	MOVEQ	#0,D1
	MOVE.B	(A0)+,D1
	MOVE.B	(A0)+,D2
dcdlop3	MOVE.B	D2,(A1)+
	DBF	D1,dcdlop3
	SUBQ.L	#2,D0
	BRA.S	decom3



; --- if crunched IFF then go 4 it!!

DecompactSIFF
	MOVE.L	A0,pic_buf
	MOVEM.L	D0-7/A0-A6,-(SP)
	BSR	iff_search
	MOVEM.L	(SP)+,D0-7/A0-6
	MOVE	width_bytes(pc),D0
	MULU	height(pc),D0
	MULU	planes_num(pc),D0
	MOVE.L	D0,SamMemSize
	MOVE.L	#$10000,D1
	MOVE.L	4.W,A6
	JSR	LVOAllocMem(A6)
	MOVE.L	D0,SamMemPtr
	BEQ	OutOfMemErr
	MOVE.L	D0,bitplane		;store where to decompact into
	BSR	colors_init
	BSR	unpacker
	MOVE.L	SamMemPtr,A1
	MOVEQ	#-1,D0
	RTS

SwapSamScreen
	LEA	SampScreenData,A0
	BSR	DecompactSam
	BEQ	Return2

bjasize=134*10
Bjarne	LEA	BitPlaneData+SamScrPos,A0
	MOVEQ	#1,D2
BjaLop1	MOVE	#bjasize-1,D1 ; 134
BjaLop2	MOVE.L	(A0),D0
	MOVE.L	(A1),(A0)+
	MOVE.L	D0,(A1)+
	DBF	D1,BjaLop2
	ADD.L	#PlaneSize-bjasize*4,A0
	DBF	D2,BjaLop1

	LEA	CopListInsPos,A0
	LEA	CopList2,A1
	MOVEQ	#29,D1
BjaLoop	MOVE	(A0),D0
	MOVE	(A1),(A0)+
	MOVE	D0,(A1)+
	DBF	D1,BjaLoop
	MOVEQ	#-1,D0
	RTS

ClearSamScr
	MOVE	#5121,TextOffset
	MOVE	#2,TextLength
	MOVE.L	#blnktxt,ShowTextPtr
	BSR	ShowText
	MOVE	#TempoNumPos,TextOffset
	MOVE	#3,TextLength
	BSR	ShowText
	MOVE	#130*10-1,D0
	MOVE.L	TextBplPtr,A0
	LEA	5560(A0),A0
	MOVE.L	A0,LineScreen
	MOVEQ	#0,D1
clrsslp	MOVE.L	D1,(A0)+
	DBF	D0,clrsslp
	RTS

blnktxt	dc.b "    "

ClearSamArea
	MOVE	#64*10-1,D0
	MOVE.L	TextBplPtr,A0
	LEA	5560(A0),A0
	MOVE.L	A0,LineScreen
	MOVEQ	#0,D1
clrsare	MOVE.L	D1,(A0)+
	DBF	D0,clrsare
	RTS

CheckSamGadgets
	MOVEM.W	MouseX2,D0/D1
	CMP	#139,D1
	BLO	SamTopBar
	CMP	#139+64,D1
	BLO	SamplePressed
	CMP	#201+11,D1
	BLO	SamDragBar
	CMP	#201+22,D1
	BLO	SamMenu1
	CMP	#201+33,D1
	BLO	SamMenu2
	CMP	#201+44,D1
	BLO	SamMenu3
	CMP	#201+66,D1
	BLO	SamMenu4
	RTS

SamTopBar
	CMP	#32,D0
	BLO	ExitFromSam
	RTS

SamMenu1
	CMP	#32,D0
	BLO	Return2
	CMP	#96,D0
	BLO	PlayWaveform
	CMP	#176,D0
	BLO	ShowRange
	CMP	#246,D0
	BLO	ZoomOut
	BRA	DispBox

SamMenu2
	CMP	#32,D0
	BLO	StopPlaying
	CMP	#96,D0
	BLO	PlayDisplay
	CMP	#176,D0
	BLO	ShowAll
	CMP	#246,D0
	BLO	RangeAll
	BRA	LoopToggle

SamMenu3
	CMP	#32,D0
	BLO	StopPlaying
	CMP	#96,D0
	BLO	PlayRange
	CMP	#109,D0			;116
	BLO	CurToStart
	CMP	#122,D0
	BLO	CurToMid
	CMP	#136,D0			;136
	BLO	CurToEnd
	CMP	#176,D0
	BLO	SwapBuffer
	CMP	#210,D0
	BLO	sh_BigMonitor
	CMP	#246,D0
	BLO	Sampler
	BRA	SetSamNote

sh_BigMonitor
	jmp	BigMonitor

SamMenu4
	CMP	#32,D0
	BLO	SamCut
	CMP	#64,D0
	BLO	SamCopy
	CMP	#96,D0
	BLO	SamPaste
	CMP	#136,D0
	BLO	RampVolume
	CMP	#176,D0
	BLO	TuningTone
	CMP	#246,D0
	BLO	Resample
	BRA	SetResamNote


PlayWaveform
	JSR	PlayNote
	JMP	WaitForButtonUp
PlayDisplay
	LEA	SampleInfo,A0
	MOVE.L	SamOffSet(PC),StartOfs
	MOVE.L	SamDisplay(PC),D0
	LSR.L	#1,D0
	MOVE	D0,(A0)
	CLR	4(A0)
	MOVE	#1,6(A0)
	MOVE	PlayInsNum,-(SP)
	CLR	PlayInsNum
	JSR	PlayNote
	MOVE	(SP)+,PlayInsNum
	BSR	ShowSampleInfo
	JMP	WaitForButtonUp
PlayRange
	MOVE.L	MarkStartOfs(PC),D1
	BMI	NoRangeError
	MOVE.L	MarkEndOfs(PC),D0
	CMP.L	D0,D1
	BEQ	LargerRangeError
	LEA	SampleInfo,A0
	MOVE.L	D1,StartOfs
	SUB.L	D1,D0
	LSR.L	#1,D0
	MOVE	D0,(A0)
	CLR	4(A0)
	MOVE	#1,6(A0)
	MOVE	PlayInsNum,-(SP)
	CLR	PlayInsNum
	JSR	PlayNote
	MOVE	(SP)+,PlayInsNum
	BSR	ShowSampleInfo
	JMP	WaitForButtonUp
StopPlaying
	BRA	TurnOffVoices

StartOfs
	dc.l	0

;----

ShowRange
	MOVE.L	MarkStartOfs(PC),D0
	BMI	NoRangeError
	MOVE.L	MarkEndOfs(PC),D1
	CMP.L	D1,D0
	BEQ	LargerRangeError
	SUB.L	D0,D1
	BNE	shorano
	MOVEQ	#1,D1
shorano	MOVE.L	D1,SamDisplay
	MOVE.L	D0,SamOffSet
	MOVEQ	#-1,D0
	MOVE.L	D0,MarkStartOfs
	CLR	MarkStart
	BSR	DisplaySample
	JMP	WaitForButtonUp

ZoomOut	MOVE.L	SamDisplay(PC),D0
	MOVE.L	SamLength(PC),D1
	MOVE.L	SamOffSet(PC),D2
	MOVE.L	D0,D3
	LSL.L	#1,D3
	CMP.L	D1,D3
	BHI	ShowAll
	LSR.L	#1,D0
	CMP.L	D2,D0
	BLO	zoomou2
	MOVEQ	#0,D0
zoomou2	SUB.L	D0,D2
	MOVE.L	D2,D0
	ADD.L	D3,D0
	CMP.L	D1,D0
	BLS	zoomou3
	SUB.L	D3,D1
	MOVE.L	D1,D2
zoomou3	MOVE.L	D2,SamOffSet
	MOVE.L	D3,SamDisplay
	BSR	OffsetToMark
	MOVE.L	MarkStartOfs(PC),D0
	CMP.L	MarkEndOfs(PC),D0
	BNE	zoomouo
	MOVEQ	#-1,D0
	MOVE.L	D0,MarkStartOfs
zoomouo	BSR	DisplaySample
	JMP	WaitForButtonUp

ShowAll	CLR.L	SamOffSet
	MOVE.L	SamLength(PC),SamDisplay
	BSR	OffsetToMark
	MOVE.L	MarkStartOfs(PC),D0
	CMP.L	MarkEndOfs(PC),D0
	BNE	shoallo
	MOVEQ	#-1,D0
	MOVE.L	D0,MarkStartOfs
	CLR	MarkStart
shoallo	BSR	DisplaySample
	JMP	WaitForButtonUp

RangeAll
	BSR	InvertRange
	MOVE	#3,MarkStart
	MOVE	#316,MarkEnd
	BSR	MarkToOffset
ranall2	BSR	InvertRange
	JMP	WaitForButtonUp


CurToStart
	BSR	InvertRange
	MOVEQ	#3,D0
	MOVE	D0,MarkStart
	MOVE	D0,MarkEnd
	MOVE.L	SamOffSet(PC),D0
	MOVE.L	D0,MarkStartOfs
	MOVE.L	D0,MarkEndOfs
	CLR.L	SamplePos
	BSR	ShowPos
	BRA	ranall2

CurToMid
	BSR	InvertRange
	MOVE	#156,D0
	MOVE	D0,MarkStart
	MOVE	D0,MarkEnd
	MOVE.L	SamOffSet(PC),D0
	LSR.L	#1,D0
	ADD.L	SamDisplay(PC),D0
	MOVE.L	D0,MarkStartOfs
	MOVE.L	D0,MarkEndOfs
	LSR.L	#1,D0
	MOVE.L	D0,SamplePos
	BSR	ShowPos
	BRA	ranall2

CurToEnd
	BSR	InvertRange
	MOVE	#316,D0
	MOVE	D0,MarkStart
	MOVE	D0,MarkEnd
	MOVE.L	SamOffSet(PC),D0
	ADD.L	SamDisplay(PC),D0
	MOVE.L	D0,MarkStartOfs
	MOVE.L	D0,MarkEndOfs
	MOVE.L	D0,SamplePos
	BSR	ShowPos
	BRA	ranall2

SwapBuffer
	MOVE	InsNum(PC),D1
	BEQ	NotSampleNull
	LSL	#2,D1
	LEA	SamplePtrs,A0
	LEA	(A0,D1.W),A0

	MOVE.L	CopyBufPtr(PC),D0
	MOVE.L	(A0),CopyBufPtr
	MOVE.L	D0,(A0)
	MOVE.L	D0,A1
	CLR	(A1)

	MOVE.L	CopyBufSize(PC),D0
	MOVE.L	124(A0),CopyBufSize
	MOVE.L	D0,124(A0)

	MOVE.L	SongDataPtr(PC),A0
	MOVE	InsNum(PC),D1
	MULU	#30,D1
	LEA	12(A0,D1.W),A0
	LSR.L	#1,D0
	MOVE	D0,(A0)
	MOVE.L	RepBuf(PC),D0
	MOVE.L	4(A0),RepBuf
	MOVE.L	D0,4(A0)

	MOVE	RepBuf2(PC),D0
	MOVE	2(A0),RepBuf2
	TST.B	D0
	BNE.S	swabuf2
	MOVE.B	#$40,D0
swabuf2	MOVE	D0,2(A0)
	JSR	TurnOffVoices
	BSR	ValidateLoops
	BSR	ShowSampleInfo
	BSR	UpdateRepeats
	BSR	RedrawSample
	JMP	WaitForButtonUp

RepBuf	dc.l	1
RepBuf2	dc.w	$0040

;----

NoRangeError
	LEA	NoRangeText(PC),A0
nres2	BSR	ShowStatusText
	JMP	SetErrorPtrCol

LargerRangeError
	LEA	LargerRangeText(PC),A0
	BRA.S	nres2

SetCursorError
	LEA	SetCursorText(PC),A0
	BRA.S	nres2

BufIsEmptyError
	LEA	BufIsEmptyText(PC),A0
	BRA.S	nres2

EmptySampleError
	LEA	EmptySampleText(PC),A0
	BRA.S	nres2

NoRangeText	dc.b "no range selected",0
LargerRangeText	dc.b "set larger range",0
SetCursorText	dc.b "set cursor pos",0
BufIsEmptyText	dc.b "buffer is empty",0
EmptySampleText	dc.b "sample is empty",0

;----

DispBox
	RTS

LoopToggle
	JSR	WaitForButtonUp
	MOVE	InsNum(PC),D1
	BEQ	NotSampleNull
	MOVE.L	SongDataPtr(PC),A0
	MULU	#30,D1
	LEA	12(A0,D1.W),A0
	TST	LoopOnOffFlag
	BEQ.S	loopton
	MOVE.L	4(A0),SavSamInf
	MOVEQ	#1,D0
	MOVE.L	D0,4(A0)
	BSR	ValidateLoops
	JSR	TurnOffVoices
looptlo	BSR	ShowSampleInfo
	BSR	UpdateRepeats
	BRA	DisplaySample
loopton	MOVE.L	SavSamInf(PC),D0
	BNE.S	loopto2
	MOVE	(A0),D0
loopto2	MOVE.L	D0,4(A0)
	BSR	ValidateLoops
	BRA	looptlo

ShowLoopToggle
	LEA	ToggleOFFText(PC),A0
	TST	LoopOnOffFlag
	BEQ.S	sltskip
	LEA	ToggleONText(PC),A0
sltskip	MOVEQ	#3,D0
	MOVE	#9076,D1
	BRA	ShowText3

LoopOnOffFlag	dc.w 0
SavSamInf	dc.l 0

SetSamNote
	BSR	ShowResamNote
	MOVE	#9516,TextOffset
	MOVE	#3,TextLength
	MOVE.L	#SpcNoteText,ShowTextPtr
	BSR	ShowText
	MOVE	#1,SamNoteType
	MOVE.L	#SampleNote,SplitAddress
	JMP	WaitForButtonUp

SetResamNote
	BSR	ShowSamNote
	MOVE	#9956,TextOffset
	MOVE	#3,TextLength
	MOVE.L	#SpcNoteText,ShowTextPtr
	BSR	ShowText
	MOVE	#2,SamNoteType
	MOVE.L	#ResampleNote,SplitAddress
	JMP	WaitForButtonUp

ResampleText	dc.b "Resample?",0
ResamplingText	dc.b "Resampling...",0

Resample
	LEA	ResampleText(PC),A0
	JSR	AreYouSure
	BNE	Return2
	JSR	StorePtrCol
	JSR	SetWaitPtrCol
	LEA	ResamplingText(PC),A0
	BSR	ShowStatusText
	LEA	SamplePtrs,A0
	MOVE	InsNum(PC),D1
	BEQ	NotSampleNull
	LSL	#2,D1
	LEA	(A0,D1.W),A0
	MOVE.L	(A0),D0
	BEQ	ERC2
	MOVE.L	D0,A2
	MOVE.L	124(A0),D6
	CMP.L	#2,D6
	BLS	ERC2

	MOVE.L	SongDataPtr(PC),A0
	MOVE	InsNum(PC),D1
	MULU	#30,D1
	MOVEQ	#0,D0
	MOVE.B	12+2(A0,D1.W),D0 ; finetune
	MULU	#37*2,D0
	LEA	PeriodTable(PC),A0
	ADD.L	D0,A0
	MOVEQ	#0,D1
	MOVE	ResampleNote(PC),D1
	LSL	#1,D1
	MOVE	(A0,D1.W),D1
	BEQ	ERC2

	LEA	PeriodTable,A0
	MOVEQ	#0,D5
	MOVE	TuneNote,D5
	LSL	#1,D5
	MOVE	(A0,D5.W),D5
	BEQ	ERC2

; D1=resamperiod, D5=tuneperiod

	MOVE.L	D5,D0 ; tune
	LSL.L	#8,D0
	LSL.L	#4,D0 ; * 4096
	DIVU	D1,D0 ; / resample
	MOVEQ	#0,D4
	MOVE	D0,D4
	LSL.L	#4,D4 ; hi-word=add value, lo-word=fraction

	MOVE	D6,D7
	LSR	#1,D7
	MULU	D1,D7
	DIVU	D5,D7
	AND.L	#$FFFF,D7
	CMP	#2,D7
	BLO	ERC2
	CMP	#$7FFF,D7
	BLO	resamlo
	MOVE	#$7FFF,D7
resamlo	ADD.L	D7,D7
	MOVE.L	D7,D0
	MOVE.L	#MEMF_CHIP!MEMF_CLEAR,D1
	MOVE.L	4.W,A6
	JSR	LVOAllocMem(A6)
	TST.L	D0
	BEQ	SamMemError
	MOVE.L	D0,A1
	MOVE.L	D0,A3
	JSR	TurnOffVoices
	MOVE.L	A2,A0
; D4=resample value, D6=old length, D7=new length
; A0/A2=old sample, A1/A3=new sample

	MOVE	#32767,D1
	MOVEQ	#0,D3
	MOVEQ	#0,D5
resampleloop
	MOVE.B	1(A0),D0
	EXT	D0
	MULS	D1,D0
	MOVE.B	(A0),D2
	EXT	D2
	MULS	D3,D2
	ADD.L	D2,D0
	ASR.L	#8,D0
	ASR.L	#7,D0
	MOVE.B	D0,(A1)+

	ADD.L	D4,D5
	SWAP	D5
	MOVE.L	A2,A0
	MOVEQ	#0,D0
	MOVE	D5,D0
	ADD.L	D0,A0
	SWAP	D5
	MOVE	D5,D1
	LSR	#1,D1
	MOVE	#32767,D3
	SUB	D1,D3

	MOVE.L	A1,A4
	SUB.L	A3,A4
	CMP.L	D7,A4
	BHS.S	resamskip
	MOVE.L	A0,A4
	SUB.L	A2,A4
	CMP.L	D6,A4
	BLO.S	resampleloop

resamskip
	MOVE.L	A2,A1
	MOVE.L	D6,D0
	MOVE.L	4.W,A6
	JSR	LVOFreeMem(A6)
	MOVE	InsNum(PC),D1
	LSL	#2,D1
	LEA	SamplePtrs,A0
	LEA	(A0,D1.W),A0
	MOVE.L	A3,(A0)
	MOVE.L	D7,124(A0)

	MOVE.L	SongDataPtr(PC),A0
	MOVE	InsNum(PC),D1
	MULU	#30,D1
	LEA	12(A0,D1.W),A0
	LSR.L	#1,D7
	MOVE	D7,(A0)
	CLR.B	2(A0)
	CLR	4(A0)
	MOVE	#1,6(A0)
	JSR	RestorePtrCol
	BSR	ClearSamStarts
	BSR	ShowSampleInfo
	BSR	ShowAllRight
	BRA	RedrawSample

ERC2	JMP	ErrorRestoreCol

SamCut	CLR.B	RawKeyCode
	MOVE.L	MarkStartOfs(PC),D0
	BMI	NoRangeError
	CMP.L	MarkEndOfs(PC),D0
	BEQ	LargerRangeError
	TST.B	CutToBufFlag
	BEQ.S	samcut2
	BSR	SamCopy
samcut2	BSR	TurnOffVoices
	LEA	SamplePtrs(PC),A0
	MOVE	InsNum(PC),D1
	BEQ	NotSampleNull
	LSL	#2,D1
	LEA	(A0,D1.W),A0
	MOVE.L	(A0),D0
	BEQ	EmptySampleError
	MOVE.L	124(A0),D2
	CMP.L	#2,D2
	BLO	EmptySampleError

	MOVE.L	D0,A1
	MOVE.L	D0,A2		; sample start
	MOVE.L	D0,A3
	MOVE.L	D0,A4
	MOVE.L	D0,A5
	ADD.L	MarkStartOfs(PC),A3	; mark start
	MOVE.L	MarkEndOfs(PC),D0
	SUB.L	MarkStartOfs(PC),D0
	CMP.L	D2,D0
	BHS	Destroy
	MOVE.L	MarkEndOfs(PC),D0
	CMP.L	D2,D0
	BLO.S	samsome
	MOVE.L	D2,D0
	SUBQ.L	#1,D0
samsome	ADD.L	D0,A4	; mark end
	ADD.L	D2,A5		; sample end

	MOVE.L	A3,D0
	SUB.L	A2,D0
	ADD.L	A5,D0
	SUB.L	A4,D0
	BNE	sacoklen
	MOVEQ	#0,D3
	MOVEQ	#0,D4
	BRA	sacfree

sacoklen
	MOVE.L	D0,D3
	MOVEQ	#MEMF_CHIP,D1
	MOVE.L	4.W,A6
	JSR	LVOAllocMem(A6)
	MOVE.L	D0,D4
	BEQ	OutOfMemErr ; No memory

	MOVE.L	D0,A0
	MOVE.L	A2,A1
	MOVE.L	A3,D0
	SUB.L	A2,D0
	BRA.S	sacskp1
saclop1	MOVE.B	(A2)+,(A0)+
sacskp1	DBF	D0,saclop1

	MOVE.L	A5,D0
	SUB.L	A4,D0
	BRA.S	sacskp2
smclop2	MOVE.B	(A4)+,(A0)+
sacskp2	DBF	D0,smclop2

sacfree	MOVE.L	D2,D0
	MOVE.L	4.W,A6
	JSR	LVOFreeMem(A6)

	MOVE	InsNum(PC),D1
	LSL	#2,D1
	LEA	SamplePtrs(PC),A0
	LEA	(A0,D1.W),A0
	MOVE.L	D4,(A0)
	MOVE.L	D3,124(A0)

	MOVE.L	D4,SamStart
	MOVE.L	D3,SamLength
	MOVE.L	SamOffSet(PC),D4
	ADD.L	SamDisplay(PC),D4
	CMP.L	D3,D4
	BLO	samcuto		; display ok
	MOVE.L	SamDisplay(PC),D4
	CMP.L	D3,D4
	BLO	samnils		; if display < length, move offset
samsall	CLR.L	SamOffSet	; else show all
	MOVE.L	D3,SamDisplay
	BRA	samcuto
samnils	MOVE.L	D3,D4
	SUB.L	SamDisplay(PC),D4
	BMI.S	samsall		; if offset < 0, show all
	MOVE.L	D4,SamOffSet
samcuto	MOVE.L	SongDataPtr(PC),A0
	MOVE	InsNum(PC),D1
	MULU	#30,D1
	LEA	12(A0,D1.W),A0

	LSR.L	#1,D3
	MOVE	D3,(A0)
	MOVE	4(A0),D0
	CMP	D3,D0
	BLS.S	samcuxx
	MOVEQ	#1,D0
	MOVE.L	D0,4(A0)
	BRA.S	samcuex
samcuxx	ADD	6(A0),D0
	CMP	D3,D0
	BLS.S	samcuex
	SUB	4(A0),D3
	MOVE	D3,6(A0)

samcuex	MOVE.L	MarkStartOfs(PC),MarkEndOfs
	BSR	ClearSamStarts
	BSR	ValidateLoops
	BSR	ShowSampleInfo
	BRA	DisplaySample


SamCopy	CLR.B	RawKeyCode
	MOVE.L	MarkStartOfs(PC),D0
	BMI	NoRangeError
	CMP.L	MarkEndOfs(PC),D0
	BEQ	LargerRangeError
	LEA	SamplePtrs(PC),A0
	MOVE	InsNum(PC),D1
	BEQ	NotSampleNull
	LSL	#2,D1
	LEA	(A0,D1.W),A0
	MOVE.L	(A0),D0
	BEQ	EmptySampleError
	MOVE.L	124(A0),D2
	BEQ	EmptySampleError
	MOVE.L	D0,A3
	MOVE.L	D0,A4
	ADD.L	MarkStartOfs(PC),A3	; mark start
	MOVE.L	MarkEndOfs(PC),D0	; mark end
	CMP.L	D2,D0
	BLO.S	csamsom
	MOVE.L	D2,D0
	SUBQ.L	#1,D0
csamsom	ADD.L	D0,A4
	BSR.S	FreeCopyBuf
	MOVE.L	A4,D0
	SUB.L	A3,D0
	ADDQ.L	#1,D0
	MOVE.L	D0,CopyBufSize
	MOVEQ	#MEMF_CHIP,D1
	MOVE.L	4.W,A6
	JSR	LVOAllocMem(A6)
	MOVE.L	D0,CopyBufPtr
	BEQ	OutOfMemErr ; No memory
	MOVE.L	D0,A5
csamlop	MOVE.B	(A3)+,(A5)+
	CMP.L	A4,A3
	BLS.S	csamlop
	BSR	InvertRange
	BSR	InvertRange
	JMP	WaitForButtonUp

FreeCopyBuf
	MOVE.L	CopyBufPtr(PC),D0
	BEQ	Return2
	MOVE.L	D0,A1
	MOVE.L	CopyBufSize(PC),D0
	MOVE.L	4.W,A6
	JSR	LVOFreeMem(A6)
	CLR.L	CopyBufPtr
	RTS

CopyBufPtr	dc.l	0
CopyBufSize	dc.l	0

SamPaste
	CLR.B	RawKeyCode
	MOVE.L	MarkStartOfs(PC),D0
	BMI	SetCursorError
	LEA	SamplePtrs(PC),A0
	MOVE	InsNum(PC),D1
	BEQ	NotSampleNull
	LSL	#2,D1
	LEA	(A0,D1.W),A0
	MOVEQ	#0,D2
	MOVE.L	(A0),D0
	BEQ.S	sapanul
	MOVE.L	124(A0),D2
sapanul	MOVE.L	D0,A2
	MOVE.L	CopyBufPtr(PC),D3
	BEQ	BufIsEmptyError
	MOVE.L	D3,A3
	MOVE.L	CopyBufSize(PC),D3
	BEQ	BufIsEmptyError

	MOVE.L	D3,D4 ; copysize
	ADD.L	D2,D4 ; + origsize
	CMP.L	#$FFFE,D4
	BLO.S	sapaok
	MOVE.L	#$FFFE,D4
sapaok	MOVE.L	D4,D0
	MOVE.L	#MEMF_CHIP!MEMF_CLEAR,D1
	MOVE.L	4.W,A6
	JSR	LVOAllocMem(A6)
	TST.L	D0
	BEQ	OutOfMemErr
	MOVE.L	D0,A4
	MOVEQ	#0,D0
	TST.L	D2
	BEQ.S	sapask1
	MOVE.L	MarkStartOfs(PC),D0
sapask1	MOVE.L	D0,MarkStartOfs
	MOVE.L	A2,A1
	MOVE.L	D2,D1
	MOVE.L	A4,A5
	MOVE.L	A4,A0
	ADD.L	D4,A0
; D0    = paste position
; A0    = end of new sample
; A1/D1 = copy of A2/D2
; A2/D2 = original sample
; A3/D3 = copy buffer
; A4/D4 = new sample
; A5    = copy of A4
	BRA.S	sapask2
sapalp1	MOVE.B	(A2)+,(A4)+ ; copy first part
	CMP.L	A0,A4
	BHS.S	sapaski
	SUBQ.L	#1,D2
sapask2	DBF	D0,sapalp1
	BRA.S	sapask3
sapalp2	MOVE.B	(A3)+,(A4)+ ; copy from buffer
	CMP.L	A0,A4
	BHS.S	sapaski
sapask3	DBF	D3,sapalp2
	TST.L	D2
	BEQ.S	sapaski
	BMI.S	sapaski
sapalp3	MOVE.B	(A2)+,(A4)+ ; copy last part
	CMP.L	A0,A4
	BHS.S	sapaski
	SUBQ.L	#1,D2
	BNE.S	sapalp3

sapaski	MOVE.L	D1,D0
	MOVE.L	4.W,A6
	JSR	LVOFreeMem(A6)

	MOVE	InsNum(PC),D1
	LSL	#2,D1
	LEA	SamplePtrs(PC),A0
	LEA	(A0,D1.W),A0
	MOVE.L	A5,(A0)
	MOVE.L	D4,124(A0)

	MOVE.L	SongDataPtr(PC),A0
	MOVE	InsNum(PC),D1
	MULU	#30,D1
	LEA	12(A0,D1.W),A0
	LSR.L	#1,D4
	MOVE	D4,(A0)

	MOVE.L	MarkStartOfs(PC),MarkEndOfs
	BSR	OffsetToMark
	BSR	ClearSamStarts
	BSR	ShowSampleInfo
	BRA	RedrawSample

RampVolume
	MOVE.L	TextBplPtr(PC),A0
	LEA	6209(A0),A0
	MOVEQ	#32,D3
ravlap2	MOVEQ	#16,D2
ravlap1	CLR.B	(A0)+
	DBF	D2,ravlap1
	LEA	23(A0),A0
	DBF	D3,ravlap2
	LEA	BitPlaneData+VolBoxPos,A0
	LEA	VolBoxData,A1
	MOVEQ	#1,D4
ravlop3	MOVEQ	#32,D3
ravlop2	MOVEQ	#16,D2
ravlop1	MOVE.B	(A1)+,(A0)+
	DBF	D2,ravlop1
	ADDQ.L	#1,A1
	LEA	23(A0),A0
	DBF	D3,ravlop2
	LEA	8920(A0),A0
	DBF	D4,ravlop3
	BSR	ShowVolSliders
	JSR	WaitForButtonUp
ravloop	BTST	#2,$DFF016
	BEQ.S	ExitVolBox
	JSR	DoKeyBuffer
	MOVE.B	RawKeyCode(PC),D2
	CMP.B	#68,D2
	BEQ.S	ExitVolBox
	BTST	#6,$BFE001
	BNE.S	ravloop
	MOVEM.W	MouseX,D0-D1
	CMP	#72,D0
	BLO.S	ravloop
	CMP	#72+136,D0
	BHS.S	ravloop
	CMP	#155,D1
	BLO.S	ravloop
	CMP	#166,D1
	BLO.S	Vol1Slider
	CMP	#177,D1
	BLO	Vol2Slider
	CMP	#188,D1
	BLO	VolGadgs
	BRA.S	ravloop

ExitVolBox
	LEA	BitPlaneData+VolBoxPos,A0
	MOVEQ	#1,D2
revlap3	MOVEQ	#32,D1
revlap2	MOVEQ	#16,D0
revlap1	CLR.B	(A0)+
	DBF	D0,revlap1
	LEA	23(A0),A0
	DBF	D1,revlap2
	LEA	8920(A0),A0
	DBF	D2,revlap3
	BRA	DisplaySample

Vol1Slider
	CMP	#167,D0
	BHI.S	v1skip
	LEA	Vol1(PC),A4
	MOVEQ	#0,D7
v1loop1	BTST	#6,$BFE001
	BNE	ravloop
	MOVE	MouseX(PC),D0
	CMP	D7,D0
	BEQ.S	v1loop1
	MOVE	D0,D7
	SUB	#107,D0
	BPL.S	v1skp2
	MOVEQ	#0,D0
v1skp2	CMP	#60,D0
	BLS.S	v1skp3
	MOVEQ	#60,D0
v1skp3	MULU	#200,D0
	DIVU	#60,D0
	MOVE	D0,(A4)
shvosl	BSR	ShowVolSliders
	BRA.S	v1loop1

v1skip	MOVE	#180,LineCurX
	MOVE	#164,LineCurY
	MOVE	#6342,TextOffset
	BSR	GetDec3Dig
	TST	AbortDecFlag
	BNE	shvosl
	CMP	#200,D0
	BLS.S	v1sk2
	MOVE	#200,D0
v1sk2	MOVE	D0,Vol1
	BRA.S	shvosl

Vol2Slider
	CMP	#167,D0
	BHI.S	v2skip
	LEA	Vol2(PC),A4
	MOVEQ	#0,D7
	BRA	v1loop1
v2skip	MOVE	#180,LineCurX
	MOVE	#175,LineCurY
	MOVE	#6782,TextOffset
	BSR	GetDec3Dig
	TST	AbortDecFlag
	BNE	shvosl
	CMP	#200,D0
	BLS.S	v2sk2
	MOVE	#200,D0
v2sk2	MOVE	D0,Vol2
	BRA	shvosl


VolGadgs
	CMP	#100,D0
	BLO	DoRampVol
	CMP	#144,D0
	BLO	Normalize
	CMP	#154,D0
	BLO.S	SetRampDown
	CMP	#164,D0
	BLO.S	SetRampUp
	CMP	#174,D0
	BLO.S	SetRampUnity
	BRA	ExitVolBox

SetRampDown
	MOVE	#100,Vol1
	CLR	Vol2
	BRA.S	sru2
SetRampUp
	CLR	Vol1
	MOVE	#100,Vol2
	BRA.S	sru2
SetRampUnity
	MOVE	#100,Vol1
	MOVE	#100,Vol2
sru2	BSR.S	ShowVolSliders
	JSR	WaitForButtonUp
	BRA	ravloop

ShowVolSliders
	MOVE.L	TextBplPtr(PC),A0
	LEA	6209(A0),A0
	MOVEQ	#21,D3
ravlip2	MOVEQ	#12,D2
ravlip1	CLR.B	(A0)+
	DBF	D2,ravlip1
	LEA	27(A0),A0
	DBF	D3,ravlip2
	MOVEQ	#0,D4
	MOVE	Vol1(PC),D4
	MOVEQ	#20,D5
	BSR	OneSlider
	MOVEQ	#0,D4
	MOVE	Vol2(PC),D4
	MOVEQ	#31,D5
	BSR	OneSlider
	MOVE	Vol1(PC),WordNumber
	MOVE	#6342,TextOffset
	BSR	Print3DecDigits
	MOVE	Vol2(PC),WordNumber
	MOVE	#6782,TextOffset
	BRA	Print3DecDigits

OneSlider
	MOVE	D4,D6
	ADD	D4,D4
	ADD	D6,D4
	DIVU	#10,D4
	ADD	#105,D4
	MOVEQ	#2,D6
oneslop	MOVE	D4,D0
	MOVE	D4,D2
	ADDQ	#5,D2
	MOVE	D5,D1
	MOVE	D5,D3
	BSR	DrawLine
	ADDQ	#1,D5
	DBF	D6,oneslop
	RTS

DoRampVol
	CLR.B	RawKeyCode
	LEA	SamplePtrs(PC),A0
	MOVE	InsNum(PC),D1
	BEQ	nozerr1
	LSL	#2,D1
	LEA	(A0,D1.W),A0
	MOVEQ	#0,D2
	MOVE.L	(A0),D0
	BEQ	nozerr2
	MOVE.L	D0,A2
	MOVE.L	124(A0),D2
	BEQ	nozerr2
	MOVE.L	MarkStartOfs(PC),D0
	BMI	drvskip
	MOVE.L	MarkEndOfs(PC),D1
	SUB.L	D0,D1
	BEQ.S	drvskip
	ADD.L	D0,A2
	MOVE.L	D1,D2
	ADDQ.L	#1,D2
drvskip	JSR	StorePtrCol
	JSR	SetWaitPtrCol
	MOVE.L	D2,D5
	MOVEQ	#0,D3
drvloop	MOVE	D3,D1
	MULU	Vol2(PC),D1
	DIVU	D2,D1
	MOVE	D2,D4
	SUB	D3,D4
	MULU	Vol1(PC),D4
	DIVU	D2,D4
	ADD	D4,D1
	ADDQ	#1,D3
	MOVE.B	(A2),D0
	EXT	D0
	MULS	D1,D0
	DIVS	#100,D0
	CMP	#127,D0
	BLT.S	drvskp2
	MOVEQ	#127,D0
drvskp2	CMP	#-128,D0
	BGT.S	drvskp3
	MOVEQ	#-128,D0
drvskp3	MOVE.B	D0,(A2)+
	SUBQ.L	#1,D5
	BNE	drvloop
	JSR	RestorePtrCol
	BRA	ExitVolBox

nozerr1	BSR	NotSampleNull
	BRA	ravloop
nozerr2	BSR	EmptySampleError
	BRA	ravloop

Normalize
	CLR.B	RawKeyCode
	LEA	SamplePtrs(PC),A0
	MOVE	InsNum(PC),D1
	BEQ	nozerr1
	LSL	#2,D1
	LEA	(A0,D1.W),A0
	MOVEQ	#0,D2
	MOVE.L	(A0),D0
	BEQ	nozerr2
	MOVE.L	D0,A2
	MOVE.L	124(A0),D2
	BEQ	nozerr2
	MOVE.L	MarkStartOfs(PC),D0
	BMI	nozskip
	MOVE.L	MarkEndOfs(PC),D1
	SUB.L	D0,D1
	BEQ.S	nozskip
	ADD.L	D0,A2
	MOVE.L	D1,D2
	ADDQ.L	#1,D2
nozskip	JSR	StorePtrCol
	JSR	SetWaitPtrCol
	MOVEQ	#0,D0
nozloop	MOVE.B	(A2)+,D1
	EXT	D1
	BPL.S	nozskp2
	NEG	D1
nozskp2	CMP	D0,D1
	BLO.S	nozskp3
	MOVE	D1,D0
nozskp3	SUBQ.L	#1,D2
	BNE	nozloop
	JSR	RestorePtrCol
	TST	D0
	BEQ	SetRampUnity
	CMP	#127,D0
	BHI	SetRampUnity
	CMP	#64,D0
	BLO.S	nozmax
	MOVE.L	#12700,D1
	DIVU	D0,D1
	MOVE	D1,Vol1
	MOVE	D1,Vol2
	BRA	sru2
nozmax	MOVE	#200,Vol1
	MOVE	#200,Vol2
	BRA	sru2

Vol1	dc.w	100
Vol2	dc.w	100

TuningTone
	JSR	WaitForButtonUp
	CLR.B	RawKeyCode
	TST	TToneFlag
	BNE	TToneOff
	MOVE	#1,TToneFlag
	MOVE	PattCurPos,D2
	DIVU	#6,D2
	ADDQ	#1,D2
	AND	#3,D2
	MOVEQ	#1,D0
	LSL	D2,D0
	MOVE	D0,TToneBit
	LEA	$DFF0A0,A0
	LSL	#4,D2
	LEA	(A0,D2.W),A0
	LEA	PeriodTable(PC),A1
	MOVE	TuneNote,D1
	LSL	#1,D1
	MOVE	(A1,D1.W),D1
	LEA	TToneData,A2
	MOVE	D0,$DFF096 ; DMACON
	MOVE.L	A2,(A0)
	MOVE	#16,4(A0) ; 32 bytes
	MOVE	D1,6(A0)
	MOVE	TToneVol,8(A0)

	JSR	DMAWaitLoop

	BSET	#15,D0
	MOVE	D0,$DFF096
	RTS

TToneOff
	CLR	TToneFlag
	MOVE	TToneBit(PC),$DFF096
	RTS

TToneFlag	dc.w 0
TToneBit	dc.w 0

SamplePressed
	CMP	#144,D1
	BHS.S	spruskp
	MOVE	LoopStartPos(PC),D2
	BEQ.S	sprusk5
	SUBQ	#3,D2
	CMP	D2,D0
	BLT.S	sprusk5
	ADDQ	#4,D2
	CMP	D2,D0
	BLO	LoopStartDrag
sprusk5	MOVE	LoopEndPos(PC),D2
	BEQ.S	spruskp
	SUBQ	#3,D2
	CMP	D2,D0
	BLT.S	spruskp
	ADDQ	#4,D2
	CMP	D2,D0
	BLO	LoopEndDrag
spruskp	CMP	#3,D0
	BLO	Return2
	CMP	#317,D0
	BHS	Return2
	MOVE	D0,LastSamPos
	BSR	InvertRange
	MOVE	LastSamPos(PC),D0
	MOVE	D0,MarkStart
	MOVE	D0,MarkEnd
	BSR	InvertRange
	BSR	MarkToOffset
	MOVE.L	MarkEndOfs(PC),SamplePos
	BSR	ShowPos
sprulop	BTST	#6,$BFE001
	BNE	spruend
	MOVE	MouseX(PC),D0
	CMP	#3,D0
	BLO	sprusk3
	CMP	#317,D0
	BHS	sprusk2
	BRA	sprusk4
sprusk2	MOVE	#316,D0
	BRA	sprusk4
sprusk3	MOVEQ	#3,D0
sprusk4	CMP	LastSamPos(PC),D0
	BEQ	sprulop
	MOVE	D0,LastSamPos
	BSR	InvertRange
	MOVE	LastSamPos(PC),MarkEnd
	BSR	InvertRange
	BSR	MarkToOffset
	MOVE.L	MarkEndOfs(PC),SamplePos
	BSR	ShowPos
	BRA	sprulop
spruend	MOVE	MarkStart(PC),D0
	MOVE	MarkEnd(PC),D1
	CMP	D0,D1
	BHS	MarkToOffset
	MOVE	D0,MarkEnd
	MOVE	D1,MarkStart
	BRA	MarkToOffset

InvertRange
	MOVE	MarkStart(PC),D4
	BEQ	Return2
	MOVE	MarkEnd(PC),D5
	MOVE.L	GfxBase(PC),A6
	JSR	LVOOwnBlitter(A6)
	JSR	LVOWaitBlit(A6)
invran3	MOVE	D4,D0
	MOVEQ	#0,D1
	MOVE	D4,D2
	MOVEQ	#64,D3
	BSR	DrawInvertLine
	CMP	D5,D4
	BEQ	invranx
	BHI	invran2
	ADDQ	#1,D4
	BRA	invran3
invran2	SUBQ	#1,D4
	BRA	invran3

invranx	MOVE.L	GfxBase(PC),A6
	JSR	LVODisownBlitter(A6)
	RTS

LoopStartPos	dc.w 0
LoopEndPos	dc.w 0

LoopStartDrag
	CLR	DragType
LopDrgLop
	MOVE.L	SongDataPtr(PC),A0
	MOVE	InsNum(PC),D0
	BEQ	Return2
	MULU	#30,D0
	LEA	12(A0,D0.W),A0
	MOVE	MouseX(PC),D0
lsdlop1	BTST	#6,$BFE001
	BNE	lsdexit
	MOVE	MouseX(PC),D1
	CMP	D0,D1
	BEQ.S	lsdlop1
	SUB	DragType,D1
	BPL.S	lsdmsk1
	MOVEQ	#0,D1
lsdmsk1	CMP	#314,D1
	BLO.S	lsdmsk2
	MOVE	#314,D1
lsdmsk2	MOVE.L	SamDisplay(PC),D0
	MULU	D0,D1
	DIVU	#314,D1
	MOVE.L	SamOffSet(PC),D0
	ADD	D1,D0    ; new repeat
	BCLR	#0,D0
	MOVEQ	#0,D1
	MOVE	4(A0),D1 ; old repeat
	ADD	D1,D1
	TST	DragType
	BNE.S	drgrepl
	MOVE	D1,D3
	SUB	D1,D0    ; offset
	ADD	D0,D1
	MOVE	6(A0),D2
	ADD	D2,D2
	ADD	D2,D3
	SUBQ	#2,D3
	SUB	D0,D2
	CMP	D3,D1
	BLS.S	lsdok
	MOVE	D3,D1
	MOVEQ	#2,D2
lsdok	LSR	#1,D1
	MOVE	D1,4(A0)
	LSR	#1,D2
	MOVE	D2,6(A0)
	BSR.S	lsdexit
	BRA	LopDrgLop
lsdexit	BSR	ShowSampleInfo
	BSR	UpdateRepeats
	BRA	SetLoopSprites2

LoopEndDrag
	MOVE	#3,DragType
	BRA	LopDrgLop

drgrepl	MOVE.L	D0,D2 ; repend
	SUB.L	D1,D2 ; subtract repstart
	CMP.L	#2,D2
	BGT.S	ledskp1
	MOVEQ	#2,D2
	BRA.S	lsdok

ledskp1	MOVE	D1,D0 ; repeat
	ADD	D2,D0 ; + replen
	MOVE	(A0),D3
	ADD	D3,D3
	CMP	D3,D0
	BLS.S	lsdok
	SUB	D1,D3
	MOVE	D3,D2
	BRA.S	lsdok

DragType dc.w 0

SamDragBar
	CMP	#4,D0
	BLO	Return2
	CMP	#316,D0
	BHS	Return2
	CMP	DragStart(PC),D0
	BLO.S	draglo
	CMP	DragEnd(PC),D0
	BHI.S	draghi
	MOVE	MouseX(PC),D0
	MOVE	D0,D1
	SUB	DragStart(PC),D1
	MOVE	D1,SaveMX
sdrlop1	BTST	#6,$BFE001
	BNE	Return2
	MOVE	MouseX(PC),D1
	CMP	D0,D1
	BEQ.S	sdrlop1
	SUB	SaveMX(PC),D0
	SUBQ	#4,D0
	BPL.S	sdrskp1
	MOVEQ	#0,D0
sdrskp1	MOVE.L	SamLength(PC),D1
	BEQ	Return2
	MULU	D1,D0
	DIVU	#311,D0
	AND.L	#$FFFF,D0
	BSR	dragchk
	MOVE	MouseX(PC),D0
	BRA.S	sdrlop1

draglo	MOVE.L	SamOffSet(PC),D0
	SUB.L	SamDisplay(PC),D0
	BPL.S	draglo2
	MOVEQ	#0,D0
draglo2	CMP.L	SamOffSet(PC),D0
	BEQ	Return2
	MOVE.L	D0,SamOffSet
	BRA	DisplaySample

draghi	MOVE.L	SamOffSet(PC),D0
	ADD.L	SamDisplay(PC),D0
dragchk	MOVE.L	D0,D1
	ADD.L	SamDisplay(PC),D1
	CMP.L	SamLength(PC),D1
	BLS.S	draglo2
	MOVE.L	SamLength(PC),D0
	SUB.L	SamDisplay(PC),D0
	BRA.S	draglo2

SaveMX	dc.w	0

;----

MarkToOffset
	MOVE.L	SamDisplay(PC),D0
	MOVE	MarkStart(PC),D1
	BEQ	Return2
	SUBQ	#3,D1
	MULU	D0,D1
	DIVU	#314,D1
	AND.L	#$FFFF,D1
	ADD.L	SamOffSet(PC),D1
	MOVE.L	D1,MarkStartOfs
	MOVE	MarkEnd(PC),D1
	CMP	#316,D1
	BLO.S	mtosome
	MOVE.L	SamOffSet(PC),D1
	ADD.L	D0,D1
	BRA.S	mtoexit
mtosome	SUBQ	#3,D1
	MULU	D0,D1
	DIVU	#314,D1
	AND.L	#$FFFF,D1
	ADD.L	SamOffSet(PC),D1
mtoexit	MOVE.L	D1,MarkEndOfs
	RTS

OffsetToMark
	MOVE.L	MarkStartOfs(PC),D0
	BMI.S	otmout
	MOVE	#3,MarkStart
	SUB.L	SamOffSet(PC),D0
	BMI.S	otmskip	; set to start if before offset
	MULU	#314,D0
	MOVE.L	SamDisplay(PC),D1
	BEQ.S	otmskip
	DIVU	D1,D0
	CMP	#314,D0
	BHI.S	otmout	; if start after display
	ADD	D0,MarkStart
otmskip	MOVE	#3,MarkEnd
	MOVE.L	MarkEndOfs(PC),D0
	SUB.L	SamOffSet(PC),D0
	BMI.S	otmout	; if end before offset
	MULU	#314,D0
	MOVE.L	SamDisplay(PC),D1
	BEQ	Return2
	DIVU	D1,D0
	CMP	#313,D0
	BLS.S	otmok
	MOVE	#313,D0	; set to end if after display
otmok	ADD	D0,MarkEnd
	RTS

otmout	CLR	MarkStart
	RTS

SamScrEnable	dc.w	0
SamMemPtr	dc.l	0
SamMemSize	dc.l	0
LastSamPos	dc.w	0
MarkStart	dc.w	0
MarkEnd		dc.w	0
MarkStartOfs	dc.l	0
MarkEndOfs	dc.l	0

;---- Sample graphing stuff ----

DisplaySample
	TST	SamScrEnable
	BEQ	Return2
	BSR	rdsdoit
	TST.L	MarkStartOfs
	BMI	Return2
	BSR	OffsetToMark
	BRA	InvertRange

RedrawSample
	TST	SamScrEnable
	BEQ	Return2
	MOVEQ	#-1,D0
	MOVE.L	D0,MarkStartOfs
	CLR	MarkStart
	MOVE	InsNum(PC),D0
	BEQ	rdsblnk
	LEA	SampleStarts(PC),A1
	SUBQ	#1,D0
	LSL	#2,D0
	MOVE.L	(A1,D0.W),SamStart
	BEQ	rdsblnk
	MOVE.L	124(A1,D0.W),D1
	BEQ	rdsblnk
	MOVE.L	D1,SamLength
	CLR.L	SamOffSet
	MOVE.L	D1,SamDisplay
	BRA	rdsdoit
rdsblnk	LEA	BlankSample,A0
	MOVE.L	A0,SamStart
	MOVE.L	#314,SamLength
	CLR.L	SamOffSet
	MOVE.L	#314,SamDisplay
rdsdoit	MOVE.L	GfxBase(PC),A6
	JSR	LVOOwnBlitter(A6)
	JSR	LVOWaitBlit(A6)
	BSR	ClearSamArea
	MOVE.L	SamStart(PC),A0
	MOVEQ	#0,D4
	MOVE.L	SamOffSet(PC),D5
	MOVE.L	SamDisplay(PC),D6
	MOVE.L	D5,D7
	MOVE.L	A0,D0
	ADD.L	D5,D0
	MOVE.L	D0,SamDrawStart
	ADD.L	D6,D0
	MOVE.L	D0,SamDrawEnd
rdsloop	MOVE	D4,D0
	ADDQ	#3,D0
	MOVEQ	#127,D1
	SUB.B	(A0,D7.L),D1
	LSR	#2,D1
	TST	D4
	BNE	rdsdraw
	BSR	MoveTo
	BRA	rdsupdt
rdsdraw	BSR	DrawTo
rdsupdt	ADDQ	#1,D4
	MOVE.L	D4,D7
	MULU	D6,D7
	DIVU	#314,D7
	AND.L	#$FFFF,D7
	ADD.L	D5,D7
	CMP	#314,D4
	BLO	rdsloop

	MOVE.L	GfxBase(PC),A6
	JSR	LVODisownBlitter(A6)
	BSR.S	SetDragBar
	MOVE.L	SamDisplay(PC),D0
	LEA	BlankSample,A0
	CMP.L	SamStart,A0
	BNE.S	rdsslwo
	MOVEQ	#0,D0
rdsslwo	MOVE	#215*40+33,TextOffset
	BSR	Print6DecDigits
	BRA	SetLoopSprites

SamStart	dc.l	0
SamLength	dc.l	0
SamOffSet	dc.l	0
SamDisplay	dc.l	0
SavSamIns	dc.w	0

SetDragBar
	MOVE	#4*10-1,D0
	MOVE.L	TextBplPtr,A0
	LEA	5560+2720(A0),A0
	MOVEQ	#0,D1
sdblop2	MOVE.L	D1,(A0)+
	DBF	D0,sdblop2
	MOVE.L	SamLength(PC),D0
	BEQ	Return2
	MOVE.L	SamOffSet(PC),D4
	MOVE.L	SamDisplay(PC),D5
	CMP.L	D0,D5
	BEQ	Return2
	ADD.L	D4,D5
	MULU	#311,D4
	DIVU	D0,D4
	ADDQ	#4,D4
	MOVE	D4,DragStart
	MULU	#311,D5
	DIVU	D0,D5
	ADDQ	#5,D5
	MOVE	D5,DragEnd
	MOVE.L	GfxBase(PC),A6
	JSR	LVOOwnBlitter(A6)
	JSR	LVOWaitBlit(A6)
	MOVEQ	#68,D6
	MOVEQ	#3,D7
sdbloop	MOVE	D4,D0
	MOVE.L	D6,D1
	MOVE	D5,D2
	MOVE.L	D6,D3
	BSR.S	DrawLine
	ADDQ.L	#1,D6
	DBF	D7,sdbloop
	MOVE.L	GfxBase(PC),A6
	JSR	LVODisownBlitter(A6)
	RTS

DragStart	dc.w	0
DragEnd		dc.w	0

;---- Line Routine ----

DrawInvertLine
	MOVE.B	#$48,MinTerm
	BSR.S	DrawLine
	MOVE.B	#$C8,MinTerm
	RTS

MoveTo	MOVE	D0,PenX
	MOVE	D1,PenY
	RTS

DrawTo	MOVE	PenX(PC),D2
	MOVE	PenY(PC),D3
	MOVE	D0,PenX
	MOVE	D1,PenY
DrawLine
	MOVEM.L	D4-D7,-(SP)
	MOVEQ	#0,D4
	SUB	D1,D3
	BGE.S	dypos
	NEG	D3
	BRA.S	dyneg
dypos	BSET	#0,D4
dyneg	SUB	D0,D2
	BGE.S	dxpos
	NEG	D2
	BRA.S	dxneg
dxpos	BSET	#1,D4
dxneg	MOVE	D2,D5
	SUB	D3,D5
	BGE.S	dxdypos
	EXG	D2,D3
	BRA.S	dxdyneg
dxdypos	BSET	#2,D4
dxdyneg	MOVEQ	#0,D5
	ROR	#4,D0
	OR	#$0B00,D0
	MOVE.B	D0,D5
	MOVE.B	MinTerm(PC),D0
	LSL	#1,D5
	MULS	#ScrWidth,D1
	ADD	D5,D1
	ADD.L	LineScreen(PC),D1
blitrdy	BTST	#14,$DFF002 ; DMACONR
	BNE.S	blitrdy
	MOVE	$DFF01C,-(SP)
	BSET	#7,(SP)
	MOVE	#$7FFF,$DFF09A
	MOVE.B	Octants(PC,D4),D4
	ADD.L	D3,D3
	MOVE	D3,$DFF062 ; BLTBMOD
	SUB	D2,D3
	BGE.S	dldspos
	OR.B	#$40,D4
dldspos	MOVE.L	D3,$DFF050 ; BLTAPTR
	SUB	D2,D3
	MOVE	D3,$DFF064 ; BLTAMOD
	MOVE	D4,$DFF042 ; BLTCON1
	MOVE	D0,$DFF040 ; BLTCON0
	MOVE.L	D1,$DFF048 ; BLTCPTR
	MOVE.L	D1,$DFF054 ; BLTDPTR
	MOVE	#ScrWidth,$DFF060 ; BLTCMOD
	MOVE	#ScrWidth,$DFF066 ; BLTDMOD
	MOVE	#$8000,$DFF074 ; BLTADAT
	MOVE	#$FFFF,$DFF044 ; BLTAFWM
	MOVE	LinMask(PC),$DFF072 ; BLTBDAT
	ASL	#6,D2
	ADD	#2,D2
	MOVE	D2,$DFF058 ; BLTSIZE
	MOVE	(SP)+,$DFF09A
	MOVEM.L	(SP)+,D4-D7
	RTS

ScrWidth = 40

Octants	dc.b	3*4+1,2*4+1,1*4+1,0*4+1,7*4+1,5*4+1,6*4+1,4*4+1
LinMask	dc.w	$FFFF
MinTerm	dc.b	$C8 ;was $CA
	dc.b	0   ;free 0
PenX	dc.w	0
PenY	dc.w	0
LineScreen dc.l	0

;---- Loop Sprites ----

SetLoopSprites
	MOVEQ	#-1,D6
	MOVEQ	#-1,D7
	MOVE	InsNum(PC),D0
	BEQ	slsset
	MULU	#30,D0
	MOVE.L	SongDataPtr(PC),A0
	LEA	12(A0,D0.W),A0
SetLoopSprites2
	TST	SamScrEnable
	BEQ	Return2
	CLR	LoopOnOffFlag
	MOVEQ	#-1,D6
	MOVEQ	#-1,D7
	MOVEQ	#0,D0
	MOVE	4(A0),D0
	ADD.L	D0,D0
	MOVEQ	#0,D1
	MOVE	6(A0),D1
	ADD.L	D1,D1
	MOVE.L	D0,D5
	ADD.L	D1,D5
	CMP	#2,D5
	BLS.S	slsset
	MOVE	#1,LoopOnOffFlag
	MOVE.L	SamOffSet(PC),D2
	MOVE.L	SamDisplay(PC),D3
	MOVE.L	D2,D4
	ADD.L	D3,D4
	CMP.L	D2,D0
	BLO.S	1$
	CMP.L	D4,D0
	BHI.S	1$
	SUB.L	D2,D0
	MULU	#314,D0
	DIVU	D3,D0
	ADDQ	#3,D0
	MOVE	D0,D6
1$	CMP.L	D2,D5
	BLO.S	slsset
	CMP.L	D4,D5
	BHI.S	slsset
	SUB.L	D2,D5
	MULU	#314,D5
	DIVU	D3,D5
	ADDQ	#6,D5
	MOVE	D5,D7
slsset	MOVE	#139,D1
	MOVE	D6,D0
	BPL.S	1$
	MOVEQ	#0,D0
	MOVE	#270,D1
1$	MOVEQ	#64,D2
	LEA	LoopSpriteData1,A0
	MOVE	D0,LoopStartPos
	BSR	SetSpritePos
	MOVE	#139,D1
	MOVE	D7,D0
	BPL.S	2$
	MOVEQ	#0,D0
	MOVE	#270,D1
2$	MOVEQ	#64,D2
	LEA	LoopSpriteData2,A0
	MOVE	D0,LoopEndPos
	BSR	SetSpritePos
	BRA	ShowLoopToggle

;---- Playroutine ----

audchan1temp	dc.l	0,0,0,0,0,$00010000,0,  0,0,0,0
audchan2temp	dc.l	0,0,0,0,0,$00020000,0,  0,0,0,0
audchan3temp	dc.l	0,0,0,0,0,$00040000,0,  0,0,0,0
audchan4temp	dc.l	0,0,0,0,0,$00080000,0,  0,0,0,0

IntMusic
	MOVEM.L	D0-D7/A0-A6,-(SP)
	;jsr	SetNewPitchCtrl
	MOVE.L	RunMode(PC),D0
	BEQ	NoNewPositionYet
	CMP.L	#'patt',D0
	BEQ.S	.s1
	MOVE.L	SongPosition(PC),CurrPos
.s1	MOVE.L	SongDataPtr(PC),A0
	MOVE.B	sd_numofpatt(A0),SongNumOfPatt+1
	TST	StepPlayEnable
	BNE.S	.s2
	ADDQ.L	#1,Counter
	MOVE.L	Counter(PC),D0
	CMP.L	CurrSpeed(PC),D0
	BLO.S	NoNewNote
.s2	CLR.L	Counter
	TST.B	PattDelayTime2
	BEQ.S	GetNewNote
	BSR.S	NoNewAllChannels
	BRA	dskip

NoNewNote
	BSR.S	NoNewAllChannels
	BRA	NoNewPositionYet

NoNewAllChannels
	LEA	audchan1toggle,A4
	LEA	audchan1temp(PC),A6
	LEA	$DFF0A0,A5
	BSR	CheckEffects
	LEA	audchan2toggle,A4
	LEA	audchan2temp(PC),A6
	LEA	$DFF0B0,A5
	BSR	CheckEffects
	LEA	audchan3toggle,A4
	LEA	audchan3temp(PC),A6
	LEA	$DFF0C0,A5
	BSR	CheckEffects
	LEA	audchan4toggle,A4
	LEA	audchan4temp(PC),A6
	LEA	$DFF0D0,A5
	BSR	CheckEffects
	RTS




GetNewNote
	LEA	12(A0),A3
	LEA	sd_pattpos(A0),A2
	LEA	sd_patterndata(A0),A0
	MOVEQ	#0,D1
	MOVE.L	SongPosition(PC),D0
	MOVE.B	(A2,D0.W),D1

	CMP.L	#'patt',RunMode
	BNE.S	1$
	MOVE.L	PatternNumber(PC),D1
1$	ASL.L	#8,D1

	ASL.L	#2,D1
	ADD.L	PatternPosition(PC),D1
	MOVE.L	D1,PatternPtr
	CLR	DMACONtemp
	LEA	audchan1toggle,A4
	LEA	$DFF0A0,A5
	LEA	audchan1temp(PC),A6
	MOVEQ	#1,D2
	BSR	PlayVoice
	MOVEQ	#0,D0
	MOVE.B	n_volume(A6),D0
	MOVE	D0,8(A5)
	LEA	audchan2toggle,A4
	LEA	$DFF0B0,A5
	LEA	audchan2temp(PC),A6
	MOVEQ	#2,D2
	BSR.S	PlayVoice
	MOVEQ	#0,D0
	MOVE.B	n_volume(A6),D0
	MOVE	D0,8(A5)
	LEA	audchan3toggle,A4
	LEA	$DFF0C0,A5
	LEA	audchan3temp(PC),A6
	MOVEQ	#3,D2
	BSR.S	PlayVoice
	MOVEQ	#0,D0
	MOVE.B	n_volume(A6),D0
	MOVE	D0,8(A5)
	LEA	audchan4toggle,A4
	LEA	$DFF0D0,A5
	LEA	audchan4temp(PC),A6
	MOVEQ	#4,D2
	BSR.S	PlayVoice
	MOVEQ	#0,D0
	MOVE.B	n_volume(A6),D0
	MOVE	D0,8(A5)
	BRA	SetDMA

CheckMetronome
	CMP.B	MetroChannel,D2
	BNE	Return2
	MOVE.B	MetroSpeed,D2
	BEQ	Return2
	MOVE.L	PatternPosition,D3
	LSR.L	#4,D3
	DIVU	D2,D3
	SWAP	D3
	TST	D3
	BNE	Return2
	AND.L	#$00000FFF,(A6)
	OR.L	#$10D6F000,(A6) ; Play sample $1F at period $0D6 (214)
	RTS


;----------------------------------------------
PlayVoice
	TST.L	(A6)
	BNE.S	plvskip
	BSR	PerNop
plvskip	MOVE.L	(A0,D1.L),(A6)	; Read note from pattern
	BSR.S	CheckMetronome
	ADDQ.L	#4,D1
	MOVEQ	#0,D2
	MOVE.B	n_cmd(A6),D2	; Get lower 4 bits of instrument
	AND.B	#$F0,D2
	LSR.B	#4,D2
	MOVE.B	(A6),D0		; Get higher 4 bits of instrument
	AND.B	#$F0,D0
	OR.B	D0,D2
	TST.B	D2
	BEQ	SetRegisters	; Instrument was zero
	MOVEQ	#0,D3
	LEA	SampleStarts(PC),A1
	MOVE	D2,D4
	MOVE.B	D2,n_samplenum(A6)
	SUBQ.L	#1,D2
	LSL.L	#2,D2
	MULU	#30,D4
	MOVE.L	(A1,D2.L),n_start(A6)
	MOVE	(A3,D4.L),n_length(A6)
	MOVE	(A3,D4.L),n_reallength(A6)
	MOVE.B	2(A3,D4.L),n_finetune(A6)
	MOVE.B	3(A3,D4.L),n_volume(A6)
	MOVE	4(A3,D4.L),D3 ; Get repeat
	TST	D3
	BEQ.S	NoLoop
	MOVE.L	n_start(A6),D2	; Get start
	ASL	#1,D3
	ADD.L	D3,D2		; Add repeat
	MOVE.L	D2,n_loopstart(A6)
	MOVE.L	D2,n_wavestart(A6)
	MOVE	4(A3,D4.L),D0	; Get repeat
	ADD	6(A3,D4.L),D0	; Add replen
	MOVE	D0,n_length(A6)
	MOVE	6(A3,D4.L),n_replen(A6)	; Save replen
	BRA.S	SetRegisters

NoLoop	MOVE.L	n_start(A6),D2
	ADD.L	D3,D2
	MOVE.L	D2,n_loopstart(A6)
	MOVE.L	D2,n_wavestart(A6)
	MOVE	6(A3,D4.L),n_replen(A6)	; Save replen
SetRegisters
	MOVE	(A6),D0
	AND	#$0FFF,D0
	BEQ	CheckMoreEffects	; If no note
	MOVE	2(A6),D0
	AND	#$0FF0,D0
	CMP	#$0E50,D0 ; finetune
	BEQ.S	DoSetFineTune
	MOVE.B	2(A6),D0
	AND.B	#$0F,D0
	CMP.B	#3,D0	; TonePortamento
	BEQ.S	ChkTonePorta
	CMP.B	#5,D0	; TonePortamento + VolSlide
	BEQ.S	ChkTonePorta
	CMP.B	#9,D0	; Sample Offset
	BNE.S	SetPeriod
	BSR	CheckMoreEffects
	BRA.S	SetPeriod

DoSetFineTune
	BSR	SetFineTune
	BRA.S	SetPeriod

ChkTonePorta
	BSR	SetTonePorta
	BRA	CheckMoreEffects





SetPeriod
	MOVEM.L	D0-D1/A0-A1,-(SP)
	MOVE	(A6),D1
	AND	#$0FFF,D1
	LEA	PeriodTable(PC),A1
	MOVEQ	#0,D0
	MOVEQ	#$24,D7
ftuloop	CMP	(A1,D0.W),D1
	BHS	ftufound
	ADDQ.L	#2,D0
	DBF	D7,ftuloop
ftufound
	MOVEQ	#0,D1
	MOVE.B	n_finetune(A6),D1
	MULU	#37*2,D1
	ADD.L	D1,A1
	MOVE	(A1,D0.W),n_period(A6)
	MOVEM.L	(SP)+,D0-D1/A0-A1

	MOVE	2(A6),D0
	AND	#$0FF0,D0
	CMP	#$0ED0,D0
	BEQ	CheckMoreEffects

	MOVE	n_dmabit(A6),$DFF096
	BTST	#2,n_wavecontrol(A6)
	BNE	vibnoc
	CLR.B	n_vibratopos(A6)
vibnoc	BTST	#6,n_wavecontrol(A6)
	BNE	trenoc
	CLR.B	n_tremolopos(A6)
trenoc	MOVE	n_length(A6),4(A5)	; Set length
	MOVE.L	n_start(A6),(A5)	; Set start
	BNE	sdmaskp
	CLR.L	n_loopstart(A6)
	MOVEQ	#1,D0
	MOVE	D0,4(A5)
	MOVE	D0,n_replen(A6)
sdmaskp	MOVE	n_period(A6),D0

	MOVE	D0,6(A5)		; Set period
	JSR	SpectrumAnalyzer	; Do the analyzer
	ST	n_trigger(A6)
	MOVE	n_dmabit(A6),D0
	OR	D0,DMACONtemp
	BRA	CheckMoreEffects
 
SetDMA	JSR	DMAWaitLoop
	MOVE	DMACONtemp,D0
	AND	ActiveChannels,D0
	OR	#$8000,D0
	MOVE	D0,$DFF096
	JSR	DMAWaitLoop
	LEA	$DFF000,A5
	LEA	audchan4temp(PC),A6
	MOVE.L	n_loopstart(A6),$D0(A5)
	MOVE	n_replen(A6),$D4(A5)
	LEA	audchan3temp(PC),A6
	MOVE.L	n_loopstart(A6),$C0(A5)
	MOVE	n_replen(A6),$C4(A5)
	LEA	audchan2temp(PC),A6
	MOVE.L	n_loopstart(A6),$B0(A5)
	MOVE	n_replen(A6),$B4(A5)
	LEA	audchan1temp(PC),A6
	MOVE.L	n_loopstart(A6),$A0(A5)
	MOVE	n_replen(A6),$A4(A5)

dskip	TST.L	RunMode
	BEQ	dskipx
	BSR	SetPatternPos
dskipx	MOVE.L	PatternPosition(PC),D0
	LSR.L	#4,D0
	MOVE	D0,ScrPattPos
	ADD.L	#16,PatternPosition
	MOVE.B	PattDelayTime,D0
	BEQ	dskpc
	MOVE.B	D0,PattDelayTime2
	CLR.B	PattDelayTime
dskpc	TST.B	PattDelayTime2
	BEQ	dskpa
	SUBQ.B	#1,PattDelayTime2
	BEQ	dskpa
	SUB.L	#16,PatternPosition
dskpa	TST.B	PBreakFlag
	BEQ	nnpysk
	SF	PBreakFlag
	MOVEQ	#0,D0
	MOVE.B	PBreakPosition(PC),D0
	LSL	#4,D0
	MOVE.L	D0,PatternPosition
	CLR.B	PBreakPosition
nnpysk	TST	StepPlayEnable
	BEQ	nnpysk2
	BSR	DoStopIt
	CLR	StepPlayEnable
	MOVE.L	PatternPosition(PC),D0
	LSR.L	#4,D0
	AND	#63,D0
	MOVE	D0,ScrPattPos
nnpysk2	CMP.L	#1024,PatternPosition
	BNE	NoNewPositionYet
NextPosition
	MOVEQ	#0,D0
	MOVE.B	PBreakPosition(PC),D0
	LSL	#4,D0
	MOVE.L	D0,PatternPosition
	CLR.B	PBreakPosition
	CLR.B	PosJumpAssert
	CMP.L	#'patp',RunMode
	BNE	NoNewPositionYet
	ADDQ.L	#1,SongPosition
	AND.L	#$7F,SongPosition
	MOVE.L	SongPosition(PC),D1
	MOVE.L	SongDataPtr(PC),A0
	CMP.B	sd_numofpatt(A0),D1
	BLO	NoNewPositionYet
	CLR.L	SongPosition

	TST	StepPlayEnable
	BEQ	NoNewPositionYet
	BSR	DoStopIt
	CLR	StepPlayEnable
	MOVE.L	PatternPosition(PC),D0
	LSR.L	#4,D0
	MOVE	D0,ScrPattPos

NoNewPositionYet
	TST.B	PosJumpAssert
	BNE	NextPosition
	MOVEM.L	(SP)+,D0-D7/A0-A6
	RTS

CheckEffects
	TST	(A4)
	BEQ	Return2
	BSR	chkefx2
	MOVEQ	#0,D0
	MOVE.B	n_volume(A6),D0
	MOVE	D0,8(A5)
	RTS

chkefx2	BSR	UpdateFunk
	MOVE	n_cmd(A6),D0
	AND	#$0FFF,D0
	BEQ	Return2
	MOVE.B	n_cmd(A6),D0
	AND.B	#$0F,D0
	TST.B	D0
	BEQ	Arpeggio
	CMP.B	#1,D0
	BEQ	PortaUp
	CMP.B	#2,D0
	BEQ	PortaDown
	CMP.B	#3,D0
	BEQ	TonePortamento
	CMP.B	#4,D0
	BEQ	Vibrato
	CMP.B	#5,D0
	BEQ	TonePlusVolSlide
	CMP.B	#6,D0
	BEQ	VibratoPlusVolSlide
	CMP.B	#$E,D0
	BEQ	E_Commands
SetBack	MOVE	n_period(A6),6(A5)
	CMP.B	#7,D0
	BEQ	Tremolo
	CMP.B	#$A,D0
	BEQ	VolumeSlide
Return2	RTS

PerNop	MOVE	n_period(A6),6(A5)
	RTS

Arpeggio
	MOVEQ	#0,D0
	MOVE.L	Counter(PC),D0
	DIVS	#3,D0
	SWAP	D0
	CMP	#1,D0
	BEQ	Arpeggio1
	CMP	#2,D0
	BEQ	Arpeggio2
Arpeggio0
	MOVE	n_period(A6),D2
	BRA	ArpeggioSet

Arpeggio1
	MOVEQ	#0,D0
	MOVE.B	n_cmdlo(A6),D0
	LSR.B	#4,D0
	BRA	ArpeggioFind

Arpeggio2
	MOVEQ	#0,D0
	MOVE.B	n_cmdlo(A6),D0
	AND.B	#15,D0
ArpeggioFind
	ASL	#1,D0
	MOVEQ	#0,D1
	MOVE.B	n_finetune(A6),D1
	MULU	#37*2,D1
	LEA	PeriodTable(PC),A0
	ADD.L	D1,A0
	MOVEQ	#0,D1
	MOVE	n_period(A6),D1
	MOVEQ	#$24,D7
arploop	MOVE	(A0,D0.W),D2
	CMP	(A0),D1
	BHS	ArpeggioSet
	ADDQ.L	#2,A0
	DBF	D7,arploop
	RTS

ArpeggioSet
	MOVE	D2,6(A5)
	RTS

FinePortaUp
	TST.L	Counter
	BNE	Return2
	MOVE.B	#$0F,LowMask
PortaUp	MOVEQ	#0,D0
	MOVE.B	n_cmdlo(A6),D0
	AND.B	LowMask,D0
	MOVE.B	#$FF,LowMask
	SUB	D0,n_period(A6)
	MOVE	n_period(A6),D0
	AND	#$0FFF,D0
	CMP	#$0071,D0
	BPL	PortaUskip
	AND	#$F000,n_period(A6)
	OR	#$0071,n_period(A6)
PortaUskip	MOVE	n_period(A6),D0
	AND	#$0FFF,D0
	MOVE	D0,6(A5)
	RTS

FinePortaDown
	TST.L	Counter
	BNE	Return2
	MOVE.B	#$0F,LowMask
PortaDown
	CLR	D0
	MOVE.B	n_cmdlo(A6),D0
	AND.B	LowMask,D0
	MOVE.B	#$FF,LowMask
	ADD	D0,n_period(A6)
	MOVE	n_period(A6),D0
	AND	#$0FFF,D0
	CMP	#$0358,D0
	BMI	PortaDskip
	AND	#$F000,n_period(A6)
	OR	#$0358,n_period(A6)
PortaDskip
	MOVE	n_period(A6),D0
	AND	#$0FFF,D0
	MOVE	D0,6(A5)
	RTS

SetTonePorta
	MOVE.L	A0,-(SP)
	MOVE	(A6),D2
	AND	#$0FFF,D2
	MOVEQ	#0,D0
	MOVE.B	n_finetune(A6),D0
	MULU	#37*2,D0
	LEA	PeriodTable(PC),A0
	ADD.L	D0,A0
	MOVEQ	#0,D0
StpLoop	CMP	(A0,D0.W),D2
	BHS	StpFound
	ADDQ	#2,D0
	CMP	#37*2,D0
	BLO	StpLoop
	MOVEQ	#35*2,D0
StpFound
	MOVE.B	n_finetune(A6),D2
	AND.B	#8,D2
	BEQ	StpGoss
	TST	D0
	BEQ	StpGoss
	SUBQ	#2,D0
StpGoss	MOVE	(A0,D0.W),D2
	MOVE.L	(SP)+,A0
	MOVE	D2,n_wantedperiod(A6)
	MOVE	n_period(A6),D0
	CLR.B	n_toneportdirec(A6)
	CMP	D0,D2
	BEQ	ClearTonePorta
	BGE	Return2
	MOVE.B	#1,n_toneportdirec(A6)
	RTS

ClearTonePorta
	CLR	n_wantedperiod(A6)
	RTS

 
TonePortamento
	MOVE.B	n_cmdlo(A6),D0
	BEQ	TonePortNoChange
	MOVE.B	D0,n_toneportspeed(A6)
	CLR.B	n_cmdlo(A6)
TonePortNoChange
	TST	n_wantedperiod(A6)
	BEQ	Return2
	MOVEQ	#0,D0
	MOVE.B	n_toneportspeed(A6),D0
	TST.B	n_toneportdirec(A6)
	BNE	TonePortaUp
TonePortaDown
	ADD	D0,n_period(A6)
	MOVE	n_wantedperiod(A6),D0
	CMP	n_period(A6),D0
	BGT	TonePortaSetPer
	MOVE	n_wantedperiod(A6),n_period(A6)
	CLR	n_wantedperiod(A6)
	BRA	TonePortaSetPer

TonePortaUp
	SUB	D0,n_period(A6)
	MOVE	n_wantedperiod(A6),D0
	CMP	n_period(A6),D0
	BLT	TonePortaSetPer
	MOVE	n_wantedperiod(A6),n_period(A6)
	CLR	n_wantedperiod(A6)

TonePortaSetPer
	MOVE	n_period(A6),D2
	MOVE.B	n_glissfunk(A6),D0
	AND.B	#$0F,D0
	BEQ	GlissSkip
	MOVEQ	#0,D0
	MOVE.B	n_finetune(A6),D0
	MULU	#37*2,D0
	LEA	PeriodTable(PC),A0
	ADD.L	D0,A0
	MOVEQ	#0,D0
GlissLoop
	CMP	(A0,D0.W),D2
	BHS	GlissFound
	ADDQ	#2,D0
	CMP	#37*2,D0
	BLO	GlissLoop
	MOVEQ	#35*2,D0
GlissFound
	MOVE	(A0,D0.W),D2
GlissSkip
	MOVE	D2,6(A5) ; Set period
	RTS

Vibrato	MOVE.B	n_cmdlo(A6),D0
	BEQ	Vibrato2
	MOVE.B	n_vibratocmd(A6),D2
	AND.B	#$0F,D0
	BEQ	vibskip
	AND.B	#$F0,D2
	OR.B	D0,D2
vibskip	MOVE.B	n_cmdlo(A6),D0
	AND.B	#$F0,D0
	BEQ	vibskip2
	AND.B	#$0F,D2
	OR.B	D0,D2
vibskip2
	MOVE.B	D2,n_vibratocmd(A6)
Vibrato2
	MOVE.L	A4,-(SP)
	MOVE.B	n_vibratopos(A6),D0
	LEA	VibratoTable(PC),A4
	LSR	#2,D0
	AND	#$001F,D0
	MOVEQ	#0,D2
	MOVE.B	n_wavecontrol(A6),D2
	AND.B	#$03,D2
	BEQ	vib_sine
	LSL.B	#3,D0
	CMP.B	#1,D2
	BEQ	vib_rampdown
	MOVE.B	#255,D2
	BRA	vib_set
vib_rampdown
	TST.B	n_vibratopos(A6)
	BPL	vib_rampdown2
	MOVE.B	#255,D2
	SUB.B	D0,D2
	BRA	vib_set
vib_rampdown2
	MOVE.B	D0,D2
	BRA	vib_set
vib_sine
	MOVE.B	0(A4,D0.W),D2
vib_set
	MOVE.B	n_vibratocmd(A6),D0
	AND	#15,D0
	MULU	D0,D2
	LSR	#7,D2
	MOVE	n_period(A6),D0
	TST.B	n_vibratopos(A6)
	BMI	VibratoNeg
	ADD	D2,D0
	BRA	Vibrato3
VibratoNeg
	SUB	D2,D0
Vibrato3
	MOVE	D0,6(A5)
	MOVE.B	n_vibratocmd(A6),D0
	LSR	#2,D0
	AND	#$003C,D0
	ADD.B	D0,n_vibratopos(A6)
	MOVE.L	(SP)+,A4
	RTS

TonePlusVolSlide
	BSR	TonePortNoChange
	BSR	VolumeSlide
	RTS

VibratoPlusVolSlide
	BSR	Vibrato2
	BSR	VolumeSlide
	RTS

Tremolo	MOVE.L	A4,-(SP)
	MOVE.B	n_cmdlo(A6),D0
	BEQ	Tremolo2
	MOVE.B	n_tremolocmd(A6),D2
	AND.B	#$0F,D0
	BEQ	treskip
	AND.B	#$F0,D2
	OR.B	D0,D2
treskip	MOVE.B	n_cmdlo(A6),D0
	AND.B	#$F0,D0
	BEQ	treskip2
	AND.B	#$0F,D2
	OR.B	D0,D2
treskip2
	MOVE.B	D2,n_tremolocmd(A6)
Tremolo2
	MOVE.B	n_tremolopos(A6),D0
	LEA	VibratoTable(PC),A4
	LSR	#2,D0
	AND	#$001F,D0
	MOVEQ	#0,D2
	MOVE.B	n_wavecontrol(A6),D2
	LSR.B	#4,D2
	AND.B	#$03,D2
	BEQ	tre_sine
	LSL.B	#3,D0
	CMP.B	#1,D2
	BEQ	tre_rampdown
	MOVE.B	#255,D2
	BRA	tre_set
tre_rampdown
	TST.B	n_vibratopos(A6)
	BPL	tre_rampdown2
	MOVE.B	#255,D2
	SUB.B	D0,D2
	BRA	tre_set
tre_rampdown2
	MOVE.B	D0,D2
	BRA	tre_set
tre_sine
	MOVE.B	0(A4,D0.W),D2
tre_set
	MOVE.B	n_tremolocmd(A6),D0
	AND	#15,D0
	MULU	D0,D2
	LSR	#6,D2
	MOVEQ	#0,D0
	MOVE.B	n_volume(A6),D0
	TST.B	n_tremolopos(A6)
	BMI	TremoloNeg
	ADD	D2,D0
	BRA	Tremolo3
TremoloNeg
	SUB	D2,D0
Tremolo3
	BPL	TremoloSkip
	CLR	D0
TremoloSkip
	CMP	#$40,D0
	BLS	TremoloOk
	MOVE	#$40,D0
TremoloOk
	MOVE	D0,8(A5)
	MOVE.B	n_tremolocmd(A6),D0
	LSR	#2,D0
	AND	#$003C,D0
	ADD.B	D0,n_tremolopos(A6)
	MOVE.L	(SP)+,A4
	ADDQ.L	#4,SP
	RTS

SampleOffset
	MOVEQ	#0,D0
	MOVE.B	n_cmdlo(A6),D0
	BEQ	sononew
	MOVE.B	D0,n_sampleoffset(A6)
sononew	MOVE.B	n_sampleoffset(A6),D0
	LSL	#7,D0
	CMP	n_length(A6),D0
	BGE	sofskip
	SUB	D0,n_length(A6)
	LSL	#1,D0
	ADD.L	D0,n_start(A6)
	RTS
sofskip MOVE	#$0001,n_length(A6)
	RTS

VolumeSlide
	MOVEQ	#0,D0
	MOVE.B	n_cmdlo(A6),D0
	LSR.B	#4,D0
	TST.B	D0
	BEQ	VolSlideDown
VolSlideUp
	ADD.B	D0,n_volume(A6)
	CMP.B	#$40,n_volume(A6)
	BMI	vsuskip
	MOVE.B	#$40,n_volume(A6)
vsuskip	MOVE.B	n_volume(A6),D0
;	MOVE	D0,8(A5)
	RTS

VolSlideDown
	MOVEQ	#0,D0
	MOVE.B	n_cmdlo(A6),D0
	AND.B	#$0F,D0
VolSlideDown2
	SUB.B	D0,n_volume(A6)
	BPL	vsdskip
	CLR.B	n_volume(A6)
vsdskip	MOVE.B	n_volume(A6),D0
;	MOVE	D0,8(A5)
	RTS

PositionJump
	MOVEQ	#0,D0
	MOVE.B	n_cmdlo(A6),D0
	SUBQ.B	#1,D0
	MOVE.L	D0,SongPosition
pj2	CLR.B	PBreakPosition
	ST 	PosJumpAssert
	RTS

VolumeChange
	MOVEQ	#0,D0
	MOVE.B	n_cmdlo(A6),D0
	CMP.B	#$40,D0
	BLS	VolumeOk
	MOVEQ	#$40,D0
VolumeOk
	MOVE.B	D0,n_volume(A6)
;	MOVE	D0,8(A5)
	RTS

PatternBreak
	MOVEQ	#0,D0
	MOVE.B	n_cmdlo(A6),D0
	MOVE.L	D0,D2
	LSR.B	#4,D0
	MULU	#10,D0
	AND.B	#$0F,D2
	ADD.B	D2,D0
	CMP.B	#63,D0
	BHI	pj2
	MOVE.B	D0,PBreakPosition
	ST	PosJumpAssert
	RTS

SetSpeed
	MOVE.B	3(A6),D0
	AND	#$FF,D0
	BEQ.S	SpeedNull
	TST.B	IntMode
	BEQ.S	normspd
	CMP	#32,D0
	BLO.S	normspd
	MOVE	D0,RealTempo
	MOVEM.L	D0-D7/A0-A6,-(SP)
	MOVE	SamScrEnable,-(SP)
	ST	SamScrEnable
	ST	UpdateTempo
	JSR	SetTempo
	MOVE	(SP)+,SamScrEnable
	MOVEM.L	(SP)+,D0-D7/A0-A6
	RTS
normspd	CLR.L	Counter
	MOVE	D0,CurrSpeed+2
	RTS
SpeedNull
	CLR.L	RunMode
	JSR	SetNormalPtrCol
	RTS


CheckMoreEffects
	MOVE.B	2(A6),D0
	AND.B	#$0F,D0
	CMP.B	#$9,D0
	BEQ	SampleOffset
	CMP.B	#$B,D0
	BEQ	PositionJump
	CMP.B	#$D,D0
	BEQ	PatternBreak
	CMP.B	#$E,D0
	BEQ	E_Commands
	CMP.B	#$F,D0
	BEQ	SetSpeed
	TST	(A4)
	BEQ	Return2
	CMP.B	#$C,D0
	BEQ	VolumeChange
	BRA	PerNop

E_Commands
	MOVE.B	n_cmdlo(A6),D0
	AND.B	#$F0,D0
	LSR.B	#4,D0
	BEQ	FilterOnOff
	CMP.B	#1,D0
	BEQ	FinePortaUp
	CMP.B	#2,D0
	BEQ	FinePortaDown
	CMP.B	#3,D0
	BEQ	SetGlissControl
	CMP.B	#4,D0
	BEQ	SetVibratoControl
	CMP.B	#5,D0
	BEQ	SetFineTune
	CMP.B	#6,D0
	BEQ	JumpLoop
	CMP.B	#7,D0
	BEQ	SetTremoloControl
	CMP.B	#8,D0
	BEQ	KarplusStrong
	CMP.B	#$E,D0
	BEQ	PatternDelay
	TST	(A4)
	BEQ	Return2
	CMP.B	#9,D0
	BEQ	RetrigNote
	CMP.B	#$A,D0
	BEQ	VolumeFineUp
	CMP.B	#$B,D0
	BEQ	VolumeFineDown
	CMP.B	#$C,D0
	BEQ	NoteCut
	CMP.B	#$D,D0
	BEQ	NoteDelay
	CMP.B	#$F,D0
	BEQ	FunkIt
	RTS

FilterOnOff
	MOVE.B	n_cmdlo(A6),D0
	AND.B	#1,D0
	ASL.B	#1,D0
	AND.B	#$FD,$BFE001
	OR.B	D0,$BFE001
	RTS

SetGlissControl
	MOVE.B	n_cmdlo(A6),D0
	AND.B	#$0F,D0
	AND.B	#$F0,n_glissfunk(A6)
	OR.B	D0,n_glissfunk(A6)
	RTS

SetVibratoControl
	MOVE.B	n_cmdlo(A6),D0
	AND.B	#$0F,D0
	AND.B	#$F0,n_wavecontrol(A6)
	OR.B	D0,n_wavecontrol(A6)
	RTS

SetFineTune
	MOVE.B	n_cmdlo(A6),D0
	AND.B	#$0F,D0
	MOVE.B	D0,n_finetune(A6)
	RTS

JumpLoop
	TST.L	Counter
	BNE	Return2
	MOVE.B	n_cmdlo(A6),D0
	AND.B	#$0F,D0
	BEQ	SetLoop
	TST.B	n_loopcount(A6)
	BEQ	jumpcnt
	SUB.B	#1,n_loopcount(A6)
	BEQ	Return2
jmploop	MOVE.B	n_pattpos(A6),PBreakPosition
	ST	PBreakFlag
	RTS

jumpcnt	MOVE.B	D0,n_loopcount(A6)
	BRA	jmploop

SetLoop	MOVE.L	PatternPosition,D0
	LSR.L	#4,D0
	AND.B	#63,D0
	MOVE.B	D0,n_pattpos(A6)
	RTS

SetTremoloControl
	MOVE.B	n_cmdlo(A6),D0
	AND.B	#$0F,D0
	LSL.B	#4,D0
	AND.B	#$0F,n_wavecontrol(A6)
	OR.B	D0,n_wavecontrol(A6)
	RTS

KarplusStrong
	MOVEM.L	D1-D2/A0-A1,-(SP)
	MOVE.L	n_loopstart(A6),A0
	MOVE.L	A0,A1
	MOVE	n_replen(A6),D0
	ADD	D0,D0
	SUBQ	#2,D0
karplop	MOVE.B	(A0),D1
	EXT	D1
	MOVE.B	1(A0),D2
	EXT	D2
	ADD	D1,D2
	ASR	#1,D2
	MOVE.B	D2,(A0)+
	DBF	D0,karplop
	MOVE.B	(A0),D1
	EXT	D1
	MOVE.B	(A1),D2
	EXT	D2
	ADD	D1,D2
	ASR	#1,D2
	MOVE.B	D2,(A0)
	MOVEM.L	(SP)+,D1-D2/A0-A1
	RTS

RetrigNote
	MOVE.L	D1,-(SP)
	MOVEQ	#0,D0
	MOVE.B	n_cmdlo(A6),D0
	AND.B	#$0F,D0
	BEQ	rtnend
	MOVE.L	Counter,D1
	BNE	rtnskp
	MOVE	n_note(A6),D1
	AND	#$0FFF,D1
	BNE	rtnend
	MOVE.L	Counter,D1
rtnskp	DIVU	D0,D1
	SWAP	D1
	TST	D1
	BNE	rtnend
DoRetrg	MOVE	n_dmabit(A6),$DFF096	; Channel DMA off
	MOVE.L	n_start(A6),(A5)	; Set sampledata pointer
	MOVE	n_length(A6),4(A5)	; Set length
	MOVE	n_period(A6),6(A5)
	MOVEQ	#0,D0
	MOVE.B	n_volume(A6),D0
;	MOVE	D0,8(A5)
	JSR	DMAWaitLoop
	MOVE	n_dmabit(A6),D0
	BSET	#15,D0
	MOVE	D0,$DFF096
	JSR	DMAWaitLoop
	MOVE.L	n_loopstart(A6),(A5)
	MOVE.L	n_replen(A6),4(A5)
rtnend	MOVE.L	(SP)+,D1
	RTS

VolumeFineUp
	TST.L	Counter
	BNE	Return2
	MOVEQ	#0,D0
	MOVE.B	n_cmdlo(A6),D0
	AND.B	#$F,D0
	BRA	VolSlideUp

VolumeFineDown
	TST.L	Counter
	BNE	Return2
	MOVEQ	#0,D0
	MOVE.B	n_cmdlo(A6),D0
	AND.B	#$0F,D0
	BRA	VolSlideDown2

NoteCut	MOVEQ	#0,D0
	MOVE.B	n_cmdlo(A6),D0
	AND.B	#$0F,D0
	CMP.L	Counter,D0
	BNE	Return2
	CLR.B	n_volume(A6)
;	MOVE	#0,8(A5)
	RTS

NoteDelay
	MOVEQ	#0,D0
	MOVE.B	n_cmdlo(A6),D0
	AND.B	#$0F,D0
	CMP.L	Counter,D0
	BNE	Return2
	MOVE	(A6),D0
	AND	#$0FFF,D0
	BEQ	Return2
	MOVE.L	D1,-(SP)
	BRA	DoRetrg

PatternDelay
	TST.L	Counter
	BNE	Return2
	MOVEQ	#0,D0
	MOVE.B	n_cmdlo(A6),D0
	AND.B	#$0F,D0
	TST.B	PattDelayTime2
	BNE	Return2
	ADDQ.B	#1,D0
	MOVE.B	D0,PattDelayTime
	RTS

FunkIt	TST.L	Counter
	BNE	Return2
	MOVE.B	n_cmdlo(A6),D0
	AND.B	#$0F,D0
	LSL.B	#4,D0
	AND.B	#$0F,n_glissfunk(A6)
	OR.B	D0,n_glissfunk(A6)
	TST.B	D0
	BEQ	Return2
UpdateFunk
	MOVEM.L	A0/D1,-(SP)
	MOVEQ	#0,D0
	MOVE.B	n_glissfunk(A6),D0
	LSR.B	#4,D0
	BEQ	funkend
	LEA	FunkTable(PC),A0
	MOVE.B	(A0,D0.W),D0
	ADD.B	D0,n_funkoffset(A6)
	BTST	#7,n_funkoffset(A6)
	BEQ	funkend
	CLR.B	n_funkoffset(A6)
	MOVE.L	n_loopstart(A6),D0
	MOVEQ	#0,D1
	MOVE	n_replen(A6),D1
	ADD.L	D1,D0
	ADD.L	D1,D0
	MOVE.L	n_wavestart(A6),A0
	ADDQ.L	#1,A0
	CMP.L	D0,A0
	BLO.S	funkok
	MOVE.L	n_loopstart(A6),A0
funkok	MOVE.L	A0,n_wavestart(A6)
	MOVEQ	#-1,D0
	SUB.B	(A0),D0
	MOVE.B	D0,(A0)
funkend	MOVEM.L	(SP)+,A0/D1
	RTS


;----------------------------------------------
; copy image data (assuming source modulo=0)
; A0...source
; A1...destin
; D0...Ysize in lines
; D1...Source Xsize in bytes
CopyImageToScreen
		MOVEM.L	D2-4,-(SP)
		LEA	BitPlaneData+TopMenusPos,A0
		LEA	TopMenusBuffer,A1
		MOVE	#ScreenWidth,D3
		MOVE	D3,D2
		MULU	#ScreenHeight,D2
		SUB	D1,D3
		MOVE	D0,D4
		MULU	D1,D4
		MOVE	D0,D7
.Yloop			MOVE	D1,D6
.Xloop				MOVE.B	(A0,D4.w),(A1,D2.w)
				MOVE.B	(A0)+,(A1)+
			SUBQ	#1,D6
			BNE.S	.Xloop
		LEA	(A1,D3.w),A1
		SUBQ	#1,D7
		BNE.S	.Yloop
		MOVEM.L	(SP)+,D2-4
		RTS


;----------------------------------------------
; copy image data (assuming destin modulo = 0)
; A0...source
; A1...destin
; D0...Ysize in lines
; D1...Source Xsize in bytes
CopyScreenToBuf
		MOVEM.L	D2-4,-(SP)
		LEA	BitPlaneData+TopMenusPos,A0
		LEA	TopMenusBuffer,A1
		MOVE	#ScreenWidth,D3
		MOVE	D3,D2
		MULU	#ScreenHeight,D2
		SUB	D1,D3
		MOVE	D0,D4
		MULU	D1,D4
		MOVE	D0,D7
.Yloop			MOVE	D1,D6
.Xloop				MOVE.B	(A0,D2.w),(A1,D4.w)
				MOVE.B	(A0)+,(A1)+
			SUBQ	#1,D6
			BNE.S	.Xloop
		LEA	(A0,D3.w),A0
		SUBQ	#1,D7
		BNE.S	.Yloop
		MOVEM.L	(SP)+,D2-4
		RTS


;************************* End of Code ******************************

FunkTable
		dc.b 0,5,6,7,8,10,11,13,16,19,22,26,32,43,64,128

VibratoTable
		dc.b	  0, 24, 49, 74, 97,120,141,161
		dc.b	180,197,212,224,235,244,250,253
		dc.b	255,253,250,244,235,224,212,197
		dc.b	180,161,141,120, 97, 74, 49, 24

AllRightText	dc.b	'All right',0
PLSTFullText	dc.b	'Plst is full!',0
AreYouSureText	dc.b	'Are you sure?',0
NoDiskInDriveText
		dc.b	'No disk in df0!',0
WriteProtectedText
		dc.b	'Write protected',0
OprAbortedText	dc.b	'Print aborted!',0
EnterDataText	dc.b	'Enter data',0
AddingPathText	dc.b	'Adding path...',0
DiskErrorText	dc.b	'Disk error !!',0
LoadingText	dc.b	'Loading...',0
LoadingSongText	dc.b	'Loading song',0
LoadingModuleText
		dc.b	'Loading module',0
LoadingSampleText
		dc.b	'Loading sample',0
SavingText	dc.b	'Saving...',0
;SaveSongText	dc.b	'Save song ?',0
SavingSongText	dc.b	'Saving song',0
;SaveModuleText	dc.b	'Save module ?',0
SavingModuleText
		dc.b	'Saving module',0
;SaveSampleText	dc.b	'Save sample ?',0
SavingSampleText
		dc.b	'Saving sample',0
LoadingPLSTText	dc.b	'Loading plst',0
SavingPLSTText	dc.b	'Saving plst',0
DeletingSongText
		dc.b	'Deleting song',0
DeletingModuleText
		dc.b	'Deleting module',0
DeletingSampleText
		dc.b	'Deleting sample',0
RenamingFileText
		dc.b	'Renaming file',0
DecrunchingText	dc.b	'Decrunching...',0
CrunchingText	dc.b	'Crunching...',0
SelectEntryText	dc.b	'Select entry',0
SelectSongText	dc.b	'Select song',0
SelectModuleText
		dc.b	'Select module',0
SelectSampleText
		dc.b	'Select sample',0
SelectFileText	dc.b	'Select file',0
ReadingDirText	dc.b	'Reading dir...',0
PosSetText	dc.b	'Position set',0
PrintingSongText
		dc.b	'Printing song',0
PrintingPLSTText
		dc.b	'Printing plst',0

SaveSongText	dc.b	'Save song ?',0
DeleteSongText	dc.b	'Delete song ?',0
SaveModuleText	dc.b	'Save module ?',0
DeleteModuleText dc.b	'Delete module ?',0
SaveSampleText	dc.b	'Save sample ?',0
DeleteSampleText dc.b	'Delete sample ?',0
PrintPLSTText	dc.b	'Print plst ?',0
PrintSongText	dc.b	'Print song ?',0
QuitPTText	dc.b	'Really quit ?',0
UpsampleText	dc.b	'Upsample ?',0
DownSampleText	dc.b	'Downsample ?',0
PleaseSelectText dc.b	'Please select',0
ClearSplitText	dc.b	'Clear split ?',0
ResetAllText	dc.b	'Reset config ?',0
DeletePresetText dc.b	'Delete preset ?',0
LoadPLSTText	dc.b	'Load presetlist?',0
SavePLSTText	dc.b	'Save presetlist?',0
KillSampleText	dc.b	'Kill sample ?',0
AbortLoadText	dc.b	'Abort loading ?',0
LoadConfigText	dc.b	'Load config ?',0
SaveConfigText	dc.b	'Save config ?',0

DiskFormatText	dc.b	'Disk format'
InProgressText	dc.b	'in progress'
FormattingCylText
		dc.b	'Formatting cyl ',0
VerifyingText	dc.b	'Verifying  cyl ',0
InitDiskText	dc.b	'Initializing',0
PlsEntNamText	dc.b	'Please enter name'
OfVolumeText	dc.b	'of volume:  ST-__',0,0
	cnop 0,2
DiskNumText1	dc.b	'0'
DiskNumText2	dc.b	'0  '
PEdDefaultPath	dc.b	'SYS:',0
		dcb.b	47,0

PEdDefaultVol	dc.b	'st-'
SndDiskNum0	dc.b	'0'
SndDiskNum1	dc.b	'1:'

PresetName	dc.b	'      '
PsetNameText	dc.b	'                '
		dc.b	' '
PsetVolText	dc.b	'  '
		dc.b	' '
PsetLenText	dc.b	'    '
		dc.b	' '
PsetRepeatText	dc.b	'    '
		dc.b	' '
PsetReplenText	dc.b	'    '

InsertPsetText	dc.b	'ST-01:                  0 0000 0000 0002'
PsetPLSTtext	dc.b	'No.    Samplename               '
		dc.b	'Length  Repeat  RepLen',$A,$A
PsetPrtNumText	dc.b	'    :  '
PsetPrtNameText	dc.b	'                             '
PsetPrtLenText	dc.b	'        '
PsetPrtRepeatText	dc.b	'        '
PsetPrtRepLenText	dc.b	10
	dc.b	0
SongDumpText
	dc.b	9
	dc.b	'Protracker Song-Dump -- Made with '
	dc.b	'Protracker V1.2   ',$D,$A,$A
	dc.b	9
	dc.b	'Songname:  '
CRLF_Text	dc.b	13,10
FF_Text		dc.b	12,0

	cnop 0,2
PatternNumText	dc.b	9,9,9,'Pattern: '
PattNumText1	dc.b	'0'
PattNumText2	dc.b	'0',$D,$A,$D,$A

PtotText	dc.b	9
PattXText1	dc.b	"0"
PattXText2	dc.b	"0 : "
PpText		dc.b	"                      "
Prafs		dc.b	"  0000  0000  0000    ",$D,$A
PnText2		dc.b	"        "
	cnop 0,2
		dc.b	0
PattPosText	dc.b	'00  :                                                       '
PnText		dc.b	'    ',0

	cnop 0,2
FmtSongDirName		dc.b	'SYS:songs',0
FmtModuleDirName	dc.b	'SYS:modules',0

	cnop 0,2
STText1		dc.b	'ST'
STText1Num	dc.b	'-'
STText1Number	dc.b	0,0,':'
STText2		dc.b	'ST'
STText2Num	dc.b	'-'
STText2Number	dc.b	0,0,':'
STText3		dc.b	'ST'
STText3Num	dc.b	'-'
STText3Number	dc.b	0,0,':'
STText4		dc.b	'ST'
STText4Num	dc.b	'-'
STText4Number	dc.b	0,0,':'

EmptyLineText	dc.b	'                       ',0

FastHexTable	dc.b	'000102030405060708090A0B0C0D0E0F'
		dc.b	'101112131415161718191A1B1C1D1E1F'
		dc.b	'202122232425262728292A2B2C2D2E2F'
		dc.b	'303132333435363738393A3B3C3D3E3F'
		dc.b	'404142434445464748494A4B4C4D4E4F'
		dc.b	'505152535455565758595A5B5C5D5E5F'
		dc.b	'606162636465666768696A6B6C6D6E6F'
		dc.b	'707172737475767778797A7B7C7D7E7F'
		dc.b	'808182838485868788898A8B8C8D8E8F'
		dc.b	'909192939495969798999A9B9C9D9E9F'
		dc.b	'A0A1A2A3A4A5A6A7A8A9AAABACADAEAF'
		dc.b	'B0B1B2B3B4B5B6B7B8B9BABBBCBDBEBF'
		dc.b	'C0C1C2C3C4C5C6C7C8C9CACBCCCDCECF'
		dc.b	'D0D1D2D3D4D5D6D7D8D9DADBDCDDDEDF'
		dc.b	'E0E1E2E3E4E5E6E7E8E9EAEBECEdEEEF'
		dc.b	'F0F1F2F3F4F5F6F7F8F9FAFBFCFdFEFF'

TrackdiskName	dc.b	'trackdisk.device',0
InputDevName	dc.b	'input.device',0
DOSBase		dc.l	0
IntuitionBase	dc.l	0
GfxBase		dc.l	0

RawKeyHexTable
	dc.b	10,1,2,3,4,5,6,7
	dc.b	8,9,32,53,51,34,18,35
RawKeyScaleTable
	dc.b	49,33,50,34,51,52,36,53,37,54,38,55,56,40,57
	dc.b	41,58,16,2,17,3,18,19,5,20,6,21,7,22,23,9,24,10
	dc.b	25,26,12,27,70,70,0

KbdTransTable1
	dc.b	 0, 1, 2, 3, 4, 5, 6, 7, 8, 9,10,11,12,13,14,15,16
	dc.b	12,13,14,15,16,17,18,19,20,21,22,23
	dc.b	24,25,26,27,28,29,30,31,36,36
KbdTransTable2
	dc.b	12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28
	dc.b	24,25,26,27,28,29,30,31,32,33,34,35
	dc.b	36,36,36,36,36,36,36,36,36,36
NoteNames1
	dc.b	'C-1 C#1 D-1 D#1 E-1 F-1 F#1 G-1 G#1 A-1 A#1 B-1 '
	dc.b	'C-2 C#2 D-2 D#2 E-2 F-2 F#2 G-2 G#2 A-2 A#2 B-2 '
	dc.b	'C-3 C#3 D-3 D#3 E-3 F-3 F#3 G-3 G#3 A-3 A#3 B-3 '
SpcNoteText
	dc.b	'--- '
NoteNames2
	dc.b	'C-1 Dб1 D-1 Eб1 E-1 F-1 Gб1 G-1 Aб1 A-1 Bб1 B-1 '
	dc.b	'C-2 Dб2 D-2 Eб2 E-2 F-2 Gб2 G-2 Aб2 A-2 Bб2 B-2 '
	dc.b	'C-3 Dб3 D-3 Eб3 E-3 F-3 Gб3 G-3 Aб3 A-3 Bб3 B-3 '
	dc.b	'--- '

PeriodTable
; Tuning 0
	dc.w	856,808,762,720,678,640,604,570,538,508,480,453
	dc.w	428,404,381,360,339,320,302,285,269,254,240,226
	dc.w	214,202,190,180,170,160,151,143,135,127,120,113,0
; Tuning 1
	dc.w	850,802,757,715,674,637,601,567,535,505,477,450
	dc.w	425,401,379,357,337,318,300,284,268,253,239,225
	dc.w	213,201,189,179,169,159,150,142,134,126,119,113,0
; Tuning 2
	dc.w	844,796,752,709,670,632,597,563,532,502,474,447
	dc.w	422,398,376,355,335,316,298,282,266,251,237,224
	dc.w	211,199,188,177,167,158,149,141,133,125,118,112,0
; Tuning 3
	dc.w	838,791,746,704,665,628,592,559,528,498,470,444
	dc.w	419,395,373,352,332,314,296,280,264,249,235,222
	dc.w	209,198,187,176,166,157,148,140,132,125,118,111,0
; Tuning 4
	dc.w	832,785,741,699,660,623,588,555,524,495,467,441
	dc.w	416,392,370,350,330,312,294,278,262,247,233,220
	dc.w	208,196,185,175,165,156,147,139,131,124,117,110,0
; Tuning 5
	dc.w	826,779,736,694,655,619,584,551,520,491,463,437
	dc.w	413,390,368,347,328,309,292,276,260,245,232,219
	dc.w	206,195,184,174,164,155,146,138,130,123,116,109,0
; Tuning 6
	dc.w	820,774,730,689,651,614,580,547,516,487,460,434
	dc.w	410,387,365,345,325,307,290,274,258,244,230,217
	dc.w	205,193,183,172,163,154,145,137,129,122,115,109,0
; Tuning 7
	dc.w	814,768,725,684,646,610,575,543,513,484,457,431
	dc.w	407,384,363,342,323,305,288,272,256,242,228,216
	dc.w	204,192,181,171,161,152,144,136,128,121,114,108,0
; Tuning -8
	dc.w	907,856,808,762,720,678,640,604,570,538,508,480
	dc.w	453,428,404,381,360,339,320,302,285,269,254,240
	dc.w	226,214,202,190,180,170,160,151,143,135,127,120,0
; Tuning -7
	dc.w	900,850,802,757,715,675,636,601,567,535,505,477
	dc.w	450,425,401,379,357,337,318,300,284,268,253,238
	dc.w	225,212,200,189,179,169,159,150,142,134,126,119,0
; Tuning -6
	dc.w	894,844,796,752,709,670,632,597,563,532,502,474
	dc.w	447,422,398,376,355,335,316,298,282,266,251,237
	dc.w	223,211,199,188,177,167,158,149,141,133,125,118,0
; Tuning -5
	dc.w	887,838,791,746,704,665,628,592,559,528,498,470
	dc.w	444,419,395,373,352,332,314,296,280,264,249,235
	dc.w	222,209,198,187,176,166,157,148,140,132,125,118,0
; Tuning -4
	dc.w	881,832,785,741,699,660,623,588,555,524,494,467
	dc.w	441,416,392,370,350,330,312,294,278,262,247,233
	dc.w	220,208,196,185,175,165,156,147,139,131,123,117,0
; Tuning -3
	dc.w	875,826,779,736,694,655,619,584,551,520,491,463
	dc.w	437,413,390,368,347,328,309,292,276,260,245,232
	dc.w	219,206,195,184,174,164,155,146,138,130,123,116,0
; Tuning -2
	dc.w	868,820,774,730,689,651,614,580,547,516,487,460
	dc.w	434,410,387,365,345,325,307,290,274,258,244,230
	dc.w	217,205,193,183,172,163,154,145,137,129,122,115,0
; Tuning -1
	dc.w	862,814,768,725,684,646,610,575,543,513,484,457
	dc.w	431,407,384,363,342,323,305,288,272,256,242,228
	dc.w	216,203,192,181,171,161,152,144,136,128,121,114,0

CursorPosTable
	dc.b	3,6,7,8,9,10,12
	dc.b	15,16,17,18,19,21
	dc.b	24,25,26,27,28,30
	dc.b	33,34,35,36,37
UnshiftedKeymap
	dc.b	'`1234567890-=\*0'
	dc.b	'qwertyuiop[]*123'
	dc.b	'asdfghjkl;',39,'#',0,'456'
	dc.b	'<zxcvbnm,./',0,'.','789 '
ShiftedKeymap
	dc.b	'~!@#$%^&*()_+|*0'
	dc.b	'qwertyuiop{}*123'
	dc.b	'asdfghjkl:',34,'^',0,'456'
	dc.b	'>zxcvbnm<>?',0,'.','789 '

SongNumOfPatt	dc.w	1
NoteNamesPtr	dc.l	0
SpritePtrsPtr	dc.l	0
LineCurPosPtr	dc.l	0
NoSpritePtr	dc.l	0
CursorPosPtr	dc.l	0
Ch1SpritePtr	dc.l	0
Ch2SpritePtr	dc.l	0
Ch3SpritePtr	dc.l	0
Ch4SpritePtr	dc.l	0
PPattPos	dc.l	0
SaveEditMode	dc.l	0
EditMode	dc.l	0
RunMode		dc.l	0
CurrCmds	dc.l	0
TextBplPtr	dc.l	0
TextOffset	dc.w	0
TextLength	dc.w	0
TextLenTemp	dc.l	0
ShowTextPtr	dc.l	0
PatternNumber	dc.l	0
CurrPos		dc.l	0
CurrSpeed	dc.l	0
KeyTransTabPtr	dc.l	0
CmdOffset	dc.w	0
RawKeyCode	dc.b	0
PattRfsh	dc.b	0
MountFlag	dc.w	0
GetLineFlag	dc.w	0
LoadInProgress	dc.w	0
KbIntSave	dc.l	0
KbIntSavePtr	dc.l	0
CurrentPlayNote	dc.w	214
LineCurX	dc.w	0
LineCurY	dc.w	0
TextEndPtr	dc.l	0
ScrPattPos	dc.w	0
PattCurPos	dc.w	0
GadgRepeat	dc.w	0
WordNumber	dc.w	0
HighPattNum	dc.w	0
InsNum		dc.w	0
LastInsNum	dc.w	1
PlayInsNum	dc.w	1
HiLowInstr	dc.w	0
PEDPos		dc.w	0
PLSTpos		dc.w	0
MaxPLSTOffset	dc.l	0
PresetMarkTotal	dc.w	0
PLSTOffset	dcb.b	14*4,0
CurrentPreset	dc.w	1
UpOrDown	dc.w	0
Joy0Low		dc.w	0
Joy0High	dc.w	0
MouseX	dc.w	0
MouseY	dc.w	0
MouseX2	dc.w	0
MouseY2	dc.w	0
MouseX3	dc.w	0
MouseY3	dc.w	0
DecompMemPtr	dc.l	0
DecompMemSize	dc.l	0

SampleInfo	dc.w	0
si_volume	dc.w	0
si_long		dc.l	0
si_pointer	dc.l	0,0,0,0,0
SampleInfo2	dc.w	0
si_volume2	dc.w	0
si_long2	dc.l	0
si_pointer2	dc.l	0,0,0,0,0

LongFFFF	dc.l	0
PosJumpAssert	dc.b	0
PBreakPosition	dc.b	0
PBreakFlag	dc.b	0
LEDStatus	dc.b	0
PattDelayTime	dc.b	0
PattDelayTime2	dc.b	0
PattRfshNum	dc.l	0
DidQuantize	dc.w	0
MessagePtr	dc.l	0
FileNamePtr	dc.l	0
DiskDataPtr	dc.l	0
FileHandle	dc.l	0
DiskDataLength	dc.l	0
LowMask		dc.b	$FF
PatternPosition	dc.l	0
SongPosition	dc.l	0
Counter		dc.l	0
PatternPtr	dc.l	0
SongDataPtr	dc.l	0
SampleStarts	dcb.l	31,0
SamplePtrs	EQU	SampleStarts-4
SampleLengths	dcb.l	32,0
DMACONtemp	dc.w	0
StackSave	dc.l	0
InputDevMouse	dc.l	0,0,0
AnalyzerHeights	dcb.w	23,0
AnalyzerOpplegg	dcb.w	23,0
Action		dc.w	0
PathPtr		dc.l	0
FileLock	dc.l	0
CurrScreen	dc.w	0
SaveCurrScreen	dc.w	0
PointerCol1Save	dc.w	0
PointerCol2Save	dc.w	0
PointerCol3Save	dc.w	0
GetDecTemp	dc.b	0
UpdateTempo	dc.b	0
MoreInstrFlag	dc.w	0
SampleSortList	dcb.l	32,0
PLSTmem		dc.l	0
PresetTotal	dc.w	0
SaveScope	dc.b	0
		dc.b	0 ;free 0
DisableAnalyzer	dc.b	0
SaveDA		dc.b	0
AutoReqRunning	dc.b	0
NoSampleInfo	dc.b	0
FormatDataPtr	dc.l	0
CylinderNumber	dc.w	0
TrackdiskPort	dc.l	0,0,0,0
ProcessPtr	dc.l	0,0,0,0
DateStamp	dc.l	0,0,0,0
EnterTextFlag	dc.w	0
PresetLength	dc.w	0
PresetFineTune	dc.w	0
PresetRepeat	dc.w	0
PresetReplen	dc.w	0
PED_Action	dc.w	0
PsetNumTemp	dc.w	0
PsetPtrTemp	dc.l	0
FreeDiskSpace	dc.l	0
SplitAddress	dc.l	0
LaHeTx		dc.l	$12345678
PLSTAllocSize	dc.l	0
MaxPLSTEntries2	dc.w	0

;---- Setup Data ----

DefaultSetupData
			dc.b	'PT1.2 Configuration File',$A,0
DefaultSongsPath
	dc.b	'ST-00:songs'
	dcb.b	21,0
	dc.b	'ST-00:modules'
	dcb.b	19,0
	dc.b	'DF0:'
	dcb.b	28,0
	dc.b	'PRT:'
	dcb.b	28,0
DefCol	dc.w	$000,$efe,$999,$445,$4c7,$b03,$000,$299
	dc.b	1   ; Song Pack Mode
	dc.b	0   ; Module Pack Mode
	dc.b	0   ; Split  0=off, 1=on
	dc.b	0   ; Filter
	dc.b	0   ; TransDel
	dc.b	1   ; ShowDec
	dc.b	1   ; AutoDir
	dc.b	1   ; AutoExit
	dc.b	1   ; ModOnly
	dc.b	0   ; MIDI
	dc.b	1,$18,$18,0		; SplitData
	dc.b	2,$1A,$18,0
	dc.b	3,$1C,$18,0
	dc.b	4,$1D,$18,0
	dc.w	20,2			; KeyRepDelay/Speed
	dc.b	0			; Accidental
	dc.b	0			; not in use
	dc.b	'newshell',0		; ExtCmd 0
	dcb.b	23,0
	dc.b	'DevPak',0		; ExtCmd 1
	dcb.b	25,0
	dc.b	'info',0		; ExtCmd 2
	dcb.b	27,0
	dc.b	'list',0		; ExtCmd 3
	dcb.b	27,0
	dc.b	'loadwb -debug',0	; ExtCmd 4
	dcb.b	18,0
	dc.b	'diskmaster2.0',0	; ExtCmd 5
	dcb.b	18,0
	dc.b	'run AudioMasterIII',0	; ExtCmd 6
	dcb.b	13,0
	dc.b	'ced',0			; ExtCmd 7
	dcb.b	28,0
	dc.w	0			; Not in use
DefaultMaxPLSTEntries
	dc.w	2500			; Max PLST Entries
	dc.b	2,3,4,1			; Multi Mode Next
	dc.w	$102,$202,$037,$047,$304, $F06,$C10,$C20,$E93,$A0F
	dc.b	0			; RAW/IFF Save, 0=RAW, 1=IFF
	dc.b	1			; IntMode, 0=VBLANK, 1=CIA
	dc.b	0			; Override
	dc.b	0			; Nosamples
	dc.b	0			; BlankZero
	dc.b	1			; ShowDirs
	dc.b	0			; CutToBuf
	dc.b	0			; ShowPublic
	dc.b	1			; IFFLoop
	dc.b	0			; HHFlag
	dc.w	125			; Tempo
DefaultDMAWait
	dc.w	500			; DMAWait
DefaultTuneNote
	dc.w	24			; TuneNote (C-3)
	dc.w	$20			; TToneVol
DefaultSalvageAddress
	dc.l	0,0
DefaultPTPath
	dc.b	"ST-00:"		; Protracker Path  (32 bytes long)
	dcb.b	26
	dc.w	6 ; DefaultSpeed
	dc.w	$0FFF,$0EDE,$0EAC,$0D8B,$0C69,$0C38,$0B16,$0A17	; VU-Meter
	dc.w	$0917,$0918,$0818,$0719,$0719,$062A,$052A	; colors  
	dc.w	$042B,$042B,$032C,$032C,$023D,$013E,$013E,$003F
	dc.w	$003F,$014F,$014F,$024E,$025E,$035E,$035E,$046E
	dc.w	$046E,$046D,$057D,$057D,$067D,$067D,$078D,$078C
	dc.w	$078C,$089C,$089C,$099C,$09AC,$0AAB,$0AAB,$0BBB,$0BBB

	dc.w	$0FF3,$0FE3,$0FD3,$0EC3,$0EC4,$0EB4,$0EA4,$0E94 ; Analyzer
	dc.w	$0D84,$0D74,$0D64,$0D65,$0C55,$0C45,$0C35,$0C26 ; colors  
	dc.w	$0C26,$0C16,$0C26,$0C26,$0C37,$0C37,$0B47,$0B47
	dc.w	$0B58,$0B58,$0B68,$0B68,$0B78,$0B79,$0B89,$0A89
	dc.w	$0A99,$0A9A,$0AAA,$0AAA,$0090,$0080,$0070,$0060

	dcb.b	302  ; Pad to 1024 bytes

;---- Sampler routines ----

_custom	EQU	$00DFF000
intreq	EQU	$0000009C
intreqr	EQU	$0000001E
intena	EQU	$0000009A
joy0dat	EQU	$0000000A
vhposr	EQU	$00000006
dmacon	EQU	$00000096
dmaconr	EQU	$00000002

SamInfoPtr	dc.l	0
SamInfoLen	dc.l	0
SampleNote	dc.w	24 ; C-3
ResampleNote	dc.w	24 ; C-3
SamIntSave	dc.w	0
SamDMASave	dc.w	0

ClearTempSampArea
	LEA	TempSampArea,A0
	MOVE	#379,D0
	MOVEQ	#0,D1
ctsalop	MOVE	D1,(A0)+
	DBF	D0,ctsalop
	RTS



;------------------------------- monitor sampler -----------------------
Sampler	CLR.B	RawKeyCode
	JSR	StopIt
	JSR	TopExit
	JSR	WaitForButtonUp
	JSR	SetWaitPtrCol
	BSR	ShowMon
	JSR	Wait_4000
	JSR	ClearRightArea
	JSR	ClearAnalyzerColors
	BSR	ClearTempSampArea
	BSR	WaitForDiskDrive
	MOVE	$DFF01C,SamIntSave ; intenar
	MOVE	#$7FFF,_custom+intena
	JSR	TurnOffVoices
	MOVE	SampleNote,D0
	ASL	#1,D0
	LEA	PeriodTable,A0
	MOVE	(A0,D0.W),D0
	LSR	#1,D0
	LEA	$DFF000,A0
	LEA	$AA(A0),A5
	LEA	$BA(A0),A6
	MOVE	D0,$A6(A0)
	MOVE	D0,$B6(A0)
	MOVEQ.L	#$40,D0
	MOVE	D0,$A8(A0)
	MOVE	D0,$B8(A0)
	MOVEQ.L	#0,D0
	MOVE	D0,(A5)
	MOVE	D0,(A6)
	MOVE.B	#6,$BFD200
	MOVEQ.L	#2,D0
	MOVE.B	D0,$BFD000
	MOVE.B	#0,$BFE301
	LEA	GraphOffsets(PC),A0
	LEA	TempSampArea,A1
	MOVE.L	TextBplPtr,A2
	LEA	$9E8-40(A2),A2
	LEA	$BFE101,A3
	LEA	_custom+intreqr,A4
	MOVE	#$180,D7
	MOVEQ.L	#6,D6
	MOVEQ.L	#10,D3
monilop2
	MOVEQ.L	#22,D5
monilop4
	MOVEQ.L	#7,D4
monilop3
	BTST	D7,(A4)
	BEQ.S	monilop3
	MOVE	D7,$7E(A4)
	MOVEQ.L	#0,D0
	MOVE.B	(A3),D0
	MOVE	D0,D1
	SUB.B	D7,D0
	MOVE.B	D0,(A5)
	MOVE.B	D0,(A6)
	LSR	#3,D1
	ADD	D1,D1
	MOVE	0(A0,D1.W),D0
	MOVE	(A1),D1
	MOVE	D0,(A1)+
	BCLR	D4,0(A2,D1.W)
	BSET	D4,0(A2,D0.W)
	DBF	D4,monilop3
	ADDQ.L	#1,A2
	DBF	D5,monilop4
	SUB.L	#23,A2
	SUB.L	#368,A1
	BTST	D6,-$0100(A3)
	BEQ	sampexit
	BTST	D3,-8(A4)
	BNE.S	monilop2

;-- start sampling --

	MOVE	InsNum(PC),D1
	BEQ	sampexit
	LSL	#2,D1
	LEA	SamplePtrs,A0
	MOVE.L	(A0,D1.W),D0
	BEQ.S	samaok
	CLR.L	(A0,D1.W)
	MOVE.L	D0,A1
	MOVE.L	124(A0,D1.W),D0
	BEQ.S	samaok
	CLR.L	124(A0,D1.W)
	MOVE.L	4.W,A6
	JSR	LVOFreeMem(A6)
samaok	MOVE.L	#$FFFE,D6	; try 64k
samalclop
	MOVE.L	D6,D0
	MOVE.L	#MEMF_CHIP!MEMF_CLEAR,D1
	MOVE.L	4.W,A6
	JSR	LVOAllocMem(A6)
	TST.L	D0
	BNE.S	samalcok
	SUB.L	#2048,D6	; try 2k less
	BPL.S	samalclop
	BSR	OutOfMemErr
	BRA	sampexit
 
samalcok
	MOVE	InsNum(PC),D1
	LSL	#2,D1
	LEA	SamplePtrs(PC),A0
	MOVE.L	D0,(A0,D1.W)
	MOVE.L	D6,124(A0,D1.W)

	MOVE	$DFF002,SamDMASave
;	MOVE	#$03FF,_custom+dmacon
	BSR	GetSampleInfo
	MOVE.L	SamInfoLen,D4
	MOVE	#0,$DFF100
	MOVE	#$555,$DFF180				;SAMPLER COLOR
	MOVE.L	SamInfoPtr,A1
	LEA	_custom+intreq,A2
	LEA	$00BFE101,A3 ; parallel port
	LEA	_custom+intreqr,A4
	LEA	$DFF0BA,A6

	MOVE	#$0180,D7
	MOVEQ.L	#6,D6
	MOVEQ.L	#0,D5
samploop
	BTST	D7,(A4)
	BEQ.S	samploop
	MOVE	D7,(A2)
	MOVE.B	(A3),D0
	SUB.B	D7,D0
	MOVE.B	D0,(A5)
	MOVE.B	D0,(A6)
	MOVE.B	D0,(A1)+
	ADDQ	#1,D5
	CMP	D4,D5
	BEQ.S	sampend
	BTST	D6,-$0100(A3)
	BNE.S	samploop
sampend	MOVE	SamDMASave,D0
	OR	#$8000,D0
	MOVE	D0,$00DFF096

	MOVE.L	A1,D0
	SUB.L	SamInfoPtr(PC),D0
	MOVE.L	D0,SamInfoLen

	MOVE.L	SongDataPtr(PC),A0
	MOVE	InsNum(PC),D1
	MULU	#30,D1
	LEA	12(A0,D1.W),A0
	MOVE.L	SamInfoLen(PC),D0
	LSR.L	#1,D0
	MOVE	D0,(A0)+
	MOVE	#$0040,(A0)+
	CLR	(A0)+
	MOVE	#1,(A0)

	MOVE.L	SamInfoLen(PC),D1
	NEG.L	D1
	AND.L	#$FFFFFFF8,D1
	NEG.L	D1
	MOVE	InsNum(PC),D0
	ASL	#2,D0
	LEA	SamplePtrs,A0
	CMP.L	124(A0,D0.W),D1
	BGE.S	sampexit
	MOVE.L	124(A0,D0.W),D2
	MOVE.L	D1,124(A0,D0.W)
	SUB.L	D1,D2
	MOVE.L	0(A0,D0.W),A1
	MOVE.L	124(A0,D0.W),D0
	ADD.L	D0,A1
	MOVE.L	D2,D0
	MOVE.L	4.W,A6
	JSR	LVOFreeMem(A6)
sampexit
	MOVE	SamIntSave,D0
	BSET	#15,D0
	MOVE	D0,$DFF09A
	JSR	TurnOffVoices
	JSR	DisplayMainScreen
	BSR	ClearSamStarts
	BSR	ShowSampleInfo
	BSR	RedrawSample
	JSR	WaitForButtonUp
	CLR	KeyBufPos
	CLR.B	RawKeyCode
	CLR	ShiftKeyStatus
	JMP	Wait_4000

SampleNullInfo
	CLR.L	SamInfoPtr
	CLR.L	SamInfoLen
	MOVEQ	#-1,D0
	RTS
 
GetSampleInfo
	MOVE	InsNum(PC),D0
	BEQ.S	SampleNullInfo
	LSL	#2,D0
	LEA	SamplePtrs(PC),A0
	MOVE.L	(A0,D0.W),SamInfoPtr
	MOVE.L	124(A0,D0.W),SamInfoLen
	MOVEQ	#0,D0
	RTS

ShowMon	SF	ScopeEnable
	ST	DisableAnalyzer
	JSR	ClearRightArea
	LEA	MonitorData,A0
	MOVEQ	#-1,D4
	JMP	cgjojo




;--------------------------------------------------------------
WaitForDiskDrive
	RTS
	JSR	StorePtrCol
	MOVE.L	4.W,A6
	LEA	$15E(A6),A0		; DeviceList
	LEA	TrackdiskName,A1	; trackdisk.device
	JSR	LVOFindName(A6)
	MOVE.L	D0,A6
	LEA	$24(A6),A6		; dn_GlobalVec
	MOVE	maxtdrwait,currdel
trdloop2
	MOVE.L	A6,A1
	MOVEQ	#3,D6
tdrloop	TST.L	(A1)+
	BEQ.S	tdrskip
	MOVE.L	-4(A1),A2
	BTST	#7,$41(A2)
	BNE.S	tdrskip
		JSR	SetDiskPtrCol
		SUBQ	#1,currdel		;protect against forever
		BEQ.S	tdrskip			;waits
		BRA.S	trdloop2

tdrskip	DBF	D6,tdrloop
	JMP	RestorePtrCol

maxtdrwait	dc.w	1000
currdel		dc.w	0




ClearSamStarts
	LEA	SamplePtrs+4,A0
	MOVEQ	#30,D0
cssLoop	MOVE.L	(A0)+,D1
	BEQ	cssSkip
	MOVE.L	D1,A1
	CLR	(A1)
cssSkip	DBF	D0,cssLoop
	RTS

GraphOffsets
	dc.w 31*40,30*40,29*40,28*40,27*40,26*40,25*40,24*40
	dc.w 23*40,22*40,21*40,20*40,19*40,18*40,17*40,16*40
	dc.w 15*40,14*40,13*40,12*40,11*40,10*40,09*40,08*40
	dc.w 07*40,06*40,05*40,04*40,03*40,02*40,01*40,00*40

SamNoteType	dc.w	0

ShowSamNote
	TST	SamScrEnable
	BEQ	Return2
	MOVE.L	NoteNamesPtr,A4
	MOVE	#237*40+36,TextOffset
	MOVE	SampleNote,D0
	LSL	#2,D0
	LEA	(A4,D0.W),A0
	MOVE.L	A0,ShowTextPtr
	MOVE	#4,TextLength
	BRA	ShowText

ShowResamNote
	TST	SamScrEnable
	BEQ	Return2
	MOVE.L	NoteNamesPtr,A4
	MOVE	#248*40+36,TextOffset
	MOVE	ResampleNote,D0
	LSL	#2,D0
	LEA	(A4,D0.W),A0
	MOVE.L	A0,ShowTextPtr
	MOVE	#4,TextLength
	BRA	ShowText

;---- Graphics Data ----

	IFD	_largetext
SpectrumAnaData	INCBIN "big/iff/ptspectrumana.iff"
		cnop 0,2
	ELSE
SpectrumAnaData	INCBIN "small/iff/ptspectrumana.iff"
		cnop 0,2
	ENDC

	IFD	_largetext
ScopeData	INCBIN "big/iff/ptscope.iff"
		cnop 0,2
	ELSE
ScopeData	INCBIN "small/iff/ptscope.iff"
		cnop 0,2
	ENDC

	IFD	_largetext
DirScreenData	INCBIN "big/iff/ptfilereq.iff"
		cnop 0,2
	ELSE
DirScreenData	INCBIN "small/iff/ptfilereq.iff"
		cnop 0,2
	ENDC

	IFD	_largetext
PLSTData	INCBIN "big/iff/ptplst.iff"
		cnop 0,2
	ELSE
PLSTData	INCBIN "small/iff/ptplst.iff"
		cnop 0,2
	ENDC

	IFD	_largetext
Edit1Data	INCBIN "big/iff/ptedit1.iff"
		cnop 0,2
	ELSE
Edit1Data	INCBIN "small/iff/ptedit1.iff"
		cnop 0,2
	ENDC

	IFD	_largetext
Edit2Data	INCBIN "big/iff/ptedit2.iff"
		cnop 0,2
	ELSE
Edit2Data	INCBIN "small/iff/ptedit2.iff"
		cnop 0,2
	ENDC

	IFD	_largetext
Edit3Data	INCBIN "big/iff/ptedit3.iff"
		cnop 0,2
	ELSE
Edit3Data	INCBIN "small/iff/ptedit3.iff"
		cnop 0,2
	ENDC

	IFD	_largetext
SetupScreenData	INCBIN "big/iff/ptsetup.iff"
		cnop 0,2
	ELSE
SetupScreenData	INCBIN "small/iff/ptsetup.iff"
		cnop 0,2
	ENDC

	IFD	_largetext
Setup2Data	INCBIN "big/iff/ptsetup2.iff"
		cnop 0,2
	ELSE
Setup2Data	INCBIN "small/iff/ptsetup2.iff"
		cnop 0,2
	ENDC

	IFD	_largetext
PresetEdData	INCBIN "big/iff/ptpreseted.iff"
		cnop 0,2
	ELSE
PresetEdData	INCBIN "small/iff/ptpreseted.iff"
		cnop 0,2
	ENDC

	IFD	_largetext
SampScreenData	INCBIN "big/iff/ptsampler.iff"
		cnop 0,2
	ELSE
SampScreenData	INCBIN "small/iff/ptsampler.iff"
		cnop 0,2
	ENDC

	IFD	_largetext
MonitorData	INCBIN "big/iff/ptmonitor.iff"
		cnop 0,2
	ELSE
MonitorData	INCBIN "small/iff/ptmonitor.iff"
		cnop 0,2
	ENDC

	IFD	_largetext
HelpScreenData	INCBIN "big/iff/pthelpscreen.iff"
		cnop 0,2
	ELSE
HelpScreenData	INCBIN "small/iff/pthelpscreen.iff"
		cnop 0,2
	ENDC

	IFD	_largetext
MainScreenData	INCBIN "big/iff/PTMainScreen.iff"
		cnop 0,2
	ELSE
MainScreenData	INCBIN "small/iff/PTMainScreen.iff"
		cnop 0,2
	ENDC


;--------- raw gfx data!!
FontData	INCBIN "raw/ptfont.raw"		;general font 8x8
FontSize	=*-FontData
		cnop 0,2

SureBoxData	INCBIN "raw/ptsurebox.raw"
SureBoxSize	=*-SureBoxData
		cnop 0,2

ClearBoxData	INCBIN "raw/ptclearbox.raw"
ClearBoxSize	=*-ClearBoxData
		cnop 0,2

FormatBoxData	INCBIN "raw/ptformatbox.raw"
FormatBoxSize	=*-FormatBoxData
		cnop 0,2

VolBoxData	INCBIN "raw/ptvolbox.raw"
ToggleONdata	INCBIN "raw/PTToggleON.raw"
ToggleOFFdata	INCBIN "raw/PTToggleOFF.raw"
S_BoxData	INCBIN "raw/PTLetters.raw"



;************************** CHIP DATA HUNK **************************
	SECTION ptdata2,BSS_C
BitPlaneData	ds.b	(ScreenWidth*256*2)+8

	SECTION ptdata,DATA_C
TToneData	; Tuning Tone (Sine Wave)
	dc.b    0,  25,  49,  71,  91, 106, 118, 126
	dc.b  127, 126, 118, 106,  91,  71,  49,  25
	dc.b    0, -25, -49, -71, -91,-106,-118,-126
	dc.b -127,-126,-118,-106, -91, -71, -49, -25

; in chipram so that it runs slooowwly on FAST! Amigas
; coz of lotsa wait states!!
;
DMAWaitLoop
	MOVE.L	D0,-(SP)
	MOVE	DMAWait,D0
dpnolp1	DBF	D0,dpnolp1
	MOVE.L	(SP)+,D0
	RTS

; as above >>>> NEVER use speed critical timings useing CPU loops
;		its is just lame!  SO its placed in CHIP ram for HIGH
;		WAIT-STATES
Wait_4000
	MOVE.L	D0,-(SP)
	MOVE	#$4000,D0
	TST.B	HHFlag
	BEQ.S	wl_loop
	MOVE	#$FFFF,D0
wl_lop1	DBF	D0,wl_lop1
	MOVE	#$A000,D0
wl_loop	DBF	D0,wl_loop
	MOVE.L	(SP)+,D0
	RTS


CopListB
	dc.l	$01800000
	dc.l	$008a0000
	dc.l	-2

;-----------------------------------------------------------------
; copper list  (very hard to implement into the OS as a screen!!
; allways enable AGA_bplcon3 !!
;
CopList
        dc.l    $01fc0000       ;MAKES ECS-COPPERLIST WORK IN AGA MODE 100%

	dc.l	$01800000
	dc.l	$008E2c81	; Display Window Start    2C/81
	dc.l	$00902cC1	; Display Window Stop     2C/C1
	dc.l	$00920038	; Display Data Fetch Start
	dc.l	$009400d0	; Display Data Fetch Stop
	dc.l	$01003300	; bplcon0
	dc.l	$01020000	; bplcon1
	dc.l	$01040024	; bplcon2 (24)
;	dc.l	$01060c00	; bplcon3
				;x4x=lores sprite
				;x8x=hires sprite
				;xCx=superhires sprite
				;x0x=normal ECS sprite
				;Exx=set lo=nibbles of 24bit palette $180..
				;Cxx=set hi-nibbles of 24bit palette
	dc.l	$01080000
	dc.l	$010A0000
;	dc.l	$010c0011	;aabb	aa=bitplane color bank ???
				;	bb=sprite color bank ???

SprList	dc.l	$01200000	;Sprite 0 high
	dc.l	$01220000	;Sprite 0 low
	dc.l	$01240000	;Sprite 1 high
	dc.l	$01260000	;Sprite 1 low
	dc.l	$01280000	;Sprite 2 high
	dc.l	$012A0000	;Sprite 2 low
	dc.l	$012C0000	;Sprite 3 high
	dc.l	$012E0000	;Sprite 3 low
	dc.l	$01300000	;Sprite 4 high
	dc.l	$01320000	;Sprite 4 low
	dc.l	$01340000	;Sprite 5 high
	dc.l	$01360000	;Sprite 5 low
	dc.l	$01380000	;Sprite 6 high
	dc.l	$013A0000	;Sprite 6 low
	dc.l	$013C0000	;Sprite 7 high
	dc.l	$013E0000	;Sprite 7 low

CopListBitplanes
	dc.l	$00E00000	;Bitplane 0 high
	dc.l	$00E20000	;Bitplane 0 low
	dc.l	$00E40000	;Bitplane 1 high
	dc.l	$00E60000	;Bitplane 1 low
	dc.l	$00E80000	;Bitplane 2 high
NoteBplptrHigh=*-2
	dc.l	$00EA0000	;Bitplane 2 low
NoteBplptrLow=*-2

CopListColors
	dc.l	$01A20AAA	; Color 17
	dc.l	$01A40888	; Color 18
	dc.l	$01A60666	; Color 19
	dc.l	$01A00000	; Color 16
	dc.l	$01800000	; Color 0
CopCol0=*-2
	dc.l	$01820AAA	; Color 1
	dc.l	$01840777	; Color 2
	dc.l	$01860444	; Color 3
	dc.l	$01880CCC	; Color 4
	dc.l	$018A0A00	; Color 5
	dc.l	$018C0000	; Color 6
	dc.l	$018E004D	; Color 7
	dc.l	$01AE0A00	; Color 23
	dc.l	$01AA0700	; Color 21
	dc.l	$01AC0400	; Color 22

	dc.l	$2C09FFFE	; Wait for line $2C, pos $07
	dc.l	$01003300	; bplcon0
CopListAnalyzer
	dcb.w	320,0
CopListInsPos
	dc.l	$B807FFFE	; Wait for line $88, pos $07
	dc.l	$01002300	; bplcon0
CopListBpl4
	dc.l	$00E80000	; Bitplane 4 high
	dc.l	$00EA0000	; Bitplane 4 low
	dc.w	$0188	; Color 4
NoteCol	dc.w	$004D
	dc.l	$B907FFFE	; Wait for line $89, pos $07
	dc.l	$01003300	; bplcon0
CopListMark2
	dcb.w	672,0

	dc.l	$E907FFFE	; Wait for line $E9, pos $07
	dc.l	$010AFFD8	; bpl2mod
	dc.l	$0108FFD8	; bpl1mod
	dc.l	$EA07FFFE	; Wait for line $EA, pos $07
	dc.l	$01040010	; bplcon2
	dc.l	$010A0000	; bpl2mod
	dc.l	$01080000	; bpl1mod
	dc.l	$EB07FFFE	; Wait for line $E8, pos $07
	dc.l	$010AFFD8	; bpl2mod
	dc.l	$0108FFD8	; bpl1mod
	dc.l	$EC07FFFE	; Wait for line $EC, pos $07
	dc.l	$010A0000	; bpl2mod
	dc.l	$01080000	; bpl1mod
	dc.l	$ED07FFFE	; Wait for line $ED, pos $07
	dc.l	$010AFFD8	; bpl2mod
	dc.l	$0108FFD8	; bpl1mod
	dc.l	$EE07FFFE	; Wait for line $EE, pos $07
	dc.l	$010A0000	; bpl2mod
	dc.l	$01080000	; bpl1mod
	dc.l	$EF07FFFE	; Wait for line $EF, pos $07
	dc.l	$010AFFD8	; bpl2mod
	dc.l	$0108FFD8	; bpl1mod
	dc.l	$F007FFFE	; Wait for line $F0, pos $07
	dc.l	$010A0000	; bpl2mod
	dc.l	$01080000	; bpl1mod
	dc.l	$F107FFFE	; Wait for line $F1, pos $07
	dc.l	$010AFFD8	; bpl2mod
	dc.l	$0108FFD8	; bpl1mod
	dc.l	$F207FFFE	; Wait for line $F2, pos $07
	dc.l	$010A0000	; bpl2mod
	dc.l	$01080000	; bpl1mod
	dc.l	$F307FFFE	; Wait for line $F3, pos $07
	dc.l	$010AFFD8	; bpl2mod
	dc.l	$0108FFD8	; bpl1mod
	dc.l	$F407FFFE	; Wait for line $F4, pos $07
	dc.l	$010A0000	; bpl2mod
	dc.l	$01080000	; bpl1mod
	dc.l	$F507FFFE	; Wait for line $F5, pos $07
	dc.l	$010AFFD8	; bpl2mod
	dc.l	$0108FFD8	; bpl1mod
	dc.l	$F607FFFE	; Wait for line $F6, pos $07
	dc.l	$010A0000	; bpl2mod
	dc.l	$01080000	; bpl1mod
	dc.l	$01B20000	; Color 1
	dc.l	$01B40000	; Color 2
	dc.l	$01B60000	; Color 3
	dc.l	$01BA0000	; Color 5
	dc.l	$01BC0000	; Color 6
	dc.l	$01BE0000	; Color 7
	dc.l	$FFDFFFFE	; Wait for line $FF, pos $DF
	dc.l	$2907FFFE	; Wait for line $29, pos $07
	dc.l	$01002300	; bplcon0
	dc.l	$2C07FFFE	; Wait for line $2C, pos $07
	dc.l	$01000300	; bplcon0
	dc.l	$3509fffe,$01800000

	dc.l	$008a0000
	dc.l	$FFFFFFFE	; Wait for line $FF, pos $FF
				; End of copperlist

;****************************************************************************
CopList2
	dc.l	$B607FFFE	; Wait for line $B6, pos $07
	dc.l	$01002300	; bplcon0
CopList2Bpl4Ptr
	dc.l	$00E80000	; Bitplane 4 high
	dc.l	$00EA0000	; Bitplane 4 low
	dc.l	$0188004D	; Color 4
	dc.l	$01B200F0	; LoopSprite color
	dc.l	$01BA00FF	; PlayPos Sprite color
	dc.l	$B707FFFE	; Wait for line $B7, pos $07
	dc.l	$01003300	; bplcon0
	dc.l	$FFDFFFFE	; Wait for line $FF, pos $DF
	dc.l	$2907FFFE	; Wait for line $29, pos $07
	dc.l	$01002300	; bplcon0
	dc.l	$2C07FFFE	; Wait for line $2C, pos $07
	dc.l	$01000300	; bplcon0
	dc.l	$FFFFFFFE	; Wait for line $FF, pos $FF
				; End of copperlist


PointerSpriteData
	dc.w	0,0
	INCBIN	"raw/PTPointer.raw"
NoSpriteData
	dc.w	0,0,0,0
CursorSpriteData
	dc.w	0,0
	dc.w	$FFE0,$FFE0,$FFE0,$FFE0,$8020,$0000,$8020,$0000
	dc.w	$8020,$0000,$8020,$0000,$8020,$0000,$8020,$0000
	dc.w	$8020,$0000,$8020,$0000,$8020,$0000,$8020,$0000
	dc.w	$0000,$FFE0,$0000,$FFE0
	dc.w	0,0
LineCurSpriteData
	dc.w	0,0,$0000,$FE00,$0000,$FE00,$0000,$0000,0,0
VUSpriteData1
	dc.w	$E95B,$EA01
	dc.w	$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0
	dc.w	$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0
	dc.w	$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0
	dc.w	$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0
	dc.w	$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0
	dc.w	$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0
	dc.w	$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0
	dc.w	$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0
	dc.w	$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0
	dc.w	$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0
	dc.w	$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0
	dc.w	$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0
	dc.w	0,0
VUSpriteData2
	dc.w	$E97F,$EA01
	dc.w	$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0
	dc.w	$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0
	dc.w	$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0
	dc.w	$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0
	dc.w	$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0
	dc.w	$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0
	dc.w	$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0
	dc.w	$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0
	dc.w	$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0
	dc.w	$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0
	dc.w	$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0
	dc.w	$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0
	dc.w	0,0
VUSpriteData3
	dc.w	$E9A3,$EA01
	dc.w	$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0
	dc.w	$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0
	dc.w	$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0
	dc.w	$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0
	dc.w	$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0
	dc.w	$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0
	dc.w	$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0
	dc.w	$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0
	dc.w	$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0
	dc.w	$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0
	dc.w	$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0
	dc.w	$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0
	dc.w	0,0
VUSpriteData4
	dc.w	$E9C7,$EA01
	dc.w	$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0
	dc.w	$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0
	dc.w	$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0
	dc.w	$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0
	dc.w	$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0
	dc.w	$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0
	dc.w	$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0
	dc.w	$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0
	dc.w	$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0
	dc.w	$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0
	dc.w	$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0
	dc.w	$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0,$C0C0,$3FC0
	dc.w	0,0
LoopSpriteData1
	dc.w 0,0
	dc.w $F000,0,$F000,0,$F000,0,$F000,0,$1000,0,$1000,0,$1000,0,$1000,0
	dc.w $1000,0,$1000,0,$1000,0,$1000,0,$1000,0,$1000,0,$1000,0,$1000,0
	dc.w $1000,0,$1000,0,$1000,0,$1000,0,$1000,0,$1000,0,$1000,0,$1000,0
	dc.w $1000,0,$1000,0,$1000,0,$1000,0,$1000,0,$1000,0,$1000,0,$7000,0
	dc.w $1000,0,$1000,0,$1000,0,$1000,0,$1000,0,$1000,0,$1000,0,$1000,0
	dc.w $1000,0,$1000,0,$1000,0,$1000,0,$1000,0,$1000,0,$1000,0,$1000,0
	dc.w $1000,0,$1000,0,$1000,0,$1000,0,$1000,0,$1000,0,$1000,0,$1000,0
	dc.w $1000,0,$1000,0,$1000,0,$1000,0,$1000,0,$1000,0,$1000,0,$1000,0
	dc.w 0,0
LoopSpriteData2
	dc.w 0,0
	dc.w $F000,0,$F000,0,$F000,0,$F000,0,$8000,0,$8000,0,$8000,0,$8000,0
	dc.w $8000,0,$8000,0,$8000,0,$8000,0,$8000,0,$8000,0,$8000,0,$8000,0
	dc.w $8000,0,$8000,0,$8000,0,$8000,0,$8000,0,$8000,0,$8000,0,$8000,0
	dc.w $8000,0,$8000,0,$8000,0,$8000,0,$8000,0,$8000,0,$8000,0,$E000,0
	dc.w $8000,0,$8000,0,$8000,0,$8000,0,$8000,0,$8000,0,$8000,0,$8000,0
	dc.w $8000,0,$8000,0,$8000,0,$8000,0,$8000,0,$8000,0,$8000,0,$8000,0
	dc.w $8000,0,$8000,0,$8000,0,$8000,0,$8000,0,$8000,0,$8000,0,$8000,0
	dc.w $8000,0,$8000,0,$8000,0,$8000,0,$8000,0,$8000,0,$8000,0,$8000,0
	dc.w 0,0
PlayPosSpriteData
	dc.w 0,0
	dc.w $8000,0,$8000,0,$8000,0,$8000,0,$8000,0,$8000,0,$8000,0,$8000,0
	dc.w $8000,0,$8000,0,$8000,0,$8000,0,$8000,0,$8000,0,$8000,0,$8000,0
	dc.w $8000,0,$8000,0,$8000,0,$8000,0,$8000,0,$8000,0,$8000,0,$8000,0
	dc.w $8000,0,$8000,0,$8000,0,$8000,0,$8000,0,$8000,0,$8000,0,$8000,0
	dc.w $8000,0,$8000,0,$8000,0,$8000,0,$8000,0,$8000,0,$8000,0,$8000,0
	dc.w $8000,0,$8000,0,$8000,0,$8000,0,$8000,0,$8000,0,$8000,0,$8000,0
	dc.w $8000,0,$8000,0,$8000,0,$8000,0,$8000,0,$8000,0,$8000,0,$8000,0
	dc.w $8000,0,$8000,0,$8000,0,$8000,0,$8000,0,$8000,0,$8000,0,$8000,0
	dc.w 0,0

;******** BSS HUNK ********

	SECTION ptbss,BSS

FileInfoBlock	ds.b	256 ;,0

FIB_EntryType	EQU	FileInfoBlock+4
FIB_FileName	EQU	FileInfoBlock+8
FIB_FileSize	EQU	FileInfoBlock+124
FIB_DateStamp	EQU	FileInfoBlock+132

InfoData	ds.b	36
TopMenusBuffer	ds.b	2200
TextDataBuffer	ds.b	546  
TrackBuffer	ds.b	256
CmdsBuffer	ds.b	256
BlockBuffer	ds.b	256
PatternBuffer	ds.b	1024
UndoBuffer	ds.b	1024

TrackdiskIOExtTD
		ds.w	1
		ds.l	3
TDPortPtr	ds.l	1
		ds.w	1
Fmt_tja		ds.w	1
		ds.l	2
		ds.b	3
Fmt_hmmm	ds.b	1
		ds.w	1
FmtDataSize	ds.w	2
FmtDataPtr	ds.w	2
FmtDiskOffset	ds.l	9

SplitTransTable	ds.b	38
SplitInstrTable	ds.b	38

ModulesPath2	ds.b	64
SongsPath2	ds.b	64
SamplePath2	ds.b	64

		ds.l	1

SetupData	ds.b	26
SongsPath	ds.b	32
ModulesPath	ds.b	32
SamplePath	ds.b	32
PrintPath	ds.b	32
ColorTable	ds.w	8
PackMode	ds.b	1
ModPackMode	ds.b	1
SplitFlag	ds.b	1
FilterFlag	ds.b	1
TransDelFlag	ds.b	1
ShowDecFlag	ds.b	1
AutoDirFlag	ds.b	1
AutoExitFlag	ds.b	1
ModOnlyFlag	ds.b	1
MIDIFlag	ds.b	1
SplitData	ds.b	4
		ds.b	4
		ds.b	4
		ds.b	4
KeyRepDelay	ds.w	1
KeyRepSpeed	ds.w	1
Accidental	ds.b	1
		ds.b	1
ExtCommands	ds.b	32*8 ; 256 bytes
MaxDirEntries	ds.w	1
MaxPLSTEntries	ds.w	1
MultiModeNext	ds.b	4
EffectMacros	ds.w	10
RAWIFFMode	ds.b	1
IntMode		ds.b	1
OverrideFlag	ds.b	1
NosamplesFlag	ds.b	1
BlankZeroFlag	ds.b	1
ShowDirsFlag	ds.b	1
ShowPublicFlag	ds.b	1
CutToBufFlag	ds.b	1
IFFLoopFlag	ds.b	1
HHFlag		ds.b	1
Tempo		ds.w	1
DMAWait		ds.w	1
TuneNote	ds.w	1
TToneVol	ds.w	1
SalvageAddress	ds.b	8
PTPath		ds.b	32  ; 512 bytes
DefaultSpeed	ds.w	1
VUMeterColors	ds.w	48
AnalyzerColors	ds.w	40
		ds.b	302 ; Pad to 1024 bytes

HelpTextIndex	ds.l	256
HelpTextData	ds.b	(ScreenWidth*16)+16

InpEvPort	ds.b	34
InpEvIOReq	ds.b	48

ScopeInfo	ds.b	20*4
ScopeSamInfo	ds.b	16*31
BlankSample	ds.b	320
FileName	ds.b	96
NewFileName	ds.b	96
SampleFileName	ds.b	28
PresetNameText	ds.b	22
DirInputName	ds.b	30
NewInputName	ds.b	30
TempSampArea	ds.w	380
SaveColors	ds.w	40+48



;****************************************************************************
;********   full monitor!
;****************************************************************************



xsize = 320
ysize = 256


	section	main,CODE
BigMonitor
	btst	#6,$bfe001
	beq.s	BigMonitor

	movem.l	d0-d7/a0-a6,-(sp)
	lea	$dff000,a6
	move	#$4000,$9a(a6)
	move	#$0400,$96(a6)
	move	#$83ff,$96(a6)
	move.l	#bm_copper,$80(a6)
	move	#0,$88(a6)

	bsr	bm_SamplerInit
	bsr	bm_setplane

bm_main1
	bsr	bm_Sampler

	bsr	noflash

	btst	#6,$bfe001
	bne.s	bm_main1

.wblit	btst	#$E,$2(a6)
	bne.s	.wblit
	bsr	bm_SampEnd
	move	#$c000,$9a(a6)
	jsr	SetCopList
	movem.l	(sp)+,d0-d7/a0-a6
	rts



page	dc.w	0

bm_setplane
	moveq	#4-1,d1
	lea	bp_pn,a0
	add.l	#bm_screen+2,d0
.mkbp1	move	d0,6(a0)
	swap	d0
	move	d0,2(a0)
	swap	d0
	add.l	#64,d0
	addq.l	#8,a0
	dbf	d1,.mkbp1
	rts

******************************************************
bm_SamplerInit
	MOVE	$DFF01C,SamIntSave		; intenar
	bsr	voiceoff
	MOVE	bm_SampleNote(pc),D0
	ASL	#1,D0
	LEA	PeriodTable,A0
	MOVE	(A0,D0.W),D0
	ADD	bm_Tuning(pc),D0
	LSR	#1,D0
	LEA	$DFF000,A6
	MOVE	D0,$A6(A6)			;set period
	MOVE	D0,$B6(A6)
	MOVEQ	#$40,D0
	MOVE	D0,$A8(A6)			;set volume
	MOVE	D0,$B8(A6)
	MOVEQ	#0,D0
	MOVE	D0,$AA(A6)			;clear 1st data
	MOVE	D0,$BA(A6)
	MOVE.B	#6,$BFD200
	MOVE.B	#2,$BFD000
	MOVE.B	#0,$BFE301
	RTS

bm_Sampler
	lea	bm_screen,a0
	lea	plottab(pc),a1
	lea	sambuf(pc),a5

	LEA	$dff09c,A2			;intreq
	LEA	$BFE101,A3			;parallel port
	LEA	$dff01e,A4			;intreqr
	MOVE	#$0180,D7			;used for calc
	MOVE	#180,D6				;loop counter
	move	#64,d2
	MOVEQ	#0,D5				;pixel offset counter
.samploop					;main sampling loop --->
	BTST	D7,(A4)
	BEQ.S	.samploop
	MOVE	D7,(A2)
	MOVEQ	#0,D0
	MOVE.B	(A3),D0			;read sampler number
; move $a(a6),d1
; asr  #8,d1
; add.b  d1,d0
	SUB.B	D7,D0
	MOVE.B	D0,$AA(A6)
	MOVE.B	D0,$BA(A6)

	add.b	d7,d0			;YPOS= [0..255]
	move	d0,d1

	move.b	1(a5,d5.w),d0

	asl	#6,d0			;YPOS=YPOS*screen x size
	move	d5,d4			;get x pos
	asr	#4,d4			;XPOS=word position
	add	d4,d4
	add	d4,d0			;offset=xpos*2 + YPOS
	move	d5,d4
	and	#%1111,d4
	move	(a1,d4.w),d4
	not	d4
	and	d4,(a0,d0.w)
	add	d2,d0
	and	d4,(a0,d0.w)
	add	d2,d0
	and	d4,(a0,d0.w)
	add	d2,d0
	and	d4,(a0,d0.w)
	add	d2,d0
	and	d4,(a0,d0.w)
	add	d2,d0
	and	d4,(a0,d0.w)

	move	d1,d0
	move.b	d0,1(a5,d5.w)

	asl	#6,d0			;YPOS=YPOS*screen x size
	move	d5,d4			;get x pos
	asr	#4,d4			;XPOS=word position
	add	d4,d4
	add	d4,d0			;offset=xpos*2 + YPOS
	move	d5,d4
	and	#%1111,d4
	move	(a1,d4.w),d4
	or	d4,(a0,d0.w)
	add	d2,d0
	or	d4,(a0,d0.w)
	add	d2,d0
	or	d4,(a0,d0.w)
	add	d2,d0
	or	d4,(a0,d0.w)
	add	d2,d0
	or	d4,(a0,d0.w)
	add	d2,d0
	or	d4,(a0,d0.w)

	move	-0(a5,d5.w),d0
	add	-2(a5,d5.w),d0
	add	-4(a5,d5.w),d0
	add	-6(a5,d5.w),d0
	add	-8(a5,d5.w),d0
	cmp	#(level*5),d0
	ble.s	.flash
	cmp	#(255-level)*5,d0
	bge.s	.flash

.cont	addq	#2,d5
	dbf	d6,.samploop
	rts

level = 7

.flash	MOVEM.L	A0-A1,-(SP)
	LEA	Colortab2,A0
	LEA	colors,A1
	MOVE	(A0)+,2(A1)
	MOVE	(A0)+,6(A1)
	MOVE	(A0)+,10(A1)
	MOVE	(A0)+,14(A1)
	MOVE	(A0)+,18(A1)
	MOVE	(A0)+,22(A1)
	MOVEM.L	(SP)+,A0-A1
	BRA.S	.cont

noflash	MOVEM.L	A0-A1,-(SP)
	LEA	Colortab1(pc),A0
	LEA	colors,A1
	MOVE	(A0)+,2(A1)
	MOVE	(A0)+,6(A1)
	MOVE	(A0)+,10(A1)
	MOVE	(A0)+,14(A1)
	MOVE	(A0)+,18(A1)
	MOVE	(A0)+,22(A1)
	MOVEM.L	(SP)+,A0-A1
	rts

plottab	dc.w	%1100000000000000
	dc.w	%11000000000000
	dc.w	%110000000000
	dc.w	%1100000000
	dc.w	%11000000
	dc.w	%110000
	dc.w	%1100
	dc.w	%11

	ds.b	8
sambuf	dcb.w	256,0


bm_SampEnd
	MOVE	SamIntSave,D0
	BSET	#15,D0
	MOVE	D0,$DFF09A
	bsr	voiceoff
	rts

voiceoff
	MOVE	#$000F,$DFF096
	MOVEQ	#0,d0
	move	d0,$DFF0A8
	move	d0,$DFF0B8
	move	d0,$DFF0C8
	move	d0,$DFF0D8
	rts

bm_SampleNote	dc.w	30	;as in Protracker  (0.......+35)
bm_Tuning	dc.w	0	;as in Protracker  (-48.....+48)


Colortab1:	DC.W	$000
		dc.w	$421
		dc.w	$872
		dc.w	$ca3
		dc.w	$ff4
		dc.w	$ca3
		dc.w	$872
		dc.w	$421
		
Colortab2:	DC.W	$00f
		dc.w	$333
		dc.w	$888
		dc.w	$ccc
		dc.w	$fff
		dc.w	$ccc
		dc.w	$888
		dc.w	$333


	section	chipdata,DATA_C
*************************************************************
bm_copper:
	dc.l $008e2950,$00902cd6
	dc.l $00920030,$009400d8
	dc.l $01080014,$010a0014,$01fc0000

	dc.l $01200000,$01220000
	dc.l $01240000,$01260000
	dc.l $01280000,$012a0000
	dc.l $012c0000,$012e0000
	dc.l $01300000,$01320000
	dc.l $01340000,$01360000
	dc.l $01380000,$013a0000
	dc.l $013c0000,$013e0000

colors	dc.l $01800000
	dc.l $01820420
	dc.l $01860861
	dc.l $018e0ba3
	dc.l $019e0ff6
	dc.l $019c0ba3
	dc.l $01980861
	dc.l $01900420

bp_pn	dc.l $00e00007,$00e20000
	dc.l $00e40007,$00e60000
	dc.l $00e80007,$00ea0000
	dc.l $00ec0007,$00ee0000
	dc.l $00f00000,$00f20000,$01004304
	dc.l -2



	section	mtdata,BSS_C
	ds.b	(64)*10
bm_screen
	ds.b	(64)*(ysize+20)
	END
