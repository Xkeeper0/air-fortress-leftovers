; Referenced data that no longer exists (here)

loc_C05D	= $C05D
unk_C248	= $C248
unk_B000	= $B000
unk_D008	= $D008


; ---------------------------------------------------------------------------


	LDA TileEditor_CursorX
	CMP #7
	BEQ locret_C2E5
	INC TileEditor_CursorX

locret_C2E5:
	RTS
; ---------------------------------------------------------------------------
	LDA TileEditor_CursorX
	BEQ locret_C2E5
	DEC TileEditor_CursorX
	RTS
; ---------------------------------------------------------------------------

loc_C2ED:
	LDA TileEditor_CursorY
	CMP #7
	BEQ locret_C2E5
	INC TileEditor_CursorY
	RTS
; ---------------------------------------------------------------------------
	LDA TileEditor_CursorY
	BEQ locret_C2E5
	DEC TileEditor_CursorY
	RTS
; ---------------------------------------------------------------------------
	LDA #0
	STA TileEditor_CursorX
	BEQ loc_C2ED
	LDA #0
	BEQ loc_C311
	LDA #1
	BNE loc_C311
	LDA #2
	BNE loc_C311
	LDA #3

loc_C311:
	TAY
	LDA TileEditor_CursorY
	ASL A
	ASL A
	ASL A
	ORA TileEditor_CursorX
	TAX
	STY TileEditor_Buffer, X
	LDA #2
	STA byte_B4
	LDA TileEditor_CursorX
	CMP #7
	BEQ locret_C328
	INC TileEditor_CursorX

locret_C328:
	RTS
; ---------------------------------------------------------------------------
	LDA #0
	BEQ loc_C337
	LDA #1
	BNE loc_C337
	LDA #2
	BNE loc_C337
	LDA #3

loc_C337:
	LDX #$3F

loc_C339:
	STA TileEditor_Buffer, X
	DEX
	BPL loc_C339
	LDA #2
	STA byte_B4
	RTS
; ---------------------------------------------------------------------------
	LDA #0
	BEQ loc_C351
	LDA #1
	BNE loc_C351
	LDA #2
	BNE loc_C351
	LDA #3

loc_C351:
	STA byte_14
	LDA TileEditor_CursorY
	ASL A
	ASL A
	ASL A
	ORA TileEditor_CursorX
	TAX
	LDA TileEditor_Buffer, X
	STA byte_15
	LDX #$3F

loc_C361:
	LDA TileEditor_Buffer, X
	CMP byte_14
	BNE loc_C36E
	LDA byte_15
	STA TileEditor_Buffer, X
	JMP loc_C376
; ---------------------------------------------------------------------------

loc_C36E:
	CMP byte_15
	BNE loc_C376
	LDA byte_14
	STA TileEditor_Buffer, X

loc_C376:
	DEX
	BPL loc_C361
	LDA #2
	STA byte_B4
	RTS
; ---------------------------------------------------------------------------
	LDA #1
	STA EditMode
	RTS
; ---------------------------------------------------------------------------
	INC byte_28
	LDA byte_28
	AND #3
	STA byte_28

; =============== S U B R O U T I N E =======================================
sub_C38B:
	JSR WaitForNMI
	LDA #$23
	STA PPUADDR
	LDA #$C0
	STA PPUADDR
	LDX byte_28
	LDA unk_C248+1, X
	LDX #$28

loc_C39F:
	STA PPUDATA
	DEX
	BNE loc_C39F
	JMP SetPPUAddressTo2000
; End of function sub_C38B

; ---------------------------------------------------------------------------
unref_C3A8:

	JSR WaitForNMI
	LDA #0
	STA PPUMASK
	JSR sub_C7E0
	LDA #0
	STA byte_E
	LDA #$A0
	STA byte_F
	LDA #$20
	STA PPUADDR
	LDA #0
	STA PPUADDR
	LDX #$10
	LDY #0

loc_C3C9:
	LDA (byte_E), Y
	STA PPUDATA
	INC byte_E
	BNE loc_C3C9
	INC byte_F
	JSR WaitForNMI
	DEX
	BNE loc_C3C9
	JSR WaitForNMI
	JSR SetPPUAddressTo2000
	LDA PPUMaskMirror
	STA PPUMASK

loc_C3E5:
	JSR MysteryHardwareInterface
	STA byte_1C
	LDX #4

loc_C3EC:
	LDA unk_C40C, X
	CMP byte_1C
	BEQ loc_C3F9
	DEX
	BPL loc_C3EC
	JMP loc_C3E5
; ---------------------------------------------------------------------------

loc_C3F9:
	LDA JumpTable_C40C_Lo, X
	STA word_1D

loc_C3FE:
	LDA JumpTable_C415_Hi, X
	STA word_1D+1
	JSR sub_C409
	JMP loc_C3E5

; =============== S U B R O U T I N E =======================================
sub_C409:
	JMP (word_1D)
; End of function sub_C409

; ---------------------------------------------------------------------------
unk_C40C:
	.db  $B
	.db  $C
	.db  $A
	.db   8
	.db $21
JumpTable_C40C_Lo:
	.db <loc_C41B
	.db <loc_C42E
	.db <loc_C431
	.db <loc_C444
	.db <loc_C447
JumpTable_C415_Hi:
	.db >loc_C41B
	.db >loc_C42E
	.db >loc_C431
	.db >loc_C444
	.db >loc_C447
; ---------------------------------------------------------------------------

loc_C41B:
	INC PPUScrollX
	LDA PPUScrollX
	CMP #$78
	BNE loc_C425
	LDA #$80

loc_C425:
	CMP #$F8
	BNE loc_C42B
	LDA #0

loc_C42B:
	STA PPUScrollX
	RTS
; ---------------------------------------------------------------------------

loc_C42E:
	DEC PPUScrollY
	RTS
; ---------------------------------------------------------------------------

loc_C431:
	DEC PPUScrollX
	LDA PPUScrollX
	CMP #$7F
	BNE loc_C43B
	LDA #$77

loc_C43B:
	CMP #$FF
	BNE loc_C441
	LDA #$F7

loc_C441:
	STA PPUScrollX
	RTS
; ---------------------------------------------------------------------------

loc_C444:
	INC PPUScrollY
	RTS
; ---------------------------------------------------------------------------

loc_C447:
	PLA
	PLA
	LDA #0
	STA PPUScrollX
	STA PPUScrollY

loc_C44F:
	JMP loc_C05D+1
; ---------------------------------------------------------------------------
	LDA SpriteOrBG
	EOR #1
	STA SpriteOrBG
	JMP loc_C05D+1
; ---------------------------------------------------------------------------
	LDA byte_25
	ASL A
	ASL A
	ASL A
	ASL A
	ORA #$B
	STA TileEditor_SolidTileNumber
	JMP loc_C05D+1
; ---------------------------------------------------------------------------
	JSR sub_C56B

loc_C46B:
	JSR WaitForNMI
	JSR sub_C4B2
	JSR MysteryHardwareInterface
	STA byte_1C
	LDX #8

loc_C478:
	LDA unk_C497, X
	CMP byte_1C
	BEQ loc_C484
	DEX
	BPL loc_C478
	BMI loc_C46B

loc_C484:
	LDA JumpTable_C4A0_Lo, X
	STA word_1D
	LDA JumpTable_C4A0_Hi, X
	STA word_1D+1
	JSR sub_C494
	JMP loc_C46B

; =============== S U B R O U T I N E =======================================
sub_C494:
	JMP (word_1D)
; End of function sub_C494

; ---------------------------------------------------------------------------
unk_C497:
	.db  $B
	.db  $C
	.db  $A
	.db   8
	.db $40
	.db $5D
	.db $2F
	.db $3B
	.db $23
JumpTable_C4A0_Lo:
	.db <loc_C4DF
	.db <loc_C4E4
	.db <loc_C4E9
	.db <loc_C4EE
	.db <loc_C551
	.db <loc_C556
	.db <loc_C55B
	.db <loc_C569
	.db <loc_C596
JumpTable_C4A0_Hi:
	.db >loc_C4DF
	.db >loc_C4E4
	.db >loc_C4E9
	.db >loc_C4EE
	.db >loc_C551
	.db >loc_C556
	.db >loc_C55B
	.db >loc_C569
	.db >loc_C596

; =============== S U B R O U T I N E =======================================
sub_C4B2:
	LDA #$77
	STA byte_200
	LDA byte_2E
	ASL A
	ASL A
	ASL A
	ADC #$20
	STA byte_203
	LDA #0
	STA byte_201
	LDX byte_202
	INX
	TXA
	AND #3
	STA byte_202
	LDA byte_2C
	ORA #$10
	STA byte_21D
	LDA byte_2B
	ORA #$10
	STA byte_219
	RTS
; End of function sub_C4B2

; ---------------------------------------------------------------------------

loc_C4DF:
	DEC byte_2C
	JMP loc_C4F0
; ---------------------------------------------------------------------------

loc_C4E4:
	INC byte_2B
	JMP loc_C4F0
; ---------------------------------------------------------------------------

loc_C4E9:
	INC byte_2C
	JMP loc_C4F0
; ---------------------------------------------------------------------------

loc_C4EE:
	DEC byte_2B

loc_C4F0:
	LDA byte_2C
	AND #$F
	STA byte_2C
	LDA byte_2B
	AND #3
	STA byte_2B
	LDA byte_2B
	ASL A
	ASL A

loc_C500:
	ASL A
	ASL A
	ORA byte_2C
	STA byte_2D
	LDA SpriteOrBG
	EOR #1
	ASL A
	ASL A
	ASL A
	ASL A
	LDX byte_2E
	BEQ loc_C51D
	ORA byte_2F
	TAX
	LDA byte_2D
	STA unk_B000, X
	JMP loc_C52C
; ---------------------------------------------------------------------------

loc_C51D:
	TAX
	LDA byte_2D
	STA unk_B000+#$0, X
	STA unk_B000+#$4, X
	STA unk_B000+#$8, X
	STA unk_B000+#$C, X

loc_C52C:
	JSR WaitForNMI
	LDA #$3F
	STA PPUADDR
	LDA #0
	STA PPUADDR
	LDA SpriteOrBG
	EOR #1
	ASL A
	ASL A
	ASL A
	ASL A
	TAX
	LDY #$10

loc_C544:
	LDA unk_B000, X
	STA PPUDATA
	INX
	DEY
	BNE loc_C544
	JMP SetPPUAddressTo2000
; ---------------------------------------------------------------------------

loc_C551:
	DEC byte_28
	JMP loc_C55D
; ---------------------------------------------------------------------------

loc_C556:
	INC byte_2E
	JMP sub_C56B
; ---------------------------------------------------------------------------

loc_C55B:
	INC byte_28

loc_C55D:
	LDA byte_28
	AND #3
	STA byte_28
	JSR sub_C38B
	JMP sub_C56B
; ---------------------------------------------------------------------------

loc_C569:
	DEC byte_2E

; =============== S U B R O U T I N E =======================================
sub_C56B:
	LDA byte_2E
	AND #3
	STA byte_2E
	LDA byte_28
	ASL A
	ASL A
	ORA byte_2E
	STA byte_2F
	LDA SpriteOrBG
	EOR #1
	ASL A
	ASL A
	ASL A
	ASL A
	ORA byte_2F
	TAX
	LDA unk_B000, X
	STA byte_2D
	AND #$F
	STA byte_2C
	LDA byte_2D
	LSR A
	LSR A
	LSR A
	LSR A
	STA byte_2B
	RTS
; End of function sub_C56B

; ---------------------------------------------------------------------------

loc_C596:
	PLA
	PLA
	RTS
; ---------------------------------------------------------------------------
	LDA TilePicker_CursorYX
	STA byte_E
	LDA #0
	ASL byte_E
	ROL A
	ASL byte_E
	ROL A
	ASL byte_E
	ROL A
	ASL byte_E
	ROL A
	ORA #$80
	STA byte_F
	LDA SpriteOrBG
	ASL A
	ASL A
	ASL A
	ASL A
	ADC byte_F
	STA byte_F
	LDA #$34
	STA byte_10
	LDA #0
	STA byte_11
	LDX #8

loc_C5C3:
	LDY #0
	LDA (byte_E), Y
	STA byte_B5
	LDY #8
	LDA (byte_E), Y
	STA byte_B6
	JSR sub_C621
	INC byte_E
	LDA byte_10
	CLC
	ADC #8
	STA byte_10
	DEX
	BNE loc_C5C3
	LDA #2
	STA byte_B4
	RTS
; ---------------------------------------------------------------------------
	LDA TilePicker_CursorYX
	STA byte_E
	LDA SpriteOrBG
	ASL byte_E
	ROL A
	ASL byte_E
	ROL A
	ASL byte_E
	ROL A
	ASL byte_E
	ROL A
	ORA #$80
	STA byte_F
	LDA #$34
	STA byte_10
	LDA #0
	STA byte_11
	LDX #8

loc_C603:
	JSR sub_C631
	LDY #0
	LDA byte_B5
	STA (byte_E), Y
	LDY #8
	LDA byte_B6
	STA (byte_E), Y
	INC byte_E
	LDA byte_10
	CLC
	ADC #8
	STA byte_10
	DEX
	BNE loc_C603
	INC byte_B7
	RTS

; =============== S U B R O U T I N E =======================================
sub_C621:
	LDY #7

loc_C623:
	LDA #0
	LSR byte_B6
	ROL A
	LSR byte_B5
	ROL A
	STA (byte_10), Y
	DEY
	BPL loc_C623
	RTS
; End of function sub_C621


; =============== S U B R O U T I N E =======================================
sub_C631:
	LDY #7

loc_C633:
	LDA (byte_10), Y
	LSR A
	ROR byte_B5
	LSR A
	ROR byte_B6
	DEY
	BPL loc_C633
	RTS
; End of function sub_C631

; ---------------------------------------------------------------------------
	LDA #$34
	STA byte_10
	LDA #0
	STA byte_11
	LDX #8

loc_C649:
	JSR sub_C631
	LDY #7

loc_C64E:
	LDA #0
	ASL byte_B6
	ROL A
	ASL byte_B5
	ROL A
	STA (byte_10), Y
	DEY
	BPL loc_C64E
	LDA byte_10
	CLC
	ADC #8
	STA byte_10
	DEX
	BNE loc_C649

loc_C665:
	LDA #2
	STA byte_B4
	RTS
; ---------------------------------------------------------------------------
	LDA #$34
	STA byte_10
	LDA #0
	STA byte_11
	LDX #7

loc_C674:
	JSR sub_C631
	LDA byte_B5
	STA byte_74, X
	LDA byte_B6
	STA byte_7C, X
	LDA byte_10
	CLC
	ADC #8
	STA byte_10
	DEX
	BPL loc_C674
	LDX #7

loc_C68B:
	LDA byte_10
	SEC
	SBC #8
	STA byte_10
	LDA byte_74, X
	STA byte_B5
	LDA byte_7C, X
	STA byte_B6
	JSR sub_C621
	DEX
	BPL loc_C68B
	JMP loc_C665
; ---------------------------------------------------------------------------
	LDA #$34
	STA byte_10
	LDA #0
	STA byte_11
	LDX #8

loc_C6AD:
	JSR sub_C631
	LDA byte_B5
	ASL A
	ROL byte_B5
	LDA byte_B6
	ASL A
	ROL byte_B6
	JSR sub_C621
	LDA byte_10
	CLC
	ADC #8
	STA byte_10
	DEX
	BNE loc_C6AD
	JMP loc_C665
; ---------------------------------------------------------------------------
	LDA #$34
	STA byte_10
	LDA #0
	STA byte_11
	LDX #8

loc_C6D4:
	JSR sub_C631
	LDA byte_B5
	LSR A
	ROR byte_B5
	LDA byte_B6
	LSR A
	ROR byte_B6
	JSR sub_C621
	LDA byte_10
	CLC
	ADC #8
	STA byte_10
	DEX
	BNE loc_C6D4
	JMP loc_C665
; ---------------------------------------------------------------------------
	LDX #7

loc_C6F3:
	LDA TileEditor_Buffer, X
	STA byte_74, X
	DEX
	BPL loc_C6F3
	LDX #0

loc_C6FC:
	LDA TileEditor_Buffer + 8, X
	STA TileEditor_Buffer, X
	INX
	CPX #$40
	BNE loc_C6FC
	JMP loc_C665
; ---------------------------------------------------------------------------
	LDX #$3F

loc_C70A:
	LDA TileEditor_Buffer, X
	STA TileEditor_Buffer + 8, X
	DEX
	BPL loc_C70A
	LDX #7

loc_C713:
	LDA byte_74, X
	STA TileEditor_Buffer, X
	DEX
	BPL loc_C713
	JMP loc_C665

; =============== S U B R O U T I N E =======================================
IRQ_Original:
	RTI


; =============== S U B R O U T I N E =======================================
NMI_Original:
	PHA
	TXA
	PHA
	TYA
	PHA
	LDA #0
	STA OAMADDR
	LDA #2
	STA OAM_DMA
	LDA #1
	STA NMIFlag
	LDA byte_B4
	BEQ loc_C73D
	JSR sub_C86D
	JSR SetPPUAddressTo2000
	DEC byte_B4

loc_C73D:
	LDA byte_B7
	BEQ loc_C746
	JSR ResetPPUADDR
	DEC byte_B7

loc_C746:
	LDA PPUScrollX
	ASL A
	LDA #0
	ROL A
	TAX
	LDA PPUScrollY
	ASL A
	TXA
	ROL A
	ORA PPUCtrlMirror
	STA PPUCTRL
	LDA PPUScrollY
	ASL A
	STA PPUSCROLL
	LDA PPUScrollX
	ASL A
	STA PPUSCROLL
	LDX #0
	JSR ReadJoypad
	INX
	JSR ReadJoypad
	PLA
	TAY
	PLA
	TAX
	PLA
	RTI
; End of function NMI_2


; =============== S U B R O U T I N E =======================================


ReadJoypad:
	                    ; NMI_2+4Bp
	LDA #1
	STA JOY1
	LDA #0
	STA JOY1
	LDY #8
	LDA #0
	STA JoypadState1, X

loc_C782:
	LDA JOY1, X
	LSR A
	ROL JoypadState1, X
	DEY
	BNE loc_C782
	LDA JoypadState1, X
	CMP JoypadState2, X
	STA JoypadState2, X
	BEQ loc_C79C
	LDA #0
	STA JoypadState3, X
	LDA #$FF
	STA JoypadRepeatTimer, X
	RTS
; ---------------------------------------------------------------------------

loc_C79C:
	LDY JoypadRepeatTimer, X
	BEQ loc_C7B0
	BMI loc_C7A9
	DEC JoypadRepeatTimer, X
	LDA #0
	STA JoypadState3, X
	RTS
; ---------------------------------------------------------------------------

loc_C7A9:
	STA JoypadState3, X
	LDA #$A
	STA JoypadRepeatTimer, X
	RTS
; ---------------------------------------------------------------------------

loc_C7B0:
	STA JoypadState3, X
	LDA #2
	STA JoypadRepeatTimer, X
	RTS
; End of function ReadJoypad


; =============== S U B R O U T I N E =======================================


WaitForNMI:
	LDA #0
	STA NMIFlag

loc_C7BB:
	LDA NMIFlag
	BEQ loc_C7BB
	RTS
; End of function WaitForNMI


; =============== S U B R O U T I N E =======================================


MysteryHardwareInterface:
	LDA #0
	STA byte_401E

loc_C7C5:
	LDA byte_4019
	AND #$C0
	CMP #$80
	BNE loc_C7C5
	LDA byte_4018
	PHA
	LDA #$40
	STA byte_401E

loc_C7D7:
	LDA byte_4019
	AND #$80
	BNE loc_C7D7
	PLA
	RTS
; End of function MysteryHardwareInterface


; =============== S U B R O U T I N E =======================================
sub_C7E0:
	LDA #$20
	STA PPUADDR
	LDA #0
	STA PPUADDR
	LDX #4
	LDY #0
	LDA TileEditor_SolidTileNumber

loc_C7F0:
	                    ; sub_C7E0+17j
	STA PPUDATA
	INY
	BNE loc_C7F0
	DEX
	BNE loc_C7F0
	LDA #$23
	STA PPUADDR
	LDA #$C0
	STA PPUADDR
	LDY #$40
	LDX byte_28
	LDA unk_C248+1, X

loc_C80A:
	STA PPUDATA
	DEY
	BNE loc_C80A
	LDA #$F0
	LDX #0

loc_C814:
	STA byte_200, X
	INX
	BNE loc_C814
	RTS
; End of function sub_C7E0

; ---------------------------------------------------------------------------
	LDA #$4C
	STA byte_E
	LDA #$20
	STA byte_F
	LDA #$10
	STA byte_15
	LDA #0
	STA byte_14

loc_C82B:
	LDA byte_F
	STA PPUADDR
	LDA byte_E
	STA PPUADDR
	LDX #$10

loc_C837:
	LDA byte_14
	STA PPUDATA
	INC byte_14
	DEX
	BNE loc_C837
	LDA byte_E
	CLC
	ADC #$20
	STA byte_E
	BCC loc_C84C
	INC byte_F

loc_C84C:
	DEC byte_15
	BNE loc_C82B
	LDA #$21
	STA PPUADDR
	LDA #$E4
	STA PPUADDR
	LDX TileEditor_SolidTileNumber
	INX
	STX PPUDATA
	INX
	STX PPUDATA
	INX
	STX PPUDATA
	INX
	STX PPUDATA
	RTS

; =============== S U B R O U T I N E =======================================
sub_C86D:
	CMP #1
	BNE loc_C87D
	LDA #2
	STA byte_18
	LDA #$21
	STA byte_19
	LDA #$20
	BNE loc_C887

loc_C87D:
	LDA #$82
	STA byte_18
	LDA #$20
	STA byte_19
	LDA #0

loc_C887:
	STA byte_1A
	LDA #4
	STA byte_1B

loc_C88D:
	LDA byte_19
	STA PPUADDR
	LDA byte_18
	STA PPUADDR
	LDY #8

loc_C899:
	LDX byte_1A
	LDA TileEditor_Buffer, X
	SEC
	ADC TileEditor_SolidTileNumber
	STA PPUDATA
	INC byte_1A
	DEY
	BNE loc_C899
	LDA byte_18
	CLC
	ADC #$20
	STA byte_18
	BCC loc_C8B3
	INC byte_19

loc_C8B3:
	DEC byte_1B
	BNE loc_C88D
	RTS
; End of function sub_C86D


; =============== S U B R O U T I N E =======================================


ResetPPUADDR:
	LDA TilePicker_CursorYX
	STA byte_18
	LDA SpriteOrBG
	ASL byte_18
	ROL A
	ASL byte_18
	ROL A
	ASL byte_18
	ROL A
	ASL byte_18
	ROL A
	ORA #$80
	STA byte_19
	LDA byte_19
	AND #$F
	ORA #$10
	STA PPUADDR
	LDA byte_18
	STA PPUADDR
	LDY #0

loc_C8DE:
	LDA (byte_18), Y
	STA PPUDATA
	INY
	CPY #$10
	BNE loc_C8DE
; End of function ResetPPUADDR


; =============== S U B R O U T I N E =======================================
SetPPUAddressTo2000:
	LDA #$20
	STA PPUADDR
	LDA #0
	STA PPUADDR
	RTS
; End of function SetPPUAddressTo2000

; ---------------------------------------------------------------------------
	LDA byte_29
	ASL A
	STA byte_30
	LDA byte_2A
	ASL A
	STA byte_31
	LDA #0
	STA byte_12
	LDA #3
	STA byte_13
	LDA #8
	STA byte_15

loc_C909:
	LDX #$A0
	LDA byte_31
	CMP #$1E
	BCC loc_C915
	LDX #$A8
	SBC #$1E

loc_C915:
	STX byte_F
	STA byte_E
	LDA #0
	ASL byte_E
	ASL byte_E
	ASL byte_E
	ROL A
	ASL byte_E
	ROL A
	ASL byte_E
	ROL A
	CLC
	ADC byte_F
	STA byte_F
	LDA byte_30
	CLC
	ADC byte_E
	STA byte_E
	BCC loc_C938
	INC byte_F

loc_C938:
	SEC
	SBC #$20
	STA byte_10
	LDA byte_F
	SBC #0
	CLC
	ADC #4
	STA byte_11
	LDA #$20
	SEC
	SBC byte_30
	BEQ loc_C95B
	STA byte_14
	LDY #0

loc_C951:
	LDA (byte_E), Y
	STA (byte_12), Y
	INY
	CPY byte_14
	BCC loc_C951
	TYA

loc_C95B:
	TAY

loc_C95C:
	LDA (byte_10), Y
	STA (byte_12), Y
	INY
	CPY #$20
	BCC loc_C95C
	LDA byte_12
	CLC
	ADC #$20
	STA byte_12
	LDA byte_13
	ADC #0
	STA byte_13
	INC byte_31
	DEC byte_15
	BNE loc_C909
	LDA byte_29
	STA byte_30
	CLC
	ADC #$10
	STA byte_32
	LDA byte_2A
	STA byte_31
	CLC
	ADC #4
	STA byte_33
	LDA #0
	STA byte_16

loc_C98E:
	LDX #0
	LDA byte_30
	STA byte_14
	SEC
	SBC #$10
	BCC loc_C99C
	STA byte_14
	INX

loc_C99C:
	LDA byte_31
	STA byte_15
	SEC
	SBC #$F
	BCC loc_C9A9
	STA byte_15
	INX
	INX

loc_C9A9:
	LDA #$C0
	STA byte_E
	LDA byte_CA6A, X
	STA byte_F
	LDX #0
	LDA byte_14
	LSR A
	BCC loc_C9BA
	INX

loc_C9BA:
	LDA byte_15
	LSR A
	BCC loc_C9C1
	INX
	INX

loc_C9C1:
	LDA byte_15
	AND #$FE
	ASL A
	ASL A
	STA byte_17
	LDA byte_14
	LSR A
	ORA byte_17
	TAY
	LDA (byte_E), Y
	AND byte_CA6E, X
	LDY byte_CA72, X
	BEQ loc_C9DD

loc_C9D9:
	LSR A
	DEY
	BNE loc_C9D9

loc_C9DD:
	LDX byte_16
	STA byte_410, X
	INC byte_16
	INC byte_30
	LDA byte_30
	CMP byte_32
	BCC loc_C98E
	LDA byte_29
	STA byte_30
	INC byte_31
	LDA byte_31
	CMP byte_33
	BCC loc_C98E
	LDX #$F

loc_C9FA:
	LDY byte_CAA6, X
	LDA byte_410, Y
	ASL A
	ASL A
	ASL A
	ASL A
	ASL A
	ASL A
	STA byte_14
	LDY byte_CA96, X
	LDA byte_410, Y
	ASL A
	ASL A
	ASL A
	ASL A
	ORA byte_14
	STA byte_14
	LDY byte_CA86, X
	LDA byte_410, Y
	ASL A
	ASL A
	ORA byte_14
	LDY byte_CA76, X
	ORA byte_410, Y
	STA byte_400, X
	DEX
	BPL loc_C9FA
	JSR WaitForNMI
	LDA #0
	STA PPUMASK
	LDX #0
	LDA #$22
	STA PPUADDR
	LDA #$80
	STA PPUADDR

loc_CA40:
	LDA byte_300, X
	STA PPUDATA
	INX
	BNE loc_CA40
	LDA #$23
	STA PPUADDR
	LDA #$E8
	STA PPUADDR

loc_CA53:
	LDA byte_400, X
	STA PPUDATA
	INX
	CPX #$10
	BNE loc_CA53
	JSR WaitForNMI
	JSR SetPPUAddressTo2000
	LDA PPUMaskMirror
	STA PPUMASK
	RTS
; ---------------------------------------------------------------------------
byte_CA6A:
	.db $A3,$A7,$AB,$AF
byte_CA6E:
	.db   3, $C,$30,$C0
byte_CA72:
	.db   0,  2,  4,  6
byte_CA76:
	.db   0,  2,  4,  6,  8, $A, $C, $E,$20,$22,$24,$26,$28,$2A,$2C,$2E
byte_CA86:
	.db   1,  3,  5,  7,  9, $B, $D, $F,$21,$23,$25,$27,$29,$2B,$2D,$2F
byte_CA96:
	.db $10,$12,$14,$16,$18,$1A,$1C,$1E,$30,$32,$34,$36,$38,$3A,$3C,$3E
byte_CAA6:
	.db $11,$13,$15,$17,$19,$1B,$1D,$1F,$31,$33,$35,$37,$39,$3B,$3D,$3F

; ---------------------------------------------------------------------------
	LDA byte_25
	ASL A
	ASL A
	ASL A
	ASL A
	ORA byte_24
	STA TilePicker_CursorYX
	LDA #$67
	STA byte_218
	STA byte_21C
	LDA #$38
	STA byte_21B
	LDA #$40
	STA byte_21F
	LDA TilePicker_CursorYX
	LSR A
	LSR A
	LSR A
	LSR A
	ORA #$10
	STA byte_219
	LDA TilePicker_CursorYX
	AND #$F
	ORA #$10
	STA byte_21D
	LDA #0
	STA byte_21A
	STA byte_21E
	LDA byte_25
	ASL A
	ASL A
	ASL A
	ADC #$F
	STA byte_204
	LDA #1
	STA byte_205
	LDX $802			; BUG!
	INX
	TXA
	AND #3
	STA byte_206
	LDA byte_24
	ASL A
	ASL A
	ASL A
	ADC #$60
	STA byte_207
	RTS
; ---------------------------------------------------------------------------
	LDA EditMode
	BNE loc_CB3A
	LDA TileEditor_CursorY
	ASL A
	ASL A
	ASL A
	ADC #$1F
	STA byte_200
	LDA TileEditor_CursorX
	ASL A
	ASL A
	ASL A
	ADC #$10
	STA byte_203
	LDA #0
	STA byte_201
	LDX byte_202
	INX
	TXA
	AND #3
	STA byte_202
	RTS
; ---------------------------------------------------------------------------

loc_CB3A:
	LDA byte_27
	ASL A
	ASL A
	ASL A
	CLC
	ADC #$9F
	STA byte_200
	LDA #0
	STA byte_201
	LDX byte_202
	INX
	TXA
	AND #3
	STA byte_202
	LDA byte_26
	ASL A
	ASL A
	ASL A
	STA byte_203
	LDA byte_27
	AND #$FE
	ASL A
	ASL A
	ASL A
	CLC
	ADC #$9F
	STA byte_208
	STA byte_20C
	CLC
	ADC #8
	STA byte_210
	STA byte_214
	LDA byte_26
	AND #$FE
	ASL A
	ASL A
	ASL A
	STA byte_20B
	STA byte_213
	CLC
	ADC #8
	STA byte_20F
	STA byte_217
	LDA #2
	STA byte_209
	STA byte_20D
	STA byte_211
	STA byte_215
	LDA #0
	STA byte_20A
	LDA #$40
	STA byte_20E
	LDA #$80
	STA byte_212
	LDA #$C0
	STA byte_216
	LDA #$87
	STA byte_220
	STA byte_224
	STA byte_228
	STA byte_22C
	LDA #0
	STA byte_222
	STA byte_226
	STA byte_22A
	STA byte_22E
	LDA #$20
	STA byte_223
	LDA #$28
	STA byte_227
	LDA #$38
	STA byte_22B
	LDA #$40
	STA byte_22F
	LDA byte_29
	ASL A
	ADC byte_26
	JSR sub_CC04
	ORA #$10
	STA byte_225
	TXA
	ORA #$10
	STA byte_221
	LDA byte_2A
	ASL A
	ADC byte_27
	JSR sub_CC04
	ORA #$10
	STA byte_22D
	TXA
	ORA #$10
	STA byte_229
	RTS

; =============== S U B R O U T I N E =======================================
sub_CC04:
	LDX #$FF

loc_CC06:
	SEC
	SBC #$A
	INX
	BCS loc_CC06
	ADC #$A
	RTS
; End of function sub_CC04

; ---------------------------------------------------------------------------
LoadGraphics:
	LDX #0              ; Load tileset graphics into PPU mem
	STX PPUADDR
	STX PPUADDR

loc_CC17:
	LDA chr_CC3C, X
	STA PPUDATA
	INX
	BNE loc_CC17

loc_CC20:
	LDA chr_CD3C, X
	STA PPUDATA
	INX
	BNE loc_CC20

loc_CC29:
	LDA chr_CE3C, X
	STA PPUDATA
	INX
	BNE loc_CC29

loc_CC32:
	LDA chr_CF3C, X
	STA PPUDATA
	INX
	BNE loc_CC32
	RTS
; ---------------------------------------------------------------------------

.include "src/data/chr.asm"

; ---------------------------------------------------------------------------
	LDA SpriteOrBG
	ASL A
	ASL A
	ASL A
	ASL A
	ORA #$80
	STA byte_F
	LDA #0
	STA byte_E
	LDA #$10
	STA PPUADDR
	LDA #0
	STA PPUADDR
	LDY #0
	LDA #$10
	STA byte_14

loc_CFA2:
	LDA (byte_E), Y
	STA PPUDATA
	INY
	BNE loc_CFA2
	INC byte_F
	DEC byte_14
	BNE loc_CFA2
	RTS
; ---------------------------------------------------------------------------
	LDA TileEditor_SolidTileNumber
	STA byte_E
	LDA #0
	ASL byte_E
	ROL A
	ASL byte_E
	ROL A
	ASL byte_E
	ROL A
	ASL byte_E
	ROL A
	STA byte_F
	ORA #$10
	STA PPUADDR
	LDA byte_E
	STA PPUADDR
	LDX #0

loc_CFD1:
	LDA unk_D008, X
	STA PPUDATA
	INX
	CPX #$50
	BNE loc_CFD1
	LDA SpriteOrBG
	ASL A
	ASL A
	ASL A
	ASL A
	ORA byte_F
	STA byte_F
	LDY #$4F

loc_CFE8:
	LDA (byte_E), Y
	STA byte_450, Y
	DEY
	BPL loc_CFE8
	LDA #$F
	STA PPUADDR
	LDA #$B0
	STA PPUADDR
	LDY #0
	LDA byte_450, Y
; ---------------------------------------------------------------------------
	.db $8D ; ì           ; End of unused segment

; $D000 ------------

	; should be STA ...
