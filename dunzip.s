; dunzip
; by Ciaran Anscomb, 2011-2017
;
; Disclaimer:
; Possibly not fit for any purpose.  You're free to use, copy, modify and
; redistribute so long as I don't get the blame for anything.

; dunzip - unzip simply coded zip data

; 1iiiiiii 0nnnnnnn - repeat 128-n (1-128) bytes from current + 1i (-ve 2s cmpl)
; 1iiiiiii 1jjjjjjj nnnnnnnn - repeat 128-n (1-256) bytes from current + 1ij
; 0nnnnnnn - directly copy next 128-n (1-128) bytes

; entry: x = zip start, u = destination, [dzip_end] = end address

dunzip
dunz_loop	ldd	,x++
		bpl	dunz_run	; run of 1-128 bytes
		tstb
		bpl	dunz_7_7
dunz_14_8	lslb			; drop top bit of byte 2
		asra
		rorb			; asrd
		leay	d,u
		ldb	,x+
		bra	10F		; copy 1-256 bytes (0 == 256)
dunz_7_7	leay	a,u		; copy 1-128 bytes
10		lda	,y+
		sta	,u+
		incb
		bvc	10B		; count UP until B == 128
		bra	80F
1		ldb	,x+
dunz_run	stb	,u+
		inca
		bvc	1B		; count UP until B == 128
zdata_end	equ	* + 1
80		cmpu	<dzip_end
		blo	dunz_loop
		rts
