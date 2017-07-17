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

		org $0300

start

		orcc #$50
		lds #$0300

		; load title dz
		ldx #$1c00
		jsr [load_part_ptr]
		pshs x

		; test for 64K
		clr flag_64k
		sta reg_sam_tys
		ldd #$6c93
		std $bffe
		cmpd $bffe
		bne dunzip_title
		cmpd $3ffe
		beq dunzip_title
		com flag_64k

		; copy low ram vars to $8000+
		ldx #$0000
		ldu #$8000
10		ldd ,x++
		std ,u++
		cmpx #$0500
		blo 10B

		; copy title dz to $8500+
		ldx #$1c00
		;ldu #$8500
10		lda ,x+
		sta ,u+
		cmpx ,s
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
		puls d
		;ldx #$1c00
		ldu #$0400+6*32
		jsr [dunzip_ptr]

		; load copyright dz
		ldx #$1c00
		jsr [load_part_ptr]
		; dunzip copyright
		tfr x,d
		ldx #$1c00
		ldu #$0400+159*32
		jsr [dunzip_ptr]

		; load game dz
		ldx #$3900
		jsr [load_part_ptr]
		pshs x

		tst flag_64k
		beq 20F

		; load music dz in page#1
		sta reg_sam_p1s
		ldx #$4000
		jsr [load_part_ptr]
		; dunzip music dz to $9500+
		tfr x,d
		ldx #$4000
		ldu #$1500
		jsr [dunzip_ptr]

		sta reg_sam_p1c

		; dunzip game
20		puls d
		ldx #$3900
		ldu #CODE_start
		jsr [dunzip_ptr]
		jmp INIT_exec
