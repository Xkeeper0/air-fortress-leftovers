
.include "src/init.asm"
.include "src/interrupts.asm"
.include "src/ppu.asm"


Start:
	JSR DisableNMI
	JSR DisablePPURendering

	JSR LoadGraphics

	JSR EnablePPURendering
	JSR EnableNMI

DoNothing:
	INC $FF
	JSR u_C3A8
	JMP DoNothing

.include "src/data/palettes.asm"


.pad $C2DD, $FF
.include "src/original-code.asm"

; -----------------------------------------------
; -----------------------------------------------
; Data in various forms lives down here
; (please keep the lid closed)

