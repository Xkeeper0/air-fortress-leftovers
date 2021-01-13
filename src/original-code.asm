; Leftover / unused tile editor code from the
; Air Fortress FDS prototype, contained on the
; TITLE side of the disk

; Leftover code starts at $C2DD ...
; Previous code before this part is lost,
; likely overwritten by other data (?)

; Unreferenced calls are labeled with
; "unreferenced" in comment; if not labeled,
; they are given "u_XXXX" as a label

; Mystery hardware device possibly connected to
; EXT port required as well;
; see QueryMysteryHardware func

; Referenced data that no longer exists:
; (marked here for label keeping)
PaletteBuffer				= $B000
Palette_NametableAttributes	= $C249
lost_code_C05E				= $C05E
lost_data_D008				= $D008


MoveCursorRight:	; $C2DD - unreferenced
	LDA TileEditor_CursorX
	CMP #7
	BEQ +
	INC TileEditor_CursorX

+
-	RTS
; ---------------------------------
MoveCursorLeft:		; $C2E6 - unreferenced
	LDA TileEditor_CursorX
	BEQ -
	DEC TileEditor_CursorX
	RTS
; ---------------------------------

MoveCursorDown:		; $C2ED
	LDA TileEditor_CursorY
	CMP #7
	BEQ -
	INC TileEditor_CursorY
	RTS
; ---------------------------------
MoveCursorUp:		; $C2F6 - unreferenced
	LDA TileEditor_CursorY
	BEQ -
	DEC TileEditor_CursorY
	RTS
; ---------------------------------
u_C2FD				; $C2FD - unreferenced
	LDA #0
	STA TileEditor_CursorX
	BEQ MoveCursorDown
	LDA #0
	BEQ loc_C311
	LDA #1
	BNE loc_C311
	LDA #2
	BNE loc_C311
	LDA #3

loc_C311:				; $C311			; $C311
	TAY
	LDA TileEditor_CursorY
	ASL A
	ASL A
	ASL A
	ORA TileEditor_CursorX
	TAX
	STY TileEditor_Buffer, X
	LDA #2
	STA TileEditor_UpdateVRAMFlag
	LDA TileEditor_CursorX
	CMP #7
	BEQ +
	INC TileEditor_CursorX

+	RTS
; ---------------------------------
u_C329:				; $C329 - unreferenced
	LDA #0
	BEQ +
u_C32D:				; $C32D - unreferenced
	LDA #1
	BNE +
u_C331:				; $C331 - unreferenced
	LDA #2
	BNE +
u_C335:				; $C335 - unreferenced
	LDA #3

+	LDX #$3F

-	STA TileEditor_Buffer, X
	DEX
	BPL -
	LDA #2
	STA TileEditor_UpdateVRAMFlag
	RTS
; ---------------------------------
u_C343:				; $C343 - unreferenced
	LDA #0
	BEQ +
u_C347:				; $C347 - unreferenced
	LDA #1
	BNE +
u_C34B:				; $C34B - unreferenced
	LDA #2
	BNE +
u_C34F:				; $C34F - unreferenced
	LDA #3

+	STA byte_14					; Save selected color as color A
	LDA TileEditor_CursorY
	ASL A
	ASL A
	ASL A
	ORA TileEditor_CursorX
	TAX
	LDA TileEditor_Buffer, X
	STA byte_15					; Save cursor pixel as color B
	LDX #$3F					; Start at last pixel

loc_C361:				; $C361						; $C361
	LDA TileEditor_Buffer, X	; Load pixel
	CMP byte_14					; Compare pixel with color A
	BNE loc_C36E				; If pixel != color A, move to next check
	LDA byte_15					; If pixel == color A, get color B
	STA TileEditor_Buffer, X	; Replace pixel wtih color B
	JMP +						; Move to next pixel
; ---------------------------------

loc_C36E:				; $C36E						; $C36E
	CMP byte_15					; Compare pixel with color B
	BNE +				; If pixel != color B, move to next pixel
	LDA byte_14					; If pixel == color B, get color A
	STA TileEditor_Buffer, X	; Replace pixel with color A

+	DEX
	BPL loc_C361
	LDA #2
	STA TileEditor_UpdateVRAMFlag
	RTS
; ---------------------------------
u_C37E:							; $C37E - unreferenced
	LDA #1
	STA TileOrPaletteMode
	RTS
; ---------------------------------
u_C383:							; $C383 - unreferenced
	INC PaletteRAM_IndexHigh2Bits
	LDA PaletteRAM_IndexHigh2Bits
	AND #3
	STA PaletteRAM_IndexHigh2Bits

; =================================
UpdateTileEditorAttributes:		; $C38B
	JSR WaitForNMI
	LDA #$23
	STA PPUADDR
	LDA #$C0
	STA PPUADDR
	LDX PaletteRAM_IndexHigh2Bits
	LDA Palette_NametableAttributes, X
	LDX #$28

-	STA PPUDATA
	DEX
	BNE -
	JMP SetPPUAddressTo2000
; End of function UpdateTileEditorAttributes

; ---------------------------------
u_C3A8:					; $C3A8 - unreferenced

	JSR WaitForNMI
	LDA #0
	STA PPUMASK
	JSR ClearBGAndSprites
	LDA #0
	STA byte_0E
	LDA #$A0
	STA byte_0F
	LDA #$20
	STA PPUADDR
	LDA #0
	STA PPUADDR
	LDX #$10
	LDY #0

loc_C3C9:				; $C3C9
	LDA (byte_0E), Y
	STA PPUDATA
	INC byte_0E
	BNE loc_C3C9
	INC byte_0F
	JSR WaitForNMI
	DEX
	BNE loc_C3C9
	JSR WaitForNMI
	JSR SetPPUAddressTo2000
	LDA PPUMaskMirror
	STA PPUMASK

loc_C3E5:				; $C3E5
	JSR QueryMysteryHardware
	STA MysteryHardwareResponse
	LDX #4

-	LDA unk_C40C, X
	CMP MysteryHardwareResponse
	BEQ loc_C3F9
	DEX
	BPL -
	JMP loc_C3E5
; ---------------------------------

loc_C3F9:				; $C3F9
	LDA JumpTable_C40C_Lo, X
	STA IndirectJumpDest
	LDA JumpTable_C415_Hi, X
	STA IndirectJumpDest+1
	JSR sub_C409
	JMP loc_C3E5

; =================================
sub_C409:
	JMP (IndirectJumpDest)

; ---------------------------------
unk_C40C:
	.db  $B
	.db  $C
	.db  $A
	.db   8
	.db $21
JumpTable_C40C_Lo:
	.db <IncrasePPUScrollY
	.db <DecreasePPUScrollX
	.db <DecreasePPUScrollY
	.db <IncreasePPUScrollX
	.db <ResetPPUScrollAndDie
JumpTable_C415_Hi:
	.db >IncrasePPUScrollY
	.db >DecreasePPUScrollX
	.db >DecreasePPUScrollY
	.db >IncreasePPUScrollX
	.db >ResetPPUScrollAndDie
; ---------------------------------

IncrasePPUScrollY:				; $C41B
	INC PPUScrollY
	LDA PPUScrollY
	CMP #$78
	BNE +
	LDA #$80

+	CMP #$F8
	BNE +
	LDA #0

+	STA PPUScrollY
	RTS
; ---------------------------------

DecreasePPUScrollX:				; $C42E
	DEC PPUScrollX
	RTS
; ---------------------------------

DecreasePPUScrollY:				; $C431
	DEC PPUScrollY
	LDA PPUScrollY
	CMP #$7F
	BNE +
	LDA #$77
+	CMP #$FF
	BNE +
	LDA #$F7
+	STA PPUScrollY
	RTS
; ---------------------------------

IncreasePPUScrollX:				; $C444
	INC PPUScrollX
	RTS
; ---------------------------------

ResetPPUScrollAndDie:				; $C447
	PLA
	PLA
	LDA #0
	STA PPUScrollY
	STA PPUScrollX
	JMP lost_code_C05E

; ---------------------------------
ToggleSpriteOrBG:		; $C452 - unreferenced
	LDA SpriteOrBG
	EOR #1
	STA SpriteOrBG
	JMP lost_code_C05E
; ---------------------------------
u_C45B:					; $C45B - unreferenced
	LDA TilePicker_CursorY
	ASL A
	ASL A
	ASL A
	ASL A
	ORA #$B
	STA TileEditor_SolidTileNumber
	JMP lost_code_C05E
; ---------------------------------

u_C468:					; $C468
	JSR UpdatePaletteValuesForDisplay

--	JSR WaitForNMI
	JSR UpdatePaletteCursorAndDigits
	JSR QueryMysteryHardware
	STA MysteryHardwareResponse
	LDX #8

-	LDA unk_C497, X
	CMP MysteryHardwareResponse
	BEQ +
	DEX
	BPL -
	BMI --

+	LDA JumpTable_C4A0_Lo, X
	STA IndirectJumpDest
	LDA JumpTable_C4A0_Hi, X
	STA IndirectJumpDest+1
	JSR IndirectJump
	JMP --

; =================================
IndirectJump:
	JMP (IndirectJumpDest)
; End of function IndirectJump

; ---------------------------------
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
	.db <DecreasePaletteHue
	.db <IncreasePaletteLuminance
	.db <IncreasePaletteHue
	.db <DecreasePaletteLuminance
	.db <DecreasePaletteRAM_IndexHigh2Bits
	.db <IncreasePaletteRAM_IndexLow2Bits
	.db <IncreasePaletteRAM_IndexHigh2Bits
	.db <DecreasePaletteRAM_IndexLow2Bits
	.db <PullATwiceAndReturn
JumpTable_C4A0_Hi:
	.db >DecreasePaletteHue
	.db >IncreasePaletteLuminance
	.db >IncreasePaletteHue
	.db >DecreasePaletteLuminance
	.db >DecreasePaletteRAM_IndexHigh2Bits
	.db >IncreasePaletteRAM_IndexLow2Bits
	.db >IncreasePaletteRAM_IndexHigh2Bits
	.db >DecreasePaletteRAM_IndexLow2Bits
	.db >PullATwiceAndReturn

; =================================
UpdatePaletteCursorAndDigits:		; $C46E
	LDA #$77
	STA byte_200
	LDA PaletteRAM_IndexLow2Bits	; Update palette index cursor
	ASL A
	ASL A
	ASL A
	ADC #$20
	STA byte_203
	LDA #0							; Tile 00 (checkerboard)
	STA byte_201
	LDX byte_202					; Cycle the color
	INX
	TXA
	AND #3
	STA byte_202
	LDA Palette_Hue					; Update palette hue digit
	ORA #$10
	STA byte_21D
	LDA Palette_Luminance			; Update palette luminance digit
	ORA #$10
	STA byte_219
	RTS
; End of function UpdatePaletteCursorAndDigits

; ---------------------------------

DecreasePaletteHue:				; $C4DF
	DEC Palette_Hue
	JMP loc_C4F0
; ---------------------------------

IncreasePaletteLuminance:		; $C4E4
	INC Palette_Luminance
	JMP loc_C4F0
; ---------------------------------

IncreasePaletteHue:				; $C4E9
	INC Palette_Hue
	JMP loc_C4F0
; ---------------------------------

DecreasePaletteLuminance:		; $C4EE
	DEC Palette_Luminance

loc_C4F0:				; $C4F0
	LDA Palette_Hue				; Update palette buffer and RAM
	AND #$F
	STA Palette_Hue
	LDA Palette_Luminance
	AND #3
	STA Palette_Luminance
	LDA Palette_Luminance
	ASL A
	ASL A
	ASL A
	ASL A
	ORA Palette_Hue
	STA Palette_Color
	LDA SpriteOrBG
	EOR #1
	ASL A
	ASL A
	ASL A
	ASL A
	LDX PaletteRAM_IndexLow2Bits
	BEQ +
	ORA PaletteRAM_Inded
	TAX
	LDA Palette_Color
	STA PaletteBuffer, X
	JMP ++

+	TAX
	LDA Palette_Color
	STA PaletteBuffer+#$0, X
	STA PaletteBuffer+#$4, X
	STA PaletteBuffer+#$8, X
	STA PaletteBuffer+#$C, X

++	JSR WaitForNMI
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

-	LDA PaletteBuffer, X
	STA PPUDATA
	INX
	DEY
	BNE -
	JMP SetPPUAddressTo2000
; ---------------------------------

DecreasePaletteRAM_IndexHigh2Bits:				; $C551
	DEC PaletteRAM_IndexHigh2Bits
	JMP +
; ---------------------------------

IncreasePaletteRAM_IndexLow2Bits:				; $C556
	INC PaletteRAM_IndexLow2Bits
	JMP UpdatePaletteValuesForDisplay
; ---------------------------------

IncreasePaletteRAM_IndexHigh2Bits:				; $C55B
	INC PaletteRAM_IndexHigh2Bits

+	LDA PaletteRAM_IndexHigh2Bits
	AND #3
	STA PaletteRAM_IndexHigh2Bits
	JSR UpdateTileEditorAttributes
	JMP UpdatePaletteValuesForDisplay
; ---------------------------------

DecreasePaletteRAM_IndexLow2Bits:				; $C569
	DEC PaletteRAM_IndexLow2Bits

; =================================
UpdatePaletteValuesForDisplay:
	LDA PaletteRAM_IndexLow2Bits
	AND #3
	STA PaletteRAM_IndexLow2Bits
	LDA PaletteRAM_IndexHigh2Bits
	ASL A
	ASL A
	ORA PaletteRAM_IndexLow2Bits
	STA PaletteRAM_Inded
	LDA SpriteOrBG
	EOR #1
	ASL A
	ASL A
	ASL A
	ASL A
	ORA PaletteRAM_Inded
	TAX
	LDA PaletteBuffer, X
	STA Palette_Color
	AND #$F
	STA Palette_Hue
	LDA Palette_Color
	LSR A
	LSR A
	LSR A
	LSR A
	STA Palette_Luminance
	RTS
; End of function UpdatePaletteValuesForDisplay

; ---------------------------------

PullATwiceAndReturn:				; $C596
	PLA
	PLA
	RTS

; ---------------------------------
u_C599:						; $C599 - unreferenced
	LDA TilePicker_CursorYX
	STA byte_0E
	LDA #0
	ASL byte_0E
	ROL A
	ASL byte_0E
	ROL A
	ASL byte_0E
	ROL A
	ASL byte_0E
	ROL A
	ORA #$80
	STA byte_0F
	LDA SpriteOrBG
	ASL A
	ASL A
	ASL A
	ASL A
	ADC byte_0F
	STA byte_0F
	LDA #$34
	STA byte_10
	LDA #0
	STA byte_11
	LDX #8

-	LDY #0
	LDA (byte_0E), Y
	STA byte_B5
	LDY #8
	LDA (byte_0E), Y
	STA byte_B6
	JSR sub_C621
	INC byte_0E
	LDA byte_10
	CLC
	ADC #8
	STA byte_10
	DEX
	BNE -
	LDA #2
	STA TileEditor_UpdateVRAMFlag
	RTS

; ---------------------------------
u_C5E3:						; $C5E3 - unreferenced
	LDA TilePicker_CursorYX
	STA byte_0E
	LDA SpriteOrBG
	ASL byte_0E
	ROL A
	ASL byte_0E
	ROL A
	ASL byte_0E
	ROL A
	ASL byte_0E
	ROL A
	ORA #$80
	STA byte_0F
	LDA #$34
	STA byte_10
	LDA #0
	STA byte_11
	LDX #8

-	JSR sub_C631
	LDY #0
	LDA byte_B5
	STA (byte_0E), Y
	LDY #8
	LDA byte_B6
	STA (byte_0E), Y
	INC byte_0E
	LDA byte_10
	CLC
	ADC #8
	STA byte_10
	DEX
	BNE -
	INC TilePicker_UpdateVRAMFlag
	RTS

; =================================
sub_C621:
	LDY #7
-	LDA #0
	LSR byte_B6
	ROL A
	LSR byte_B5
	ROL A
	STA (byte_10), Y
	DEY
	BPL -
	RTS
; End of function sub_C621


; =================================
sub_C631:
	LDY #7
-	LDA (byte_10), Y
	LSR A
	ROR byte_B5
	LSR A
	ROR byte_B6
	DEY
	BPL -
	RTS
; End of function sub_C631

; ---------------------------------
u_C63F:					; $C63F - unreferenced
	LDA #$34
	STA byte_10
	LDA #0
	STA byte_11
	LDX #8
--	JSR sub_C631
	LDY #7
-	LDA #0
	ASL byte_B6
	ROL A
	ASL byte_B5
	ROL A
	STA (byte_10), Y
	DEY
	BPL -
	LDA byte_10
	CLC
	ADC #8
	STA byte_10
	DEX
	BNE --

loc_C665:				; $C665
	LDA #2
	STA TileEditor_UpdateVRAMFlag
	RTS

; ---------------------------------
u_C66A:					; $C66A - unreferenced
	LDA #$34
	STA byte_10
	LDA #0
	STA byte_11
	LDX #7
-	JSR sub_C631
	LDA byte_B5
	STA byte_74, X
	LDA byte_B6
	STA byte_7C, X
	LDA byte_10
	CLC
	ADC #8
	STA byte_10
	DEX
	BPL -
	LDX #7

-	LDA byte_10
	SEC
	SBC #8
	STA byte_10
	LDA byte_74, X
	STA byte_B5
	LDA byte_7C, X
	STA byte_B6
	JSR sub_C621
	DEX
	BPL -
	JMP loc_C665
; ---------------------------------
u_C6A3:					; $C6A3 - unreferenced
	LDA #$34
	STA byte_10
	LDA #0
	STA byte_11
	LDX #8
-	JSR sub_C631
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
	BNE -
	JMP loc_C665

; ---------------------------------
u_C6CA:					; $C6CA - unreferenced
	LDA #$34
	STA byte_10
	LDA #0
	STA byte_11
	LDX #8
-	JSR sub_C631
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
	BNE -
	JMP loc_C665

; ---------------------------------
u_C6F1:					; $C6F1 - unreferenced
	LDX #7
-	LDA TileEditor_Buffer, X
	STA byte_74, X
	DEX
	BPL -
	LDX #0
-	LDA TileEditor_Buffer + 8, X
	STA TileEditor_Buffer, X
	INX
	CPX #$40
	BNE -
	JMP loc_C665
; ---------------------------------
u_C708:					; $C708 - unreferenced
	LDX #$3F
-	LDA TileEditor_Buffer, X
	STA TileEditor_Buffer + 8, X
	DEX
	BPL -
	LDX #7
-	LDA byte_74, X
	STA TileEditor_Buffer, X
	DEX
	BPL -
	JMP loc_C665


; =================================
IRQ_Original:			; $C71D
	RTI

; =================================
NMI_Original:			; $C71E
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
	LDA TileEditor_UpdateVRAMFlag
	BEQ +
	JSR UpdateTileEditorVRAM
	JSR SetPPUAddressTo2000
	DEC TileEditor_UpdateVRAMFlag

+	LDA TilePicker_UpdateVRAMFlag
	BEQ +
	JSR UpdateTilePickerVRAM
	DEC TilePicker_UpdateVRAMFlag

+	LDA PPUScrollY
	ASL A
	LDA #0
	ROL A
	TAX
	LDA PPUScrollX
	ASL A
	TXA
	ROL A
	ORA PPUCtrlMirror
	STA PPUCTRL
	LDA PPUScrollX
	ASL A
	STA PPUSCROLL
	LDA PPUScrollY
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


; =================================


ReadJoypad:				; $C772
	                    ; NMI_2+4Bp
	LDA #1
	STA JOY1
	LDA #0
	STA JOY1
	LDY #8
	LDA #0
	STA JoypadState1, X

-	LDA JOY1, X
	LSR A
	ROL JoypadState1, X
	DEY
	BNE -

	LDA JoypadState1, X
	CMP JoypadState2, X
	STA JoypadState2, X
	BEQ +
	LDA #0
	STA JoypadState3, X
	LDA #$FF
	STA JoypadRepeatTimer, X
	RTS

+	LDY JoypadRepeatTimer, X
	BEQ ++
	BMI +
	DEC JoypadRepeatTimer, X
	LDA #0
	STA JoypadState3, X
	RTS

+	STA JoypadState3, X
	LDA #$A
	STA JoypadRepeatTimer, X
	RTS

++	STA JoypadState3, X
	LDA #2
	STA JoypadRepeatTimer, X
	RTS
; End of function ReadJoypad


; =================================


WaitForNMI:				; $C7B7
	LDA #0
	STA NMIFlag
-	LDA NMIFlag
	BEQ -
	RTS
; End of function WaitForNMI


; =================================

; Interacts with unknown hardware
; $401E: Output?
; $4019: Status?
; $4018: Data?
; Returns data in A
QueryMysteryHardware:	; $C7C0
	LDA #0
	STA byte_401E		; ? Send device command?

-	LDA byte_4019		; ? Check device status?
	AND #$C0
	CMP #$80
	BNE -				; ? Not ready, loop?
	LDA byte_4018		; ? Device response?
	PHA					; Save response
	LDA #$40			; ? Load next command?
	STA byte_401E		; ? Send command?

-	LDA byte_4019		; ? Check device status?
	AND #$80
	BNE -				; ? Wait for device acknowledge?
	PLA					; Pull response
	RTS


; =================================
ClearBGAndSprites:		; $C7E0
	LDA #$20
	STA PPUADDR
	LDA #0
	STA PPUADDR
	LDX #4
	LDY #0
	LDA TileEditor_SolidTileNumber
-	STA PPUDATA
	INY
	BNE -
	DEX
	BNE -
	LDA #$23
	STA PPUADDR
	LDA #$C0
	STA PPUADDR
	LDY #$40
	LDX PaletteRAM_IndexHigh2Bits
	LDA Palette_NametableAttributes, X
-	STA PPUDATA
	DEY
	BNE -
	LDA #$F0
	LDX #0
-	STA byte_200, X
	INX
	BNE -
	RTS
; End of function ClearBGAndSprites

; ---------------------------------
u_C81B:					; $C81B - unreferenced
	LDA #$4C
	STA byte_0E
	LDA #$20
	STA byte_0F
	LDA #$10
	STA byte_15
	LDA #0
	STA byte_14

--	LDA byte_0F
	STA PPUADDR
	LDA byte_0E
	STA PPUADDR
	LDX #$10

-	LDA byte_14
	STA PPUDATA
	INC byte_14
	DEX
	BNE -

	LDA byte_0E
	CLC
	ADC #$20
	STA byte_0E
	BCC +
	INC byte_0F
+	DEC byte_15
	BNE --

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

; =================================
UpdateTileEditorVRAM:	; $C86D
	CMP #1
	BNE +

	LDA #2
	STA byte_18
	LDA #$21
	STA byte_19
	LDA #$20
	BNE ++

+	LDA #$82
	STA byte_18
	LDA #$20
	STA byte_19
	LDA #0

++	STA byte_1A
	LDA #4
	STA byte_1B

--	LDA byte_19
	STA PPUADDR
	LDA byte_18
	STA PPUADDR
	LDY #8

-	LDX byte_1A
	LDA TileEditor_Buffer, X
	SEC
	ADC TileEditor_SolidTileNumber
	STA PPUDATA
	INC byte_1A
	DEY
	BNE -

	LDA byte_18
	CLC
	ADC #$20
	STA byte_18
	BCC +
	INC byte_19

+	DEC byte_1B
	BNE --

	RTS
; End of function UpdateTileEditorVRAM


; =================================


UpdateTilePickerVRAM:		; $C8B8
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

-	LDA (byte_18), Y
	STA PPUDATA
	INY
	CPY #$10
	BNE -


; =================================
SetPPUAddressTo2000:
	LDA #$20
	STA PPUADDR
	LDA #0
	STA PPUADDR
	RTS
; End of function SetPPUAddressTo2000

; ---------------------------------
u_C8F3:					; $C8F3 - unreferenced
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

loc_C909:				; $C909 (used for branch below)
	LDX #$A0
	LDA byte_31
	CMP #$1E
	BCC +
	LDX #$A8
	SBC #$1E

+	STX byte_0F
	STA byte_0E
	LDA #0
	ASL byte_0E
	ASL byte_0E
	ASL byte_0E
	ROL A
	ASL byte_0E
	ROL A
	ASL byte_0E
	ROL A
	CLC
	ADC byte_0F
	STA byte_0F
	LDA byte_30
	CLC
	ADC byte_0E
	STA byte_0E
	BCC +
	INC byte_0F

+	SEC
	SBC #$20
	STA byte_10
	LDA byte_0F
	SBC #0
	CLC
	ADC #4
	STA byte_11
	LDA #$20
	SEC
	SBC byte_30
	BEQ +

	STA byte_14
	LDY #0
-	LDA (byte_0E), Y
	STA (byte_12), Y
	INY
	CPY byte_14
	BCC -

	TYA
+	TAY

-	LDA (byte_10), Y
	STA (byte_12), Y
	INY
	CPY #$20
	BCC -

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

loc_C98E:				; $C98E (used for branch below)
	LDX #0
	LDA byte_30
	STA byte_14
	SEC
	SBC #$10
	BCC +

	STA byte_14
	INX

+	LDA byte_31
	STA byte_15
	SEC
	SBC #$F
	BCC +

	STA byte_15
	INX
	INX

+	LDA #$C0
	STA byte_0E
	LDA byte_CA6A, X
	STA byte_0F
	LDX #0
	LDA byte_14
	LSR A
	BCC +
	INX

+	LDA byte_15
	LSR A
	BCC +
	INX
	INX

+	LDA byte_15
	AND #$FE
	ASL A
	ASL A
	STA byte_17
	LDA byte_14
	LSR A
	ORA byte_17
	TAY
	LDA (byte_0E), Y
	AND byte_CA6E, X
	LDY byte_CA72, X
	BEQ +

-	LSR A
	DEY
	BNE -

+	LDX byte_16
	STA byte_410, X
	INC byte_16
	INC byte_30
	LDA byte_30
	CMP byte_32
	BCC loc_C98E		; branch target above
	LDA byte_29
	STA byte_30
	INC byte_31
	LDA byte_31
	CMP byte_33
	BCC loc_C98E		; branch target above
	LDX #$F

-	LDY byte_CAA6, X
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
	BPL -

	JSR WaitForNMI
	LDA #0
	STA PPUMASK
	LDX #0
	LDA #$22
	STA PPUADDR
	LDA #$80
	STA PPUADDR

-	LDA byte_300, X
	STA PPUDATA
	INX
	BNE -

	LDA #$23
	STA PPUADDR
	LDA #$E8
	STA PPUADDR

-	LDA byte_400, X
	STA PPUDATA
	INX
	CPX #$10
	BNE -

	JSR WaitForNMI
	JSR SetPPUAddressTo2000
	LDA PPUMaskMirror
	STA PPUMASK
	RTS

; ---------------------------------
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

; ---------------------------------
u_CAB6:					; $CAB6 - unreferenced
	LDA TilePicker_CursorY
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
	LDA TilePicker_CursorY
	ASL A
	ASL A
	ASL A
	ADC #$F
	STA byte_204
	LDA #1
	STA byte_205
	LDX $802			; BUG! - tries to cycle cursor color via $0802 instead of $0206
						; (load $0802, add 1, AND #$03, store at $0206)

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
; ---------------------------------
u_CB12:					; $CB12 - unreferenced
	LDA TileOrPaletteMode
	BNE +
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

+	LDA byte_27
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

; =================================
sub_CC04:
	LDX #$FF

-	SEC
	SBC #$A
	INX
	BCS -
	ADC #$A
	RTS


; ---------------------------------
LoadGraphics:
	LDX #0              ; Load tileset graphics into PPU mem
	STX PPUADDR
	STX PPUADDR

-	LDA CHR_Row1, X
	STA PPUDATA
	INX
	BNE -

-	LDA CHR_Row2, X
	STA PPUDATA
	INX
	BNE -

-	LDA CHR_Row3, X
	STA PPUDATA
	INX
	BNE -

	; Mild bug: copies garbage past the end of CHR data
-	LDA CHR_Row4, X
	STA PPUDATA
	INX
	BNE -
	RTS
; ---------------------------------

.include "src/data/chr.asm"

; ---------------------------------
u_CF84:				; $CF84
	LDA SpriteOrBG
	ASL A
	ASL A
	ASL A
	ASL A
	ORA #$80
	STA byte_0F
	LDA #0
	STA byte_0E
	LDA #$10
	STA PPUADDR
	LDA #0
	STA PPUADDR
	LDY #0
	LDA #$10
	STA byte_14

-	LDA (byte_0E), Y
	STA PPUDATA
	INY
	BNE -
	INC byte_0F
	DEC byte_14
	BNE -
	RTS

; ---------------------------------

u_CFB1:					; $CFB1 - unreferenced
	LDA TileEditor_SolidTileNumber
	STA byte_0E
	LDA #0
	ASL byte_0E
	ROL A
	ASL byte_0E
	ROL A
	ASL byte_0E
	ROL A
	ASL byte_0E
	ROL A
	STA byte_0F
	ORA #$10
	STA PPUADDR
	LDA byte_0E
	STA PPUADDR
	LDX #0

-	LDA lost_data_D008, X
	STA PPUDATA
	INX
	CPX #$50
	BNE -

	LDA SpriteOrBG
	ASL A
	ASL A
	ASL A
	ASL A
	ORA byte_0F
	STA byte_0F
	LDY #$4F

-	LDA (byte_0E), Y
	STA byte_450, Y
	DEY
	BPL -

	LDA #$F
	STA PPUADDR
	LDA #$B0
	STA PPUADDR
	LDY #0
	LDA byte_450, Y
	; STA ????
	.db $8D				; data truncated :(
	; ???		; $D000
	; ???		; $D001
	; ???		; $D002
	; ???		; $D003
	; ???		; $D004
	; ???		; $D005
	; ???		; $D006
	; ???		; $D007

; lost_data_D008: (lost data))
