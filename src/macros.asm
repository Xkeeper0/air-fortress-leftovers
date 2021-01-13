;
; Macros
;

; Convert simple X/Y coordinates to PPU addresses
; (assumes 0, 0 scroll position)
MACRO PPUPos y, x
	@temp = #$2000 + (y << 5) + x
	.db #>@temp, #<@temp
ENDM

MACRO PPUDat data
	@temp	= $
	.db @len, data
	@len	= $ - @temp - 1
ENDM


;
; Macro to set the PPU buffer address without having to
; remember all those pesky 8 bit marker referenes and such
;
MACRO SetPPUBuffer addr
	LDA #<addr
	STA PPUBufferLo
	LDA #>addr
	STA PPUBufferHi
	LDA #$1
	STA PPUBufferReady
ENDM

;
; Macro to set the PPU address
;
MACRO SetPPUAddress addr
	LDA #>addr
	STA PPUADDR
	LDA #<addr
	STA PPUADDR
ENDM

;
; Simple macro to run WaitForNMI a while
;
MACRO DelayFrames f
	LDX f
	;LDX #2
	JSR WaitXFrames
ENDM
