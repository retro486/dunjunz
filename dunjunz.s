
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

		include	"dragonhw.s"
		include "objects.s"

fb0		equ $0400	; framebuffer base
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

; viewport addresses

vp1		equ fb0+20*fb_w+1
vp2		equ fb0+20*fb_w+14
vp3		equ fb0+100*fb_w+1
vp4		equ fb0+100*fb_w+14

; stats window addresses

stat_win1	equ fb0+21*fb_w+27
stat_win2	equ stat_win1+40*fb_w
stat_win3	equ stat_win1+80*fb_w
stat_win4	equ stat_win1+120*fb_w

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
obj_pos		rmb 2
obj_type	rmb 1
obj_voff	rmb 2		; precalc viewport offset
obj_render	rmb 2		; render function
sizeof_object

facing_up	equ 0
facing_down	equ 2
facing_left	equ 4
facing_right	equ 6

		org sprite_offset
100

sprite_facing	rmb 1	; direction sprite is facing
sprite_moveoff	rmb 1	; offset to add to move in facing direction

sprite_set	rmb 2	; const base of all direction sprites

sprite_voff	rmb 2	; offset into viewport to draw sprite
sprite_render	rmb 2	; points to set of three pointers to sprites
sprite_undraw	rmb 2	; draw routine for covered item

sprite_room	rmb 2	; pointer to top-left of current room
sprite_pos	rmb 2	; pointer to sprite's position in map
sprite_next_pos	rmb 2

sprite_offset	equ 100B-*

sprite_hp	rmb 1	; -ve = sprite inactive (e.g. dead player)

sprite_state	rmb 1	; depends on type of sprite

sprite_undraw_room
		rmb 2

sizeof_sprite	equ *-sprite_offset

; - - -

		org sprite_offset
		rmb sizeof_sprite
sizeof_monster	equ *-sprite_offset

; - - -

		org sprite_offset
		rmb sizeof_sprite
plr_stat_win	rmb 2	; pointer to stats window
plr_vp		rmb 2	; pointer to viewport

plr_moving	rmb 1	; non-zero = move in direction from sprite_facing
plr_armour	rmb 1
plr_power	rmb 1
plr_ammo	rmb 1
plr_key		rmb 1	; object id of key
plr_speed	rmb 1
plr_score2	rmb 1
plr_score0	rmb 1
sizeof_player	equ *-sprite_offset

; - - -

; player defaults

		org 0
plr_dfl_pos	rmb 2
plr_dfl_facing	rmb 1
plr_dfl_armour	rmb 1
plr_dfl_power	rmb 1
plr_dfl_ammo	rmb 1
plr_dfl_spriteset
		rmb 2
plr_dfl_stat_win
		rmb 2
plr_dfl_vp	rmb 2
sizeof_player_defaults

; - - -

; trapdoors let monsters through, they're constant background tiles, but
; we also keep a list of their positions to iterate over quickly.

		org 0
trapdoor_pos	rmb 2
trapdoor_voff	rmb 2
sizeof_trapdoor

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

; Direct page variables

; Trying to keep player sprites here for now, as there are plenty of
; places where we manipulate them directly rather than as offsets into the
; player struct.

		org $0112
		setdp $00

level		rmb 1

anim_count	rmb 1

dzip_end
tmp0		rmb 2
tmp1		rmb 2
tmp2		rmb 2

; Avoid the soft reset flag/vector

players		equ *-sprite_offset
player1		equ *-sprite_offset
		rmb sizeof_player
player2		equ *-sprite_offset
		rmb sizeof_player
player3		equ *-sprite_offset
		rmb sizeof_player
player4		equ *-sprite_offset
		rmb sizeof_player
players_end	equ *-sprite_offset

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

		org fb0_top

mainloop

		; two-frame animations toggle every 8 frames.
		; this will cause top bit of anim_count to reflect that.
		lda anim_count
		adda #16
		beq 10F
		bvc 30F
		ldx #tile_drainer0_a
		ldu #tile_drainer0_b
		bra 20F
10		ldx #tile_drainer1_a
		ldu #tile_drainer1_b
20		stx mod_drainer_a
		stu mod_drainer_b
30		sta anim_count

		; spawn new monsters
		jsr new_monster

		bsr draw_objects
		; move the existing ones
		jsr process_monsters

		jsr scan_controls
		jsr process_players

		lda player1+sprite_hp
		inca
		bne 99F
		lda player2+sprite_hp
		inca
		bne 99F
		lda player3+sprite_hp
		inca
		bne 99F
		lda player4+sprite_hp
		inca
		beq game_over

99		bra mainloop

game_over
		jmp [$bffe]

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

; render 8x8 window
; entry:
;     x -> screen
;     u -> player struct
; uses: tmp0, tmp1

		; draw player window
		; only draws static tiles: floor, stone, doors

plr_draw_room
		ldx plr_vp,u
		ldd sprite_next_pos,u
		andb #$18
		tfr d,y
		lda #vp_tiles_h
		sta tmp1
		pshs u
yloop
		lda #vp_tiles_w/2
		sta tmp1+1
xloop
		; even tiles
		lda ,y+
		beq 10F
		bpl 20F
10		jsr single_tile_a

		; odd tiles
20		leax 1,x
		lda ,y+
		; only render static tiles
		beq 30F
		bpl 40F
30
		jsr single_tile_b

40		leax 2,x
		dec tmp1+1
		bne xloop
		leax (9*fb_w)-12,x
		leay map_w-vp_tiles_w,y
		dec tmp1
		bne yloop
		puls u
		jmp plr_inc_state

draw_objects
		ldu #objects
10		lda obj_type,u
		beq 50F
		jsr [obj_render,u]
50		leau sizeof_object,u
		cmpu #objects_end
		blo 10B
		rts

DRAW_ROW_A	macro
		clra
		ldb (\1+1),x
		andb #$0f
		addd ,u++
		std \1,x
		endm

DRAW_LAST_ROW_A	macro
		clra
		ldb (\1+1),x
		andb #$0f
		addd ,u
		std \1,x
		endm

DRAW_ROW_B	macro
		lda \1,x
		clrb
		anda #$f0
		addd ,u++
		std \1,x
		endm

DRAW_LAST_ROW_B	macro
		lda \1,x
		clrb
		anda #$f0
		addd ,u
		std \1,x
		endm

		; u -> object
draw_object_a
		ldd obj_pos,u
		andb #$18
		tfr d,y
		lda obj_type,u
		ldx obj_voff,u
		; fall through

		; a = tile id
		; x = vp offset
		; y = room
draw_tile_a	
		pshs x,u
		ldu #tiles_a
		ldu a,u
		stu tmp2
		cmpy player1+sprite_room
		bne 10F
		leax vp1+128,x
		bsr 100F
10		cmpy player2+sprite_room
		bne 20F
		ldx ,s
		leax vp2+128,x
		ldu tmp2
		bsr 100F
20		cmpy player3+sprite_room
		bne 30F
		ldx ,s
		leax vp3+128,x
		ldu tmp2
		bsr 100F
30		cmpy player4+sprite_room
		bne 40F
		ldx ,s
		leax vp4+128,x
		ldu tmp2
		bsr 100F
40		puls x,u,pc
single_tile_a	ldu #tiles_a
		ldu a,u
100		DRAW_ROW_A -128
		DRAW_ROW_A -96
		DRAW_ROW_A -64
		DRAW_ROW_A -32
		DRAW_ROW_A 0
		DRAW_ROW_A 32
		DRAW_ROW_A 64
		DRAW_ROW_A 96
		DRAW_LAST_ROW_A 128
		rts

		; u -> object
draw_object_b
		ldd obj_pos,u
		andb #$18
		tfr d,y
		lda obj_type,u
		ldx obj_voff,u
		; fall through

		; a = tile id
		; x = vp offset
		; y = room
draw_tile_b
		pshs x,u
		ldu #tiles_b
		ldu a,u
		stu tmp2
		cmpy player1+sprite_room
		bne 10F
		leax vp1+128,x
		bsr 100F
10		cmpy player2+sprite_room
		bne 20F
		ldx ,s
		leax vp2+128,x
		ldu tmp2
		bsr 100F
20		cmpy player3+sprite_room
		bne 30F
		ldx ,s
		leax vp3+128,x
		ldu tmp2
		bsr 100F
30		cmpy player4+sprite_room
		bne 40F
		ldx ,s
		leax vp4+128,x
		ldu tmp2
		bsr 100F
40		puls x,u,pc
single_tile_b	ldu #tiles_b
		ldu a,u
100		DRAW_ROW_B -128
		DRAW_ROW_B -96
		DRAW_ROW_B -64
		DRAW_ROW_B -32
		DRAW_ROW_B 0
		DRAW_ROW_B 32
		DRAW_ROW_B 64
		DRAW_ROW_B 96
		DRAW_LAST_ROW_B 128
		rts

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

; initialise game for starting from level 1

start		; binray start address

game_setup

		setdp -1

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
		lds #$0400

		lda #$ff
		tfr a,dp
		setdp $ff

		; XXX 64K mode for testing.  I hope to get everything
		; within 32K.
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
		sta reg_sam_v0c
		sta reg_sam_v1s
		sta reg_sam_v2s
		; SAM display offset = $0400
		sta reg_sam_f0c
		sta reg_sam_f1s
		sta reg_sam_f2c
		; VDG mode = CG6, CSS0
		lda #$e2
		sta reg_pia1_pdrb

		lda #$01
		tfr a,dp
		setdp $01

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
		jsr plr_draw_stats
		leau sizeof_player,u
		leay sizeof_player_defaults,y
		jsr player_setup
		jsr plr_draw_stats
		leau sizeof_player,u
		leay sizeof_player_defaults,y
		jsr player_setup
		jsr plr_draw_stats
		leau sizeof_player,u
		leay sizeof_player_defaults,y
		jsr player_setup
		jsr plr_draw_stats

		ldu #levels
		lda level
		inca
		sta level
		lsla
		ldx #levelcache_end
		stx dzip_end	; dzip end
		ldx a,u		; dzip start
		ldu #levelcache
		jsr dunzip
		ldu #levelcache

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
10		lda #door_h
		ldx ,u++
		beq 30F
		bpl 20F
		leax -$8000,x
		lda #door_v
20		leax leveldata,x
		sta ,x
30		dec tmp0
		bne 10B

		; tmp0+1 = current OID
		ldb #$ff
		stb tmp0+1

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
		ldx #trapdoors-sizeof_trapdoor
		stx 20F
10		ldx ,u++
		beq 30F
		lda #trapdoor
		ldb tmp0+1
		incb
		stb tmp0+1
		bsr place_object
		tfr x,d		; d = pos
20		equ *+1
		ldx #trapdoors
		leax sizeof_trapdoor,x
		stx 20B
		std trapdoor_pos,x
		ldd obj_voff,y
		std trapdoor_voff,x
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
		ldb tmp0+1
		incb
		bsr object_ptr
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
		pshs x
		stb ,x		; store oid in map
		bsr object_ptr	; y -> object
		sta obj_type,y
		ldx #draw_object_a
		ldb 1,s
		lsrb
		bcc 10F
		ldx #draw_object_b
10		stx obj_render,y
		ldd ,s
		std obj_pos,y
		ldd ,s
		bsr pos_to_voff
		std obj_voff,y
		puls x,pc

		; b = oid
		; returns y -> object
object_ptr	pshs a,b,x
		lda #sizeof_object
		mul
		ldx #objects
		leay d,x
		puls a,b,x,pc

pos_to_voff
		pshs x
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
		puls x,pc

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

; set up player.  if player is dead, restore default stats and clear
; score.  always restore to 99 health.

; entry:
;     u -> player struct
;     y -> player defaults

player_setup
		ldd plr_dfl_spriteset,y
		std sprite_set,u
		ldd plr_dfl_stat_win,y
		std plr_stat_win,u
		ldd plr_dfl_vp,y
		std plr_vp,u
		ldd plr_dfl_pos,y
		std sprite_next_pos,u
		lda #1
		sta sprite_undraw_room,u
		clr sprite_room,u	; no "current" room
		clr plr_key,u		; no key
		clr plr_speed,u		; no speedyboots
		lda sprite_hp,u
		bpl 1F
		; reset player stats if dead
		ldd plr_dfl_armour,y	; armour & power
		std plr_armour,u
		lda plr_dfl_ammo,y	; ammo
		sta plr_ammo,u
		clr plr_score2,u
		clr plr_score0,u
		; always reset health
1		ldd #$9902
		sta sprite_hp,u
		lda plr_dfl_facing,y
		sta sprite_facing,u
		clr plr_moving,u
		ldb #state_plr_draw_room
		stb sprite_state,u
20		rts

		; check player keys in order: magic, up, down, right, left,
		; fire.  only one key at a time!  i think in the case of
		; joysticks, fire must be checked first.

		; DP is set to $ff before any of these are called
		setdp $ff

scan_controls

		; keyboard & joystick scanning - will hit the PIAs a lot,
		; so set DP
		lda #$ff
		tfr a,dp
		setdp $ff

		; player 1 - (C), W, S, X, Z, (Q)
		lda player1+sprite_state
		beq 1F
		cmpa #state_plr_landed
		bne 90F
1		clr player1+plr_moving
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
		lda #facing_up
		bra 80F
		; p1 down: 'S'
10		ldd #$f710
		sta reg_pia0_pdrb
		bitb reg_pia0_pdra
		bne 20F
		lda #facing_down
		bra 80f
		; p1 right: 'X'
20		ldd #$fe20
		sta reg_pia0_pdrb
		bitb reg_pia0_pdra
		bne 30F
		lda #facing_right
		bra 80F
		; p1 left: 'Z'
30		ldd #$fb20
		sta reg_pia0_pdrb
		bitb reg_pia0_pdra
		bne 40F
		lda #facing_left
		bra 80F
		; p1 fire: 'Q'
40		ldd #$fd10
		sta reg_pia0_pdrb
		bitb reg_pia0_pdra
		bne 90F
		; XXX p1 pressed fire
		bra 90F
80
		sta player1+sprite_facing
		inca
		sta player1+plr_moving
90

		; player 2 - (@), P, L, K, J, (H)
		lda player2+sprite_state
		beq 1F
		cmpa #state_plr_landed
		bne 90F
1		clr player2+plr_moving
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
		lda #facing_up
		bra 80F
		; p2 down: 'L'
10		ldd #$ef08
		sta reg_pia0_pdrb
		bitb reg_pia0_pdra
		bne 20F
		lda #facing_down
		bra 80f
		; p2 right: 'K'
20		ldd #$f708
		sta reg_pia0_pdrb
		bitb reg_pia0_pdra
		bne 30F
		lda #facing_right
		bra 80F
		; p2 left: 'J'
30		ldd #$fb08
		sta reg_pia0_pdrb
		bitb reg_pia0_pdra
		bne 40F
		lda #facing_left
		bra 80F
		; p2 fire: '@'
40		ldd #$fe04
		sta reg_pia0_pdrb
		bitb reg_pia0_pdra
		bne 90F
		; XXX p2 pressed fire
		bra 90F
80
		sta player2+sprite_facing
		inca
		sta player2+plr_moving
90

		; disable sound mux
		lda #$35
		sta reg_pia1_crb

		; player 3 - left joystick
		lda player3+sprite_state
		beq 1F
		cmpa #state_plr_landed
		bne 90F
1		clr player3+plr_moving
		ldd #$3d34
		sta reg_pia0_crb	; left joystick
		stb reg_pia0_cra	; x axis
		lda #$20
		sta reg_pia1_pdra
		lda reg_pia0_pdra	; left?
		bmi 10F
		lda #facing_left
		bra 80F
10		ldd #$ffc0
		sta reg_pia1_pdra
		stb reg_pia1_pdra
		lda reg_pia0_pdra	; right?
		bpl 20F
		lda #facing_right
		bra 80F
20		lda #$3c
		sta reg_pia0_cra	; y axis
		lda reg_pia0_pdra	; down?
		bpl 30F
		lda #facing_down
		bra 80F
30		neg reg_pia1_pdra
		lda reg_pia0_pdra	; up?
		bmi 90F
		lda #facing_up
		bra 80F
80
		sta player3+sprite_facing
		inca
		sta player3+plr_moving
90

		; player 4 - right joystick
		lda player4+sprite_state
		beq 1F
		cmpa #state_plr_landed
		bne 90F
1		clr player4+plr_moving
		ldd #$353c
		sta reg_pia0_crb	; right joystick
		stb reg_pia0_cra	; y axis
		lda #$20
		sta reg_pia1_pdra
		lda reg_pia0_pdra	; up?
		bmi 10F
		lda #facing_up
		bra 80F
10		ldd #$ffc0
		sta reg_pia1_pdra
		stb reg_pia1_pdra
		lda reg_pia0_pdra	; down?
		bpl 20F
		lda #facing_down
		bra 80F
20		lda #$34
		sta reg_pia0_cra	; x axis
		lda reg_pia0_pdra	; right?
		bpl 30F
		lda #facing_right
		bra 80F
30		neg reg_pia1_pdra
		lda reg_pia0_pdra	; left?
		bmi 90F
		lda #facing_left
		bra 80F
80
		sta player4+sprite_facing
		inca
		sta player4+plr_moving
90

		; re-enable sound mux
		lda #$34
		sta reg_pia0_cra	; mux sel 0 = 0
		ldd #$c03d
		sta reg_pia1_pdra	; dac = sbs high value
		stb reg_pia1_crb	; enable sound mux

		lda #$01
		tfr a,dp
		setdp $01

		rts


		; u -> player
		; y -> object
player_teleport
		ldx obj_pos,y
10		leay sizeof_object,y
		cmpy #objects_end
		blo 20F
		ldy #items	; #objects
20		lda obj_type,y
		cmpa #tport
		bne 10B
		cmpx obj_pos,y
		beq 30F
		ldx obj_pos,y
30		leax -map_w,x
		stx sprite_pos,u
		rts

plr_draw_armour	ldx plr_stat_win,u
		leax 2*fb_w+3+128,x
		lda plr_armour,u
10		pshs u
		bsr draw_snum
		puls u,pc

plr_draw_power	ldx plr_stat_win,u
		leax 10*fb_w+2+128,x
		lda plr_power,u
		bra 10B

draw_snum	ldu #s_snum
		lsla
		jmp [a,u]

plr_draw_hp	ldx plr_stat_win,u
		leax 13*fb_w+128,x
		ldy #s_lnum
		lda sprite_hp,u
		bra draw_lnum_pair

		; u -> player
plr_draw_stats	pshs y
		ldx plr_stat_win,u
		leax fb_w+128,x
		ldy sprite_set,u
		jsr [24,y]
		bsr plr_draw_armour
		bsr plr_draw_power
		bsr plr_draw_ammo
		bsr plr_draw_hp
		bsr plr_draw_score
		puls y,pc

plr_draw_score	ldx plr_stat_win,u
		leax 23*fb_w+128,x
		ldy #s_lnum
		lda plr_score2,u
		bsr draw_lnum_pair
		lda plr_score0,u
		; fall through to draw_lnum_pair

draw_lnum_pair
		pshs a
		lsra
		lsra
		lsra
		anda #$1e
		jsr [a,y]
		puls a
		lsla
		anda #$1e
		jmp [a,y]

plr_draw_ammo	ldx plr_stat_win,u
		leax 15*fb_w+2,x
		lda plr_ammo,u
		sta tmp1
		suba #4
		sta tmp1+1
		ldd #$55ba
		stb 1,x
		leax fb_w,x
10		ldb #$7e
		std ,x
		ldb #$ba
		stb fb_w+1,x
		leax 2*fb_w,x
		dec tmp1
		bne 10B
		ldd #$aaaa
20		inc tmp1+1
		beq 30F
		std ,x
		std fb_w,x
		leax 2*fb_w,x
		bra 20B
30		rts

player1_defaults
		fdb leveldata+$016b	; plr_dfl_pos
		fcb facing_up		; plr_dfl_facing
		fcb 3			; plr_dfl_armour
		fcb 2			; plr_dfl_power
		fcb 3			; plr_dfl_ammo
		fdb spriteset_p1	; plr_dfl_spriteset
		fdb stat_win1		; plr_dfl_stat_win
		fdb vp1+128		; plr_dfl_vp
player2_defaults
		fdb leveldata+$018b	; plr_dfl_pos
		fcb facing_right	; plr_dfl_facing
		fcb 1			; plr_dfl_armour
		fcb 3			; plr_dfl_power
		fcb 2			; plr_dfl_ammo
		fdb spriteset_p2	; plr_dfl_spriteset
		fdb stat_win2		; plr_dfl_stat_win
		fdb vp2+128		; plr_dfl_vp
player3_defaults
		fdb leveldata+$016c	; plr_dfl_pos
		fcb facing_down		; plr_dfl_facing
		fcb 4			; plr_dfl_armour
		fcb 9			; plr_dfl_power
		fcb 1			; plr_dfl_ammo
		fdb spriteset_p3	; plr_dfl_spriteset
		fdb stat_win3		; plr_dfl_stat_win
		fdb vp3+128		; plr_dfl_vp
player4_defaults
		fdb leveldata+$018c	; plr_dfl_pos
		fcb facing_left		; plr_dfl_facing
		fcb 6			; plr_dfl_armour
		fcb 5			; plr_dfl_power
		fcb 2			; plr_dfl_ammo
		fdb spriteset_p4	; plr_dfl_spriteset
		fdb stat_win4		; plr_dfl_stat_win
		fdb vp4+128		; plr_dfl_vp

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

new_monster
next_td		equ *+1
		ldu #trapdoors-sizeof_trapdoor
		leay sizeof_trapdoor,u
		cmpy #trapdoors_end
		blo 10F
		ldy #trapdoors
10		sty next_td
		ldu #monsters
20		lda sprite_hp,u
		bmi 30F
		leau sizeof_monster,u
		cmpu #monsters_end
		blo 20B
		rts
30		lda #9
		sta sprite_hp,u
		ldd trapdoor_pos,y
		std sprite_pos,u
		andb #$18
		std sprite_room,u
		ldd trapdoor_pos,y
		jsr pos_to_voff
		std sprite_voff,u
		ldd #spriteset_mon
		std sprite_set,u
		; fall through

mon_change_direction
next_dir	equ *+1
		lda #$03
		inca
		anda #$03
		sta next_dir
		lsla
		cmpa sprite_facing,u		; same direction?
		beq mon_change_direction	; try again
		sta sprite_facing,u
		ldx sprite_pos,u
		clr sprite_state,u
		; fall through

		; u -> sprite
		; uses sprite_facing, sprite_set, sprite_pos
		; updates sprite_moveoff, sprite_render

sprite_set_render
		ldx #dir_offsets
		ldb sprite_facing,u
		ldd b,x
		sta sprite_moveoff,u
		ldx sprite_set,u
		abx
		lda sprite_pos+1,u
		lsra
		bcc 10F
		leax 6,x		; tile set B
10		cmpb #48
		bhs 20F
		; up & down only: select tile based on y position
		; ie test bit 5 (but shifted already so test bit 4)
		bita #16
		beq 20F
		leax 12,x
20		stx sprite_render,u
		ldd sprite_room,u
		std sprite_undraw_room,u
		rts

hit_player
		lda #$90
		adda plr_armour,u
		adda sprite_hp,u
		daa
		cmpa sprite_hp,u
		blo 10F
		clra
		; XXX player dead
10		sta sprite_hp,u
		jsr plr_draw_hp
		puls x,u
		bra 30F

mon_check_direction
		ldx sprite_pos,u
		ldb sprite_moveoff,u
		leax b,x
		pshs x,u
		ldu #players
5		cmpx sprite_pos,u
		beq hit_player
		leau sizeof_player,u
		cmpu #players_end
		blo 5B
		puls x,u
		ldy #players
10		cmpx sprite_pos,y
		beq 30F
		leay sizeof_player,y
		cmpy #players_end
		blo 10B
		ldy #monsters
20		cmpx sprite_pos,y
		beq 30F
		leay sizeof_monster,y
		cmpy #monsters_end
		blo 20B
		lda ,x
		bpl 40F
30		jsr mon_change_direction
		ldy [sprite_render,u]
		bsr draw_sprite
		bra next_monster
40		stx sprite_next_pos,u
		tfr x,d
		andb #$18
		cmpd sprite_room,u
		beq 50F
		jsr sprite_set_render
		lda #12
		bra mon_set_state
50		jsr sprite_set_render
		bra mon_inc_state

mon_landed
		jsr undraw_sprite
		ldd sprite_next_pos,u
		std sprite_pos,u
		andb #$18
		std sprite_room,u
		ldd sprite_pos,u
		jsr pos_to_voff
		std sprite_voff,u
		clr sprite_state,u
		; fall through

mon_centred
		jsr sprite_set_render
		ldy [sprite_render,u]
		bsr draw_sprite
		bra mon_inc_state

mon_move1
		bsr undraw_sprite
		ldx sprite_render,u
		ldy 2,x
		bsr draw_sprite
		bra mon_inc_state

process_monsters
		ldu #monsters
10		lda sprite_hp,u
		bmi next_monster
		lda sprite_state,u
		ldx #jtbl_monster_state
		jmp [a,x]
mon_clr_state	clra
mon_set_state	sta sprite_state,u
next_monster	leau sizeof_monster,u
		cmpu #monsters_end
		blo 10B
		rts

mon_inc_state	lda sprite_state,u
mon_delay	adda #2
		bra mon_set_state

mon_move2
		bsr undraw_sprite
		ldx sprite_render,u
		ldy 4,x
		bsr draw_sprite
		bra mon_inc_state

draw_sprite
		ldd sprite_pos,u
		andb #$18
		cmpd player1+sprite_room
		bne 20F
		ldx sprite_voff,u
		leax vp1+128,x
		jsr ,y

		ldd sprite_pos,u
		andb #$18
20		cmpd player2+sprite_room
		bne 30F
		ldx sprite_voff,u
		leax vp2+128,x
		jsr ,y

		ldd sprite_pos,u
		andb #$18
30		cmpd player3+sprite_room
		bne 40F
		ldx sprite_voff,u
		leax vp3+128,x
		jsr ,y

		ldd sprite_pos,u
		andb #$18
40		cmpd player4+sprite_room
		bne 90F
		ldx sprite_voff,u
		leax vp4+128,x
		jsr ,y
90		rts

undraw_sprite
		lda [sprite_pos,u]
		bne 90B
		clra
		ldx sprite_voff,u
		ldy sprite_undraw_room,u
		ldb sprite_pos+1,u
		lsrb
		bcc 10F
		jmp draw_tile_b
10		jmp draw_tile_a

plr_move1
		bsr undraw_sprite
		ldx sprite_render,u
		ldy 2,x
		bsr draw_sprite
		jmp plr_inc_state

plr_move2
		bsr undraw_sprite
		ldx sprite_render,u
		ldy 4,x
		bsr draw_sprite
		jmp plr_inc_state

plr_draw_objects
		bsr undraw_sprite
		lda #state_plr_landed
		sta sprite_state,u
		jmp next_player

plr_landed
		bsr undraw_sprite
		ldd sprite_next_pos,u
		std sprite_pos,u
		andb #$18
		std sprite_room,u
		ldd sprite_pos,u
		jsr pos_to_voff
		std sprite_voff,u
		clr sprite_state,u
		; pickups...
		ldx sprite_pos,u
		ldy #objects
10		lda obj_type,y
		beq 20F
		cmpx obj_pos,y
		bne 20F
		pshs a,x,y
		ldx #tbl_pickup
		jsr [a,x]
		puls a
		ldx #pickup_scores
		lsra
		lda a,x
		beq 15F
		ldy 2,s
		clr obj_type,y
		clr [sprite_pos,u]
		adda plr_score0,u
		daa
		sta plr_score0,u
		lda plr_score2,u
		adca #$00
		daa
		sta plr_score2,u
		jsr plr_draw_score

15		puls x,y
20		leay sizeof_object,y
		cmpy #objects_end
		blo 10B
		; fall through

plr_centred

		jsr sprite_set_render
		ldy [sprite_render,u]
		jsr draw_sprite
		lda plr_moving,u
		beq next_player

		ldx sprite_pos,u
		ldb sprite_moveoff,u
		leax b,x
		cmpx player1+sprite_pos
		beq 30F
		cmpx player2+sprite_pos
		beq 30F
		cmpx player3+sprite_pos
		beq 30F
		cmpx player4+sprite_pos
		beq 30F
		ldy #monsters
20		cmpx sprite_pos,y
		beq 35F
		leay sizeof_monster,y
		cmpy #monsters_end
		blo 20B
		lda ,x
		bpl 40F
		; XXX temporarily allow moving through doors
		cmpa #door_v
		beq 40F
		cmpa #door_h
		beq 40F
30		bra next_player
35		lda sprite_hp,u
		; XXX better way of doing this?
		adda #$99
		daa
		cmpa sprite_hp,u
		blo 36F
		clra
36		sta sprite_hp,u
		jsr plr_draw_hp
		bra next_player
40		stx sprite_next_pos,u
		tfr x,d
		andb #$18
		cmpd sprite_room,u
		beq 50F
		clr sprite_room,u
		lda #state_plr_draw_room
		bra plr_set_state
50		jsr sprite_set_render
		bra plr_inc_state

process_players
		ldu #players
10		lda sprite_state,u
		bmi next_player
		lda sprite_state,u
		ldx #jtbl_player_state
		jmp [a,x]
plr_clr_state	clra
plr_set_state	sta sprite_state,u
next_player	leau sizeof_player,u
		cmpu #players_end
		blo 10B
		rts

plr_inc_state	lda sprite_state,u
plr_delay	adda #2
		bra plr_set_state

pickup_nop	rts

pickup_drainer
		lda sprite_hp,u
		suba #$20
		bcc 10F
		clra
10		sta sprite_hp,u
		jmp plr_draw_hp

pickup_potion
		lda plr_score0,u
		anda #$0f
		ldb #$11
		mul
10		stb sprite_hp,u
		jmp plr_draw_hp

pickup_food
		lda sprite_hp,u
		adda #$10
		daa
		bcc 10F
		lda #$99
10		sta sprite_hp,u
		jmp plr_draw_hp

pickup_armour
		lda plr_armour,u
		inca
		cmpa #7
		bhi 99F
		sta plr_armour,u
		jmp plr_draw_armour
99		rts

pickup_money
		rts

pickup_power
		lda plr_power,u
		inca
		cmpa #9
		bhi 99F
		sta plr_power,u
		jmp plr_draw_power
99		rts

pickup_weapon
		lda plr_ammo,u
		inca
		cmpa #3
		bhi 99F
		sta plr_ammo,u
		jmp plr_draw_ammo
99		rts

jtbl_monster_state
		fdb mon_centred		; 0
		fdb mon_check_direction	; 2
		fdb mon_move1		; 4
		fdb mon_delay		; 6
		fdb mon_move2		; 8
		fdb mon_landed		; 10
		fdb mon_delay		; 12
		fdb mon_delay		; 14
		fdb mon_delay		; 16
		fdb mon_landed		; 18

jtbl_player_state
		fdb plr_centred		; 0
		fdb plr_move1		; 2
		fdb plr_move2		; 4
state_plr_landed	equ *-jtbl_player_state
		fdb plr_landed		; 6
state_plr_draw_room	equ *-jtbl_player_state
		fdb plr_draw_room	; 8
		fdb plr_draw_objects	; 10

tbl_pickup	equ *-2		; no dispatch for floor
		fdb pickup_nop	; exit
		fdb pickup_nop	; trapdoor
		fdb pickup_drainer	; drainer
		fdb pickup_money
		fdb pickup_food
		fdb pickup_nop	; tport
		fdb pickup_power
		fdb pickup_armour
		fdb pickup_potion
		fdb pickup_weapon
		fdb pickup_nop	; cross
		fdb pickup_nop	; speed
		fdb pickup_nop	; key

pickup_scores	equ *-1		; floor not a pickup
		fcb 0		; exit
		fcb 0		; trapdoor
		fcb 0		; drainer
		fcb $20		; money
		fcb $05		; food
		fcb 0		; tport
		fcb $10		; power
		fcb $10		; armour
		fcb $10		; potion
		fcb $10		; weapon
		fcb $10		; cross
		fcb $10		; speed
		fcb 0		; key

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

spr_draw_seq	macro
		fdb draw_\{1}_\{2}\{3}_\{4}0
		fdb draw_\{1}_\{2}\{3}_\{4}1
		fdb draw_\{1}_\{2}\{3}_\{4}2
		endm

spriteset_p1
		spr_draw_seq "p1","up","0","a"
		spr_draw_seq "p1","up","0","b"
		spr_draw_seq "p1","up","1","a"
		spr_draw_seq "p1","up","1","b"
		spr_draw_seq "p1","down","0","a"
		spr_draw_seq "p1","down","0","b"
		spr_draw_seq "p1","down","1","a"
		spr_draw_seq "p1","down","1","b"
		spr_draw_seq "p1","left","0","a"
		spr_draw_seq "p1","left","1","b"
		spr_draw_seq "p1","right","0","a"
		spr_draw_seq "p1","right","1","b"

spriteset_p2
		spr_draw_seq "p2","up","0","a"
		spr_draw_seq "p2","up","0","b"
		spr_draw_seq "p2","up","1","a"
		spr_draw_seq "p2","up","1","b"
		spr_draw_seq "p2","down","0","a"
		spr_draw_seq "p2","down","0","b"
		spr_draw_seq "p2","down","1","a"
		spr_draw_seq "p2","down","1","b"
		spr_draw_seq "p2","left","0","a"
		spr_draw_seq "p2","left","1","b"
		spr_draw_seq "p2","right","0","a"
		spr_draw_seq "p2","right","1","b"

spriteset_p3
		spr_draw_seq "p3","up","0","a"
		spr_draw_seq "p3","up","0","b"
		spr_draw_seq "p3","up","1","a"
		spr_draw_seq "p3","up","1","b"
		spr_draw_seq "p3","down","0","a"
		spr_draw_seq "p3","down","0","b"
		spr_draw_seq "p3","down","1","a"
		spr_draw_seq "p3","down","1","b"
		spr_draw_seq "p3","left","0","a"
		spr_draw_seq "p3","left","1","b"
		spr_draw_seq "p3","right","0","a"
		spr_draw_seq "p3","right","1","b"

spriteset_p4
		spr_draw_seq "p4","up","0","a"
		spr_draw_seq "p4","up","0","b"
		spr_draw_seq "p4","up","1","a"
		spr_draw_seq "p4","up","1","b"
		spr_draw_seq "p4","down","0","a"
		spr_draw_seq "p4","down","0","b"
		spr_draw_seq "p4","down","1","a"
		spr_draw_seq "p4","down","1","b"
		spr_draw_seq "p4","left","0","a"
		spr_draw_seq "p4","left","1","b"
		spr_draw_seq "p4","right","0","a"
		spr_draw_seq "p4","right","1","b"

dir_offsets	fcb -32,0	; facing_up
		fcb 32,24	; facing_down
		fcb -1,48	; facing_left
		fcb 1,60	; facing_right

spriteset_mon
		spr_draw_seq "monster","up","0","a"
		spr_draw_seq "monster","up","0","b"
		spr_draw_seq "monster","up","1","a"
		spr_draw_seq "monster","up","1","b"
		spr_draw_seq "monster","down","0","a"
		spr_draw_seq "monster","down","0","b"
		spr_draw_seq "monster","down","1","a"
		spr_draw_seq "monster","down","1","b"
		spr_draw_seq "monster","left","0","a"
		spr_draw_seq "monster","left","1","b"
		spr_draw_seq "monster","right","0","a"
		spr_draw_seq "monster","right","1","b"

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

		include "dunzip.s"

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

; tile grid metadata.  offsets into viewport.

POS2GRID_ELEM	macro
		fdb (\1)*tile_h*fb_w+((\2)*tile_w)/8
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

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

levels
		fdb level1,level2,level3,level4
		fdb level5,level6,level7,level8
		fdb level9,level10,level11,level12
		fdb level13,level14,level15,level16
		fdb level17,level18,level19,level20
		fdb level21,level22,level23,level24

level1		includebin "level01.bin.dz"
level2		includebin "level02.bin.dz"
level3		includebin "level03.bin.dz"
level4		includebin "level04.bin.dz"
level5		includebin "level05.bin.dz"
level6		includebin "level06.bin.dz"
level7		includebin "level07.bin.dz"
level8		includebin "level08.bin.dz"
level9		includebin "level09.bin.dz"
level10		includebin "level10.bin.dz"
level11		includebin "level11.bin.dz"
level12		includebin "level12.bin.dz"
level13		includebin "level13.bin.dz"
level14		includebin "level14.bin.dz"
level15		includebin "level15.bin.dz"
level16		includebin "level16.bin.dz"
level17		includebin "level17.bin.dz"
level18		includebin "level18.bin.dz"
level19		includebin "level19.bin.dz"
level20		includebin "level20.bin.dz"
level21		includebin "level21.bin.dz"
level22		includebin "level22.bin.dz"
level23		includebin "level23.bin.dz"
level24		includebin "level24.bin.dz"

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

TILE_BLOCKING	macro
		fdb tile_door_v_\1
		fdb tile_door_h_\1
mod_stone_\1	fdb tile_stone01_\1
		endm

TILE_LIST	macro
		fdb tile_floor_\1
		fdb tile_exit_\1
		fdb tile_trapdoor_\1
mod_drainer_\1	fdb tile_drainer0_\1
		fdb tile_money_\1
		fdb tile_food_\1
		fdb tile_tport_\1
		fdb tile_power_\1
		fdb tile_armour_\1
		fdb tile_potion_\1
		fdb tile_weapon_\1
		fdb tile_cross_\1
		fdb tile_speed_\1
		fdb tile_key_\1
		endm

		TILE_BLOCKING a
tiles_a		TILE_LIST a
		TILE_BLOCKING b
tiles_b		TILE_LIST b

		include "tiles.s"
		include "sprites.s"

play_screen_dz	includebin "play-screen.bin.dz"

s_snum		equ *-2		; no zero in this font
		fdb draw_snum_1,draw_snum_2,draw_snum_3
		fdb draw_snum_4,draw_snum_5,draw_snum_6,draw_snum_7
		fdb draw_snum_8,draw_snum_9
s_lnum		fdb draw_lnum_0,draw_lnum_1,draw_lnum_2,draw_lnum_3
		fdb draw_lnum_4,draw_lnum_5,draw_lnum_6,draw_lnum_7
		fdb draw_lnum_8,draw_lnum_9

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

trapdoors	rmb max_trapdoors*sizeof_trapdoor
trapdoors_end

monsters	equ *-sprite_offset
		rmb max_monsters*sizeof_monster
monsters_end	equ *-sprite_offset

		rmb (256-*%256)%256		; page align

leveldata	rmb sizeof_map
leveldata_end
objects
keys		rmb max_keys*sizeof_object
items		rmb max_items*sizeof_object
		rmb max_trapdoors*sizeof_object
objects_end

levelcache	rmb 378
levelcache_end
