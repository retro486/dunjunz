; Jenky
; Ciaran Anscomb, 2017

; Simulate as much of a 76489 as needed to play a specific tune.

; 3 channels
; 2 square waves, 1 pulse wave (from table)
; 9.0kHZ samplerate

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

		include "dragonhw.s"

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

		org $9500

psg_dp		equ *>>8
		setdp psg_dp

; Entry:
; 	x = duration
; 	y = channel 3 waveform (pulse)

psg_playfrag

		ldy #psg_pulse		; channel 3 waveform
		ldu #reg_pia1_pdra

psg_core_loop

psg_c1off1	equ *+1
		ldd #$0000		; 3
psg_c1freq1	equ *+1
		addd #$0000		; 4
		std psg_c1off1		; 5
psg_c1off0	equ *+1
		ldb #$00		; 2
psg_c1freq0	equ *+1
		adcb #$00		; 2
		stb psg_c1off0		; 4
		sex			; 2
psg_c1att	equ *+1
		anda #$00		; 2
		sta psg_c1		; 4

psg_c2off1	equ *+1
		ldd #$0000		; 3
psg_c2freq1	equ *+1
		addd #$0000		; 4
		std psg_c2off1		; 5
psg_c2off0	equ *+1
		ldb #$00		; 2
psg_c2freq0	equ *+1
		adcb #$00		; 2
		stb psg_c2off0		; 4
		sex			; 2
psg_c2att	equ *+1
		anda #$00		; 2
		sta psg_c2		; 4

psg_c3off1	equ *+1
		ldd #$0000		; 3
psg_c3freq1	equ *+1
		addd #$0000		; 4
		std psg_c3off1		; 5
psg_c3off0	equ *+1
		ldb #$00		; 2
psg_c3freq0	equ *+1
		adcb #$00		; 2
		stb psg_c3off0		; 4
		lda b,y			; 5
psg_c3att	equ *+1
		anda #$00		; 2

psg_c1		equ *+1
		adda #$00		; 2
psg_c2		equ *+1
		adda #$00		; 2

		sta ,u			; 4

		leax -1,x		; 5
		bne psg_core_loop	; 3
					; total 99 cycles
					; rate = 9.0kHz

		rts

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

p_timer		fcb 0
c1_a_timer	fcb 0
c1_f_timer	fcb 0
c2_a_timer	fcb 0
c2_f_timer	fcb 0
c3_a_timer	fcb 0
c3_f_timer	fcb 0

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

song_loop

		; song
		dec p_timer
		bne 20F
song_ptr	equ *+1
		ldu #$0000
		lda ,u+
		cmpa #255
		bne 10F
		ldu #song
		lda ,u+
10		sta p_timer
		pulu x,y
		lda ,x+
		ldb ,y+
		std c1_a_timer
		stx c1_a_next
		sty c1_f_next
		pulu x,y
		lda ,x+
		ldb ,y+
		std c2_a_timer
		stx c2_a_next
		sty c2_f_next
		pulu x,y
		lda ,x+
		ldb ,y+
		std c3_a_timer
		stx c3_a_next
		sty c3_f_next
		stu song_ptr
20

		; channel 1
		dec c1_a_timer
		bne 10F
c1_a_next	equ *+1
		ldu #$0000
		pulu a,b
		sta c1_a_timer
		stb psg_c1att
		stu c1_a_next
10		dec c1_f_timer
		bne 20F
c1_f_next	equ *+1
		ldu #$0000
		pulu a,b,x
		sta c1_f_timer
		stb psg_c1freq0
		stx psg_c1freq1
		stu c1_f_next
20

		; channel 2
		dec c2_a_timer
		bne 10F
c2_a_next	equ *+1
		ldu #$0000
		pulu a,b
		sta c2_a_timer
		stb psg_c2att
		stu c2_a_next
10		dec c2_f_timer
		bne 20F
c2_f_next	equ *+1
		ldu #$0000
		pulu a,b,x
		sta c2_f_timer
		stb psg_c2freq0
		stx psg_c2freq1
		stu c2_f_next
20

		; channel 3
		dec c3_a_timer
		bne 10F
c3_a_next	equ *+1
		ldu #$0000
		pulu a,b
		sta c3_a_timer
		stb psg_c3att
		stu c3_a_next
10		dec c3_f_timer
		bne 20F
c3_f_next	equ *+1
		ldu #$0000
		pulu a,b,x
		sta c3_f_timer
		stb psg_c3freq0
		stx psg_c3freq1
		stu c3_f_next
20

		ldx #90
		jsr psg_playfrag

		lda reg_pia0_pdra
		ora #$80
		inca
		lbeq song_loop

		lda #5
		pshs a
10		lsr psg_c1att
		lsr psg_c2att
		lsr psg_c3att
		ldx #360
		jsr psg_playfrag
		dec ,s
		bne 10B

		puls a,dp,pc

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

		export play_song
play_song

		pshs dp
		lda #psg_dp
		tfr a,dp

		; wait if key held
		clr reg_pia0_pdrb
10		lda reg_pia0_pdra
		ora #$80
		inca
		bne 10B
		; leave set to detect any key

		ldb #$3d
		stb reg_pia1_crb	; enable sound mux

		jmp song_loop

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

		export reset_song
reset_song
		lda #1
		sta >p_timer
		ldu #song
		stu >song_ptr
		rts

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

		rzb 16,$ff
		rzb 112,0
psg_pulse	rzb 128,0

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

		export press_key_dz
press_key_dz	includebin "press-key.bin.dz"

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

song

		include "song.s"
