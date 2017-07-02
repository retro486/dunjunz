
; Many game specifics are now noted in the "Serious business" chapter of
; the development diary (dunjunz.md).  If in doubt, consult that!

; tile position
;  - address of a tile
; tile
;  - bit 7 = blocking flag
;  - bits 0-6 = object id (or zero for floor)
; object
;  - items, drainers, trapdoors, keys, exit
;  - rules:
;    - drainers always on top of list (blocking flag stops shots)
;    - teleports always on bottom of list
;    - trapdoors always on bottom of list
;  - object ids are collected into easily-comparable ranges

; player sprites are rendered after objects.  bones are just a specialised
; player sprite.  shots specifically check against player locations; need
; to to shoot players and block shots with bones.

; TODO
; keys and doors can conceal objects, so list them separately.
; only update tiles on window change - but update ALL tiles
; monster rendering pushes a tile onto erase stack
; processing erase stack compares against player windows(?)

; maybe draw tiles in pairs: always left first,
; render routine stores the shared byte output in direct page.

; map data page aligns, so the following holds true:
; window y = pos >> 8
; window x = (pos >> 3) & 3
; andb #$18 then cmpd...

; er does resurrection cross really increase armour?  no!

; PLAYER STATE
; -3 = draw stones & floors
; 	state = -2
; -2 = draw objects
; 	state = -1
; -1 = finished moving
; 	set new position
; 	cache covered tile metadata
; 	state = 0 AND FALL THROUGH
; 0 = ready
; 	draw player sprite 0
; 	controls scanned, if moving, state = 1 or -3
; 1 = moving
; 	redraw covered tile
; 	draw player sprite 1
; 	state = 2
; 2 = moving
; 	redraw covered tile
; 	draw player sprite 2
; 	state = 3
; 3 = finished moving
; 	redraw covered tile
; 	GOTO state = -3

		include	"dragonhw.s"
		include "objects.s"

fb0		equ $0c00	; framebuffer base
fb_w		equ 32		; framebuffer line width
fb_h		equ 192		; framebuffer height
sizeof_fb	equ fb_w*fb_h
fb0_top		equ fb0+sizeof_fb

map_w		equ 32
map_h		equ 48
sizeof_map	equ map_w*map_h

; tile dimensions in pixels.

tile_w		equ 12
tile_h		equ 9

vp1		equ fb0+20*fb_w+1
vp2		equ fb0+20*fb_w+15
vp3		equ fb0+100*fb_w+1
vp4		equ fb0+100*fb_w+15

; viewport dimensions in tiles.  VERY unlikely to ever change.  if they
; do, many other things would need reviewing (and become less efficient).

vp_tiles_w	equ 8
vp_tiles_h	equ 8
sizeof_vp_tiles	equ vp_tiles_w*vp_tiles_h

; viewport dimensions in pixels, calculated from above.

vp_w		equ (vp_tiles_w*tile_w)/8
vp_h		equ vp_tiles_h*tile_h

; offset from top-left byte of viewport to immediately after last byte in
; last line.  used for fast stack based vp clear.

vp_voff_end	equ (vp_h-1)*fb_w+vp_w

; counts for things that need separate tracking

max_doors	equ 20
max_keys	equ 20
max_items	equ 30		; including exit
max_trapdoors	equ 8		; *must* be this amount of trapdoors
max_monsters	equ 24		; needn't all be active at once

; generic object structure
; drainers: always at top of list
; teleports: always at bottom of list (so safe to reuse "link")
; trapdoors: always at bottom of list

; don't actually need to track the grid pos here, just the window
; position.

		org 0
obj_winpos	rmb 2
obj_type	rmb 1
obj_voff	rmb 2		; precalc viewport offset
obj_render	rmb 2		; render function
obj_data	rmb 1
obj_link	rmb 1
sizeof_object

; object data (and sometimes link) used for different purposes depending
; on object type:

obj_door_id	equ obj_data	; key: index of door it opens
obj_drainer_hp	equ obj_data	; hits remaining until destroyed
obj_tport_dest	equ obj_data	; teleport destination tile

		org 0
sprite_pos	rmb 2
sprite_hp	rmb 1
sprite_winpos	rmb 2
sprite_voff	rmb 2	; used for undraw
sprite_undraw	rmb 2	; draw routine for covered item
sizeof_sprite

		org 0
		rmb sizeof_sprite
monster_dir	rmb 1
monster_mcount	rmb 1
monster_save0	rmb 1
sizeof_monster

		org 0
		rmb sizeof_sprite
plr_next_winpos	rmb 2
plr_redraw	rmb 1	; 1 = clear, 0 = draw, -ve = no action
plr_armour	rmb 1
plr_power	rmb 1
plr_ammo	rmb 1
plr_key		rmb 1	; object id of key
plr_speed	rmb 1
plr_score4	rmb 1
plr_score2	rmb 1
plr_score0	rmb 1
sizeof_player

; player defaults

		org 0
plr_dfl_pos	rmb 2
plr_dfl_armour	rmb 1
plr_dfl_power	rmb 1
plr_dfl_ammo	rmb 1
sizeof_player_defaults

; trapdoors let monsters through, they're constant background tiles, but
; we also keep a list of their positions to iterate over quickly.

		org 0
trapdoor_pos	rmb 2
trapdoor_voff	rmb 2
sizeof_trapdoor

		org $0000
		setdp $00

player1		rmb sizeof_player
player2		rmb sizeof_player
player3		rmb sizeof_player
player4		rmb sizeof_player

level		rmb 1

anim_count	rmb 1

dzip_end
tmp0		rmb 2
tmp1		rmb 2
tmp2		rmb 2

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

		org $2400

		jmp game_setup

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

mainloop

		; two-frame animations toggle every 8 frames.
		; this will cause top bit of anim_count to reflect that.
		lda anim_count
		adda #16
		beq 10F
		bvc 30F
		ldx #draw_drainer0_a
		ldu #draw_drainer0_b
		bra 20F
10		ldx #draw_drainer1_a
		ldu #draw_drainer1_b
20		stx mod_drainer_a
		stu mod_drainer_b
30		sta anim_count

		; render all player windows
		ldu #player1
		ldx #vp1
		jsr render_window
		ldu #player2
		ldx #vp2
		jsr render_window
		ldu #player3
		ldx #vp3
		jsr render_window
		ldu #player4
		ldx #vp4
		jsr render_window

		; spawn new monsters
		jsr	new_monster
		; move the existing ones
		jsr	process_monsters

		; keyboard & joystick scanning - will hit the PIAs a lot,
		; so set DP
		lda	#$ff
		tfr	a,dp
		setdp	$ff
		sta	reg_pia0_pdrb

		; check player keys in order: magic, up, down, right, left,
		; fire.  only one key at a time!  i think in the case of
		; joysticks, fire must be checked first.

		; player 1 - (C), W, S, X, Z, (Q)
		ldu #player1
		lda plr_redraw,u
		bpl 90F
		ldx sprite_pos,u
		; p1 magic: 'C'
		ldd #$f704
		sta reg_pia0_pdrb
		bitb reg_pia0_pdra
		bne 5F
		; XXX p1 pressed magic
		bra 90F
		; p1 up: 'W'
5		ldd #$7f10
		sta reg_pia0_pdrb
		bitb reg_pia0_pdra
		bne 10F
		leax -map_w,x
		cmpx #leveldata
		blo 90F
		bra 80F
		; p1 down: 'S'
10		ldd #$f710
		sta reg_pia0_pdrb
		bitb reg_pia0_pdra
		bne 20F
		leax map_w,x
		cmpx #leveldata_end
		bhs 90F
		bra 80f
		; p1 right: 'X'
20		ldd #$fe20
		sta reg_pia0_pdrb
		bitb reg_pia0_pdra
		bne 30F
		tfr x,d
		andb #$1f
		cmpb #24
		bhs 90F
		leax 1,x
		bra 80F
		; p1 left: 'Z'
30		ldd #$fb20
		sta reg_pia0_pdrb
		bitb reg_pia0_pdra
		bne 40F
		tfr x,d
		andb #$1f
		cmpb #$08
		blo 90F
		leax -1,x
		bra 80F
		; p1 fire: 'Q'
40		ldd #$fd10
		sta reg_pia0_pdrb
		bitb reg_pia0_pdra
		bne 90F
		; XXX p1 pressed fire
		bra 90F

80
		stx sprite_pos,u
		jsr check_pickups
90

		; player 2 - (@), P, L, K, J, (H)
		ldu #player2
		lda plr_redraw,u
		bpl 90F
		ldx sprite_pos,u
		; p2 magic: 'H'
		ldd #$fe08
		sta reg_pia0_pdrb
		bitb reg_pia0_pdra
		bne 5F
		; XXX p2 pressed magic
		bra 90F
		; p2 up: 'P'
5		ldd #$fe10
		sta reg_pia0_pdrb
		bitb reg_pia0_pdra
		bne 10F
		leax -map_w,x
		cmpx #leveldata
		blo 90F
		bra 80F
		; p2 down: 'L'
10		ldd #$ef08
		sta reg_pia0_pdrb
		bitb reg_pia0_pdra
		bne 20F
		leax map_w,x
		cmpx #leveldata_end
		bhs 90F
		bra 80f
		; p2 right: 'K'
20		ldd #$f708
		sta reg_pia0_pdrb
		bitb reg_pia0_pdra
		bne 30F
		tfr x,d
		andb #$1f
		cmpb #24
		bhs 90F
		leax 1,x
		bra 80F
		; p2 left: 'J'
30		ldd #$fb08
		sta reg_pia0_pdrb
		bitb reg_pia0_pdra
		bne 40F
		tfr x,d
		andb #$1f
		cmpb #$08
		blo 90F
		leax -1,x
		bra 80F
		; p2 fire: '@'
40		ldd #$fe04
		sta reg_pia0_pdrb
		bitb reg_pia0_pdra
		bne 90F
		; XXX p2 pressed fire
		bra 90F

80
		stx sprite_pos,u
		jsr check_pickups
90

		lda	#$35
		sta	reg_pia1_crb	; disable sound mux

		; process joysticks in order:
		;  left x <,  left x >,  left y >,  left y <
		; right y <, right y >, right x >, right x <
		; leaves mux select on 0,0, ie the DAC

		; player 3 - left joystick
		ldu #player3
		lda plr_redraw,u
		bpl 90F
		ldx sprite_pos,u
		ldd #$3d34
		sta reg_pia0_crb	; left joystick
		stb reg_pia0_cra	; x axis
		lda #$20
		sta reg_pia1_pdra
		lda reg_pia0_pdra	; left?
		bmi 10F
		tfr x,d
		andb #$1f
		cmpb #8
		blo 90F
		leax -1,x
		bra 80F
10		ldd #$ffc0
		sta reg_pia1_pdra
		stb reg_pia1_pdra
		lda reg_pia0_pdra	; right?
		bpl 20F
		tfr x,d
		andb #$1f
		cmpb #24
		bhs 90F
		leax 1,x
		bra 80F
20		lda #$3c
		sta reg_pia0_cra	; y axis
		lda reg_pia0_pdra	; down?
		bpl 30F
		leax map_w,x
		cmpx #leveldata_end
		bhs 90F
		bra 80F
30		neg reg_pia1_pdra
		lda reg_pia0_pdra	; up?
		bmi 90F
		leax -map_w,x
		cmpx #leveldata
		blo 90F
80
		stx sprite_pos,u
		jsr check_pickups
90

		; player 4 - right joystick
		ldu #player4
		lda plr_redraw,u
		bpl 90F
		ldx sprite_pos,u
		ldd #$353c
		sta reg_pia0_crb	; right joystick
		stb reg_pia0_cra	; y axis
		lda reg_pia0_pdra	; up?
		bmi 10F
		leax -map_w,x
		cmpx #leveldata
		blo 90F
		bra 80F
10		ldd #$ffc0
		sta reg_pia1_pdra
		stb reg_pia1_pdra
		lda reg_pia0_pdra	; down?
		bpl 20F
		leax map_w,x
		cmpx #leveldata_end
		bhs 90F
		bra 80F
20		lda #$34
		sta reg_pia0_cra	; x axis
		lda reg_pia0_pdra	; right?
		bpl 30F
		tfr x,d
		andb #$1f
		cmpb #24
		bhs 90F
		leax 1,x
		bra 80F
30		neg reg_pia1_pdra
		lda reg_pia0_pdra	; left?
		bmi 90F
		tfr x,d
		andb #$1f
		cmpb #8
		blo 90F
		leax -1,x
80
		stx sprite_pos,u
		jsr check_pickups
90

		lda #$34
		sta reg_pia0_cra	; mux sel 0 = 0
		ldd #$c03d
		sta reg_pia1_pdra	; dac = sbs high value
		stb reg_pia1_crb	; enable sound mux

		clra
		tfr a,dp
		setdp $00

		lda player1+sprite_hp
		bne 99F
		lda player2+sprite_hp
		bne 99F
		lda player3+sprite_hp
		bne 99F
		lda player4+sprite_hp
		beq game_over

99		jmp mainloop

game_over
		jmp [$bffe]

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

; render 8x8 window
; entry:
;     x -> screen
;     u -> player struct
; uses: tmp0, tmp1

; plr_redraw:
;      1 - update viewport
;      0 - update player winpos
;     -1 - do nothing

render_window
		lda plr_redraw,u
		bmi draw_objects
		deca
		sta plr_redraw,u
		beq update_window
		ldd plr_next_winpos,u
		std sprite_winpos,u
		rts

update_window
		ldu plr_next_winpos,u
		lda #vp_tiles_h
		sta tmp1
yloop
		lda #vp_tiles_w/2
		sta tmp1+1
xloop
		lda ,u+
		; don't dereference OID <= 0
		beq 10F
		bpl 20F
10		pshs x,u
		ldu #tiles_a
		jsr [a,u]
		puls x,u
		;
20		leax 1,x
		lda ,u+
		; don't dereference OID <= 0
		beq 30F
		bpl 40F
30		pshs x,u
		ldu #tiles_b
		jsr [a,u]
		puls x,u
		;
40		leax 2,x
		dec tmp1+1
		bne xloop
		leax (9*fb_w)-12,x
		leau map_w-vp_tiles_w,u
		dec tmp1
		bne yloop
		rts

draw_objects
		ldu #objects
10		lda obj_type,u
		beq 50F
		ldd obj_winpos,u
		cmpd player1+sprite_winpos
		bne 20F
		ldd obj_voff,u
		ldx #vp1
		leax d,x
		jsr [obj_render,u]
		ldd obj_winpos,u
20		cmpd player2+sprite_winpos
		bne 30F
		ldd obj_voff,u
		ldx #vp2
		leax d,x
		jsr [obj_render,u]
		ldd obj_winpos,u
30		cmpd player3+sprite_winpos
		bne 40F
		ldd obj_voff,u
		ldx #vp3
		leax d,x
		jsr [obj_render,u]
		ldd obj_winpos,u
40		cmpd player4+sprite_winpos
		bne 50F
		ldd obj_voff,u
		ldx #vp4
		leax d,x
		jsr [obj_render,u]
50		leau sizeof_object,u
		cmpu #objects_end
		blo 10B
		rts

; initialise game for starting from level 1

game_setup

		; flag all players as "dead" so they get reset
		lda #$ff
		sta player1+sprite_hp
		sta player2+sprite_hp
		sta player3+sprite_hp
		sta player4+sprite_hp
		; level -1: will be incremented before use
		sta level

		ldd #reset_hook
		std $0072
		lda #$55
		sta $0071

reset_hook	nop

		orcc #$50
		lds #$0600
		sta $ffdf

		clr reg_pia1_cra	; ddr...
		lda #$fc
		sta reg_pia1_ddra	; only DAC bits are outputs
		clr reg_pia1_crb	; ddr...
		lda #$fe
		sta reg_pia1_ddrb	; VDG, ROMSEL & SBS as outputs
		ldd #$343c
		sta reg_pia0_cra	; HS disabled
		sta reg_pia1_cra	; printer FIRQ disabled
		stb reg_pia1_crb	; CART FIRQ disabled
		inca
		sta reg_pia0_crb	; FS enabled hi->lo

		; SAM VDG mode = G6R,G6C
		sta	reg_sam_v0c
		sta	reg_sam_v1s
		sta	reg_sam_v2s
		; SAM display offset = $0c00
		sta	reg_sam_f0c
		sta	reg_sam_f1s
		sta	reg_sam_f2s
		; VDG mode = CG6, CSS0
		lda	#$e2
		sta	reg_pia1_pdrb

		clr anim_count

		; unpack play screen
		ldx #fb0_top
		stx dzip_end
		ldu #fb0
		ldx #play_screen_dz
		jsr dunzip

; initialise for next level

level_setup

		; clear monsters (-ve HP)
		ldx #monsters
		lda #$ff
1		sta sprite_hp,x
		leax sizeof_monster,x
		cmpx #monsters_end
		blo 1B

		; setup players (restore defaults if dead)
		ldu #player1
		ldy #player1_defaults
		jsr player_setup
		leau sizeof_player,u
		leay sizeof_player_defaults,y
		jsr player_setup
		leau sizeof_player,u
		leay sizeof_player_defaults,y
		jsr player_setup
		leau sizeof_player,u
		leay sizeof_player_defaults,y
		jsr player_setup

		ldu #levels
		lda level
		inca
		sta level
		lsla
		ldu a,u

		; u -> level packed bitmap
		ldy #leveldata
		; y -> current level bytemap
		lda #192
		sta tmp0
10		lda #8
		sta tmp0+1
		lda ,u+
20		ldb #floor
		lsla
		bcc 30F
		ldb #stone
30		stb ,y+
		dec tmp0+1
		bne 20B
		dec tmp0
		bne 10B

		; u -> level door list
		; y -> current door list
		lda #max_doors
		sta tmp0
		ldb #$ff
		stb tmp0+1
10		lda #door_h
		ldx ,u++
		beq 30F
		bpl 20F
		leax -$8000,x
		lda #door_v
20		ldb tmp0+1
		incb
		stb tmp0+1
		bsr place_object
30		dec tmp0
		bne 10B

		; u -> level key list
		lda #max_keys
		sta tmp0
10		ldx ,u++
		beq 30F
		lda #key
		ldb tmp0+1
		incb
		stb tmp0+1
		bsr place_object
30		dec tmp0
		bne 10B

		; u -> level trapdoor list
		; XXX also populate current trapdoor list
		lda #max_trapdoors
		sta tmp0
10		ldx ,u++
		beq 30F
		lda #trapdoor
		ldb tmp0+1
		incb
		stb tmp0+1
		bsr place_object
30		dec tmp0
		bne 10B

		; u -> level item list
		lda #max_items
		sta tmp0
10		ldx ,u
		beq 30F
		lda 2,u
		ldb tmp0+1
		incb
		stb tmp0+1
		bsr place_object
30		leau 3,u
		dec tmp0
		bne 10B

		; clear any remaining objects
		; y -> object list
		leay sizeof_object,y
10		cmpy #objects_end
		bhs 80F
		clr ,y+
		bra 10B
80

		jmp mainloop

		; x = pos
		; a = type
		; b = oid
		; returns y -> object
place_object
		leax leveldata,x
		pshs a,x
		stb ,x		; store oid in map
		lda #sizeof_object
		mul
		ldx #objects
		leay d,x	; y -> object
		puls a
		sta obj_type,y
		ldx #tiles_a
		ldb 1,s
		lsrb
		bcc 10F
		ldx #tiles_b
10		ldx a,x
		stx obj_render,y
		ldd ,s
		andb #$18
		std obj_winpos,y
		puls d

pos2voff
		;pshs x
		;tfr x,d
		lslb
		rola
		lslb
		rola
		lslb
		rola
		lslb
		lslb
		lslb
		rola
		lslb
		rola
		lslb
		rola
		lsla
		anda #$7e
		ldx #pos2grid
		ldd a,x
		std obj_voff,y
		rts
		;puls x,pc

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

; set up player.  if player is dead, restore default stats and clear
; score.  always restore to 99 health.  falls through to check_pickups.

; entry:
;     u -> player struct
;     y -> player defaults

player_setup
		ldd plr_dfl_pos,y
		addd #leveldata		; index into map
		std sprite_pos,u
		andb #$18
		std plr_next_winpos,u
		clr plr_key,u		; no key
		clr plr_speed,u		; no speedyboots
		lda sprite_hp,u
		bpl 1F
		; reset player stats if dead
		ldd plr_dfl_armour,y	; armour & power
		std plr_armour,u
		lda plr_dfl_ammo,y	; ammo
		sta plr_ammo,u
		clr plr_score4,u
		clr plr_score2,u
		clr plr_score0,u
		; always reset health
1		ldd #$9902
		sta sprite_hp,u
		decb
		stb plr_redraw,u
		; fall through

; check player against map for pickups, keys, etc.  don't call this every
; loop, only when a player first enters a map square.

; entry:
;     u -> player struct

check_pickups
		ldx sprite_pos,u
		lda ,x
		beq 10F			; floor - no action
10		ldb #$fe		; blocking tile
		;stb ,x

		; check if player window need redrawn
		ldx #player1
		ldd sprite_pos,u
		andb #$18
		cmpd sprite_winpos,u
		beq 20F
		std plr_next_winpos,u
		lda #1
		sta plr_redraw,u
		sta sprite_winpos,u	; invalidate
20
		rts

		; u -> player
		; y -> object
player_teleport
		ldd obj_tport_dest,y
		std sprite_pos,u
		rts

player1_defaults
		fdb	$016b		; plr_dfl_pos
		fcb	3		; plr_dfl_armour
		fcb	2		; plr_dfl_power
		fcb	3		; plr_dfl_ammo
player2_defaults
		fdb	$016c		; plr_dfl_pos
		fcb	1		; plr_dfl_armour
		fcb	3		; plr_dfl_power
		fcb	2		; plr_dfl_ammo
player3_defaults
		fdb	$018b		; plr_dfl_pos
		fcb	4		; plr_dfl_armour
		fcb	9		; plr_dfl_power
		fcb	1		; plr_dfl_ammo
player4_defaults
		fdb	$018c		; plr_dfl_pos
		fcb	6		; plr_dfl_armour
		fcb	5		; plr_dfl_power
		fcb	2		; plr_dfl_ammo

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

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
40		lda	sprite_hp,y
		bmi	50F
		leay	sizeof_monster,y
		cmpy	#monsters_end
		blo	40B
		rts
50		ldx	,u
		lda	#9
		sta	sprite_hp,y
		stx	sprite_pos,y
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
		ldx	sprite_pos,y
		lda	,x
mon_update	sta	monster_save0,y
		stb	,x
		lda	#12
		sta	monster_mcount,y
		rts

do_monster
		ldx	sprite_pos,y
		lda	monster_save0,y
		ldb	,x
		sta	,x
		lda	monster_dir,y
		leax	a,x
		lda	,x
		cmpa	#door_h
		bhs	mon_change_dir
		stx	sprite_pos,y
		bra	mon_update

process_monsters
		ldy	#monsters
10		lda	sprite_hp,y
		bmi	80F
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

		include "dunzip.s"

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

; tile grid metadata.  offsets into viewport.

POS2GRID_ELEM	macro
		fdb	(\1)*tile_h*fb_w+((\2)*tile_w)/8
		endm

POS2GRID_ROW	macro
		POS2GRID_ELEM (\1),0
		POS2GRID_ELEM (\1),1
		POS2GRID_ELEM (\1),2
		POS2GRID_ELEM (\1),3
		POS2GRID_ELEM (\1),4
		POS2GRID_ELEM (\1),5
		POS2GRID_ELEM (\1),6
		POS2GRID_ELEM (\1),7
		endm

pos2grid
		POS2GRID_ROW 0
		POS2GRID_ROW 1
		POS2GRID_ROW 2
		POS2GRID_ROW 3
		POS2GRID_ROW 4
		POS2GRID_ROW 5
		POS2GRID_ROW 6
		POS2GRID_ROW 7

; the old way of doing the above

	if 0
pos2yoff	fdb	0*tile_h*fb_w
		fdb	1*tile_h*fb_w
		fdb	2*tile_h*fb_w
		fdb	3*tile_h*fb_w
		fdb	4*tile_h*fb_w
		fdb	5*tile_h*fb_w
		fdb	6*tile_h*fb_w
		fdb	7*tile_h*fb_w
mul3		fcb	0,3,6,9,12,15,18,21
	endif

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

levels
		fdb level1,level2,level3,level4
		fdb level5,level6,level7,level8
		fdb level9,level10,level11,level12
		fdb level13,level14,level15,level16
		fdb level17,level18,level19,level20
		fdb level21,level22,level23,level24

level1		includebin "level01.bin"
level2		includebin "level02.bin"
level3		includebin "level03.bin"
level4		includebin "level04.bin"
level5		includebin "level05.bin"
level6		includebin "level06.bin"
level7		includebin "level07.bin"
level8		includebin "level08.bin"
level9		includebin "level09.bin"
level10		includebin "level10.bin"
level11		includebin "level11.bin"
level12		includebin "level12.bin"
level13		includebin "level13.bin"
level14		includebin "level14.bin"
level15		includebin "level15.bin"
level16		includebin "level16.bin"
level17		includebin "level17.bin"
level18		includebin "level18.bin"
level19		includebin "level19.bin"
level20		includebin "level20.bin"
level21		includebin "level21.bin"
level22		includebin "level22.bin"
level23		includebin "level23.bin"
level24		includebin "level24.bin"

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

TILE_BLOCKING	macro
		fdb draw_door_v_\1
		fdb draw_door_h_\1
mod_stone_\1	fdb draw_stone01_\1
		endm

TILE_LIST	macro
		fdb draw_floor_\1
		fdb draw_exit_\1
		fdb draw_trapdoor_\1
		fdb jmp_drainer_\1
		fdb draw_money_\1
		fdb draw_food_\1
		fdb draw_tport_\1
		fdb draw_power_\1
		fdb draw_armour_\1
		fdb draw_potion_\1
		fdb draw_weapon_\1
		fdb draw_cross_\1
		fdb draw_speed_\1
		fdb draw_key_\1
		endm

mod_drainer_a	equ *+1
jmp_drainer_a	jmp draw_drainer0_a
mod_drainer_b	equ *+1
jmp_drainer_b	jmp draw_drainer0_b

		TILE_BLOCKING a
tiles_a		TILE_LIST a
		TILE_BLOCKING b
tiles_b		TILE_LIST b

	if 0

SPRITE_ANIM	macro
\1_a		fdb \1_a0
		fdb \1_a1
		fdb \1_a2
\1_b		fdb \1_b0
		fdb \1_b1
		fdb \1_b2
		endm

anim_p1_up0
		fdb draw_monster_up0_

		SPRITE_FRAMES "draw_monster_up0"
		SPRITE_FRAMES "draw_monster_up1"
		SPRITE_FRAMES "draw_monster_down0"
		SPRITE_FRAMES "draw_monster_down1"
		SPRITE_FRAMES "draw_monster_left0"
		SPRITE_FRAMES "draw_monster_left1"
		SPRITE_FRAMES "draw_monster_right0"
		SPRITE_FRAMES "draw_monster_right1"

	endif

		include "tiles.s"
		include "sprites.s"

play_screen_dz	includebin "play-screen.bin.dz"

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

trapdoors	rmb max_trapdoors*sizeof_trapdoor
trapdoors_end

monsters	rmb max_monsters*sizeof_monster
monsters_end

		rmb (256-*%256)%256		; page align

leveldata	rmb sizeof_map
leveldata_end
objects
doors		rmb max_doors*sizeof_object
keys		rmb max_keys*sizeof_object
items		rmb max_items*sizeof_object
objects_end
