;
; Palettes
;
Palette_Main:
	;   PPU Addr  Len
	.db $3F, $00, $20
	.db $0F, $30, $10, $00 ; BG 0
	.db $0F, $35, $25, $15 ; BG 1
	.db $0F, $39, $29, $19 ; BG 2
	.db $0F, $31, $21, $11 ; BG 3
	.db $0F, $30, $10, $00 ; SP 0
	.db $0F, $35, $25, $15 ; SP 1
	.db $0F, $39, $29, $19 ; SP 2
	.db $0F, $31, $21, $11 ; SP 3
	.db $00 ; End
