; Dunjunz - remade for the Dragon 32/64
; Copyright (c) 2017 Ciaran Anscomb
;
; See COPYING file for redistribution conditions.

; Title screen and 64K setup.

		include "dragonhw.s"

flag_64k	equ $03ff

		org $3000

title_dz	includebin "title.bin.dz"
title_dz_end
copyright_dz	includebin "copyright.bin.dz"
copyright_dz_end
copyright64_dz	includebin "copyright64.bin.dz"
copyright64_dz_end
dunj64_dz	includebin "dunj64.bin.dz"
dunj64_dz_end

DUNJ2_exec

		pshs cc
		orcc #$50

		ldx #$0e00
		ldd #$aaaa
10		std ,x++
		cmpx #$2600
		blo 10B

		lda #$e0
		sta reg_pia1_ddrb
		sta reg_sam_v0c
		sta reg_sam_v1s
		sta reg_sam_v2s
		sta reg_sam_f0s
		sta reg_sam_f1s
		sta reg_sam_f2s
		sta reg_sam_f3c

		; dunzip title
		ldx #title_dz
		ldd #title_dz_end
		ldu #$0e00+6*32
		bsr dunzip
		; dunzip copyright
		;ldx #copyright_dz
		ldd #copyright_dz_end
		ldu #$0e00+159*32
		bsr dunzip

		; test for 64K
		clr flag_64k
		sta reg_sam_tys
		lda $0062
		ldb $8063
		coma		; a != [$0062]
		comb		; b != [$8063]
		std $8062
		cmpd $8062
		bne no_64k	; didn't write
		cmpd $0062
		beq no_64k	; *did* shadow write
		com flag_64k
no_64k

		lda flag_64k
		beq 20F

		; dunzip copyright64
		ldx #copyright64_dz
		ldd #copyright64_dz_end
		ldu #$0e00+159*32+11*32
		bsr dunzip

		; copy title dz to $8500+
		ldx #title_dz
		ldu #$8500
10		lda ,x+
		sta ,u+
		cmpx #title_dz_end
		blo 10B

		; dunzip dunj64
		ldx #dunj64_dz
		ldd #dunj64_dz_end
		ldu #$9500
		bsr dunzip

20		sta reg_sam_tyc

		puls cc,pc

dunzip		pshs d
dunz_loop	ldd ,x++
		bpl dunz_run	; run of 1-128 bytes
		tstb
		bpl dunz_7_7
dunz_14_8	lslb		; drop top bit of byte 2
		asra
		rorb		; asrd
		leay d,u
		ldb ,x+
		bra 10F		; copy 1-256 bytes (0 == 256)
dunz_7_7	leay a,u	; copy 1-128 bytes
10		lda ,y+
		sta ,u+
		incb
		bvc 10B		; count UP until B == 128
		bra 80F
1		ldb ,x+
dunz_run	stb ,u+
		inca
		bvc 1B		; count UP until B == 128
80		cmpx ,s
		blo dunz_loop
		puls x,pc

DUNJ2_end
