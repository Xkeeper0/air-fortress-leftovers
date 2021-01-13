; tcrf10th.nes
; ============

; -----------------------------------------
; Add NES header
	.db "NES", $1a ; identification of the iNES header
	.db 2 ; number of 16KB PRG-ROM pages
	.db 0 ; number of 8KB CHR-ROM pages

;        ++++----- Lower nybble of mapper number
;        ||||+---- 1: Ignore mirroring control or above mirroring bit; instead provide four-screen VRAM
;        |||||+--- 1: 512-byte trainer at $7000-$71FF (stored before PRG data)
;        ||||||+-- 1: Cartridge contains battery-backed PRG RAM ($6000-7FFF) or other persistent memory
;        |||||||              1: vertical (horizontal arrangement) (CIRAM A10 = PPU A10)
;        |||||||+- Mirroring: 0: horizontal (vertical arrangement) (CIRAM A10 = PPU A11)
;        ||||||||
	.db %00000010 ; mapper and mirroring
	.dsb 9, $00 ; clear the remaining bytes


; -----------------------------------------
; Add definitions
.enum $0000
.include "src/defs.asm"
.ende

; Add RAM definitions
.enum $0000
.include "src/ram.asm"
.ende

.include "src/macros.asm"

; -----------------------------------------
; Program
.base $8000
.include "src/prg.asm"

; -----------------------------------------
; Vectors
.include "src/vectors.asm"
