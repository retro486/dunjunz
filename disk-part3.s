; Main game.  Assumes DUNJ2.BIN has already been run, and that DUNJUNZ.BAS
; has CLEARed space.

		include "dunjunz.sym"

; Position at end of RAM.  Really should be INIT_end + number of dunzip
; overflow bytes + dunzip loop bytes, but no way of determining that right
; now.

		org $8000-sizeof_DUNJ3

DUNJ3_start

dunjunz_dz	includebin "dunjunz.bin.dz"

DUNJ3_exec

		orcc #$50

		ldx #dunjunz_dz
		ldu #CODE_start

dunzip
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
80		cmpu #INIT_end
		blo dunz_loop

		jmp INIT_exec

DUNJ3_end
sizeof_DUNJ3	equ *-DUNJ3_start
