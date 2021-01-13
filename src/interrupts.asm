; -----------------------------------------------------------------------------
; If we end up here something probably went wrong, oops
IRQ:
	JSR DisableNMI
	SEC
-	BCS -
	RTI

; -----------------------------------------------------------------------------
NMI:
	JMP NMI_Original


DisableNMI:
	LDA PPUCtrlMirror
	AND #(#$FF ^ PPUCtrl_NMIEnabled)
	STA PPUCTRL
	STA PPUCtrlMirror
	RTS

EnableNMI:
	LDA PPUSTATUS						; Clear possible vblank flag
	LDA PPUCtrlMirror
	ORA #PPUCtrl_NMIEnabled
	STA PPUCtrlMirror
	STA PPUCTRL
	RTS


