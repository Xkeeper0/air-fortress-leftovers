PPUCtrlMirror:			; $0000
	.dsb 1
PPUMaskMirror:			; $0001
	.dsb 1
PPUScrollX:		; $0002
	.dsb 1
PPUScrollY:		; $0003
	.dsb 1
NMIFlag:		; $0004
	.dsb 1

JoypadState1:	; $0005
	.dsb 2
JoypadState2:	; $0007
	.dsb 2
JoypadState3:	; $0009
	.dsb 2
JoypadRepeatTimer:	; $000B
	.dsb 2


SpriteOrBG:		; $D
	.dsb 1
byte_E:		; $E
	.dsb 1
byte_F:		; $F
	.dsb 1
byte_10:		; $10
	.dsb 1
byte_11:		; $11
	.dsb 1
byte_12:		; $12
	.dsb 1
byte_13:		; $13
	.dsb 1
byte_14:		; $14
	.dsb 1
byte_15:		; $15
	.dsb 1
byte_16:		; $16
	.dsb 1
byte_17:		; $17
	.dsb 1
byte_18:		; $18
	.dsb 1
byte_19:		; $19
	.dsb 1
byte_1A:		; $1A
	.dsb 1
byte_1B:		; $1B
	.dsb 1
byte_1C:		; $1C
	.dsb 1
word_1D:		; $1D
	.dsb 2
TileEditor_SolidTileNumber:		; $1F
	.dsb 1

EditMode:		; $0020
	.dsb 1

TileEditor_CursorX:		; $21
	.dsb 1
TileEditor_CursorY:		; $22
	.dsb 1
TilePicker_CursorYX:		; $23
	.dsb 1
byte_24:		; $24
	.dsb 1
byte_25:		; $25
	.dsb 1
byte_26:		; $26
	.dsb 1
byte_27:		; $27
	.dsb 1
byte_28:		; $28
	.dsb 1
byte_29:		; $29
	.dsb 1
byte_2A:		; $2A
	.dsb 1
byte_2B:		; $2B
	.dsb 1
byte_2C:		; $2C
	.dsb 1
byte_2D:		; $2D
	.dsb 1
byte_2E:		; $2E
	.dsb 1
byte_2F:		; $2F
	.dsb 1
byte_30:		; $30
	.dsb 1
byte_31:		; $31
	.dsb 1
byte_32:		; $32
	.dsb 1
byte_33:		; $33
	.dsb 1
TileEditor_Buffer:		; $34
	; "64 bytes, 2 bits per pixel"
	.dsb 64

.pad $0074, $00
byte_74:		; $74
	.dsb 1
	.dsb 1
	.dsb 1
	.dsb 1
	.dsb 1
	.dsb 1
	.dsb 1
	.dsb 1
byte_7C:		; $7C
	.dsb 1

.pad $00b4, $00

byte_B4:		; $B4
	.dsb 1
byte_B5:		; $B5
	.dsb 1
byte_B6:		; $B6
	.dsb 1
byte_B7:		; $B7
	.dsb 1


.pad $0100, $00
StackArea: .dsb $100
SpriteDMAArea	= $200
SpriteY			= $200
SpriteIndex		= $201
SpriteAttrib	= $202
SpriteX			= $203


byte_200:		; $200
	.dsb 1
byte_201:		; $201
	.dsb 1
byte_202:		; $202
	.dsb 1
byte_203:		; $203
	.dsb 1
byte_204:		; $204
	.dsb 1
byte_205:		; $205
	.dsb 1
byte_206:		; $206
	.dsb 1
byte_207:		; $207
	.dsb 1
byte_208:		; $208
	.dsb 1
byte_209:		; $209
	.dsb 1
byte_20A:		; $20A
	.dsb 1
byte_20B:		; $20B
	.dsb 1
byte_20C:		; $20C
	.dsb 1
byte_20D:		; $20D
	.dsb 1
byte_20E:		; $20E
	.dsb 1
byte_20F:		; $20F
	.dsb 1
byte_210:		; $210
	.dsb 1
byte_211:		; $211
	.dsb 1
byte_212:		; $212
	.dsb 1
byte_213:		; $213
	.dsb 1
byte_214:		; $214
	.dsb 1
byte_215:		; $215
	.dsb 1
byte_216:		; $216
	.dsb 1
byte_217:		; $217
	.dsb 1
byte_218:		; $218
	.dsb 1
byte_219:		; $219
	.dsb 1
byte_21A:		; $21A
	.dsb 1
byte_21B:		; $21B
	.dsb 1
byte_21C:		; $21C
	.dsb 1
byte_21D:		; $21D
	.dsb 1
byte_21E:		; $21E
	.dsb 1
byte_21F:		; $21F
	.dsb 1
byte_220:		; $220
	.dsb 1
byte_221:		; $221
	.dsb 1
byte_222:		; $222
	.dsb 1
byte_223:		; $223
	.dsb 1
byte_224:		; $224
	.dsb 1
byte_225:		; $225
	.dsb 1
byte_226:		; $226
	.dsb 1
byte_227:		; $227
	.dsb 1
byte_228:		; $228
	.dsb 1
byte_229:		; $229
	.dsb 1
byte_22A:		; $22A
	.dsb 1
byte_22B:		; $22B
	.dsb 1
byte_22C:		; $22C
	.dsb 1
byte_22D:		; $22D
	.dsb 1
byte_22E:		; $22E
	.dsb 1
byte_22F:		; $22F
	.dsb 1


.pad $0300, $00

byte_300:		; $300
	.dsb 1


.pad $0400, $00

byte_400:		; $400
	.dsb $10
byte_410:		; $410
	.dsb $40
byte_450:		; $450
	.dsb 1



; ----------------------------------------------------------
.pad $07F0, $00
; PPUCtrlMirror:  .dsb 1
; PPUMaskMirror:  .dsb 1
PPUBufferReady:	.dsb 1
PPUBufferLo:	.dsb 1
PPUBufferHi:	.dsb 1

TempAddrLo:		.dsb 1
TempAddrHi:		.dsb 1






; ----------------------------------------------------------
; PPU registers
; $2000-$2007

PPUCTRL    = $2000
PPUMASK    = $2001
PPUSTATUS  = $2002
OAMADDR    = $2003
OAMDATA    = $2004
PPUSCROLL  = $2005
PPUADDR    = $2006
PPUDATA    = $2007

; APU registers and joypad registers
;  $4000-$4015         $4016-$4017

SQ1_VOL    = $4000
SQ1_SWEEP  = $4001
SQ1_LO     = $4002
SQ1_HI     = $4003

SQ2_VOL    = $4004
SQ2_SWEEP  = $4005
SQ2_LO     = $4006
SQ2_HI     = $4007

TRI_LINEAR = $4008
_APU_TRI_UNUSED = $4009
TRI_LO     = $400a
TRI_HI     = $400b

NOISE_VOL  = $400c
_APU_NOISE_UNUSED = $400d
NOISE_LO   = $400e
NOISE_HI   = $400f

DMC_FREQ   = $4010
DMC_RAW    = $4011
DMC_START  = $4012
DMC_LEN    = $4013

OAM_DMA    = $4014

SND_CHN    = $4015

JOY1       = $4016
JOY2       = $4017

byte_4018  = $4018
byte_4019  = $4019
byte_401E  = $401E









; Used for the clear-one-tile-row function because im lazy
ClearRowPPUHi:		.dsb 1
ClearRowPPULo:		.dsb 1
ClearRowPPULen:		.dsb 1
ClearRowPPUChar:	.dsb 1


; --------------------------------------
; End of RAM

; PPU registers
; $2000-$2007

PPUCTRL    = $2000
PPUMASK    = $2001
PPUSTATUS  = $2002
OAMADDR    = $2003
OAMDATA    = $2004
PPUSCROLL  = $2005
PPUADDR    = $2006
PPUDATA    = $2007

; APU registers and joypad registers
;  $4000-$4015         $4016-$4017

SQ1_VOL    = $4000
SQ1_SWEEP  = $4001
SQ1_LO     = $4002
SQ1_HI     = $4003

SQ2_VOL    = $4004
SQ2_SWEEP  = $4005
SQ2_LO     = $4006
SQ2_HI     = $4007

TRI_LINEAR = $4008
_APU_TRI_UNUSED = $4009
TRI_LO     = $400a
TRI_HI     = $400b

NOISE_VOL  = $400c
_APU_NOISE_UNUSED = $400d
NOISE_LO   = $400e
NOISE_HI   = $400f

DMC_FREQ   = $4010
DMC_RAW    = $4011
DMC_START  = $4012
DMC_LEN    = $4013

OAM_DMA    = $4014

SND_CHN    = $4015

JOY1       = $4016
JOY2       = $4017
