		org $2600
		setdp 0		; assumed

boot_flag	fcc /OS/

boot_exec	lda $a000	; [$A000] points to ROM1 in CoCos
		anda #$20
		beq 10F		; dragon
		dec run_token	; coco RUN token is $8e, not $8f
10		ldx #basic_next
		ldu #$02dc
		stu $00a6
20		lda ,x+
		sta ,u+
		bne 20B
		clr boot_flag	; needed for coco
		; work around DOSplus issue where BOOT does not
		; expect to return
		ldx ,s
		ldd 1,x
		cmpd #$8344	; looks like jump to error handler?
		bne 30F
		leas 2,s
30		rts

basic_next	fcc /:/
run_token	fcb $8f
		fcc /"DUNJUNZ":/,0

		; for the people that play with disk editors...
		rzb (32-(*%32))%32
		fcc /OHAI! COME PLAY DUNJUNZ!/,13,0
		rzb (32-(*%32))%32
		fcc /THIS IS A UNIFIED BOOT BLOCK/,13
		rzb (32-(*%32))%32
		fcc /FOR DRAGON AND TANDY COCO./,13
		rzb (32-(*%32))%32
		fcc /NEAT, EH?/,13,0

		; fill rest of sector
		rzb (256-(*%256))%256
