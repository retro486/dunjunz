; TODO
; keys and doors can conceal objects, so list them separately.
; only update tiles on window change - but update ALL tiles
; monster rendering pushes a tile onto erase stack
; processing erase stack compares against player windows(?)

; map data page aligns, so the following holds true:
; window y = pos >> 8
; window x = (pos >> 3) & 3
; andb #$18 then cmpd...

		include	"dragonhw.s"

fb0		equ	$0e00
fb_w		equ	32

map_w		equ	32
map_h		equ	48

vp1		equ	fb0+20*fb_w+2
vp2		equ	fb0+20*fb_w+18
vp3		equ	fb0+116*fb_w+2
vp4		equ	fb0+116*fb_w+18

		org	0
drainer_hp	rmb	1
drainer_pos	rmb	2
sizeof_drainer

		org	0
monster_hp	rmb	1
monster_pos0	rmb	2
monster_pos1	rmb	2
monster_dir	rmb	1
monster_mcount	rmb	1
monster_save0	rmb	1
monster_save1	rmb	1
sizeof_monster

		org	0
trapdoor_pos	rmb	2
trapdoor_voff	rmb	2
trapdoor_half	rmb	1
sizeof_trapdoor

		org	$0000
		setdp	$00

playerdata	macro
p\1pos		rmb	2
p\1hp		rmb	1
p\1armour	rmb	1
p\1power	rmb	1
p\1ammo		rmb	1
p\1key		rmb	1
p\1speed	rmb	1
p\1score4	rmb	1
p\1score2	rmb	1
p\1score0	rmb	1
		endm

		playerdata	1
		playerdata	2
		playerdata	3
		playerdata	4

anim_count	rmb	1

tmp0		rmb	2
tmp1		rmb	2
tmp2		rmb	2

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

		org	$2600

		orcc	#$50

		clr	reg_pia1_cra	; ddr...
		lda	#$fc
		sta	reg_pia1_ddra	; only DAC bits are outputs
		clr	reg_pia1_crb	; ddr...
		lda	#$fe
		sta	reg_pia1_ddrb	; VDG, ROMSEL & SBS as outputs
		ldd	#$343c
		sta	reg_pia0_cra	; HS disabled
		sta	reg_pia1_cra	; printer FIRQ disabled
		stb	reg_pia1_crb	; CART FIRQ disabled
		inca
		sta	reg_pia0_crb	; FS enabled hi->lo

		jsr	game_setup

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

mainloop

		lda	anim_count
		adda	#$08
		sta	anim_count
		ldb	#drainer0
		lsla
		bcc	1F
		addb	#2
1		stb	drainer_tile

		;ldd	#$e2ea
		;sta	reg_pia1_pdrb
		lda	reg_pia0_pdrb
		sync
		;stb	reg_pia1_pdrb

		; render all player windows
		ldd	p1pos
		andb	#$18
		tfr	d,u
		ldx	#vp1
		ldy	#buffer1
		jsr	render_window
		ldd	p2pos
		andb	#$18
		tfr	d,u
		ldx	#vp2
		ldy	#buffer2
		jsr	render_window
		ldd	p3pos
		andb	#$18
		tfr	d,u
		ldx	#vp3
		ldy	#buffer3
		jsr	render_window
		ldd	p4pos
		andb	#$18
		tfr	d,u
		ldx	#vp4
		ldy	#buffer4
		jsr	render_window

		; iterate over drainers
		ldu	#drainers
10		lda	drainer_hp,u
		beq	80F
		ldx	drainer_pos,u
drainer_tile	equ	*+1
		ldb	#drainer0
		stb	,x
80		leau	sizeof_drainer,u
		cmpu	#drainers_end
		blo	10B

		jsr	new_monster
		jsr	process_monsters

		lda	#$ff
		tfr	a,dp
		setdp	$ff
		sta	reg_pia0_pdrb

		; player 1 - W, S, Z, X, C, Q
		ldu	p1pos
		lda	#$7f
		sta	reg_pia0_pdrb
		lda	reg_pia0_pdra
		bita	#$10
		bne	10F
		leau	-map_w,u
		cmpu	#leveldata
		blo	90F
		bra	80F
10		lda	#$f7
		sta	reg_pia0_pdrb
		lda	reg_pia0_pdra
		bita	#$10
		bne	20F
		leau	map_w,u
		cmpu	#leveldata_end
		bhs	90F
		bra	80f
20		lda	#$fb
		sta	reg_pia0_pdrb
		lda	reg_pia0_pdra
		bita	#$20
		bne	30F
		tfr	u,d
		andb	#$1f
		cmpb	#$08
		blo	90F
		leau	-1,u
		bra	80F
30		lda	#$fe
		sta	reg_pia0_pdrb
		lda	reg_pia0_pdra
		bita	#$20
		bne	90F
		tfr	u,d
		andb	#$1f
		cmpb	#24
		bhs	90F
		leau	1,u
80		stu	p1pos
90

		; player 2 - P, L, J, K, @, H
		ldu	p2pos
		lda	#$fe
		sta	reg_pia0_pdrb
		lda	reg_pia0_pdra
		bita	#$10
		bne	10F
		leau	-map_w,u
		cmpu	#leveldata
		blo	90F
		bra	80F
10		lda	#$ef
		sta	reg_pia0_pdrb
		lda	reg_pia0_pdra
		bita	#$08
		bne	20F
		leau	map_w,u
		cmpu	#leveldata_end
		bhs	90F
		bra	80f
20		lda	#$fb
		sta	reg_pia0_pdrb
		lda	reg_pia0_pdra
		bita	#$08
		bne	30F
		tfr	u,d
		andb	#$1f
		cmpb	#$08
		blo	90F
		leau	-1,u
		bra	80F
30		lda	#$f7
		sta	reg_pia0_pdrb
		lda	reg_pia0_pdra
		bita	#$08
		bne	90F
		tfr	u,d
		andb	#$1f
		cmpb	#24
		bhs	90F
		leau	1,u
80		stu	p2pos
90

		lda	#$35
		sta	reg_pia1_crb	; disable sound mux

		; process joysticks in order:
		;  left x <,  left x >,  left y >,  left y <
		; right y <, right y >, right x >, right x <
		; leaves mux select on 0,0, ie the DAC

		; player 3 - left joystick
		ldu	p3pos
		ldd	#$3d34
		sta	reg_pia0_crb	; left joystick
		stb	reg_pia0_cra	; x axis
		lda	#$20
		sta	reg_pia1_pdra
		lda	reg_pia0_pdra	; left?
		bmi	10F
		tfr	u,d
		andb	#$1f
		cmpb	#8
		blo	10F
		leau	-1,u
10		ldd	#$ffc0
		sta	reg_pia1_pdra
		stb	reg_pia1_pdra
		lda	reg_pia0_pdra	; right?
		bpl	20F
		tfr	u,d
		andb	#$1f
		cmpb	#24
		bhs	20F
		leau	1,u
20		lda	#$3c
		sta	reg_pia0_cra	; y axis
		lda	reg_pia0_pdra	; down?
		bpl	30F
		cmpu	#leveldata_end-map_w
		bhs	30F
		leau	map_w,u
30		neg	reg_pia1_pdra
		lda	reg_pia0_pdra	; up?
		bmi	80F
		cmpu	#leveldata+map_w
		blo	80F
		leau	-map_w,u
80		stu	p3pos

		; player 4 - right joystick
		ldu	p4pos
		lda	#$35
		sta	reg_pia0_crb	; right joystick
		;
		lda	reg_pia0_pdra	; up?
		bmi	10F
		cmpu	#leveldata+map_w
		blo	10F
		leau	-map_w,u
10		ldd	#$ffc0
		sta	reg_pia1_pdra
		stb	reg_pia1_pdra
		lda	reg_pia0_pdra	; down?
		bpl	20F
		cmpu	#leveldata_end-map_w
		bhs	20F
		leau	map_w,u
20		lda	#$34
		sta	reg_pia0_cra	; x axis
		lda	reg_pia0_pdra	; right?
		bpl	30F
		tfr	u,d
		andb	#$1f
		cmpb	#24
		bhs	30F
		leau	1,u
30		neg	reg_pia1_pdra
		lda	reg_pia0_pdra	; left?
		bmi	80F
		tfr	u,d
		andb	#$1f
		cmpb	#8
		blo	80F
		leau	-1,u
80		stu	p4pos

		; due to order of polling joysticks, dac is left selected

		ldd	#$c03d
		sta	reg_pia1_pdra	; dac = sbs high value
		stb	reg_pia1_crb	; enable sound mux

		clra
		tfr	a,dp
		setdp	$00

99		jmp	mainloop

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

; render 8x8 window
; entry:
;     x -> screen
;     y -> player window buffer
;     u -> map data
; uses: tmp0, tmp1

render_window
		lda	#$08
		sta	tmp1
yloop
		lda	#$04
		sta	tmp1+1
xloop
		lda	,u+
		bmi	10F
		cmpa	,y+
		beq	20F
		sta	-1,y
10		anda	#$7f
		pshs	x,u
		ldu	#tiles_0
		jmp	[a,u]
next_tile1	puls	x,u
20		leax	1,x
		lda	,u+
		bmi	30F
		cmpa	,y+
		beq	40F
		sta	-1,y
30		anda	#$7f
		pshs	x,u
		ldu	#tiles_1
		jmp	[a,u]
next_tile0	puls	x,u
40		leax	2,x
		dec	tmp1+1
		bne	xloop
		leax	(9*fb_w)-12,x
		leau	24,u
		dec	tmp1
		bne	yloop
		rts

; initialise game for starting from level 1

game_setup

		; SAM VDG mode = G6R,G6C
		sta	reg_sam_v0c
		sta	reg_sam_v1s
		sta	reg_sam_v2s
		; SAM display offset = $0e00
		sta	reg_sam_f0s
		sta	reg_sam_f1s
		sta	reg_sam_f2s
		; VDG mode = CG6, CSS0
		lda	#$e2
		sta	reg_pia1_pdrb

		; clear screen "purple"
		ldx	#$0e00
2		ldd	#$aa20
1		sta	,x+
		decb
		bne	1B
		ldd	#$ff20
1		sta	,x+
		decb
		bne	1B
		cmpx	#$2600
		blo	2B

		; flag all players as "dead" so they get reset
		lda	#$ff
		sta	p1hp
		sta	p2hp
		sta	p3hp
		sta	p4hp
		; fall through

; initialise for next level

level_setup

		; clear monsters (-ve HP)
		ldx	#monsters
		lda	#$ff
1		sta	monster_hp,x
		leax	sizeof_monster,x
		cmpx	#monsters_end
		blo	1B

		; player start positions
		ldx	#leveldata+$016b
		;stx	p1pos
		;leax	1,x
		;stx	p2pos
		;ldx	#leveldata+$018b
		stx	p3pos
		;leax	1,x
		;stx	p4pos
		leax	8,x
		stx	p4pos
		leax	-8*map_w,x
		stx	p2pos
		leax	-8,x
		stx	p1pos

		; reset dead players' stats
		lda	p1hp
		bpl	1F
		ldd	#$0302
		std	p1armour	; and p1power
		sta	p1ammo
		clr	p1score4
		clr	p1score2
		clr	p1score0
1		lda	p2hp
		bpl	1F
		ldd	#$0103
		std	p2armour	; and p2power
		inca
		sta	p2ammo
		clr	p2score4
		clr	p2score2
		clr	p2score0
1		lda	p3hp
		bpl	1F
		ldd	#$0409
		std	p3armour	; and p3power
		lda	#$01
		sta	p3ammo
		clr	p3score4
		clr	p3score2
		clr	p3score0
1		lda	p4hp
		bpl	1F
		ldd	#$0605
		std	p4armour	; and p4power
		lda	#$02
		sta	p4ammo
		clr	p4score4
		clr	p4score2
		clr	p4score0
1

		; always start level with 99HP
		lda	#$99
		sta	p1hp
		sta	p2hp
		sta	p3hp
		sta	p4hp

		; no keys, no speedyboots
		clr	p1key
		clr	p2key
		clr	p3key
		clr	p4key
		clr	p1speed
		clr	p2speed
		clr	p3speed
		clr	p4speed

		ldy	#trapdoors
		ldu	#drainers
		ldx	#leveldata
10		lda	,x
		cmpa	#drainer0
		bne	20F
		lda	#20
		sta	,u+
		stx	,u++
		bra	80F
20		cmpa	#trapdoor
		bne	80F
		stx	trapdoor_pos,y
		pshs	x
		bsr	pos2voff
		stx	trapdoor_voff,y
		sta	trapdoor_half,y
		puls	x
		leay	sizeof_trapdoor,y
		;bra	80F
80		leax	1,x
		cmpx	#leveldata_end
		blo	10B

1		cmpu	#drainers_end
		bhs	2F
		clr	,u+
		bra	1B
2

		rts

pos2voff
		tfr	x,d
		stb	tmp0
		andb	#$e0
		lsrb
		lsrb
		lsrb
		lsrb
		ldx	#pos2yoff
		ldd	b,x
		std	tmp1
		ldb	tmp0
		andb	#7
		ldx	#mul3
		ldb	b,x
		ldx	tmp0
		clra
		lsrb
		bcc	1F
		coma
		abx
		rts

pos2yoff	fdb	0,288,576,864,1152,1440,1728,2016
mul3		fcb	0,3,6,9,12,15,18,21

player_teleport
		ldu	#teleports
		cmpx	,u
		bhi	1F
		ldx	#$ffff
1		cmpx	,u++
		blo	1B
		ldx	-2,u
		leax	-map_w,x
		rts

new_monster
next_td		equ	*+1
		ldu	#trapdoors
10		lda	[trapdoor_pos,u]
		cmpa	#trapdoor
		beq	30F
		leau	sizeof_trapdoor,u
		cmpu	#trapdoors_end
		blo	20F
		ldu	#trapdoors
20		cmpu	next_td
		bne	10B
		rts
30		stu	next_td
		ldy	#monsters
40		lda	monster_hp,y
		bmi	50F
		leay	sizeof_monster,y
		cmpy	#monsters_end
		blo	40B
		rts
50		ldx	,u
		lda	#8
		sta	monster_hp,y
		stx	monster_pos0,y
		; fall through

mon_change_dir
next_dir	equ	*+1
		lda	#$03
		inca
		anda	#$03
		sta	next_dir
		lsla
		ldx	#mon_dir_data
		ldd	a,x
		sta	monster_dir,y
		ldx	monster_pos0,y
		lda	,x
mon_update	sta	monster_save0,y
		stb	,x
		lda	#12
		sta	monster_mcount,y
		rts

do_monster
		ldx	monster_pos0,y
		lda	monster_save0,y
		ldb	,x
		sta	,x
		lda	monster_dir,y
		leax	a,x
		lda	,x
		cmpa	#door_h
		bhs	mon_change_dir
		stx	monster_pos0,y
		bra	mon_update

process_monsters
		ldy	#monsters
10		lda	monster_hp,y
		beq	80F
		dec	monster_mcount,y
		bne	80F
		bsr	do_monster
80		leay	sizeof_monster,y
		cmpy	#monsters_end
		blo	10B
		rts

mon_dir_data	fcb	-1,monster_left
		fcb	-32,monster_up0
		fcb	1,monster_right
		fcb	32,monster_down0

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -



		include	"tiles.s"

buffer1		fill	$ff,64
buffer2		fill	$ff,64
buffer3		fill	$ff,64
buffer4		fill	$ff,64

trapdoors
		rmb	8*sizeof_trapdoor
trapdoors_end

drainers
		rmb	16*sizeof_drainer
drainers_end

monsters
		rmb	24*sizeof_monster
monsters_end

		rmb	(256-*%256)%256		; page align

		include	"level01.s"
