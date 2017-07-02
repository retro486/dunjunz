; Dunjunz
; Dragon version by Ciaran Anscomb <xroar@6809.org.uk>
; BBC Micro/Master original by Julian Avis and Copyright Bug Byte 1987

; This rewrite for the Dragon does not reference any original code, all
; behaviour is inferred.

; REMEMBER
; When player dies and we "drop" the key, remember to set the bit in
; bmap_pickups!

		include	"dragonhw.s"
		include "objects.s"

fb0		equ $0200	; framebuffer base
fb_w		equ 32		; framebuffer line width
fb_h		equ 192		; framebuffer height
sizeof_fb	equ fb_w*fb_h
fb0_top		equ fb0+sizeof_fb

bmap_w		equ 4
bmap_h		equ 48
sizeof_bmap	equ bmap_w*bmap_h

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

; Maximum numbers of certain types of object.

max_doors	equ 20
max_keys	equ 20
max_items	equ 30		; including exit
max_trapdoors	equ 8		; *must* be this amount of trapdoors
max_monsters	equ 28		; needn't all be active at once

; Players, monsters, shots: need to know which way each of them is facing.

facing_up	equ 0
facing_down	equ 2
facing_left	equ 4
facing_right	equ 6

; - - -

		org 0
obj_y		rmb 1
obj_x		rmb 1
obj_tile	rmb 1
obj_voff	rmb 2		; precalc viewport offset
obj_data	rmb 3
sizeof_object

obj_drainer_hp	equ obj_data
obj_key_opens	equ obj_data
obj_shot_facing	equ obj_data
obj_shot_plr	equ obj_data+1

; sprite inherits from object, reuses portions of obj_data

		org 0-sprite_offset
100

spr_next_y	rmb 1
spr_next_x	rmb 1

spr_hp		rmb 1	; -ve = sprite inactive (e.g. dead player)
spr_state	rmb 1	; depends on type of sprite

spr_cx		rmb 1	; current x

sprite_offset	equ *-100B
		rmb sizeof_object

spr_base_tile	rmb 1

sizeof_sprite	equ *+sprite_offset

spr_facing	equ obj_data
spr_ovoff	equ obj_data+1	; origin vp offset (for undraw during move)

; - - -

; monster inherits from sprite.  No actual extra data...

		org 0-monster_offset
100
monster_offset	equ *-100B+sprite_offset
		rmb sizeof_sprite
sizeof_monster	equ *+monster_offset

; - - -

; player inherits from sprite.

		org 0-player_offset
100

plr_nshots	rmb 1	; number of currently active shots
plr_moving	rmb 1	; non-zero = move in direction from spr_facing
plr_key_opens	rmb 2	; y,x of door that held key opens
plr_speed	rmb 1	; non-zero = player moves fast!
plr_score2	rmb 1	; BCD
plr_score0	rmb 1	; BCD
plr_yroom	rmb 1	; obj_y & 0xf8
plr_bit		rmb 1	; bit within playing/done

player_offset	equ *-100B+sprite_offset
		rmb sizeof_sprite

plr_stat_win	rmb 2	; pointer to stats window
plr_vp		rmb 2	; pointer to viewport
plr_armour	rmb 1
plr_power	rmb 1
plr_ammo	rmb 1

sizeof_player	equ *+player_offset

; - - -

; Player defaults.

		org 0
plr_dfl_y	rmb 1		; default y
plr_dfl_x	rmb 1		; default x
plr_dfl_base_sprite	rmb 1	; id of player's "up" tile
plr_dfl_facing	rmb 1
plr_dfl_armour	rmb 1
plr_dfl_power	rmb 1
plr_dfl_ammo	rmb 1
plr_dfl_stat_win
		rmb 2
plr_dfl_vp	rmb 2
sizeof_player_defaults

; - - -

; Trapdoors let monsters through, they're constant background tiles, but
; we also keep a list of their positions to iterate over quickly.

		org 0
trapdoor_y	rmb 1
trapdoor_x	rmb 1
sizeof_trapdoor

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

; Direct page variables

; Trying to keep player sprites here for now, as there are plenty of
; places where we manipulate them directly rather than as offsets into the
; player struct.

		org $0112
		setdp $01

tmp0		rmb 2
dzip_end
tmp1		rmb 2
tmp2		rmb 2
tmp3		rmb 2
tmp4		rmb 2

obj_draw_yroom	equ tmp0

playing		rmb 1	; bits 0-3 = player 1-4 active
finished	rmb 1	; bits 0-3 = player 1-4 finished level
dead		rmb 1	; bits 0-3 = player 1-4 dead

death_stack	rmb 2

sound		rmb 1
level		rmb 1

stone_a		rmb 2
stone_b		rmb 2

anim_count	rmb 1

; Avoid the soft reset flag/vector

players		equ *+player_offset
player1		equ *+player_offset
		rmb sizeof_player
player2		equ *+player_offset
		rmb sizeof_player
player3		equ *+player_offset
		rmb sizeof_player
player4		equ *+player_offset
		rmb sizeof_player
players_end	equ *+player_offset

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

; Level source unzips into screen area.  Will then immediately overwrite
; by unzipping play area.  Level bitmap immediately follows screen, so
; unpacking puts it in the right place.

		org fb0_top-(378-sizeof_bmap)
levelcache	rmb 378-sizeof_bmap

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

		org fb0_top

bmap_level	rmb sizeof_bmap
levelcache_end
bmap_pickups	rmb sizeof_bmap
bmap_pickups_end

mainloop

		; two-frame animations toggle every 8 frames.
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

		; always update *some* objects
mod_objects_non_doors_2	equ *+1
		ldu #$0000
10		lda obj_tile,u
		cmpa #always_draw_tile
		blo 50F
		jsr obj_draw
50		leau sizeof_object,u
		cmpu #all_objects_end
		blo 10B

		; move the existing ones
		jsr process_monsters
		jsr plr_scan_controls
		jsr process_players
		jsr process_shots

		; XXX things are running a bit fast
		; i'm sure sound will sort that out...
		ldx #1000
10		leax -1,x
		bne 10B

		lda finished
		ora dead
		cmpa #$0f
		bne mainloop

		lda dead
		cmpa playing
		lbne level_setup

		lda #$ff
		sta level	; no cheating once all dead!
		ldx #death_screen_dz	; dzip start
game_over_screen
		jsr dunzip_text_screen

		; a few seconds pause for reflection
		ldx #$1a00
10		deca
		bne 10B
		leax -1,x
		bne 10B
		jmp game_setup

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

; Possible optimisation: stones in tileset A are full-width, and contain
; floor bitmap.  Always going to render the next one, and in that case
; rendering floor in position B becomes single byte op.  More RAM used for
; renderer though.

; render 8x8 window
; entry:
;     x -> screen
;     u -> player struct
; uses: tmp1, tmp3

plr_draw_room
		ldb spr_next_y,u
		andb #$f8
		ldx #bmap_level+128
		leay b,x
		ldx plr_vp,u
		lda #vp_tiles_h
		sta tmp1
		pshs u
yloop
		lda ,y+
		sta tmp3
		lda #vp_tiles_w/2
		sta tmp1+1
xloop
		; even tiles
		ldu #tile_floor_a
		lsl tmp3
		bcc 10F
		ldu stone_a
10		bsr single_tile_x_a

		; odd tiles
		leax 1,x
		ldu #tile_floor_b
		lsl tmp3
		bcc 30F
		ldu stone_b
30		jsr single_tile_x_b

		leax 2,x
		dec tmp1+1
		bne xloop
		leax (9*fb_w)-12,x
		dec tmp1
		bne yloop
		puls u
		jmp spr_inc_state

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

single_tile_a	ldu #tbl_tiles_a
		lsla
		ldu a,u
single_tile_x_a
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

draw_object_once
		ldb obj_x,y
		lsrb
		bcc single_tile_a
		; fall through to single_tile_b

single_tile_b	ldu #tbl_tiles_b
		lsla
		ldu a,u
single_tile_x_b
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

; binary start address
start

game_setup

		setdp 0			; assumed

		ldd #reset_hook
		std $0072
		ldd #$55ff
		sta $0071
		stb level

reset_hook	nop

		orcc #$50
		lds #$0100

		lda #$ff
		tfr a,dp
		setdp $ff

		; XXX 64K mode for testing.  I hope to get everything
		; within 32K.
		;sta $ffdf

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

		; SAM display offset = $0200
		sta reg_sam_f0s
		sta reg_sam_f1c
		sta reg_sam_f2c

		lda #$01
		tfr a,dp
		setdp $01

		lda level
		inca
		beq 1F
		ldd #$fd40
		sta reg_pia0_pdrb
		bitb reg_pia0_pdra
		lbeq cheat
1

		ldx #select_screen_dz	; dzip start
		jsr dunzip_text_screen

		lda #$0f
		sta playing
set_sound_on	clr sound

10		ldx #$0294
		lda playing
		ldb #4
		pshs a,b
15		lsr ,s
		bcc 20F
		ldd #$1905
		std ,x
		lda #$13
		bra 22F
20		ldd #$0e0f
		std ,x
		lda #$20
22		sta 2,x
		leax 32,x
		dec 1,s
		bne 15B
		leas 2,s

		ldd #$0606
		tst sound
		bne 23F
		ldd #$0e20
23		std $03ae

		; wait if key held
		clr reg_pia0_pdrb
26		lda reg_pia0_pdra
		ora #$80
		inca
		bne 26B

27		ldx #tbl_keyboard
28		ldd ,x++
		beq 27B
		sta reg_pia0_pdrb
		bitb reg_pia0_pdra
		bne 28B
		jmp [,x]

toggle_p1	lda #$01
		bra 30F
toggle_p2	lda #$02
		bra 30F
toggle_p3	lda #$04
		bra 30F
toggle_p4	lda #$08
30		eora playing
		sta playing
		bra 10B
set_sound_off	lda #$ff
		sta sound
		bra 10B

		DATA
tbl_keyboard	fdb $7f20,start_game
		fdb $fd01,toggle_p1	; $fd10 for coco
		fdb $fb01,toggle_p2	; $fb10 for coco
		fdb $f701,toggle_p3	; $f710 for coco
		fdb $ef01,toggle_p4	; $ef10 for coco
		fdb $df01,set_sound_on	; $df10 for coco
		fdb $bf01,set_sound_off	; $bf10 for coco
		fdb 0
		CODE

start_game

		; must select some players
		lda playing
		beq 10B

		; flag all players as "dead" so they get reset
		lda #$ff
		sta dead
		; level -1: will be incremented before use
		sta level

cheat

		; SAM VDG mode = G6R,G6C
		;sta reg_sam_v0c
		sta reg_sam_v1s
		sta reg_sam_v2s
		; VDG mode = CG6, CSS0
		lda #$e2
		sta reg_pia1_pdrb

		clr anim_count

; initialise for next level

level_setup

		lda playing
		eora #$0f
		sta finished

		; clear monsters (-ve HP)
		ldx #monsters
		ldd #$8000|monster_base_tile
1		clr spr_hp,x
		sta obj_y,x
		stb spr_base_tile,x
		leax sizeof_monster,x
		cmpx #monsters_end
		blo 1B

		ldu #levels
		lda level
		inca
		cmpa #25
		blo 5F
		ldx #end_screen_dz
		jmp game_over_screen
5		sta level
		lsla
		ldx #levelcache_end
		stx dzip_end	; dzip end
		ldx a,u		; dzip start
		ldu #levelcache
		jsr dunzip
		; clear object bitmap
10		clr ,u+
		cmpu #bmap_pickups_end
		blo 10B

		lda level
		cmpa #12
		blo 10F
		suba #12
10		ldb #36
		mul
		ldx #tile_stone01_a
		leax d,x
		stx stone_a
		leax 18,x
		stx stone_b

		ldu #levelcache
		ldy #objects

		; u -> level door list
		; y -> current door list
		lda #max_doors
		sta tmp0
10		pulu d
		tstb
		bmi 20F
		tfr d,x
		lda #door_h
		bra 30F
20		andb #$7f
		tfr d,x
		lda #door_v
30		jsr place_object
		jsr x_clr_pickup
		dec tmp0
		bne 10B

		sty mod_objects_non_doors
		sty mod_objects_non_doors_2

		; u -> level key list
		; y -> object list
		lda #max_keys
		sta tmp0
10		pulu x
		cmpx #$8080
		beq 30F
		lda #key
		bsr place_object
		ldd -(max_doors*2)-2,u
		andb #$7f
		std obj_key_opens-sizeof_object,y
30		dec tmp0
		bne 10B

		; u -> level trapdoor list
		; XXX also populate current trapdoor list
		lda #max_trapdoors
		sta tmp0
		ldx #trapdoors
10		pshs x
		pulu x
		lda #trapdoor
		bsr place_object
		tfr x,d		; d = y,x
		puls x
		std ,x++
		dec tmp0
		bne 10B

		; u -> level item list
		; y -> object list
		lda #max_items
		sta tmp0
10		pulu a,x
		cmpa #drainer
		bne 20F
		ldb #20
		stb obj_drainer_hp,y
20		bsr place_object
30		dec tmp0
		bne 10B

		; clear any remaining objects
		; including shots
		; y -> object list
10		cmpy #all_objects_end
		bhs 80F
		clr ,y+
		bra 10B
80

		; unpack play screen
		ldx #fb0_top
		stx dzip_end
		ldu #fb0
		ldx #play_screen_dz
		jsr dunzip

		bsr plr_setup

		jmp mainloop

		; x = y,x
		; a = type
place_object
		pshs x
		sta obj_tile,y
		stx obj_y,y
		tfr x,d
		cmpa #$80	; y = $80?
		beq 99F		; invalid object - skip
		bsr set_pickup
		bsr yx_to_voff
		bcc 10F
10		stx obj_voff,y
		leay sizeof_object,y
99		puls x,pc

; sets bit in pickup table
; on entry:
; 	a = y
; 	b = x
set_pickup
		pshs b,x
		ldx #tbl_x_to_bit
		ldb b,x
		ldx #bmap_pickups+128
		orb a,x
		stb a,x
		puls b,x,pc

		DATA
tbl_x_to_bit	fcb $80,$40,$20,$10,$08,$04,$02,$01
		CODE

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

		; b = oid
		; returns y -> object
object_ptr	pshs a,b,x
		lda #sizeof_object
		mul
		ldx #objects
		leay d,x
		puls a,b,x,pc

; - - -

; on entry:
; 	a = y
; 	b = x
; return:
; 	x = voff
; 	cc.c = 1 if odd

yx_to_voff
		pshs a,b,u
		ldu #tbl_y_to_voff
		anda #7
		lsla
		ldx a,u
		ldu #tbl_x_to_voff
		lda b,u
		leax a,x
		lsrb
		puls a,b,u,pc

		DATA
tbl_y_to_voff	fdb $0000,$0120,$0240,$0360,$0480,$05a0,$06c0,$07e0
tbl_x_to_voff	fcb 0,1,3,4,6,7,9,10
		CODE

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

; set up player.  if player is dead, restore default stats and clear
; score.  always restore to 99 health.

; entry:
;     u -> player struct
;     y -> player defaults

plr_setup

		; setup players (restore defaults if dead)
		ldu #player1
		ldy #tbl_plr_dfl
		ldb #1
		stb tmp0

		ldx #dead_players_top
		stx death_stack

10
		lda tmp0
		sta plr_bit,u
		lsl tmp0
		ldd plr_dfl_stat_win,y
		std plr_stat_win,u
		ldd plr_dfl_vp,y
		std plr_vp,u
		ldd plr_dfl_y,y
		std spr_next_y,u
		ldb #$02
		stb plr_yroom,u	; invalidate yroom
		ldd #$8080
		std plr_key_opens,u	; no key
		clr plr_speed,u		; no speedyboots
		lsr dead
		bcc 20F
		; reset player stats if dead
		ldd plr_dfl_armour,y	; armour & power
		std plr_armour,u
		lda plr_dfl_ammo,y	; ammo
		sta plr_ammo,u
		clr plr_score2,u
		clr plr_score0,u
		; always reset health
20		lda #$99
		sta spr_hp,u
		lda plr_dfl_facing,y
		sta spr_facing,u
		clr plr_moving,u
		clr plr_nshots,u
		ldb #state_plr_draw_room
		stb spr_state,u
		lda plr_dfl_base_sprite,y
		sta spr_base_tile,u
		jsr plr_draw_stats

		leay sizeof_player_defaults,y
		leau sizeof_player,u
		cmpu #players_end
		blo 10B
		clr dead		; clear remaining bits

		; check player keys in order: magic, up, down, right, left,
		; fire.  only one key at a time!  i think in the case of
		; joysticks, fire must be checked first.

		setdp $ff	; only ever called with DP=$ff

scan_keys	lda #6
		sta tmp0
10		ldd ,x
		sta reg_pia0_pdrb
		bitb reg_pia0_pdra
		beq 20F
		leax 3,x
		dec tmp0
		bne 10B
		rts
20		lda 2,x
		andcc #$fb
		rts

		DATA
tbl_player1_keys
		fdb $f704
		fcb -2
		fdb $7f10
		fcb facing_up
		fdb $f710
		fcb facing_down
		fdb $fe20
		fcb facing_right
		fdb $fb20
		fcb facing_left
		fdb $fd10
		fcb -1

tbl_player2_keys
		fdb $fe08
		fcb -2
		fdb $fe10
		fcb facing_up
		fdb $ef08
		fcb facing_down
		fdb $f708
		fcb facing_right
		fdb $fb08
		fcb facing_left
		fdb $fe04
		fcb -1
		CODE

plr_scan_controls

		; keyboard & joystick scanning - will hit the PIAs a lot,
		; so set DP
		lda #$ff
		tfr a,dp
		setdp $ff

		ldu #player1
		lda spr_state,u
		beq 10F
		cmpa #state_plr_landed
		bne 90F
10		clr plr_moving,u
		ldx #tbl_player1_keys
		bsr scan_keys
		beq 90F		; no keypress
		bmi 20F		; fire or magic
		sta spr_facing,u
		stb plr_moving,u
		bra 90F
20		jsr plr_fire
90

		ldu #player2
		lda spr_state,u
		beq 10F
		cmpa #state_plr_landed
		bne 90F
10		clr plr_moving,u
		ldx #tbl_player2_keys
		bsr scan_keys
		beq 90F		; no keypress
		bmi 20F		; fire or magic
		sta spr_facing,u
		stb plr_moving,u
		bra 90F
20		jsr plr_fire
90

		; disable sound mux
		ldd #$35ff
		sta reg_pia1_crb
		stb reg_pia0_pdrb

		; player 3 - left joystick
		ldu #player3
		lda spr_state,u
		beq 10F
		cmpa #state_plr_landed
		bne 90F
10		clr plr_moving,u
		ldd #$3d34
		sta reg_pia0_crb	; left joystick
		stb reg_pia0_cra	; x axis
		lda reg_pia0_pdra
		bita #$02
		bne 15F
		; fire
		jsr plr_fire
		bra 90F
15		lda #$20
		sta reg_pia1_pdra
		lda reg_pia0_pdra	; left?
		bmi 20F
		lda #facing_left
		bra 80F
20		ldd #$ffc0
		sta reg_pia1_pdra
		stb reg_pia1_pdra
		lda reg_pia0_pdra	; right?
		bpl 30F
		lda #facing_right
		bra 80F
30		lda #$3c
		sta reg_pia0_cra	; y axis
		lda reg_pia0_pdra	; down?
		bpl 40F
		lda #facing_down
		bra 80F
40		neg reg_pia1_pdra
		lda reg_pia0_pdra	; up?
		bmi 90F
		lda #facing_up
80
		sta spr_facing,u
		inca
		sta plr_moving,u
90

		; player 4 - right joystick
		ldu #player4
		lda spr_state,u
		beq 10F
		cmpa #state_plr_landed
		bne 90F
10		clr plr_moving,u
		ldd #$353c
		sta reg_pia0_crb	; right joystick
		stb reg_pia0_cra	; y axis
		lda reg_pia0_pdra
		bita #$01
		bne 15F
		; fire
		bsr plr_fire
		bra 90F
15		lda #$20
		sta reg_pia1_pdra
		lda reg_pia0_pdra	; up?
		bmi 20F
		lda #facing_up
		bra 80F
20		ldd #$ffc0
		sta reg_pia1_pdra
		stb reg_pia1_pdra
		lda reg_pia0_pdra	; down?
		bpl 30F
		lda #facing_down
		bra 80F
30		lda #$34
		sta reg_pia0_cra	; x axis
		lda reg_pia0_pdra	; right?
		bpl 40F
		lda #facing_right
		bra 80F
40		neg reg_pia1_pdra
		lda reg_pia0_pdra	; left?
		bmi 90F
		lda #facing_left
80
		sta spr_facing,u
		inca
		sta plr_moving,u
90

		; re-enable sound mux
		lda #$34
		sta reg_pia0_cra	; mux sel 0 = 0
		ldd #$c03d
		sta reg_pia1_pdra	; dac = sbs high value
		stb reg_pia1_crb	; enable sound mux

		lda #$01
		tfr a,dp

		rts

plr_fire
		lda plr_nshots,u
		cmpa plr_ammo,u
		blo 10F
		rts
10		inca
		sta plr_nshots,u
		ldy #shots
20		lda obj_tile,y
		beq 30F
		leay sizeof_object,y
		bra 20B		; XXX *should* be safe...
30		ldb spr_facing,u
		lsrb
		addb #8
		addb spr_base_tile,u
		stb obj_tile,y
		ldb spr_facing,u
		stb obj_shot_facing,y
		ldd obj_y,u
		std obj_y,y
		jsr yx_to_voff
		stx obj_voff,y
		stu obj_shot_plr,y
		rts

		setdp $01

; - - -

plr_draw_armour	ldx plr_stat_win,u
		leax 2*fb_w+3+128,x
		lda plr_armour,u
		bra draw_snum

plr_draw_power	ldx plr_stat_win,u
		leax 10*fb_w+2+128,x
		lda plr_power,u
		; fall through to draw_snum

draw_snum	pshs u
		ldu #tbl_snum
		lsla
		ldu a,u
		pulu d
		sta -128,x
		stb -96,x
		pulu d
		sta -64,x
		stb -32,x
		lda ,u
		sta ,x+
		puls u,pc

plr_draw_hp	ldx plr_stat_win,u
		leax 13*fb_w+128,x
		lda spr_hp,u
		bra draw_lnum_pair

		; u -> player
plr_draw_stats	pshs y,u
		ldx plr_stat_win,u
		leax fb_w+128,x
		lda spr_base_tile,u
		adda #2
		jsr single_tile_a
		ldu 2,s
		bsr plr_draw_armour
		bsr plr_draw_power
		bsr plr_draw_ammo
		bsr plr_draw_hp
		bsr plr_draw_score
		puls y,u,pc

plr_add_score
		adda plr_score0,u
		daa
		sta plr_score0,u
		lda plr_score2,u
		adca #$00
		daa
		sta plr_score2,u
		; fall through to plr_draw_score

plr_draw_score	ldx plr_stat_win,u
		leax 23*fb_w+128,x
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
		bsr 10F
		puls a
		lsla
		anda #$1e
10		pshs u
		ldu #tbl_lnum
		ldu a,u
		pulu d
		sta -128,x
		stb -96,x
		pulu d
		sta -64,x
		stb -32,x
		pulu d
		sta ,x+
		stb 31,x
		lda ,u
		sta 63,x
		puls u,pc

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

plr_draw_key	ldx plr_stat_win,u
		leax 2+32,x
		ldd #$a656
		sta -32,x
		stb ,x
		lda #$66
		sta 32,x
		rts

plr_undraw_key	ldx plr_stat_win,u
		leax 2+32,x
		ldd #$aaaa
		sta -32,x
		stb ,x
		sta 32,x
		rts

plr_draw_speed	ldx plr_stat_win,u
		leax 4*fb_w+2+64,x
		ldd #$a69a
		sta -64,x
		stb -32,x
		sta ,x
		stb 32,x
		lda #$6a
		sta 64,x
		rts

plr_undraw_speed
		ldx plr_stat_win,u
		leax 4*fb_w+2+64,x
		ldd #$aaaa
		sta -64,x
		stb -32,x
		sta ,x
		stb 32,x
		sta 64,x
		rts

		DATA

tbl_plr_dfl
		; player 1 defaults
		fcb 7*8+3-128,3		; plr_dfl_y,x
		fcb p1_base_tile	; plr_dfl_base_sprite
		fcb facing_up		; plr_dfl_facing
		fcb 3			; plr_dfl_armour
		fcb 2			; plr_dfl_power
		fcb 3			; plr_dfl_ammo
		fdb stat_win1		; plr_dfl_stat_win
		fdb vp1+128		; plr_dfl_vp
		; player 2 defaults
		fcb 7*8+4-128,3		; plr_dfl_y,x
		fcb p2_base_tile	; plr_dfl_base_sprite
		fcb facing_right	; plr_dfl_facing
		fcb 1			; plr_dfl_armour
		fcb 3			; plr_dfl_power
		fcb 2			; plr_dfl_ammo
		fdb stat_win2		; plr_dfl_stat_win
		fdb vp2+128		; plr_dfl_vp
		; player 3 defaults
		fcb 7*8+3-128,4		; plr_dfl_y,x
		fcb p3_base_tile	; plr_dfl_base_sprite
		fcb facing_down		; plr_dfl_facing
		fcb 4			; plr_dfl_armour
		fcb 9			; plr_dfl_power
		fcb 1			; plr_dfl_ammo
		fdb stat_win3		; plr_dfl_stat_win
		fdb vp3+128		; plr_dfl_vp
		; player 4 defaults
		fcb 7*8+4-128,4		; plr_dfl_y,x
		fcb p4_base_tile	; plr_dfl_base_sprite
		fcb facing_left		; plr_dfl_facing
		fcb 6			; plr_dfl_armour
		fcb 5			; plr_dfl_power
		fcb 2			; plr_dfl_ammo
		fdb stat_win4		; plr_dfl_stat_win
		fdb vp4+128		; plr_dfl_vp

		CODE

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
20		lda obj_y,u
		deca
		bvs 30F
		leau sizeof_monster,u
		cmpu #monsters_end
		blo 20B
		rts
30		lda #8
		sta spr_hp,u
		ldd trapdoor_y,y
		std obj_y,u
		stb spr_cx,u
		jsr yx_to_voff
		stx obj_voff,u
		stx spr_ovoff,u
		; fall through to mon_change_direction

mon_change_direction
next_dir	equ *+1
		lda #$06
		adda #2
		anda #$06
		sta next_dir
		cmpa spr_facing,u		; same direction?
		beq mon_change_direction	; try again
		sta spr_facing,u
		clr spr_state,u
		; fall through to spr_set_tile

; Determine which tile to use for a sprite.  Calculates based on facing, x
; and y and adds to base_tile.  Because x & y vary, this animates sprite
; as it moves.
; Entry:
; 	u -> sprite

spr_set_tile
		lda spr_facing,u
		bita #$04
		bne 10F
		; up/down
		ldb obj_y,u
		bra 20F
		; left/right
10		ldb obj_x,u
20		lsrb
		adca spr_base_tile,u
		sta obj_tile,u
		rts

; returns:
; 	a = new y
; 	b = new x
; 	x -> stone bitmap byte
; 	cc.z = 1 if not stone/door
spr_move
		lda spr_facing,u
		ldx #jtbl_spr_move
		jmp [a,x]
		DATA
jtbl_spr_move	fdb spr_move_up,spr_move_down,spr_move_left,spr_move_right
		CODE
spr_move_up	ldd obj_y,u
		deca
		bra 10F
spr_move_down	ldd obj_y,u
		inca
10		ldx #tbl_x_to_bit
		pshs b
		ldb b,x
		ldx #bmap_level+128
		bitb a,x
		puls b,pc
spr_move_left	ldd obj_y,u
		decb
		bpl 10B
		ldb #$07
		suba #48
		bra 10B
spr_move_right	ldd obj_y,u
		incb
		andb #7
		bne 10B
		adda #48
		bra 10B

hit_player
		lda #$90
		adda plr_armour,u
		adda spr_hp,u
		daa
		bcs 10F
		jsr kill_player
		clra
10		sta spr_hp,u
		jsr plr_draw_hp
		bra 50F

mon_check_direction
		bsr spr_move
		bne 55F
10		pshs u
		ldu #players
20		cmpd obj_y,u
		beq hit_player
		leau sizeof_player,u
		cmpu #players_end
		blo 20B
		ldu #monsters
30		cmpd obj_y,u
		beq 50F
		leau sizeof_monster,u
		cmpu #monsters_end
		blo 30B
		; no collisions - monster is moving
		puls u
		std spr_next_y,u
		eora obj_y,u
		anda #$f8
		beq 40F
		jsr spr_set_tile
		lda #state_mon_new_room
		bra spr_set_state
40		jsr spr_set_tile
		bra spr_inc_state
		; collision - change direction
50		puls u
55		jsr mon_change_direction
		jmp obj_draw

mon_landed
		jsr spr_undraw
		ldd spr_next_y,u
		std obj_y,u
		stb spr_cx,u
		jsr yx_to_voff
		stx obj_voff,u
		stx spr_ovoff,u
		clr spr_state,u
		; fall through to mon_centred

mon_centred
		jsr spr_set_tile
		bsr obj_draw
		bra spr_inc_state

spr_move1
		jsr spr_undraw
		ldx #tbl_obj_voff1
		ldb obj_x,u
		andb #1
		orb spr_facing,u
		lslb
		ldd b,x
		; a = offset from current screen position
		; b = tile set select (0=A, 1=B)
		ldx spr_ovoff,u
		leax a,x
		stx obj_voff,u
		stb spr_cx,u
		bsr obj_draw_vx
		bra spr_inc_state

mon_die
		lda #bones0
		bsr 10F
		bra spr_inc_state
mon_dying
		lda obj_tile,u
		beq 20F
		inca
		cmpa #bones2
		bls 10F
		clra
10		sta obj_tile,u
		ldx obj_voff,u
		; use cx to position the death anim exactly where the
		; monster was
		ldb spr_cx,u
		bra obj_draw_vx
20		ldb #$80
		stb obj_y,u
		rts

		DATA
		; offset,tileset select
tbl_obj_voff1	fcb -3*fb_w,0	; up, x&1=0
		fcb -3*fb_w,1	; up, x&1=1
		fcb 3*fb_w,0	; down, x&1=0
		fcb 3*fb_w,1	; down, x&1=1
		fcb -1,1	; left, x&1=0
		fcb 0,0		; left, x&1=1
		fcb 0,1		; right, x&1=0
		fcb 1,0		; right, x&1=1
		; offset only (tileset remains)
		; could just reuse voff1 table and invert x&1
tbl_obj_voff2	fcb -3*fb_w	; up, x&1=0
		fcb -3*fb_w	; up, x&1=1
		fcb 3*fb_w	; down, x&1=0
		fcb 3*fb_w	; down, x&1=1
		fcb 0		; left, x&1=0
		fcb -1		; left, x&1=1
		fcb 1		; right, x&1=0
		fcb 0		; right, x&1=1
		CODE

process_monsters
		ldu #monsters
10		lda obj_y,u
		deca
		bvs 20F
		lda spr_state,u
		ldx #jtbl_monster_state
		jsr [a,x]
20		leau sizeof_monster,u
		cmpu #monsters_end
		blo 10B
		rts

		DATA
jtbl_monster_state
		fdb mon_centred		; 0
		fdb mon_check_direction	; 2
		fdb spr_move1		; 4
		fdb spr_delay		; 6
		fdb spr_move2		; 8
		fdb mon_landed		; 10
state_mon_new_room	equ *-jtbl_monster_state
		fdb spr_delay		; 12
		fdb spr_delay		; 14
		fdb spr_delay		; 16
		fdb mon_landed		; 18
state_mon_die	equ *-jtbl_monster_state
		fdb mon_die		; 20
		fdb mon_dying		; 22
		CODE

spr_inc_state	lda spr_state,u
spr_delay	adda #2
spr_set_state	sta spr_state,u
		rts

spr_move2
		jsr spr_undraw
		ldx #tbl_obj_voff2
		ldb obj_x,u
		stb spr_cx,u
		andb #1
		orb spr_facing,u
		lda b,x
		; a = offset from current screen position
		; b = tile set select (0=A, 1=B)
		ldx obj_voff,u
		leax a,x
		stx obj_voff,u
		bsr obj_draw_v
		bra spr_inc_state

; Draw object.
; Entry:
; 	u -> object
obj_draw	ldx obj_voff,u
; ... if x already == voff
obj_draw_v	ldb obj_x,u
; ... if b *also* already == x
obj_draw_vx	lda obj_y,u
		anda #$f8
		sta obj_draw_yroom	; preserve room
		lda obj_tile,u
; ... if a *also* already == tile, but note must manually set obj_draw_yroom
; don't need u to point to an object to call this
obj_draw_vxt	stx tmp4		; preserve voff
		pshs u
		lsrb
		bcs 10F
		ldx #tbl_tiles_a
		ldy #single_tile_x_a
		bra 15f
10		ldx #tbl_tiles_b
		ldy #single_tile_x_b
15		leax a,x
		ldu a,x
		pshs u
		lda obj_draw_yroom	; re-fetch room
		cmpa player1+plr_yroom
		bne 20F
		ldx tmp4		; re-fetch voff
		leax vp1+128,x
		jsr ,y
		lda obj_draw_yroom	; re-fetch room
20		cmpa player2+plr_yroom
		bne 30F
		ldx tmp4		; re-fetch voff
		leax vp2+128,x
		ldu ,s
		jsr ,y
		lda obj_draw_yroom	; re-fetch room
30		cmpa player3+plr_yroom
		bne 40F
		ldx tmp4		; re-fetch voff
		leax vp3+128,x
		ldu ,s
		jsr ,y
		lda obj_draw_yroom	; re-fetch room
40		cmpa player4+plr_yroom
		bne 90F
		ldx tmp4		; re-fetch voff
		leax vp4+128,x
		ldu ,s
		jsr ,y
90		puls x,u,pc

spr_undraw
		ldx spr_ovoff,u
spr_undraw_v
		pshs x			; preserve voff
		bsr spr_test_pickup
		beq 30F
mod_objects_non_doors	equ *+2
		ldy #objects
		ldx obj_y,u
10		lda obj_tile,y
		cmpa #always_draw_tile	; this tile always drawn?
		bhs 20F			; skip - drawn soon enough anyway
		cmpx obj_y,y
		beq 40F
20		leay sizeof_object,y
		cmpy #objects_end
		blo 10B
		puls x,pc
30		clra
40		puls x			; restore voff
		ldb obj_y,u
		andb #$f8
		stb obj_draw_yroom
		ldb obj_x,u
		jmp obj_draw_vxt

plr_draw_objects
		bsr spr_undraw		; from other windows
		ldd plr_vp,u
		std 20F
		ldb spr_next_y,u
		stb 15F
		pshs u
		; draw objects
		ldy #objects
10		lda obj_tile,y
		beq 50F
		ldb obj_y,y
15		equ *+1
		eorb #$00
		andb #$f8
		bne 50F
		ldx obj_voff,y
20		equ *+2
		leax >$0000,x
		jsr draw_object_once
50		leay sizeof_object,y
		cmpy #objects_end
		blo 10B
		puls u
		lda plr_bit,u
		bita playing
		beq plr_set_inactive
		lda #state_plr_landed
		sta spr_state,u
		rts

plr_set_inactive
		lda #state_plr_inactive
		sta spr_state,u
		lda spr_next_y,u
		anda #$f8
		sta plr_yroom,u
		com obj_x,u
		rts

; on entry:
; 	y -> sprite
; returns:
; 	a = y
; 	b = x bit
; 	x -> pickup bitmap byte
; 	cc.z = 1 if no pickup
spr_test_pickup
		ldd obj_y,u
		ldx #tbl_x_to_bit
		ldb b,x
		ldx #bmap_pickups+128
		bitb a,x
		rts

plr_landed
		jsr spr_undraw
		ldd spr_next_y,u
		std obj_y,u
		anda #$f8
		sta plr_yroom,u
		ldd obj_y,u
		stb spr_cx,u
		jsr yx_to_voff
		stx obj_voff,u
		stx spr_ovoff,u
		clr spr_state,u
		bsr spr_test_pickup
		beq 99F
		; pickups...
		ldx obj_y,u
		ldy #objects
10		lda obj_tile,y
		beq 20F
		bmi 20F
		cmpx obj_y,y
		bne 20F
		pshs a,x,y
		ldx #jtbl_pickup
		lsla
		jsr [a,x]
		puls a
		ldx #tbl_pickup_scores
		lda a,x
		beq 15F
		ldy 2,s
		jsr obj_clr_pickup
		clr obj_tile,y
		jsr plr_add_score
15		puls x,y
20		leay sizeof_object,y
		cmpy #objects_end
		blo 10B
		; fall through to plr_centred
99

plr_centred

		jsr spr_set_tile
		jsr obj_draw
		lda plr_moving,u
		beq 30F
		lda dead
		sta tmp0
		jsr spr_move
		beq 10F
		cmpd plr_key_opens,u
		bne 30F
		bra plr_open_door
10		lsr tmp0
		bcs 12F
		cmpd player1+obj_y
		beq 30F
12		lsr tmp0
		bcs 14F
		cmpd player2+obj_y
		beq 30F
14		lsr tmp0
		bcs 16F
		cmpd player3+obj_y
		beq 30F
16		lsr tmp0
		bcs 18F
		cmpd player4+obj_y
		beq 30F
18		ldy #monsters
20		cmpd obj_y,y
		beq 35F
		leay sizeof_monster,y
		cmpy #monsters_end
		blo 20B
		bra 40F
30		lda #state_plr_landed
		sta spr_state,u
		rts
35		lda spr_hp,u
		adda #$99
		daa
		bcs 36F
		jsr kill_player
		clra
36		sta spr_hp,u
		jmp plr_draw_hp
40		std spr_next_y,u
		anda #$f8
		cmpa plr_yroom,u
		beq 50F
		dec plr_yroom,u	; invalidate yroom
		lda #state_plr_draw_room
		jmp spr_set_state
50		jsr spr_set_tile
		jmp spr_inc_state

plr_delay	lda #state_plr_landed
		sta spr_state,u
		rts

x_clr_pickup
		pshs a
		tfr x,d
		bra 10F
; on entry:
; 	y -> object
obj_clr_pickup
		pshs a
		ldd obj_y,y
10		ldx #tbl_x_to_bit
		ldb b,x
		ldx #bmap_pickups+128
		comb
		andb a,x
		stb a,x
		puls a,pc

plr_open_door
		ldx #doors
10		cmpd obj_y,x
		beq 20F
		leax sizeof_object,x
		; XXX theoretically safe
		bra 10B
20		clr obj_tile,x
		ldx #tbl_x_to_bit
		ldb b,x
		ldx #bmap_level+128
		comb
		andb a,x
		stb a,x
		ldd #$8080
		std plr_key_opens,u
		jsr plr_undraw_key
plr_inactive	rts

process_players
		ldu #players
10		lda spr_state,u
		bmi 20F
		lda spr_state,u
		ldx #jtbl_player_state
		jsr [a,x]
20		leau sizeof_player,u
		cmpu #players_end
		blo 10B
		rts

plr_die
		lda #bones0-1
		sta obj_tile,u
		ldx obj_voff,u
		ldb spr_cx,u
		clra
		jsr obj_draw_vx
		jmp spr_inc_state

plr_dying
		lda obj_tile,u
		cmpa #bones7
		bhs 10F
		inca
		bra 20F
10		ldb spr_hp,u
		beq 20F
		ldb #state_plr_undying
		stb spr_state,u
20		sta obj_tile,u
		ldx spr_ovoff,u
		; don't use cx - player should die centred
		ldb obj_x,u
		jmp obj_draw_vx
plr_undying
		lda obj_tile,u
		cmpa #bones0
		bls 10F
		deca
		bra 20B
10 		lda #state_plr_landed
		sta spr_state,u
		lda plr_bit,u
		coma
		anda dead
		sta dead
		jmp plr_draw_hp

		DATA
jtbl_player_state
		fdb plr_centred		; 0
		fdb spr_move1		; 2
		fdb spr_move2		; 4
state_plr_landed	equ *-jtbl_player_state
		fdb plr_landed		; 6
state_plr_draw_room	equ *-jtbl_player_state
		fdb plr_draw_room	; 8
		fdb plr_draw_objects	; 10
state_plr_die	equ *-jtbl_player_state
		fdb plr_die		; 12
state_plr_dying	equ *-jtbl_player_state
		fdb plr_dying		; 14
state_plr_undying	equ *-jtbl_player_state
		fdb plr_undying		; 16
state_plr_inactive	equ *-jtbl_player_state
		fdb plr_inactive	; 18
state_plr_delay	equ *-jtbl_player_state
		fdb spr_delay		; 20
		fdb plr_delay		; 22
		CODE

kill_player_y
		exg y,u
		bsr kill_player
		exg y,u
99		rts

kill_player
		lda spr_state,u
		cmpa #state_plr_dying
		beq 99B
		cmpa #state_plr_die
		beq 99B
		ldx death_stack
		stu ,--x
		stx death_stack
		lda #state_plr_die
		sta spr_state,u
		lda dead
		ora plr_bit,u
		sta dead
		ldx plr_key_opens,u
		cmpx #$8080
		beq 99B
		pshs y
		ldy #objects
20		lda obj_tile,y
		beq 30F
		leay sizeof_object,y
		bra 20B
30		stx obj_key_opens,y
		lda #key
		sta obj_tile,y
		ldd obj_y,u
		std obj_y,y
		jsr set_pickup
		ldd #$8080
		std plr_key_opens,u
		jsr plr_undraw_key
		puls y,pc

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

; TODO
; player able to move into shot, so need to spr_move before placing
; the shot and then reverse how things are done here.

shot_hit_player
		ldx obj_shot_plr,u
		lda #$9a
		suba plr_power,x
		adda spr_hp,y
		daa
		bcs 10F
		jsr kill_player_y
		clra
10		sta spr_hp,y
		pshs u
		leau ,y
		jsr plr_draw_hp
		puls u
		bra 15F

shot_hit_monster
		lda #$9a
		pshs u
		ldu obj_shot_plr,u
		suba plr_power,u
		adda spr_hp,y
		daa
		bcs 10F
		ldd #$0100|state_mon_die	; 1pt for monster
		stb spr_state,y
		jsr plr_add_score
		; fall through - monster hp ignored now
10		sta spr_hp,y
		puls u
		bra 15F

process_shots
		ldu #shots
10		lda obj_tile,u
		beq 80F
		ldx obj_voff,u
		jsr spr_undraw_v
		jsr spr_move
		beq 20F

15		clr obj_tile,u
		ldx obj_shot_plr,u
		dec plr_nshots,x
		bra 80F

20		ldy #players
30		cmpd obj_y,y
		beq shot_hit_player
		leay sizeof_player,y
		cmpy #players_end
		blo 30B

		ldy #monsters
40		cmpd obj_y,y
		beq shot_hit_monster
		leay sizeof_monster,y
		cmpy #monsters_end
		blo 40B

		std obj_y,u
		jsr yx_to_voff
		stx obj_voff,u

		jsr spr_test_pickup
		beq 80F

		; drainers...
		ldx obj_y,u
		ldy #objects
50		lda obj_tile,y
		cmpa #drainer
		bne 70F
		cmpx obj_y,y
		beq shot_drainer
70		leay sizeof_object,y
		cmpy #objects_end
		blo 50B

80		leau sizeof_object,u
		cmpu #shots_end
		blo 10B
		rts

shot_drainer
		lda obj_shot_facing,u
		eora #$02
		sta obj_shot_facing,u
		lda obj_tile,u
		eora #$01
		sta obj_tile,u
		pshs u
		ldu obj_shot_plr,u
		lda #1
		jsr plr_add_score
		puls u
		dec obj_drainer_hp,y
		bne 80B
		clr obj_tile,y
		bra 80B

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

; on entering pickup dispatch:
;   a  = object type
;   y -> object
;   u -> player

		; not a pickup: drain health
pickup_drainer
		ldb spr_hp,u
		subb #$20
		bcc 10F
		jsr kill_player
		clr spr_hp,u
		jsr plr_draw_hp
		leas 3,s	; skip return address, stacked object type
		puls x,y,pc

pickup_potion
		lda plr_score0,u
		anda #$0f
		ldb #$11
		mul
10		stb spr_hp,u
		jmp plr_draw_hp

pickup_food
		lda spr_hp,u
		adda #$10
		daa
		bcc 10F
		lda #$99
10		sta spr_hp,u
		jmp plr_draw_hp

pickup_armour
		lda plr_armour,u
		inca
		cmpa #7
		bhi 99F
		sta plr_armour,u
		jmp plr_draw_armour

pickup_nop
99		rts

pickup_money
		rts

pickup_power
		lda plr_power,u
		inca
		cmpa #9
		bhi 99B
		sta plr_power,u
		jmp plr_draw_power

pickup_weapon
		lda plr_ammo,u
		inca
		cmpa #3
		bhi 99B
		sta plr_ammo,u
		jmp plr_draw_ammo

pickup_cross
		lda dead
		beq 10F
		ldx death_stack
		ldy ,x++
		stx death_stack
		lda #$32
		sta spr_hp,y
		lda plr_bit,y
		coma
		anda dead
		sta dead
10		rts

pickup_key
		ldd plr_key_opens,u
		ldx obj_key_opens,y
		stx plr_key_opens,u
		std obj_key_opens,y
		cmpd #$8080
		bne 10F
		clr obj_tile,y
		jsr obj_clr_pickup
10		jmp plr_draw_key

		; not a pickup: teleport player
pickup_tport
		ldx obj_y,y
10		leay sizeof_object,y
		cmpy #objects_end
		blo 20F
		ldy #objects
20		lda obj_tile,y
		cmpa #tport
		bne 10B
		ldd obj_y,y
		deca
		std spr_next_y,u
		anda #$f8
		cmpa plr_yroom,u
		beq 30F
		dec plr_yroom,u	; invalidate yroom
		lda #state_plr_draw_room
		bra 40F
30		lda #state_plr_landed
40		sta spr_state,u
		leas 3,s	; skip return address, stacked object type
		puls x,y,pc

pickup_exit
		lda #state_plr_inactive
		sta spr_state,u
		lda finished
		ora plr_bit,u
		sta finished
		com obj_x,u
		leas 3,s	; skip return address, stacked object type
		puls x,y,pc

		DATA

tbl_pickup_scores	equ *-1		; floor not a pickup
		fcb 0		; exit
		fcb 0		; trapdoor
		fcb $20		; money
		fcb $05		; food
		fcb 0		; tport
		fcb $10		; power
		fcb $10		; armour
		fcb $10		; potion
		fcb $10		; weapon
		fcb $10		; cross
		fcb $10		; speed
		fcb 0		; drainer
		fcb 0		; key

jtbl_pickup	equ *-2			; no dispatch for floor
		fdb pickup_exit		; exit
		fdb pickup_nop		; trapdoor
		fdb pickup_money
		fdb pickup_food
		fdb pickup_tport	; tport
		fdb pickup_power
		fdb pickup_armour
		fdb pickup_potion
		fdb pickup_weapon
		fdb pickup_cross	; cross
		fdb pickup_nop		; speed
		fdb pickup_drainer	; drainer
		fdb pickup_key		; key

		CODE

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

dunzip_text_screen
		; SAM VDG mode = SG4
		sta reg_sam_v1c
		sta reg_sam_v2c
		; VDG mode = SG4, CSS0
		clr reg_pia1_pdrb
		ldu #$0400
		stu dzip_end
		ldu #$0200
		; fall through to dunzip

		include "dunzip.s"

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

		DATA

select_screen_dz	includebin "select-screen.bin.dz"
death_screen_dz	includebin "death-screen.bin.dz"
end_screen_dz	includebin "end-screen.bin.dz"
play_screen_dz	includebin "play-screen.bin.dz"

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
level25		includebin "level25.bin.dz"

levels
		fdb level1,level2,level3,level4
		fdb level5,level6,level7,level8
		fdb level9,level10,level11,level12
		fdb level13,level14,level15,level16
		fdb level17,level18,level19,level20
		fdb level21,level22,level23,level24
		fdb level25

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

		include "tiles.s"

TILE_NEGATIVE	macro
		fdb tile_door_v_\1
		fdb tile_door_h_\1
		endm

TILE_LIST	macro
		fdb tile_floor_\1
		fdb tile_exit_\1
		fdb tile_trapdoor_\1
		fdb tile_money_\1
		fdb tile_food_\1
		fdb tile_tport_\1
		fdb tile_power_\1
		fdb tile_armour_\1
		fdb tile_potion_\1
		fdb tile_weapon_\1
		fdb tile_cross_\1
		fdb tile_speed_\1
mod_drainer_\1	fdb tile_drainer0_\1
		fdb tile_key_\1

		fdb tile_p1_up0_\1
		fdb tile_p1_up1_\1
		fdb tile_p1_down0_\1
		fdb tile_p1_down1_\1
		fdb tile_p1_left0_\1
		fdb tile_p1_left1_\1
		fdb tile_p1_right0_\1
		fdb tile_p1_right1_\1
		fdb tile_arrow_up_\1
		fdb tile_arrow_down_\1
		fdb tile_arrow_left_\1
		fdb tile_arrow_right_\1

		fdb tile_p2_up0_\1
		fdb tile_p2_up1_\1
		fdb tile_p2_down0_\1
		fdb tile_p2_down1_\1
		fdb tile_p2_left0_\1
		fdb tile_p2_left1_\1
		fdb tile_p2_right0_\1
		fdb tile_p2_right1_\1
		fdb tile_fball_up_\1
		fdb tile_fball_down_\1
		fdb tile_fball_left_\1
		fdb tile_fball_right_\1

		fdb tile_p3_up0_\1
		fdb tile_p3_up1_\1
		fdb tile_p3_down0_\1
		fdb tile_p3_down1_\1
		fdb tile_p3_left0_\1
		fdb tile_p3_left1_\1
		fdb tile_p3_right0_\1
		fdb tile_p3_right1_\1
		fdb tile_axe_up_\1
		fdb tile_axe_down_\1
		fdb tile_axe_left_\1
		fdb tile_axe_right_\1

		fdb tile_p4_up0_\1
		fdb tile_p4_up1_\1
		fdb tile_p4_down0_\1
		fdb tile_p4_down1_\1
		fdb tile_p4_left0_\1
		fdb tile_p4_left1_\1
		fdb tile_p4_right0_\1
		fdb tile_p4_right1_\1
		fdb tile_sword_up_\1
		fdb tile_sword_down_\1
		fdb tile_sword_left_\1
		fdb tile_sword_right_\1

		fdb tile_monster_up0_\1
		fdb tile_monster_up1_\1
		fdb tile_monster_down0_\1
		fdb tile_monster_down1_\1
		fdb tile_monster_left0_\1
		fdb tile_monster_left1_\1
		fdb tile_monster_right0_\1
		fdb tile_monster_right1_\1

		fdb tile_bones0_\1
		fdb tile_bones1_\1
		fdb tile_bones2_\1
		fdb tile_bones3_\1
		fdb tile_bones4_\1
		fdb tile_bones5_\1
		fdb tile_bones6_\1
		fdb tile_bones7_\1
		endm

		TILE_NEGATIVE a
tbl_tiles_a	TILE_LIST a
		TILE_NEGATIVE b
tbl_tiles_b	TILE_LIST b

tbl_snum	equ *-2		; no zero in this font
		fdb tile_snum_1,tile_snum_2,tile_snum_3
		fdb tile_snum_4,tile_snum_5,tile_snum_6,tile_snum_7
		fdb tile_snum_8,tile_snum_9
tbl_lnum	fdb tile_lnum_0,tile_lnum_1,tile_lnum_2,tile_lnum_3
		fdb tile_lnum_4,tile_lnum_5,tile_lnum_6,tile_lnum_7
		fdb tile_lnum_8,tile_lnum_9

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

dead_players	rmb 8
dead_players_top

trapdoors	rmb max_trapdoors*sizeof_trapdoor
trapdoors_end

monsters	equ *+monster_offset
		rmb max_monsters*sizeof_monster
monsters_end	equ *+monster_offset

objects
doors		rmb max_doors*sizeof_object
keys		rmb max_keys*sizeof_object
items		rmb max_items*sizeof_object
		rmb max_trapdoors*sizeof_object
objects_end
shots		rmb 12*sizeof_object
shots_end
all_objects_end

