; Tape part 1
;
; Wraps up title screen and copyright message.  Dzipped title screen is
; copied into high RAM for later use if 64K is detected, otherwise
; discarded.

; loader function pointers
load_part_ptr	equ $01e9
dunzip_ptr	equ $01eb

flag_64k	equ $03ff

		include "dragonhw.s"
		include "dunjunz.sym"
		include "tape-part2.sym"

		org $0300
		setdp 0		; assumed

start

		orcc #$50
		lds #$0300

		; use different pages for $c000-$fdff on coco3
		ldd #$3637
		std $ffa6

		; load part2
		ldx #PART2_start
		jsr [load_part_ptr]

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
		beq dunzip_title

		; copy low ram vars to $8000+
		ldx #$0000
		ldu #$8000
10		ldd ,x++
		std ,u++
		cmpx #$0500
		blo 10B

		; copy title & copyright64 dz to $8500+
		ldx #PART2_title_dz
		;ldu #$8500
10		lda ,x+
		sta ,u+
		cmpx #PART2_copyright64_dz_end
		blo 10B

dunzip_title

		sta reg_sam_tyc
		ldx #$0400
		ldd #$aaaa
10		std ,x++
		cmpx #$1c00
		blo 10B

		sta reg_sam_v0c
		sta reg_sam_v1s
		sta reg_sam_v2s
		lda #$e0
		sta reg_pia1_ddrb

		; dunzip title
		ldx #PART2_title_dz
		ldd #PART2_title_dz_end
		ldu #$0400+6*32
		jsr [dunzip_ptr]

		; dunzip copyright
		ldx #PART2_copyright_dz
		ldd #PART2_copyright_dz_end
		ldu #$0400+159*32
		jsr [dunzip_ptr]

		; load game dz
		ldx #$3700
		jsr [load_part_ptr]
		pshs x

		lda flag_64k
		beq 20F

		; tidy up where flasher was
		lda #$aa
		sta $0400
		; dunzip copyright64
		sta reg_sam_tys
		ldx #$8500+PART2_copyright64_dz-PART2_start
		ldd #$8500+PART2_copyright64_dz_end-PART2_start
		ldu #$0400+159*32+11*32
		jsr [dunzip_ptr]
		sta reg_sam_tyc

		; load music dz in page#1
		sta reg_sam_p1s
		ldd #$3637
		std $ffa2
		ldx #$4000		; $c000, mapped lower
		jsr [load_part_ptr]
		sta reg_sam_p1c
		ldd #$3a3b
		std $ffa2
		sta reg_sam_tys

		; dunzip music dz to $9500+
		tfr x,d
		ora #$80
		ldx #$c000
		ldu #$9500
		jsr [dunzip_ptr]
		sta reg_sam_tyc

		; dunzip game
20		puls d
		ldx #$3700
		ldu #CODE_start
		jsr [dunzip_ptr]
		jmp INIT_exec
