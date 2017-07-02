; Dunjunz
; Dragon version by Ciaran Anscomb <xroar@6809.org.uk>
; BBC Micro/Master original by Julian Avis and Copyright Bug Byte 1987

; This rewrite for the Dragon does not reference any original code, all
; behaviour is inferred.

; Level data was, however, converted from the BBC disk version using
; information gleaned from David Boddie's Python scripts.

; ========================================================================

; There are 4 x 6 rooms in each map.  Each room has 8 x 8 positions.  Room
; IDs are organised like this:

; -$80  -$50  -$20  $10
; -$78  -$48  -$18  $18
; -$70  -$40  -$10  $20
; -$68  -$38  -$08  $28
; -$60  -$30   $00  $30
; -$58  -$28   $08  $38

; Object positions (y,x) are not strictly cartesian.  The 'y' coordinate
; is a room ID plus vertical offset within the room.  The 'x' coordinate
; is just horizontal offset into the room.  Thus, 'y' ranges from -$80 to
; $3f, and 'x' ranges from 0 to 7.

; Two simple bitmaps are maintained.  'bmp_wall' tracks where walls and
; doors are (anything that blocks player movement).  Doors are cleared
; within the bitmap when opened.  'bmp_objects' indicates where objects
; are, consulted both for pickups and undrawing.

; In each bitmap, one byte represents all positions for one 'y'
; coordinate.  Most significant bit maps to leftmost position ('x' == 0).

; ========================================================================

; Definitions

DEBUG_LEVEL25	equ 0

		include	"dragonhw.s"
		include "objects.s"
		include "notefreq.s"

fb0		equ $0200	; framebuffer base
fb_w		equ 32		; framebuffer line width
fb_h		equ 192		; framebuffer height
fb0_end		equ fb0+fb_w*fb_h

; Tile dimensions in pixels.  Information only.  Check 'yx_to_woff' for
; how (y,x) is actually mapped to window offsets.

tile_w		equ 12
tile_h		equ 9

; Size of wall and pickup bitmaps.

bmp_w		equ 4
bmp_h		equ 48
sizeof_bmp	equ bmp_w*bmp_h

; Window base addresses

p1_win		equ fb0+20*fb_w+1
p2_win		equ fb0+20*fb_w+14
p3_win		equ fb0+100*fb_w+1
p4_win		equ fb0+100*fb_w+14

; Stats window base addresses

p1_swin		equ fb0+21*fb_w+27
p2_swin		equ p1_swin+40*fb_w
p3_swin		equ p1_swin+80*fb_w
p4_swin		equ p1_swin+120*fb_w

; Player window dimensions in tiles.  Here for information only: code
; assumes these values and they must not change.

win_w		equ 8
win_h		equ 8

; Maximum numbers of certain types of object.

max_doors	equ 20
max_keys	equ 20
max_items	equ 30		; including exit
max_trapdoors	equ 8		; *must* be this amount of trapdoors

max_monsters	equ 28		; needn't all be active at once

; Players, monsters, shots: need to know which way each of them is facing.
; Multiples of 2 for indexing into jump tables.  Order important as bit
; twiddling is used to reverse the direction of shots.

facing_up	equ 0
facing_down	equ 2
facing_left	equ 4
facing_right	equ 6

; ========================================================================

; Structures
; ----------

; _obj_ - object.  Type is indicated by 'tile'.  Reserves a few bytes of
; arbitrary data, use of which is type-dependent.

		org 0
obj_y		rmb 1		; 'y' coordinate in map (-$80 to $3f)
obj_x		rmb 1		; 'x' coordinate in map (0 to 7)
obj_tile	rmb 1		; tile id
obj_woff	rmb 2		; precalc offset into window
obj_data	rmb 3
sizeof_obj

obj_drainer_hp	equ obj_data
obj_key_opens	equ obj_data
obj_shot_facing	equ obj_data
obj_shot_plr	equ obj_data+1

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

; _spr_ - sprite.  Extends _obj_.

spr_org_	org 0-spr_offset_

spr_next_y	rmb 1		; destination 'y' when moving
spr_next_x	rmb 1		; destination 'x' when moving

spr_hp		rmb 1		; hit points (BCD)
spr_state	rmb 1		; state machine index

spr_cx		rmb 1		; current 'x' - see note

spr_offset_	equ *-spr_org_
		rmb sizeof_obj

spr_tilebase	rmb 1		; lowest tile id for player tiles

sizeof_sprite	equ *+spr_offset_

spr_facing	equ obj_data	; one of facing_*
spr_owoff	equ obj_data+1	; origin win offset (undraw during move)
spr_tmp0	equ obj_data+1	; use as a counter when not moving

; Note: spr_cx is only used for its lowest bit, which is modified during
; horizontal movement and changes which tileset to use when drawing.

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

; _mon_ - monster.  Inherits from _spr_.

mon_org_	org 0-mon_offset_

mon_offset_	equ *-mon_org_+spr_offset_
		rmb sizeof_sprite

sizeof_mon	equ *+mon_offset_

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

; _plr_ - player.  Extends _spr_.

plr_org_	org 0-plr_offset_

; 'control' - populated while reading keyboard/joysticks.
;   $00 = no action
;   $01 = fire
;   $02 = magic
;   $80|facing = move

plr_control	rmb 1

plr_nshots	rmb 1		; number of active shots (<= ammo)
plr_key_opens	rmb 2		; (y,x) of door that held key opens
plr_speed	rmb 1		; non-zero = player moves fast!
plr_score2	rmb 1		; BCD
plr_score0	rmb 1		; BCD
plr_yroom	rmb 1		; obj_y & 0xf8
plr_bit		rmb 1		; bit within playing/done

plr_offset_	equ *-plr_org_+spr_offset_
		rmb sizeof_sprite

plr_swin	rmb 2		; address of stats window
plr_win		rmb 2		; address of player window
plr_armour	rmb 1		; armour
plr_power	rmb 1		; weapon power
plr_ammo	rmb 1		; ammunition (1 to 3)

sizeof_plr	equ *+plr_offset_

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

; _p_dfl_ - player defaults.  Used by setup_players.

		org 0
p_dfl_y		rmb 1		; initial 'y' coordinate in map
p_dfl_x		rmb 1		; initial 'x' coordinate in map
p_dfl_tilebase	rmb 1		; lowest player tile id
p_dfl_facing	rmb 1		; initially facing direction
p_dfl_armour	rmb 1		; initial armour
p_dfl_power	rmb 1		; initial weapon power
p_dfl_ammo	rmb 1		; initial ammunition
p_dfl_swin	rmb 2		; fb offset of stats window
p_dfl_win	rmb 2		; fb offset of player window
sizeof_p_dfl

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

; _lvl_ - level source data.

		org 0
lvl_doors	rmb max_doors*2		; y,x
lvl_keys	rmb max_keys*2		; y,x
lvl_items	rmb max_items*3		; tile,y,x
lvl_trapdoors	rmb max_trapdoors*2	; y,x
lvl_bmp_wall	rmb sizeof_bmp		; wall bitmap
sizeof_lvl

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

; Keyboard table entry macros to reduce possibility of error.

KEYDSP_ENTRY	macro
		fcb ~(1<<\1)		; column
		fcb 1<<\2		; row
		fdb \3			; dispatch
		endm

KEYTBL_ENTRY	macro
		fcb ~(1<<\1)		; column
		fcb 1<<\2		; row
		fcb \3			; action
		endm

; Head up a state machine jump table with this macro.

STATE_JTBL	macro
19824		equ *
		endm

; Use this macro to create symbols for specific states.

STATE_ID	macro
\1		equ *-19824B
		endm

; Patches that directly modify code to cope with different machine or
; display variants use a common format.

PATCH		macro
		fcb 19826F-19825F
		fdb \1
19825
		endm

ENDPATCH	macro
19826
		endm

; ========================================================================

; Direct page variables

; Trying to keep player sprites here for now, as there are plenty of
; places where we manipulate them directly rather than as offsets into the
; player struct.

		org $0112
gamedp		equ *>>8

tmp0		rmb 2
dzip_end
tmp1		rmb 2

playing		rmb 1		; bits 0-3 = player 1-4 active
finished	rmb 1		; bits 0-3 = player 1-4 finished level
dead		rmb 1		; bits 0-3 = player 1-4 dead
exiting		rmb 1		; non-zero = a player is using exit

; 'death_fifo' is a list of pointers to _plr_ struct in order of player
; death.  'death_fifo_end' points to end of list, where next dead player
; is stored.  FIFO is shifted on resurrection.

death_fifo_end	rmb 2		; ptr to end of death fifo

; PSG channel priority
psg_c1pri	rmb 1
psg_c2pri	rmb 1

difficulty	rmb 1
sound		rmb 1
joystk_mode	rmb 1
level		rmb 1

anim_count	rmb 1

p3_moved	rmb 1
p4_moved	rmb 1

; Player structs

players		equ *+plr_offset_
player1		equ *+plr_offset_
		rmb sizeof_plr
player2		equ *+plr_offset_
		rmb sizeof_plr
player3		equ *+plr_offset_
		rmb sizeof_plr
player4		equ *+plr_offset_
		rmb sizeof_plr
players_end	equ *+plr_offset_

; ========================================================================

; Level source unzips into screen area.  Will then immediately overwrite
; by unzipping play screen.  Level wall bitmap placed such that unpacking
; puts it in the right place without need to copy.

levelcache	equ fb0_end-(sizeof_lvl-sizeof_bmp)

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

		org fb0_end

; Wall bitmap.  Bits set where wall or door exists.  Tested against before
; moving, and door bits cleared when opened.

bmp_wall	rmb sizeof_bmp
bmp_wall_end

; Objects bitmap.  Bits set where any object lies.  Used to determine if
; pickups need processed, or if a non-floor tile needs redrawn when a
; sprite moves.

bmp_objects	rmb sizeof_bmp
bmp_objects_end

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

		CODE
CODE_start_	equ *
		DATA
DATA_start_	equ *
		BSS
BSS_start_	equ *
		CODE

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

; Programmable Sound Generator & Mixer.

; Either channel can be configured as a sawtooth or square wave using
; self-modifying code.  The core for each channel always generates a
; sawtooth wave.  The result is ANDed, either with $FF (no change - still
; sawtooth), or $80 (square wave).  This is then shifted so that summing
; can't overflow.

; The square wave ends up having half the amplitude of the sawtooth, but
; in terms of RMS it's not too far off.

; Then envelope is applied, also using self-modifying code.  Two bytes are
; executed, generally either NOP or LSRA.  Two LSRA instructions would
; drop the amplitude of the channel to a quarter.

psg_play2frags
		bsr psg_playfrag
		; fall through to psg_playfrag

psg_playfrag
		lda #*>>8
		tfr a,dp
		setdp *>>8

		; channel 1 "envelope"
psg_c1env	equ *+1
		ldu #psg_c1freq		; convenient initial zero
		pulu d,x
		std psg_c1freq
		beq 10F
		stx psg_c1envops
		stu psg_c1env
		bra 20F
10		sta psg_c1pri
		std psg_c1off
20

		; channel 2 "envelope"
psg_c2env	equ *+1
		ldu #psg_c2freq		; convenient initial zero
		pulu d,x
		std psg_c2freq
		beq 10F
		stx psg_c2envops
		stu psg_c2env
		bra 20F
10		sta psg_c2pri
		std psg_c2off
20

		lda psg_c1pri
		ora psg_c2pri
		beq 10F
		ldb #$3d
		stb reg_pia1_crb	; enable sound mux
10

		ldx #100		; fragment length
		ldu #reg_pia1_pdra	; DAC

		; - - - - - - - - - - - - - - - - - - - - - - -

psg_core_loop

psg_c1off	equ *+1
                ldd #$0000		; 3
psg_c1freq	equ *+1
                addd #$0000		; 4
		std psg_c1off		; 5
psg_c1wave	equ *+1
		anda #$ff		; 2
		lsra			; 2

psg_c1envops	nop			; 2
		nop			; 2
		sta psg_c1val		; 4

psg_c2off	equ *+1
                ldd #$0000		; 3
psg_c2freq	equ *+1
                addd #$0000		; 4
		std psg_c2off		; 5
psg_c2wave	equ *+1
		anda #$ff		; 2
		lsra			; 2

psg_c2envops	nop			; 2
		nop			; 2

psg_c1val	equ *+1
		adda #$00		; 2

		anda #$fc		; 2
		sta ,u			; 4
		leax -1,x		; 4
		bne psg_core_loop	; 3
					; total 59 cycles

		; - - - - - - - - - - - - - - - - - - - - - - -

		ldd #$3580
		sta reg_pia1_crb	; disable sound mux
		stb ,u			; centre DAC

		lda #gamedp
		tfr a,dp
		setdp gamedp
		rts

; Set up a sequence to be played.  Find lower priority channel and
; populate its data.

; Sound data starts with a waveform (either psg_wave_sqr or psg_wave_saw), and
; continues with a list of (frequency,envelope).  A zero frequency ends
; the list.

; Entry:
; 	a = priority
; 	x -> sound data

psg_play_snd	ldb sound
		beq 10F

		ldb psg_c1pri
		cmpb psg_c2pri
		bhi psg_play_snd_c2

psg_play_snd_c1	cmpa psg_c1pri
		bls 10F
		sta psg_c1pri
		lda ,x+
		sta psg_c1wave
		stx psg_c1env
		ldd #$0000
		std psg_c1off
10		rts

psg_play_snd_c2	cmpa psg_c2pri
		bls 10F
		sta psg_c2pri
		lda ,x+
		sta psg_c2wave
		stx psg_c2env
		ldd #$0000
		std psg_c2off
10		rts

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

; Sound data

psg_wave_sqr	equ $80		; (anda) #$80
psg_wave_saw	equ $ff		; (anda) #$ff

psg_env3	equ $1212	; nop,nop
psg_env2	equ $1244	; nop,lsra
psg_env1	equ $4444	; lsra,lsra
psg_env0	equ $124f	; nop,clra

		DATA
snd_key		fcb psg_wave_sqr
		fdb g6,psg_env3,g6,psg_env2
		fdb 0

snd_hit		fcb psg_wave_sqr
		fdb c4,psg_env3,a3,psg_env3
		fdb 0

snd_bump	fcb psg_wave_sqr
		fdb f3,psg_env3
		fdb 0

snd_monster_hit	fcb psg_wave_saw
		fdb e4,psg_env1,c4,psg_env3
		fdb 0

snd_monster_die	fcb psg_wave_saw
		fdb c4,psg_env3,c4,psg_env2
		fdb e4,psg_env3,e4,psg_env2
		fdb c4,psg_env3,c4,psg_env2
		fdb e4,psg_env2,e4,psg_env1
		fdb e4,psg_env2,e4,psg_env1
		fdb 0

snd_drainer	fcb psg_wave_saw
		fdb g2,psg_env2,g1,psg_env2
		fdb g2,psg_env2,g1,psg_env2
		fdb g2,psg_env2,g1,psg_env2
		fdb g2,psg_env2,g1,psg_env2
		fdb 0

snd_low		fcb psg_wave_saw
		fdb c4,psg_env1,c4,psg_env2
		fdb c4+20,psg_env2,c4+20,psg_env2
		fdb c4,psg_env3,c4,psg_env3
		fdb c4+20,psg_env3,c4+20,psg_env3
		fdb 0

snd_money	fcb psg_wave_sqr
		fdb c7,psg_env2,c7,psg_env3
		fdb c7-20,psg_env3,c7-20,psg_env3
		fdb c7,psg_env3,c7,psg_env2
		fdb c7-20,psg_env1,c7-20,psg_env1
		fdb 0

snd_fire	fcb psg_wave_saw
		fdb c5,psg_env1,c5,psg_env2
		fdb 0

snd_door	fcb psg_wave_saw
		fdb f5,psg_env3,f5,psg_env3
		fdb f4,psg_env2,f4,psg_env2
		fdb f4,psg_env2,f4,psg_env1
		fdb 0

snd_food	fcb psg_wave_saw
		fdb g5,psg_env3,g5,psg_env2
		fdb g5+20,psg_env3,g5+20,psg_env2
		fdb g4,psg_env3,g4,psg_env2
		fdb g4+20,psg_env3,g4+20,psg_env2
		fdb 0

snd_magic	fcb psg_wave_saw
		fdb c4,psg_env3,c4,psg_env1
		fdb e4,psg_env3,e4,psg_env1
		fdb c5,psg_env3,c5,psg_env1
		fdb c5,psg_env3,c5,psg_env1
		fdb c4,psg_env3,c4,psg_env1
		fdb e4,psg_env3,e4,psg_env1
		fdb c5,psg_env2,c5,psg_env1
		fdb c5,psg_env2,c5,psg_env1
		fdb c4,psg_env2,c4,psg_env1
		fdb e4,psg_env2,e4,psg_env1
		fdb c5,psg_env2,c5,psg_env1
		fdb c5,psg_env2,c5,psg_env1
		fdb c4,psg_env1,c4,psg_env1
		fdb e4,psg_env1,e4,psg_env1
		fdb c5,psg_env1,c5,psg_env1
		fdb c5,psg_env1,c5,psg_env1
		fdb 0

snd_exit	fcb psg_wave_saw
		fdb c7,psg_env3,c7,psg_env3
		fdb (c7+b6)/2,psg_env3,(c7+b6)/2,psg_env3
		fdb b6,psg_env3,b6,psg_env3
		fdb (b6+as6)/2,psg_env3,(b6+as6)/2,psg_env3
		fdb as6,psg_env3,as6,psg_env3
		fdb (as6+a6)/2,psg_env3,(as6+a6)/2,psg_env3
		fdb a6,psg_env3,a6,psg_env3
		fdb (a6+gs6)/2,psg_env3,(a6+gs6)/2,psg_env3
		fdb gs6,psg_env3,gs6,psg_env3
		fdb (gs6+g6)/2,psg_env3,(gs6+g6)/2,psg_env3
		fdb g6,psg_env3,g6,psg_env3
		fdb (g6+fs6)/2,psg_env3,(g6+fs6)/2,psg_env3
		fdb fs6,psg_env3,fs6,psg_env3
		fdb (fs6+f6)/2,psg_env3,(fs6+f6)/2,psg_env3
		fdb f6,psg_env3,f6,psg_env3
		fdb (f6+e6)/2,psg_env3,(f6+e6)/2,psg_env3
		fdb e6,psg_env3,e6,psg_env3
		fdb (e6+ds6)/2,psg_env3,(e6+ds6)/2,psg_env3
		fdb ds6,psg_env3,ds6,psg_env3
		fdb (ds6+d6)/2,psg_env3,(ds6+d6)/2,psg_env3
		fdb d6,psg_env2,d6,psg_env2
		fdb (d6+cs6)/2,psg_env2,(d6+cs6)/2,psg_env2
		fdb cs6,psg_env1,cs6,psg_env1
		fdb (cs6+c6)/2,psg_env1,(cs6+c6)/2,psg_env1
		fdb 0

snd_tport	fcb psg_wave_saw
		fdb cs5,psg_env1,ds5,psg_env1
		fdb f5,psg_env1,g5,psg_env1
		fdb a5,psg_env1,b5,psg_env1
		fdb c6,psg_env1
		fdb cs5,psg_env2
		fdb ds5,psg_env2,f5,psg_env2
		fdb g5,psg_env2,a5,psg_env2
		fdb b5,psg_env2,c6,psg_env2
		fdb cs5,psg_env3,ds5,psg_env3
		fdb f5,psg_env3,g5,psg_env3
		fdb a5,psg_env3,b5,psg_env3
		fdb c6,psg_env3
		fdb cs5,psg_env3,ds5,psg_env3
		fdb f5,psg_env3,g5,psg_env3
		fdb a5,psg_env3,b5,psg_env3
		fdb c6,psg_env3
		fdb cs5,psg_env3,ds5,psg_env3
		fdb f5,psg_env3,g5,psg_env3
		fdb a5,psg_env3,b5,psg_env3
		fdb c6,psg_env3
		fdb cs5,psg_env2,ds5,psg_env2
		fdb f5,psg_env2,g5,psg_env2
		fdb a5,psg_env2,b5,psg_env2
		fdb c6,psg_env2
		fdb cs5,psg_env1
		fdb ds5,psg_env1,f5,psg_env1
		fdb g5,psg_env1,a5,psg_env1
		fdb b5,psg_env1,c6,psg_env1
		fdb 0

		CODE

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

; Main game loop


		; tile set 0
anim_tiles_0	ldx #tile_drainer0_a
		stx mod_drainer_a
		ldx #tile_drainer0_b
		stx mod_drainer_b
		ldx #tile_money0_a
		stx mod_money_a
		ldx #tile_money0_b
		stx mod_money_b
		ldx #tile_power0_a
		ldu #tile_power0_b
		ldy #tile_chalice_nw0_a
		bra 10F

		; tile set 1
anim_tiles_1	ldx #tile_drainer1_a
		stx mod_drainer_a
		ldx #tile_drainer1_b
		stx mod_drainer_b
		ldx #tile_money1_a
		stx mod_money_a
		ldx #tile_money1_b
		stx mod_money_b
		ldx #tile_power1_a
		ldu #tile_power1_b
		ldy #tile_chalice_nw1_a
10		stx mod_power_a
		stu mod_power_b
		sty mod_chalice
mod_draw_chalice_0
                jsr update_chalice
		bra anim_done

animate
		; Two-frame animations toggle every 8 frames.
		inc anim_count
		lda anim_count
		anda #15
		beq anim_tiles_1
		anda #7
		beq anim_tiles_0
anim_done

		; Always update *some* objects
		ldu #pickups
10		lda obj_tile,u
		cmpa #always_draw_tile
		blo 50F
		jsr obj_draw
50		leau sizeof_obj,u
		cmpu #all_objects_end
		blo 10B

		rts

mainloop

		bsr animate

		jsr process_monsters
		jsr plr_scan_controls
		jsr process_players
		jsr process_shots
		jsr psg_play2frags

		ldb #$7f40
		sta reg_pia0_pdrb
		bitb reg_pia0_pdra	; SHIFT?
		bne 60F
		lda #$fb
		sta reg_pia0_pdrb
		bitb reg_pia0_pdra	; BREAK?
		beq 99F
60

		lda finished
		ora dead
		cmpa #$0f
		bne mainloop

		lda dead
		cmpa playing
		bne finished_level

		lda #$ff
		sta level	; no cheating once all dead!
		ldy #death_screen	; dzip start
game_over_screen
		jsr write_screen

		; a few seconds pause for reflection
		ldx #$2000
10		deca
		bne 10B
		leax -1,x
		bne 10B
99		jmp game_reset

		DATA
death_screen	fcb 12
		fdb fb0+18*fb_w+128
		includebin "death-screen.bin"
		CODE

finished_level
		lda level
		cmpa #24
		beq end_animation
		jmp level_setup

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

eanim_add
		lda obj_y,y
		cmpa #$80
		bne 10F
		pulu a,b
		std obj_y,y
		stb spr_cx,y
		jsr yx_to_woff
		stx obj_woff,y
		stx spr_owoff,y
		clr spr_state,y
		leay sizeof_mon,y
10		rts

mon_step4	bsr mon_step1
		bsr mon_step1
		bsr mon_step1
mon_step1	pshs u
		jsr mon_run_state
		puls u,pc

eanim_step	pshs u
		ldu #monsters
10		lda obj_y,u
		deca
		bvs 20F
		lda spr_state,u
		ldx #jtbl_eanim_state
		jsr [a,x]
20		leau sizeof_mon,u
		cmpu #monsters_end
		blo 10B
		puls u,pc

end_animation
		; first, destroy all monsters
		ldu #monsters
		ldb #state_mon_die
10		lda obj_y,u
		deca
		bvs 20F
		stb spr_state,u
20		leau sizeof_mon,u
		cmpu #monsters_end
		blo 10B
		; step monsters through to death
		bsr mon_step4

		ldd #1200
		std mod_edelay

		lda #2
		sta mod_eanim_rate

		lda #$01
		pshs a

30		ldy #monsters
		ldu #tbl_eanim

40		bsr eanim_add
		pshs y,u

		lda 4,s
		deca
		beq 42F
		cmpa #13
		bne 44F
		sta 4,s
		lda #$ff
		ldx #snd_tport
		jsr psg_play_snd
		bra 46F
42		lda #$ff
		ldx #snd_magic
		jsr psg_play_snd
		lda #25
44		sta 4,s
46

		jsr animate
		jsr eanim_step

		jsr psg_play2frags
mod_edelay	equ *+1
		ldx #1200
1		leax -1,x
		bne 1B

		ldx mod_edelay
		leax -2,x
		beq 90F
		stx mod_edelay
		cmpx #900
		beq 1F
		cmpa #600
		bne 2F
1		lda mod_eanim_rate
		adda #2
		sta mod_eanim_rate
2

60		puls y,u
		cmpu #tbl_eanim_end
		blo 40B
		bra 30B

90		leas 5,s

		; finish off
		ldb #15
		pshs b
91		jsr animate
		jsr eanim_step
		jsr psg_play2frags
		dec ,s
		bne 91B
		leas 1,s

		jmp level_setup

eanim_start
		lda #bones0
		bra 20F
eanim_cont
		lda obj_tile,u
		inca
		cmpa #bones2
		bls 20F
		clra
20		sta obj_tile,u
		ldx obj_woff,u
		ldb obj_x,u
		jsr obj_draw_vx
		lda obj_tile,u
		bne 30F
		lda #$80
		sta obj_y,u
30		lda spr_state,u
mod_eanim_rate	equ *+1
		adda #2
		sta spr_state,u
		rts

		DATA
tbl_eanim
		fcb $16,4
		fcb $16,3
		fcb $16,2
		fcb $16,1
		fcb $15,1
		fcb $14,1
		fcb $13,1
		fcb $13,2
		fcb $13,3
		fcb $13,4
		fcb $14,4
		fcb $15,4
tbl_eanim_end

jtbl_eanim_state
		STATE_JTBL
		STATE_ID "state_eanim_start"
		fdb eanim_start
		fdb spr_delay
		fdb spr_delay
		fdb spr_delay
		fdb eanim_cont
		fdb spr_delay
		fdb spr_delay
		fdb spr_delay
		fdb eanim_cont
		fdb spr_delay
		fdb spr_delay
		fdb spr_delay
		fdb eanim_cont
		fdb spr_set_state
		fdb spr_set_state
		fdb spr_set_state
		CODE

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

		CODE

; First state while changing room.  Initialises player window with map
; outline: stone & floor.  Next state will draw all objects.

; Entry:
;     x -> screen
;     u -> player struct

DRAW_ROW_A_FAST	macro
		pulu d
		std \1,x
		endm

DRAW_LAST_ROW_A_FAST	macro
		ldd ,u
		std \1,x
		endm

DRAW_ROW_B_FAST	macro
		lda \1,x
		clrb
		addd ,u++
		std \1,x
		endm

DRAW_LAST_ROW_B_FAST	macro
		lda \1,x
		clrb
		addd ,u
		std \1,x
		endm

plr_draw_room
		ldb spr_next_y,u
		andb #$f8
		ldx #bmp_wall+128
		leay b,x
		ldx plr_win,u
		lda #win_h
		sta tmp1
		pshs u
10		lda ,y+
		sta tmp0
		lda #win_w/2
		sta tmp1+1

20
		; even tiles
		ldu #tile_floor_a
		lsl tmp0
		bcc 30F
mod_stone_a	equ *+1
		ldu #$0000
30		DRAW_ROW_A_FAST -128
		DRAW_ROW_A_FAST -96
		DRAW_ROW_A_FAST -64
		DRAW_ROW_A_FAST -32
		DRAW_ROW_A_FAST 0
		DRAW_ROW_A_FAST 32
		DRAW_ROW_A_FAST 64
		DRAW_ROW_A_FAST 96
		DRAW_LAST_ROW_A_FAST 128

		; odd tiles
		leax 1,x
		ldu #tile_floor_b
		lsl tmp0
		bcc 40F
mod_stone_b	equ *+1
		ldu #$0000
40		DRAW_ROW_B_FAST -128
		DRAW_ROW_B_FAST -96
		DRAW_ROW_B_FAST -64
		DRAW_ROW_B_FAST -32
		DRAW_ROW_B_FAST 0
		DRAW_ROW_B_FAST 32
		DRAW_ROW_B_FAST 64
		DRAW_ROW_B_FAST 96
		DRAW_LAST_ROW_B_FAST 128

		leax 2,x
		dec tmp1+1
		lbne 20B

		leax (9*fb_w)-12,x
		dec tmp1
		lbne 10B
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
		leau a,u
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
		leau a,u
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
99		rts

update_chalice
		ldu #player1
		bsr plr_update_chalice
		ldu #player2
		bsr plr_update_chalice
		ldu #player3
		bsr plr_update_chalice
		ldu #player4
		; fall through to plr_update_chalice

plr_update_chalice
		ldb plr_yroom,u
plr_update_chalice_b
		andb #$f8
		cmpb #$10
		bne 99B
10		ldx plr_win,u
		leax 4*9*fb_w+3,x
mod_chalice	equ *+1
		ldu #tile_chalice_nw0_a
		jsr single_tile_x_a
		leau 2,u
		leax 1,x
		jsr single_tile_x_b
		leau 2,u
		leax 9*fb_w-1,x
		jsr single_tile_x_a
		leau 2,u
		leax 1,x
		jmp single_tile_x_b

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

		setdp 0			; assumed
game_reset	nop

		orcc #$50
		lds #$0100

		lda #$ff
		tfr a,dp
		setdp $ff

		clr reg_pia0_cra	; ddr...
		clr reg_pia0_ddra	; all inputs
		clr reg_pia0_crb	; ddr...
		ldd #$fffc
		sta reg_pia0_ddrb	; all outputs
		clr reg_pia1_cra	; ddr...
		stb reg_pia1_ddra	; only DAC bits are outputs
		clr reg_pia1_crb	; ddr...
PATCH_p1ddrb	equ *+1
		lda #$fc		; VDG & ROMSEL as outputs
		sta reg_pia1_ddrb
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

		; SAM VDG mode = G6R,G6C
		sta reg_sam_v0c
		sta reg_sam_v1s
		sta reg_sam_v2s

		lda #gamedp
		tfr a,dp
		setdp gamedp

		lda level
		inca
		beq 10F
		ldd #$fd40
		sta reg_pia0_pdrb
		bitb reg_pia0_pdra	; CLEAR?
		lbeq cheat
10

		ldy #select_screen
		jsr write_screen

mod_skip_init	brn skip_init
		clr difficulty
		clr joystk_mode
		lda #$0f
		sta playing
		dec mod_skip_init	; change to bra
set_sound_on	lda #$fc
update_sound	sta sound

skip_init

update_select_screen
		ldx #fb0+24*fb_w+4*8*fb_w+128
		stx tmp0

		lda playing
		ldb #4
		pshs a,b
10		lsr ,s
		bcc 20F
		ldy #text_yes
		bra 30F
20		ldy #text_no
30		jsr write_continue
		dec 1,s
		bne 10B
		leas 2,s

		ldy #text_hard
		tst difficulty
		bne 40F
		ldy #text_easy
40		jsr write_continue

		ldy #text_off
		tst sound
		beq 10F
		ldy #text_on
10		jsr write_continue

		ldy #text_1
		tst joystk_mode
		beq 10F
		ldy #text_2
10		jsr write_continue

		ldx #tbl_kdsp_menu
		jmp wait_keypress_jump

toggle_p1	lda #$01
		bra 10F
toggle_p2	lda #$02
		bra 10F
toggle_p3	lda #$04
		bra 10F
toggle_p4	lda #$08
10		eora playing
		sta playing
		bra update_select_screen
toggle_sound	lda sound
		eora #$fc
		bra update_sound
toggle_skill	com difficulty
		bra update_select_screen
toggle_joystk	com joystk_mode
		bra update_select_screen

show_version	ldx #fb0+24*fb_w+128
		stx tmp0
		ldy #version
		jsr write_continue
		jmp update_select_screen

		DATA
select_screen	fcb 8
		fdb fb0+24*fb_w+128
		includebin "select-screen.bin"
text_yes	fcb $8e,$22,$0e,$1c,$ff,0
text_no		fcb $8e,$17,$18,$27,$ff,0
text_hard	fcb $ff,$8e,$11,$0a,$1b,$0d,0
text_easy	fcb $ff,$8e,$0e,$0a,$1c,$22,0
text_on		fcb $ff,$8e,$18,$17,$27,0
text_off	fcb $ff,$8e,$18,$0f,$0f,0
text_1		fcb $ff,$ff,$8e,$01,0
text_2		fcb $ff,$ff,$8e,$02,0
version		includebin "version.bin"
		CODE

		DATA
tbl_kdsp_menu	KEYDSP_ENTRY 7,5,start_game	; SPACE
		KEYDSP_ENTRY 1,0,toggle_p1	; '1'
		KEYDSP_ENTRY 2,0,toggle_p2	; '2'
		KEYDSP_ENTRY 3,0,toggle_p3	; '3'
		KEYDSP_ENTRY 4,0,toggle_p4	; '4'
		KEYDSP_ENTRY 4,2,toggle_skill	; 'D'
		KEYDSP_ENTRY 3,4,toggle_sound	; 'S'
		KEYDSP_ENTRY 2,3,toggle_joystk	; 'J'
		KEYDSP_ENTRY 6,6,show_version	; N/C
		fdb 0
		CODE

start_game

		; must select some players
		lda playing
		lbeq update_select_screen

		lda difficulty
		bne 5F
		; easy mode
		ldd #$024c	; 2, inca
		sta mod_skill_door
		stb mod_skill_key
		ldd #$0400
		sta mod_monster_hp
		ldd #$0e90	; 14, 100-10
		bra 6F
		; hard mode
5		ldd #$0012	; 0, nop
		sta mod_skill_door
		stb mod_skill_key
		ldd #$0800
		sta mod_monster_hp
		ldd #$1480	; 20, 100-20
6		sta mod_drainer_hp
		stb mod_drainer_dmg

		lda joystk_mode
		bne 5F
		lda #$27	; beq
		fcb $8c		; cmpx
5		lda #$26	; bne
		sta mod_joystk_p3
		sta mod_joystk_p4

		; flag all players as "dead" so they get reset
		lda #$ff
		sta dead

	if DEBUG_LEVEL25

		bra 10F
cheat		lda #23
10		sta level

	else

		; level -1: will be incremented before use
		sta level
cheat

	endif

		; VDG mode = CG6, CSS0
PATCH_vdgmode_game	equ *+1
		lda #$e2
		sta reg_pia1_pdrb
		; fall through to level_setup

		; - - - - - - - - - - - - - - - - - - - - - - -

		DATA
end_screen	fcb 12
		fdb fb0+18*fb_w+128
		includebin "end-screen.bin"
		CODE

		; Set up next level.

level_setup

		lda playing
		eora #$0f
		sta finished
		clr exiting

		; Clear monsters
		ldx #monsters
		ldd #$8000|monster_tilebase
10		clr spr_hp,x
		sta obj_y,x
		stb spr_tilebase,x
		leax sizeof_mon,x
		cmpx #monsters_end
		blo 10B

		; Next level.  Detect when game is complete (finished
		; level 25).  Modify various routines to only call
		; chalice-based routines on level 25.  Unpack level data.
		ldu #levels
		ldb #$8c	; cmpx
		inc level
		lda level
		cmpa #24
		beq 10F
		blo 20F
		ldy #end_screen
		jmp game_over_screen
10		ldb #$bd	; jsr
20		stb mod_draw_chalice_0
		stb mod_draw_chalice_1
		stb mod_check_chalice
		lsla
		ldx #bmp_wall_end
		stx dzip_end	; dzip end
		ldx a,u		; dzip start
		ldu #levelcache
		jsr dunzip
		; clear object bitmap
30		clr ,u+
		cmpu #bmp_objects_end
		blo 30B

		; Select stone graphic based on level
		lda level
		ldb #18
		mul
		addd #tile_stone01_a
		std mod_stone_a
		addd #tiles_b_start-tiles_a_start
		std mod_stone_b

		; Populate object table

		ldu #levelcache		; source: from unpacked level
		ldy #objects		; destination: object table

		; Doors.  Source is (y,x) pairs.  Top bit of x set if door
		; is vertical, else horizontal.
		clr tmp0+1
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
30		com tmp0+1
		bne 40F
mod_skill_door	equ *+1
		suba #2
40		jsr place_object
		jsr clr_pickup_x
		dec tmp0
		bne 10B

		; Clear remaining door slots
10		cmpy #doors_end
		bhs 20F
		jsr clr_object
		bra 10B
20

		; Keys.  Source is (y,x) of key, and order is important:
		; the nth key here opens the nth door above.
		clr tmp0+1
		lda #max_keys
		sta tmp0
10		pulu x
		cmpx #$8080
		beq 30F
		lda #key
		com tmp0+1
		bne 20F
mod_skill_key	inca
20		bsr place_object
		ldd -(max_doors*2)-2,u
		andb #$7f
		std obj_key_opens-sizeof_obj,y
30		dec tmp0
		bne 10B

		; Clear remaining key slots
10		cmpy #keys_end
		bhs 20F
		bsr clr_object
		bra 10B
20

		; Items (pickups, drainers).  Source is (type,y,x).
		lda #max_items
		sta tmp0
10		pulu a,x
		cmpa #drainer
		bne 20F
mod_drainer_hp	equ *+1
		ldb #20
		stb obj_drainer_hp,y
20		bsr place_object
30		dec tmp0
		bne 10B

		; Clear remaining item slots
10		cmpy #items_end
		bhs 20F
		bsr clr_object
		bra 10B
20

		; Trapdoors.  Source is (y,x).
		lda #max_trapdoors
		sta tmp0
10		pulu x
		lda #trapdoor
		bsr place_object
		dec tmp0
		bne 10B

		; Clear any remaining objects, including shots
10		cmpy #all_objects_end
		bhs 20F
		bsr clr_object
		bra 10B
20

		; Unpack play screen
		ldx #fb0_end
		stx dzip_end
		ldu #fb0
		ldx #play_screen_dz
		jsr dunzip

		bra setup_players

		DATA
play_screen_dz	includebin "play-screen.bin.dz"
		CODE

		; - - - - - - - - - - - - - - - - - - - - - - -

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
		bsr yx_to_woff
		stx obj_woff,y
		leay sizeof_obj,y
99		puls x,pc

clr_object	ldd #$8080
		std obj_y,y
		clr obj_tile,y
		leay sizeof_obj,y
		rts

; Sets bit in pickup table.
; Entry:
; 	a = y
; 	b = x
set_pickup
		pshs b,x
		ldx #tbl_x_to_bit
		ldb b,x
		ldx #bmp_objects+128
		orb a,x
		stb a,x
		puls b,x,pc

; Clear bitmap entry for object y.
; Entry:
; 	y -> object
obj_clr_pickup	pshs a,x,y
		ldd obj_y,y
		bra clr_pickup_d_

; Clear bitmap entry for y,x (held in x) if no other pickups there.  Only
; necessary to check like this for keys and drainers.
; Entry:
; 	x = (y,x)
check_clr_pickup
		pshs a,x,y
		ldy #pickups
10		lda obj_tile,y
		beq 20F
		cmpx obj_y,y
		beq 30F
20		leay sizeof_obj,y
		cmpy #pickups_end
		blo 10B
clr_pickup_x_	tfr x,d
clr_pickup_d_	ldx #tbl_x_to_bit
		ldb b,x
		ldx #bmp_objects+128
		comb
		andb a,x
		stb a,x
30		puls a,x,y,pc

; Clear bitmap entry for y,x (held in x) without checking.
; Entry:
; 	x = (y,x)
clr_pickup_x	pshs a,x,y
		bra clr_pickup_x_

		DATA
tbl_x_to_bit	fcb $80,$40,$20,$10
		fcb $08,$04,$02,$01
		CODE

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

; on entry:
; 	a = y
; 	b = x
; return:
; 	x = woff

yx_to_woff
		pshs a,b,u
		ldu #tbl_y_to_woff
		anda #7
		lsla
		ldx a,u
		ldu #tbl_x_to_woff
		lda b,u
		leax a,x
		puls a,b,u,pc

		DATA
		; vertical offsets within a window
tbl_y_to_woff	fdb $0000,$0120
		fdb $0240,$0360
		fdb $0480,$05a0
		fdb $06c0,$07e0
		; horizontal offsets within a window, and within the whole
		; screen (when writing menus, messages, etc.)
tbl_x_to_woff	fcb 0,1,3,4
		fcb 6,7,9,10
		fcb 12,13,15,16
		fcb 18,19,21,22
		fcb 24,25,27,28
		fcb 30
		CODE

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

; Set up players.  If player is dead, restore default stats and clear
; score.  Always restore to 99 health.

; Continues from level_setup.

setup_players

		ldu #player1
		ldy #tbl_p_dfl
		lda #1

10
		sta plr_bit,u
		ldd p_dfl_swin,y	; stats window address
		std plr_swin,u
		ldd p_dfl_win,y		; player window address
		std plr_win,u
		lda p_dfl_tilebase,y	; tile base
		sta spr_tilebase,u
		ldd p_dfl_y,y		; default (y,x)
		std spr_next_y,u
		ldb #$02
		stb plr_yroom,u		; invalidate yroom
		ldd #$8080
		std obj_y,u
		std plr_key_opens,u	; no key
		clr plr_speed,u		; no speedyboots

		lda #$99		; init health
		sta spr_hp,u
		lda p_dfl_facing,y	; init facing
		sta spr_facing,u
		clr plr_nshots,u	; not shooting
		; initial state for all players is to draw room
		ldb #state_plr_draw_room
		stb spr_state,u

		lsr dead		; player dead?
		bcc 20F
		; reset player stats if dead
		ldd p_dfl_armour,y	; init armour, power
		std plr_armour,u
		lda p_dfl_ammo,y	; init ammo
		sta plr_ammo,u
		clr plr_score2,u	; clear score
		clr plr_score0,u
20

		jsr plr_draw_stats	; update stats window

		lda plr_bit,u
		leay sizeof_p_dfl,y	; next player
		leau sizeof_plr,u
		lsla
		cmpa #$08
		bls 10B

		clra
		clrb

		sta dead		; clear remaining bits
		ldx #death_fifo		; initialise death fifo
		stx death_fifo_end

		ldx #psg_c1freq
		stx psg_c1env
		std ,x
		ldx #psg_c2freq
		stx psg_c2env
		std ,x
		sta psg_c1pri
		sta psg_c2pri

		jmp mainloop

		DATA
tbl_p_dfl
		; player 1 defaults
		fcb 7*8+3-128,3		; p_dfl_y,x
		fcb p1_tilebase		; p_dfl_tilebase
		fcb facing_up		; p_dfl_facing
		fcb 3			; p_dfl_armour
		fcb 2			; p_dfl_power
		fcb 3			; p_dfl_ammo
		fdb p1_swin		; p_dfl_swin
		fdb p1_win+128		; p_dfl_win
		; player 2 defaults
		fcb 7*8+4-128,3		; p_dfl_y,x
		fcb p2_tilebase		; p_dfl_tilebase
		fcb facing_right	; p_dfl_facing
		fcb 1			; p_dfl_armour
		fcb 3			; p_dfl_power
		fcb 2			; p_dfl_ammo
		fdb p2_swin		; p_dfl_swin
		fdb p2_win+128		; p_dfl_win
		; player 3 defaults
		fcb 7*8+3-128,4		; p_dfl_y,x
		fcb p3_tilebase		; p_dfl_tilebase
		fcb facing_down		; p_dfl_facing
		fcb 4			; p_dfl_armour
		fcb 9			; p_dfl_power
		fcb 1			; p_dfl_ammo
		fdb p3_swin		; p_dfl_swin
		fdb p3_win+128		; p_dfl_win
		; player 4 defaults
		fcb 7*8+4-128,4		; p_dfl_y,x
		fcb p4_tilebase		; p_dfl_tilebase
		fcb facing_left		; p_dfl_facing
		fcb 6			; p_dfl_armour
		fcb 5			; p_dfl_power
		fcb 2			; p_dfl_ammo
		fdb p4_swin		; p_dfl_swin
		fdb p4_win+128		; p_dfl_win
		CODE

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

; Player input.  Scan keyboard & joysticks, set plr_control accordingly.

		setdp $ff	; only ever called with DP=$ff

; On exit, B always == 0

scan_keys
10		ldd ,x++
		beq 99F
		sta reg_pia0_pdrb
		lda ,x+
		andb reg_pia0_pdra
		bne 10B
		sta plr_control,u
99		rts

		DATA
tbl_p1_keys	KEYTBL_ENTRY 3,2,2			; 'C' = magic
		KEYTBL_ENTRY 7,4,$80|facing_up		; 'W' = up
		KEYTBL_ENTRY 3,4,$80|facing_down	; 'S' = down
		KEYTBL_ENTRY 0,5,$80|facing_right	; 'X' = right
		KEYTBL_ENTRY 2,5,$80|facing_left	; 'Z' = left
		KEYTBL_ENTRY 1,4,1			; 'Q' = fire
		fdb 0
tbl_p2_keys	KEYTBL_ENTRY 2,2,2			; 'B' = magic
		KEYTBL_ENTRY 7,3,$80|facing_up		; 'O' = up
		KEYTBL_ENTRY 3,3,$80|facing_down	; 'K' = down
		KEYTBL_ENTRY 5,3,$80|facing_right	; 'M' = right
		KEYTBL_ENTRY 6,3,$80|facing_left	; 'N' = left
		KEYTBL_ENTRY 0,4,1			; 'P' = fire
		fdb 0
		CODE

plr_scan_controls

		setdp gamedp		; called with usual game DP

		clra
		sta player1+plr_control
		sta player2+plr_control
		sta player3+plr_control
		sta player4+plr_control

		; keyboard & joystick scanning - will hit the PIAs a lot,
		; so set DP
		coma		; lda #$ff
		tfr a,dp
		setdp $ff

		; player 1 - table-driven scan
		ldu #player1
		ldx #tbl_p1_keys
		bsr scan_keys

		; player 2 - table-driven scan
		ldu #player2
		ldx #tbl_p2_keys
		bsr scan_keys

		decb			; ldb #$ff - scan_keys leaves b==0
		stb reg_pia0_pdrb	; polling firebuttons

		; player 3 - left joystick
		ldu #player3
		lda #$3d
		sta reg_pia0_crb	; left joystick
		lda reg_pia0_pdra
		bita #$02
		bne 10F
		lda #1			; fire
		sta plr_control,u
10		ldb p3_moved
mod_joystk_p3	equ *
		beq 30F
		bsr joy_yaxis
		bcc 20F
		jsr spr_move_control
		beq 50F
20		bsr joy_xaxis
		bra 50F
30		bsr joy_xaxis
		bcc 40F
		jsr spr_move_control
		beq 50F
40		bsr joy_yaxis
50

		; player 4 - right joystick
		ldu #player4
		lda #$35
		sta reg_pia0_crb	; right joystick
		lda reg_pia0_pdra
		bita #$01
		bne 10F
		lda #1			; fire
		sta plr_control,u
10		ldb p4_moved
mod_joystk_p4	equ *
		beq 30F
		bsr joy_yaxis
		bcc 20F
		jsr spr_move_control
		beq 50F
20		bsr joy_xaxis
		bra 50F
30		bsr joy_xaxis
		bcc 40F
		bsr spr_move_control
		beq 50F
40		bsr joy_yaxis
50

		; ensure DAC selected when sound reenabled
		ldd #$3400
		sta reg_pia0_cra
		stb reg_pia1_pdra	; zero DAC

		lda #gamedp
		tfr a,dp
		setdp gamedp

		rts

joy_yaxis	lda #$3c
		sta reg_pia0_cra	; y axis
		ldd #$8040
		sta reg_pia1_pdra
		stb reg_pia1_pdra
		lda reg_pia0_pdra
		bmi 20F
		lda #$80|facing_up	; up
		bra 80F
20		ldd #$ffc0
		sta reg_pia1_pdra
		stb reg_pia1_pdra
		lda reg_pia0_pdra
		bpl 90F
		lda #$80|facing_down	; down
		bra 80F

joy_xaxis	lda #$34
		sta reg_pia0_cra	; x axis
		ldd #$ffc0
		sta reg_pia1_pdra
		stb reg_pia1_pdra
		lda reg_pia0_pdra
		bpl 40F
		lda #$80|facing_right	; right
		bra 80F
40		ldd #$8040
		sta reg_pia1_pdra
		stb reg_pia1_pdra
		lda reg_pia0_pdra
		bmi 90F
		lda #$80|facing_left	; left

80		sta plr_control,u
		orcc #1
		rts

90		andcc #~1
		rts

spr_move_control
		anda #$7f
		ldx obj_y,u
		pshs x
		ldx spr_next_y,u
		stx obj_y,u
		jsr spr_move_a
		pshs cc
		ldx 1,s
		stx obj_y,u
		puls cc,x,pc

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

plr_draw_armour	ldx plr_swin,u
		leax 2*fb_w+3+128,x
		lda plr_armour,u
		bra draw_snum

plr_draw_power	ldx plr_swin,u
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

plr_draw_hp	ldx plr_swin,u
		leax 13*fb_w+128,x
		lda spr_hp,u
		bra draw_lnum_pair

		; u -> player
plr_draw_stats	pshs y,u
		ldx plr_swin,u
		leax fb_w+128,x
		lda spr_tilebase,u
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

plr_draw_score	ldx plr_swin,u
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
		bsr 10F
		puls a
		lsla
10		anda #$1e
		pshs u
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

plr_draw_ammo	ldx plr_swin,u
		leax 15*fb_w+2,x
		lda plr_ammo,u
		sta tmp1
		suba #4
		sta tmp1+1
PATCH_draw_ammo0	equ *+1
		ldd #$55ba
		stb 1,x
		leax fb_w,x
PATCH_draw_ammo1	equ *+1
10		ldb #$7e
		std ,x
PATCH_draw_ammo2	equ *+1
		ldb #$ba
		stb fb_w+1,x
		leax 2*fb_w,x
		dec tmp1
		bne 10B
PATCH_draw_ammo3	equ *+1
		ldd #$aaaa
20		inc tmp1+1
		beq 30F
		std ,x
		std fb_w,x
		leax 2*fb_w,x
		bra 20B
30		rts

plr_draw_key	ldx plr_swin,u
		leax 2+32,x
		lda plr_speed,u
		bmi plr_draw_key1
PATCH_draw_key0	equ *+1
		ldd #$a656
		sta -32,x
		stb ,x
PATCH_draw_key1	equ *+1
		lda #$66
		sta 32,x
		rts

plr_draw_key1
PATCH_draw_key01	equ *+1
		ldd #$a202
		sta -32,x
		stb ,x
PATCH_draw_key11	equ *+1
		lda #$22
		sta 32,x
		rts

plr_undraw_key	ldx plr_swin,u
		leax 2+32,x
PATCH_undraw_key	equ *+1
		ldd #$aaaa
		sta -32,x
		stb ,x
		sta 32,x
		rts

plr_draw_speed	ldx plr_swin,u
		leax 4*fb_w+2+64,x
PATCH_draw_speed0	equ *+1
		ldd #$a69a
		sta -64,x
		stb -32,x
		sta ,x
		stb 32,x
PATCH_draw_speed1	equ *+1
		lda #$6a
		sta 64,x
		rts

plr_undraw_speed
		ldx plr_swin,u
		leax 4*fb_w+2+64,x
PATCH_undraw_speed	equ *+1
		ldd #$aaaa
		sta -64,x
		stb -32,x
		sta ,x
		stb 32,x
		sta 64,x
		rts

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

; Handle monsters.  First, spawn a new monster if a slot is available,
; then for each extant monster, run its state machine.

process_monsters
		bsr new_monster
mon_run_state
		ldu #monsters
10		lda obj_y,u
		deca
		bvs 20F
		lda spr_state,u
		ldx #jtbl_monster_state
		jsr [a,x]
20		leau sizeof_mon,u
		cmpu #monsters_end
		blo 10B
		rts

; Find next empty monster slot (if any) and create a new one.  Successive
; calls iterate through each trapdoor in turn.

new_monster
next_td		equ *+1
		ldu #trapdoors-sizeof_obj
		leay sizeof_obj,u
		cmpy #trapdoors_end
		blo 10F
		ldy #trapdoors
10		sty next_td
		ldu #monsters
20		lda obj_y,u
		deca
		bvs 30F
		leau sizeof_mon,u
		cmpu #monsters_end
		blo 20B
		rts
30		lda level		; XXX monster strength by level?
		lsra
mod_monster_hp	equ *+1
		adda #8
		sta spr_hp,u
		ldd obj_y,y
		std obj_y,u
		stb spr_cx,u
		jsr yx_to_woff
		stx obj_woff,u
		stx spr_owoff,u
		; fall through to mon_change_direction

; Choose next "random" direction for a monster to head in.  Actually, it
; simply cycles through the directions, but as it may be called for
; multiple monsters each in turn, can appear random.

mon_change_direction
next_dir	equ *+1
		lda #$06
10		adda #2
		anda #$06
		cmpa spr_facing,u	; same direction?
		beq 10B			; try again
		sta next_dir
		sta spr_facing,u
		clr spr_state,u
		; fall through to spr_set_tile

; Determine which tile to use for a sprite.  Calculates based on facing, x
; and y and adds to tilebase.  Because x & y vary, this animates sprite
; as it moves.

spr_set_tile
		lda spr_facing,u
		ldb obj_y,u
		eorb obj_x,u
		lsrb
		adca spr_tilebase,u
		sta obj_tile,u
		rts

; Test moving a sprite based on 'facing'.

; Returns:
; 	a = new y
; 	b = new x
; 	x -> stone bitmap byte
; 	cc.z = 1 if not stone/door

spr_move
		lda spr_facing,u
spr_move_a
		ldx #jtbl_spr_move
		jmp [a,x]
		DATA
jtbl_spr_move	fdb spr_move_up,spr_move_down
		fdb spr_move_left,spr_move_right
		CODE
spr_move_up	ldd obj_y,u
		deca
		bra 10F
spr_move_down	ldd obj_y,u
		inca
10		ldx #tbl_x_to_bit
		pshs b
		ldb b,x
		ldx #bmp_wall+128
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

mon_check_direction
		bsr spr_move
		bne 55F
10		pshs u
		ldu #players
20		cmpd obj_y,u
		beq 45F			; monster hit player
25		leau sizeof_plr,u
		cmpu #players_end
		blo 20B
		ldu #monsters
30		cmpd obj_y,u
		beq 50F
		leau sizeof_mon,u
		cmpu #monsters_end
		blo 30B
		; no collisions - monster is moving
		puls u
		std spr_next_y,u
		eora obj_y,u
		anda #$f8
		beq 40F
		bsr spr_set_tile
		lda #state_mon_new_room
		jmp spr_set_state
40		bsr spr_set_tile
		bra spr_inc_state
		; monster hit player
45		lda #1
		ldx #snd_hit
		jsr psg_play_snd
		lda #$90		; decrement hp by 10-armour
		adda plr_armour,u
		jsr plr_damage
		; collision - change direction
50		puls u
55		jsr mon_change_direction
		jmp obj_draw

mon_landed
		jsr spr_undraw
		ldd spr_next_y,u
		std obj_y,u
		stb spr_cx,u
		jsr yx_to_woff
		stx obj_woff,u
		stx spr_owoff,u
		clr spr_state,u
		; fall through to mon_centred

mon_centred
		jsr spr_set_tile
		bsr obj_draw
		bra spr_inc_state

spr_move1
		jsr spr_undraw
		ldx #tbl_obj_woff1
		ldb obj_x,u
		andb #1
		orb spr_facing,u
		lslb
		ldd b,x
		; a = offset from current screen position
		; b = tile set select (0=A, 1=B)
		ldx spr_owoff,u
		leax a,x
		stx obj_woff,u
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
		bhi 20F
10		sta obj_tile,u
		ldx obj_woff,u
		; use cx to position the death anim exactly where the
		; monster was
		ldb spr_cx,u
		bra obj_draw_vx
20		jsr spr_undraw
		ldd spr_next_y,u
		cmpd obj_y,u
		beq 30F
		std obj_y,u
		jsr yx_to_woff
		jsr spr_undraw_v
30		clr obj_tile,u
		ldb #$80
		stb obj_y,u
		rts

		DATA
jtbl_monster_state
		STATE_JTBL
		fdb mon_centred
		fdb mon_check_direction
		fdb spr_move1
		fdb spr_delay
		fdb spr_move2
		STATE_ID "state_mon_landed"
		fdb mon_landed
		STATE_ID "state_mon_new_room"
		fdb spr_delay
		fdb spr_delay
		fdb spr_delay
		STATE_ID "state_mon_landed2"
		fdb mon_landed
		; keep these as the last states
		STATE_ID "state_mon_die"
		fdb mon_die
		fdb mon_dying
		CODE

		DATA
		; offset,tileset select
tbl_obj_woff1	fcb -3*fb_w,0	; up, x&1=0
		fcb -3*fb_w,1	; up, x&1=1
		fcb 3*fb_w,0	; down, x&1=0
		fcb 3*fb_w,1	; down, x&1=1
		fcb -1,1	; left, x&1=0
		fcb 0,0		; left, x&1=1
		fcb 0,1		; right, x&1=0
		fcb 1,0		; right, x&1=1
		; offset only (tileset remains)
		; could just reuse woff1 table and invert x&1
tbl_obj_woff2	fcb -3*fb_w	; up, x&1=0
		fcb -3*fb_w	; up, x&1=1
		fcb 3*fb_w	; down, x&1=0
		fcb 3*fb_w	; down, x&1=1
		fcb 0		; left, x&1=0
		fcb -1		; left, x&1=1
		fcb 1		; right, x&1=0
		fcb 0		; right, x&1=1
		CODE

spr_inc_state	lda spr_state,u
spr_delay	adda #2
spr_set_state	sta spr_state,u
99		rts

spr_move2
		jsr spr_undraw
		ldx #tbl_obj_woff2
		ldb obj_x,u
		stb spr_cx,u
		andb #1
		orb spr_facing,u
		lda b,x
		; a = offset from current screen position
		; b = tile set select (0=A, 1=B)
		ldx obj_woff,u
		leax a,x
		stx obj_woff,u
		bsr obj_draw_v
		bra spr_inc_state

spr_draw_cx
		ldx obj_woff,u
		ldb spr_cx,u
		bra obj_draw_vx

; Draw object.
; Entry:
; 	u -> object
obj_draw	ldx obj_woff,u
		; XXX this is accounting for the fudged shot delay
		; is there a better way to do this?
		bmi 99B
; ... if x already == woff
obj_draw_v	ldb obj_x,u
; ... if b *also* already == x
obj_draw_vx	lda obj_y,u
		anda #$f8
		sta tmp0		; preserve room
		lda obj_tile,u
; ... if a *also* already == tile, but note must manually set tmp0=yroom
; don't need u to point to an object to call this
obj_draw_vxt	stx tmp1		; preserve woff
obj_draw_vxt1	pshs u
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
		lda tmp0		; re-fetch room
		cmpa player1+plr_yroom
		bne 20F
		ldx tmp1		; re-fetch woff
		leax p1_win+128,x
		jsr ,y
		lda tmp0		; re-fetch room
20		cmpa player2+plr_yroom
		bne 30F
		ldx tmp1		; re-fetch woff
		leax p2_win+128,x
		ldu ,s
		jsr ,y
		lda tmp0		; re-fetch room
30		cmpa player3+plr_yroom
		bne 40F
		ldx tmp1		; re-fetch woff
		leax p3_win+128,x
		ldu ,s
		jsr ,y
		lda tmp0		; re-fetch room
40		cmpa player4+plr_yroom
		bne 90F
		ldx tmp1		; re-fetch woff
		leax p4_win+128,x
		ldu ,s
		jsr ,y
90		puls x,u,pc

; Undraw sprite.  Sprite's current map position isn't updated until
; movement finishes ("lands"), so during movement, this will only redraw
; the tile the sprite is moving *from*.
; Entry:
; 	u -> sprite

spr_undraw
		ldx spr_owoff,u		; original (centred) woff
spr_undraw_v
		stx tmp1		; preserve woff
		bsr obj_test_pickup
		beq 30F
		ldy #pickups
		ldx obj_y,u
10		lda obj_tile,y
		cmpa #always_draw_tile	; this tile always drawn?
		bhs 20F			; skip - drawn soon enough anyway
		cmpx obj_y,y
		beq 40F
20		leay sizeof_obj,y
		cmpy #objects_end
		blo 10B
		rts
30		clra
40		ldb obj_y,u
		andb #$f8
		stb tmp0
		ldb obj_x,u
		jmp obj_draw_vxt1

; Second state while changing room.  Draws all objects once.
; Subsequently, keys and animated objects are redrawn, anything else is
; only redrawn as part of undrawing a sprite.

plr_draw_objects
		bsr spr_undraw		; from other windows
		ldd plr_win,u
		std 30F
		ldb spr_next_y,u
		stb 20F
		pshs u
mod_draw_chalice_1
		jsr plr_update_chalice_b
		; draw objects
		ldy #objects
10		lda obj_tile,y
		beq 40F
		ldb obj_y,y
20		equ *+1
		eorb #$00
		andb #$f8
		bne 40F
		ldx obj_woff,y
30		equ *+2
		leax >$0000,x
		jsr draw_object_once
40		leay sizeof_obj,y
		cmpy #objects_end
		blo 10B
		puls u
		lda plr_bit,u
		bita playing
		beq plr_set_inactive
		lda #state_plr_landed
		sta spr_state,u
		rts

; Still need to update yroom for inactive players, as their windows get
; updated anyway.  However, player setup invalidates their (y,x) and the
; inactive state doesn't update this, so checks against their position
; will fail.

plr_set_inactive
		lda #state_plr_inactive
		sta spr_state,u
		lda spr_next_y,u
		anda #$f8
		sta plr_yroom,u
		rts

		; - - - - - - - - - - - - - - - - - - - - - - -

; Entry:
; 	u -> sprite
; Returns:
; 	a = y
; 	b = x bit
; 	x -> pickup bitmap byte
; 	cc.z = 1 if no pickup
obj_test_pickup
		ldd obj_y,u
obj_test_pickup_d
		ldx #tbl_x_to_bit
		ldb b,x
		ldx #bmp_objects+128
		bitb a,x
		rts

		; - - - - - - - - - - - - - - - - - - - - - - -

plr_landed
		jsr spr_undraw
plr_landed_nu
		ldd spr_next_y,u
		std obj_y,u
		anda #$f8
		sta plr_yroom,u
		ldd obj_y,u
		stb spr_cx,u
		jsr yx_to_woff
		stx obj_woff,u
		stx spr_owoff,u
		clr spr_state,u
		bsr obj_test_pickup_d
		beq 99F
		; pickups...
		ldx obj_y,u
		ldy #pickups
10		lda obj_tile,y
		beq 20F
		bmi 20F
		cmpx obj_y,y
		bne 20F
		pshs a,x,y
		; pickups MUST have 0 < obj_tile <= $3f
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
20		leay sizeof_obj,y
		cmpy #pickups_end
		blo 10B
		; fall through to plr_centred
99

plr_centred
		jsr spr_set_tile
		lda plr_control,u
		beq 30F
8		bpl plr_fire
9

		anda #$7f
		sta spr_facing,u
		jsr spr_set_tile	; yes, again
		lda dead
		sta tmp0
		jsr spr_move
		beq 10F
mod_check_chalice
		jsr check_chalice
		cmpd plr_key_opens,u
		bne 30F
		jmp plr_open_door
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
		bne 18F
30		jsr obj_draw
32		jmp spr_inc_state
18		ldy #monsters
20		cmpd obj_y,y
		beq plr_bump
25		leay sizeof_mon,y
		cmpy #monsters_end
		blo 20B

		std spr_next_y,u
		anda #$f8
		cmpa plr_yroom,u
		beq 50F
		dec plr_yroom,u	; invalidate yroom
		lda #state_plr_draw_room
		jmp spr_set_state
50		jsr obj_draw
		ldb #state_plr_move1
		lda plr_speed,u
		anda #$7f
		beq 60F
		ldb #state_plr_landed
60		stb spr_state,u
		bra plr_move1

plr_delay
		lda plr_control,u
		bne 8B
		jmp spr_inc_state

plr_fire
		lsra
		bne plr_magic
10		lda plr_nshots,u
		cmpa plr_ammo,u
		bhs 30B
		inca
		sta plr_nshots,u
		lda obj_tile,u
		eora #$01
		sta obj_tile,u
		ldy #shots
20		lda obj_tile,y
		beq 30F
		leay sizeof_obj,y
		bra 20B		; XXX *should* be safe...
30		ldb spr_facing,u
		stb obj_shot_facing,y
		lsrb
		addb #8
		addb spr_tilebase,u
		stb obj_tile,y
		ldd obj_y,u
		std obj_y,y
		ldd #$fffe	; 1 frame delay
		std obj_woff,y
		stu obj_shot_plr,y

		lda #2		; priority
		ldx #snd_fire
		jsr psg_play_snd

		jmp obj_draw	; draw player

		; player bumped into monster
		; limit amount of damage caused by only dropping health if
		; monster is "landed"
plr_bump	lda spr_state,y
		cmpa #state_mon_landed
		beq 10F
		cmpa #state_mon_landed2
		beq 10F
		rts
10		lda #1
		ldx #snd_bump
		jsr psg_play_snd
		lda #$99		; decrement hp by 1
		jmp plr_damage

		; Continues on from plr_centred, decided player is moving,
		; no speedyboots.  Hack to store decision for
		; joystick-controlled players.
plr_move1	ldb spr_facing,u
		andb #$04	; only care about axis
		lda plr_bit,u
		cmpa #$04
		bne 61F
		stb p3_moved
		bra 62F
61		cmpa #$08
		bne 62F
		stb p4_moved
62		rts

plr_magic
		jsr obj_draw
		lda #$94	; -6HP for player 1
		ldb plr_bit,u
		lsrb
		beq 10F
		lda #$97	; -3HP for player 2
10		jsr plr_damage
		; only kill monsters in player's window
		lda obj_y,u
		sta tmp0+1
		; calculate score and mark monsters for death
		ldy #monsters
25		lda obj_y,y
		eora tmp0+1
		anda #$f8
		bne 30F
		ldd #$0100|state_mon_die
		stb spr_state,y
		jsr plr_add_score
30		leay sizeof_mon,y
		cmpy #monsters_end
		blo 25B
		lda #$ff	; highest priority
		ldx #snd_magic
		jsr psg_play_snd
		; step monsters through death and play magic sound fx
		bsr magic_mon_step
		bsr magic_mon_step
		bsr magic_mon_step
		; fall through to magic_mon_step

magic_mon_step	pshs u
		bsr mon_step
		; funny sound
		jsr psg_play2frags
		jsr psg_play2frags
		jsr psg_play2frags
		jsr psg_play2frags
		puls u,pc

mon_step	pshs u
		ldu #monsters
10		lda obj_y,u
		eora tmp0+1
		anda #$f8
		bne 20F
		lda spr_state,u
		ldx #jtbl_monster_state
		jsr [a,x]
20		leau sizeof_mon,u
		cmpu #monsters_end
		blo 10B
		puls u,pc

plr_open_door
		ldx #doors
10		cmpd obj_y,x
		beq 20F
		leax sizeof_obj,x
		bra 10B		; should be safe loop
20		clr obj_tile,x
		pshs a,b,u
		leau ,x
		jsr obj_draw
		puls a,b,u
		ldx #tbl_x_to_bit
		ldb b,x
		ldx #bmp_wall+128
		comb
		andb a,x
		stb a,x
		ldd #$8080
		std plr_key_opens,u
		lda #2		; priority
		ldx #snd_door
		jsr psg_play_snd
		lda #7
		jsr plr_add_score
		jsr plr_undraw_key
plr_inactive	rts

process_players
		lda level
		cmpa #24
		bne 5F
		; special-case finishing level 25
		lda playing
		eora #$0f
		sta finished
5		ldu #players
10		lda spr_state,u
		bmi 20F
		lda spr_state,u
		ldx #jtbl_player_state
		jsr [a,x]
20		leau sizeof_plr,u
		cmpu #players_end
		blo 10B
		rts

plr_die
		; if player had started to move to another square
		; (spr_next_y != obj_y), undraw that square
		ldd spr_next_y,u
		cmpd obj_y,u
		beq 10F
		ldx obj_y,u
		pshs x			; preserve old y,x
		std obj_y,u
		jsr yx_to_woff
		jsr spr_undraw_v
		puls x
		stx obj_y,u		; restore old y,x
		stx spr_next_y,u	; ensure resurrects in same place
10		lda #bones0-1
		sta obj_tile,u
		jmp spr_inc_state

plr_dying
		lda #state_plr_dying_delay
		sta spr_state,u
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
		ldx spr_owoff,u
		; don't use cx - player should die centred
		ldb obj_x,u
		jmp obj_draw_vx
plr_undying
		lda #state_plr_undying_delay
		sta spr_state,u
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

; It's ok to destroy A here, as B will still test false in plr_centred,
; and there are no actual doors on level 25.
check_chalice	cmpa #$14
		blo 10F
		cmpa #$15
		bhi 10F
		cmpb #2
		blo 10F
		cmpb #3
		bhi 10F
		lda plr_bit,u
		ora finished
		bra 20F
10		lda plr_bit,u
		coma
		anda finished
20		sta finished
		rts

		DATA

jtbl_player_state
		STATE_JTBL
		STATE_ID "state_plr_centred"
		fdb plr_centred
		fdb plr_delay
		fdb plr_delay
		fdb plr_delay
		fdb plr_landed_nu
		STATE_ID "state_plr_move1"
		fdb spr_move1
		STATE_ID "state_plr_move2"
		fdb spr_move2
		STATE_ID "state_plr_landed"
		fdb plr_landed
		STATE_ID "state_plr_draw_room"
		fdb plr_draw_room
		STATE_ID "state_plr_draw_objects"
		fdb plr_draw_objects
		STATE_ID "state_plr_inactive"
		fdb plr_inactive
		; keep these as the last states
		STATE_ID "state_plr_exit0"
		fdb plr_exit0
		STATE_ID "state_plr_exitdelay"
		fdb spr_delay
		fdb plr_exit1
		STATE_ID "state_plr_die"
		fdb plr_die
		STATE_ID "state_plr_dying_delay"
		fdb spr_delay
		STATE_ID "state_plr_dying"
		fdb plr_dying
		STATE_ID "state_plr_undying_delay"
		fdb spr_delay
		STATE_ID "state_plr_undying"
		fdb plr_undying

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

		CODE

plr_damage	adda spr_hp,u
		daa
		bcs 10F
		bsr plr_kill
		clra
10		sta spr_hp,u
		jmp plr_draw_hp

plr_kill
		lda spr_state,u
		cmpa #state_plr_exit0
		blo 10F
		rts
10		ldx death_fifo_end
		stu ,x++
		stx death_fifo_end
		jsr kill_speed
		lda #state_plr_die
		sta spr_state,u
		lda dead
		ora plr_bit,u
		sta dead
		ldd obj_y,u
		; fall through to drop_key

; Drop key held by player in specified location.  Checks player has a key
; in the first place.

; Entry:
; 	a,b = y,x
; 	u -> player

drop_key
		pshs a,b,y
		lda plr_key_opens,u
		deca
		bvs 99F		; y = $80 - no key!
		jsr plr_undraw_key
		ldy #keys
20		lda obj_tile,y
		beq 30F
		leay sizeof_obj,y
		bra 20B
30		ldd plr_key_opens,u
		std obj_key_opens,y
		clra
		ldb plr_speed,u
		lslb
		adca #key
		sta obj_tile,y
		ldd ,s
		std obj_y,y
		jsr yx_to_woff
		stx obj_woff,y
		jsr set_pickup
		ldd #$8080
		std plr_key_opens,u
99		puls a,b,y,pc

shot_hit_player
		ldx obj_shot_plr,u	; x -> player shot belongs to
		pshs u
		leau ,y			; u -> player being shot
		lda #$9a		; decrement hp by shot power
		suba plr_power,x
		bsr plr_damage
		puls u
		bra shot_clear

process_shots
		ldu #shots
10		lda obj_tile,u
		beq 90F

		ldx obj_woff,u
		bpl 11F
		leax 1,x
		beq 12F
		stx obj_woff,u
		bra 90F
11		jsr spr_undraw_v
12		jsr spr_move
		beq 20F

shot_clear
		clr obj_tile,u
		ldx obj_shot_plr,u
		dec plr_nshots,x
		bra 90F

		; drainers...
20		tfr d,x
		ldy #items
50		lda obj_tile,y
		cmpa #drainer
		bne 70F
		cmpx obj_y,y
		beq shot_drainer
70		leay sizeof_obj,y
		cmpy #items_end
		blo 50B

35		ldy #players
30		cmpx obj_y,y
		beq shot_hit_player
		leay sizeof_plr,y
		cmpy #players_end
		blo 30B

		ldy #monsters
40		cmpx obj_y,y
		beq shot_hit_monster
42		leay sizeof_mon,y
		cmpy #monsters_end
		blo 40B

		stx obj_y,u
		tfr x,d
		jsr yx_to_woff
		stx obj_woff,u

		jsr obj_test_pickup_d
		beq 90F

90		leau sizeof_obj,u
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
		pshs x,u
		ldu obj_shot_plr,u
		lda #1
		jsr plr_add_score
		puls x,u
		dec obj_drainer_hp,y
		bne 35B
		clr obj_tile,y
		jsr check_clr_pickup
		jmp 35B

shot_hit_monster
		lda spr_state,y
		cmpa #state_mon_die
		bhs 42B
		lda #$9a
		pshs u
		ldu obj_shot_plr,u
		lda spr_hp,y
		suba plr_power,u
		bcc 10F
		lda #3
		ldx #snd_monster_die
		jsr psg_play_snd
		ldd #$0100|state_mon_die	; 1pt for monster
		stb spr_state,y
		jsr plr_add_score
		puls u
		jmp shot_clear
10		sta spr_hp,y
		lda #1
		ldx #snd_monster_hit
		jsr psg_play_snd
		puls u
		jmp shot_clear

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

; Pickup dispatch routines.

		CODE

; Entry:
; 	a  = object type
; 	y -> object
; 	u -> player

		; not a pickup: drain health
pickup_drainer
		lda #2		; priority
		ldx #snd_drainer
		jsr psg_play_snd
		bsr kill_speed
mod_drainer_dmg	equ *+1
		lda #$80	; -20HP
		jsr plr_damage
		leas 3,s	; skip return address, stacked object type
		puls x,y,pc

pickup_potion
		bsr sound_low
		lda plr_score0,u
		anda #$0f
		ldb #$11
		mul
10		stb spr_hp,u
		jmp plr_draw_hp

pickup_food
		lda #2		; priority
		ldx #snd_food
		jsr psg_play_snd
		lda spr_hp,u
		adda #$10
		daa
		bcc 10F
		lda #$99
10		sta spr_hp,u
		jsr plr_draw_hp
		bra kill_speed

pickup_armour
		bsr sound_low
		lda plr_armour,u
		inca
		cmpa #7
		bhi 99F
		sta plr_armour,u
		jmp plr_draw_armour

pickup_nop
99		rts

pickup_power
		bsr sound_low
		lda plr_power,u
		inca
		cmpa #9
		bhi 99B
		sta plr_power,u
		jmp plr_draw_power

pickup_weapon
		bsr sound_low
		lda plr_ammo,u
		inca
		cmpa #3
		bhi 99B
		sta plr_ammo,u
		jmp plr_draw_ammo

sound_low
		lda #2		; priority
		ldx #snd_low
		jsr psg_play_snd
		; fall through to kill_speed

kill_speed	clra
		lsl plr_speed,u
		rora
		sta plr_speed,u
		jmp plr_undraw_speed

pickup_money
		lda #2		; priority
		ldx #snd_money
		jsr psg_play_snd
		bra kill_speed

pickup_cross
		bsr sound_low
		lda dead
		beq 10F
		ldx death_fifo_end
		leax -2,x
		stx death_fifo_end
		ldx death_fifo
		ldd death_fifo+2
		std death_fifo
		ldd death_fifo+4
		std death_fifo+2
		ldd death_fifo+6
		std death_fifo+4
		lda #$32
		sta spr_hp,x
		lda plr_bit,x
		coma
		anda dead
		sta dead
10		rts

pickup_speed
		bsr sound_low
		; this is safe!
		inc plr_speed,u
		jmp plr_draw_speed

pickup_key
		pshs a			; preserve key type

		; key pickup preempts most other sound, as it's important
		; to know how many times player has juggled keys
		lda #4
		ldx #snd_key
		jsr psg_play_snd

		ldd plr_key_opens,u
		ldx obj_key_opens,y
		stx plr_key_opens,u
		std obj_key_opens,y

		clra
		ldb plr_speed,u		; top bit of plr_speed is key type
		lslb
		adca #key		; tile is #key or #key+1
		sta obj_tile,y		; update object tile

		puls a			; which key type was picked up?
		lsra			; tile id was shifted left
		lsra			; and now we want lowest bit
		rorb			; into top bit of plr_speed
		stb plr_speed,u

		; clear object tile if player wasn't actually holding a
		; key.  means some of above was redundant...
		ldd obj_key_opens,y
		cmpd #$8080
		bne 10F
		clr obj_tile,y
		ldx obj_y,u
		jsr check_clr_pickup

10		jmp plr_draw_key

		; not a pickup: teleport player
pickup_tport
		lda #4		; priority
		ldx #snd_tport
		jsr psg_play_snd
10		leay sizeof_obj,y
		cmpy #items_end
		blo 20F
		ldy #items
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
		jsr kill_speed	; XXX test this
		leas 3,s	; skip return address, stacked object type
		puls x,y,pc

pickup_exit
		lda exiting
		bne 20F
		lda #facing_up
		jsr spr_move_a
		beq 10F
		lda #facing_right
		jsr spr_move_a
		beq 10F
		lda #facing_down
		jsr spr_move_a
		beq 10F
		lda #facing_left
		jsr spr_move_a
		; XXX assuming one will work
10		jsr drop_key
		lda #state_plr_exit0
		sta spr_state,u
		sta exiting
		; invalidate x, but store its value in cx for use drawing
		; exit sprites
		lda obj_x,u
		sta spr_cx,u
		com obj_x,u
		ldd #tbl_exit_data
		std spr_tmp0,u
		jsr kill_speed
		lda #4		; priority
		ldx #snd_exit
		jsr psg_play_snd
		leas 3,s	; skip return address, stacked object type
		puls x,y,pc
20		rts

plr_exit1
		lda #state_plr_exitdelay-2
		sta spr_state,u
		; fall through to plr_exit0

plr_exit0
		ldx spr_tmp0,u
		cmpx #tbl_exit_data_end
		bhs 10F
		lda ,x+
		adda spr_tilebase,u
		sta obj_tile,u
		stx spr_tmp0,u
		jsr spr_draw_cx
		jmp spr_inc_state

10
		clr exiting
		lda finished
		ora plr_bit,u
		sta finished
		lda #state_plr_inactive
		sta spr_state,u
		lda #exit
		sta obj_tile,u
		jmp spr_draw_cx

		DATA

tbl_exit_data	fcb p1_up0-p1_tilebase
		fcb p1_right0-p1_tilebase
		fcb p1_down0-p1_tilebase
		fcb p1_left0-p1_tilebase
		fcb p1_exit4-p1_tilebase
		fcb p1_exit5-p1_tilebase
		fcb p1_exit6-p1_tilebase
		fcb p1_exit7-p1_tilebase
		fcb p1_exit8-p1_tilebase
		fcb p1_exit9-p1_tilebase
		fcb p1_exit10-p1_tilebase
		fcb p1_exit11-p1_tilebase
tbl_exit_data_end

tbl_pickup_scores	equ *-1		; floor not a pickup
		fcb 0		; exit
		fcb 0		; trapdoor
		fcb $05		; food
		fcb 0		; tport
		fcb $10		; armour
		fcb $10		; potion
		fcb $10		; weapon
		fcb $10		; cross
		fcb $10		; speed
		fcb 0		; drainer
		fcb $20		; money
		fcb $10		; power
		fcb 0		; dummy
		fcb 0		; key
		fcb 0		; key1

jtbl_pickup	equ *-2			; no dispatch for floor
		fdb pickup_exit
		fdb pickup_nop		; trapdoor
		fdb pickup_food
		fdb pickup_tport
		fdb pickup_armour
		fdb pickup_potion
		fdb pickup_weapon
		fdb pickup_cross
		fdb pickup_speed
		fdb pickup_drainer
		fdb pickup_money
		fdb pickup_power
		fdb pickup_key		; dummy
		fdb pickup_key
		fdb pickup_key		; key1

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

		CODE

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

; For menus: scan table of KEYDSP_ENTRY and jump to handler

wait_keypress_jump
		; wait if key held
		clr reg_pia0_pdrb
10		lda reg_pia0_pdra
		ora #$80
		inca
		bne 10B
		; test firebutton before & after scan
20		bsr firebutton_pressed
		bne 20B
		leau -2,x
30		leau 4,u
		ldd -2,u
		beq 20B
		sta reg_pia0_pdrb
		bitb reg_pia0_pdra
		bne 30B
		bsr firebutton_pressed
		bne 20B
		pulu pc

firebutton_pressed
		lda #$ff
		sta reg_pia0_pdrb
		lda reg_pia0_pdra
		ora #$80
		inca
		rts

; Screen data:
; 	line height (1 byte)
; 	initial line base (2 bytes)
; 	character data (zero terminated)

write_screen
		; VDG mode = RG6, CSS0
		lda #$f2
		sta reg_pia1_pdrb
		clra
		clrb
		ldx #fb0
1		std ,x++
		cmpx #fb0_end
		blo 1B

		lda ,y+
		ldb #fb_w
		mul
		std mod_line_height
		ldx ,y++
write_update
9		stx tmp0	; base address for current line
write_continue
		clr tmp1	; cursor x position
10		lda ,y+
		bne 15F
		rts
15		bpl write_char
		inca
		beq 18F
		anda #$7f
		adda tmp1
		sta tmp1
		bra 10B
18		ldx tmp0
mod_line_height	equ *+2
		leax >0,x
		bra 9B
write_char	ldx #tbl_x_to_woff
		ldb tmp1
		ldb b,x
		ldx tmp0
		abx
		deca
		ldb #12
		mul
		tfr d,u
		ldb tmp1
		lsrb
		bcs 20F
		leau textfont_a,u
		DRAW_ROW_A -128
		DRAW_ROW_A -96
		DRAW_ROW_A -64
		DRAW_ROW_A -32
		DRAW_ROW_A 0
		DRAW_LAST_ROW_A 32
		bra 30F
20		leau textfont_b,u
		DRAW_ROW_B -128
		DRAW_ROW_B -96
		DRAW_ROW_B -64
		DRAW_ROW_B -32
		DRAW_ROW_B 0
		DRAW_LAST_ROW_B 32
30		inc tmp1
		jmp 10B

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

		DATA

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
	if DEBUG_LEVEL25
level25		includebin "level25d.bin.dz"
	else
level25		includebin "level25.bin.dz"
	endif

levels
		fdb level1,level2,level3,level4
		fdb level5,level6,level7,level8
		fdb level9,level10,level11,level12
		fdb level13,level14,level15,level16
		fdb level17,level18,level19,level20
		fdb level21,level22,level23,level24
		fdb level25

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

		DATA

		include "tiles.s"
		include "fonts.s"

tbl_tiles_a_start

		fdb tile_door1_v_a
		fdb tile_door1_h_a
		fdb tile_door_v_a
		fdb tile_door_h_a

tbl_tiles_a

		fdb tile_floor_a
		fdb tile_exit_a
		fdb tile_trapdoor_a
		fdb tile_food_a
		fdb tile_tport_a
		fdb tile_armour_a
		fdb tile_potion_a
		fdb tile_weapon_a
		fdb tile_cross_a
		fdb tile_speed_a
mod_drainer_a	fdb tile_drainer0_a
mod_money_a	fdb tile_money0_a
mod_power_a	fdb tile_power0_a
		fdb tile_key_a	; dummy
		fdb tile_key_a
		fdb tile_key1_a

		fdb tile_p1_up0_a
		fdb tile_p1_up1_a
		fdb tile_p1_down0_a
		fdb tile_p1_down1_a
		fdb tile_p1_left0_a
		fdb tile_p1_left1_a
		fdb tile_p1_right0_a
		fdb tile_p1_right1_a
		fdb tile_arrow_up_a
		fdb tile_arrow_down_a
		fdb tile_arrow_left_a
		fdb tile_arrow_right_a
		fdb tile_p1_exit4_a
		fdb tile_p1_exit5_a
		fdb tile_p1_exit6_a
		fdb tile_p1_exit7_a
		fdb tile_exit8_a
		fdb tile_exit9_a
		fdb tile_exit10_a
		fdb tile_exit11_a

		fdb tile_p2_up0_a
		fdb tile_p2_up1_a
		fdb tile_p2_down0_a
		fdb tile_p2_down1_a
		fdb tile_p2_left0_a
		fdb tile_p2_left1_a
		fdb tile_p2_right0_a
		fdb tile_p2_right1_a
		fdb tile_fball_up_a
		fdb tile_fball_down_a
		fdb tile_fball_left_a
		fdb tile_fball_right_a
		fdb tile_p2_exit4_a
		fdb tile_p2_exit5_a
		fdb tile_p2_exit6_a
		fdb tile_p2_exit7_a
		fdb tile_exit8_a
		fdb tile_exit9_a
		fdb tile_exit10_a
		fdb tile_exit11_a

		fdb tile_p3_up0_a
		fdb tile_p3_up1_a
		fdb tile_p3_down0_a
		fdb tile_p3_down1_a
		fdb tile_p3_left0_a
		fdb tile_p3_left1_a
		fdb tile_p3_right0_a
		fdb tile_p3_right1_a
		fdb tile_axe_up_a
		fdb tile_axe_down_a
		fdb tile_axe_left_a
		fdb tile_axe_right_a
		fdb tile_p3_exit4_a
		fdb tile_p3_exit5_a
		fdb tile_p3_exit6_a
		fdb tile_p3_exit7_a
		fdb tile_exit8_a
		fdb tile_exit9_a
		fdb tile_exit10_a
		fdb tile_exit11_a

		fdb tile_p4_up0_a
		fdb tile_p4_up1_a
		fdb tile_p4_down0_a
		fdb tile_p4_down1_a
		fdb tile_p4_left0_a
		fdb tile_p4_left1_a
		fdb tile_p4_right0_a
		fdb tile_p4_right1_a
		fdb tile_sword_up_a
		fdb tile_sword_down_a
		fdb tile_sword_left_a
		fdb tile_sword_right_a
		fdb tile_p4_exit4_a
		fdb tile_p4_exit5_a
		fdb tile_p4_exit6_a
		fdb tile_p4_exit7_a
		fdb tile_exit8_a
		fdb tile_exit9_a
		fdb tile_exit10_a
		fdb tile_exit11_a

		fdb tile_monster_up0_a
		fdb tile_monster_up1_a
		fdb tile_monster_down0_a
		fdb tile_monster_down1_a
		fdb tile_monster_left0_a
		fdb tile_monster_left1_a
		fdb tile_monster_right0_a
		fdb tile_monster_right1_a

		fdb tile_bones0_a
		fdb tile_bones1_a
		fdb tile_bones2_a
		fdb tile_bones3_a
		fdb tile_bones4_a
		fdb tile_bones5_a
		fdb tile_bones6_a
		fdb tile_bones7_a

tbl_tiles_a_end

tbl_snum	equ *-2		; no zero in this font
		fdb tile_snum_1
		fdb tile_snum_2,tile_snum_3
		fdb tile_snum_4,tile_snum_5
		fdb tile_snum_6,tile_snum_7
		fdb tile_snum_8,tile_snum_9
tbl_lnum	fdb tile_lnum_0,tile_lnum_1
		fdb tile_lnum_2,tile_lnum_3
		fdb tile_lnum_4,tile_lnum_5
		fdb tile_lnum_6,tile_lnum_7
		fdb tile_lnum_8,tile_lnum_9

		; Zeroed areas to be populated by tile shifting code in
		; INIT.  Try to keep these together for better
		; compression.

tiles_b_start
tile_drainer0_b	equ *+tile_drainer0_a-tiles_a_start
tile_drainer1_b	equ *+tile_drainer1_a-tiles_a_start
tile_money0_b	equ *+tile_money0_a-tiles_a_start
tile_money1_b	equ *+tile_money1_a-tiles_a_start
tile_power0_b	equ *+tile_power0_a-tiles_a_start
tile_power1_b	equ *+tile_power1_a-tiles_a_start
tile_floor_b	equ *+tile_floor_a-tiles_a_start
		rzb tiles_a_end-tiles_a_start

tbl_tiles_b_start
tbl_tiles_b	equ *+tbl_tiles_a-tbl_tiles_a_start
mod_drainer_b	equ *+mod_drainer_a-tbl_tiles_a_start
mod_money_b	equ *+mod_money_a-tbl_tiles_a_start
mod_power_b	equ *+mod_power_a-tbl_tiles_a_start
		rzb tbl_tiles_a_end-tbl_tiles_a_start

textfont_b	rzb textfont_a_end-textfont_a

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

		BSS
death_fifo	rmb 8

monsters	equ *+mon_offset_
		rmb max_monsters*sizeof_mon
monsters_end	equ *+mon_offset_

objects
doors		rmb max_doors*sizeof_obj
doors_end
pickups
keys		rmb max_keys*sizeof_obj
keys_end
items		rmb max_items*sizeof_obj
items_end
pickups_end
trapdoors	rmb max_trapdoors*sizeof_obj
trapdoors_end
objects_end
shots		rmb 12*sizeof_obj
shots_end
all_objects_end

; ========================================================================

; This code is run once on startup, then discarded.  It's positioned at
; the beginning of the uninitialised data area (BSS).

; Note this shouldn't be used to initialise anything in BSS, obviously!
; That should happen in the main CODE section.

		section "INIT"

		org BSS_start

start
		setdp 0			; assumed

	if 0
		orcc #$50

		ldu #$8000
		sta reg_sam_tys
		clr ,u
		lda ,u
		bne no64k
		dec ,u
		lda ,u
		coma
		bne no64k

		; 64K loader

		; copy everything from page 0 to page 1 - overkill, but we
		; need the DP vars to continue tape loading and this code,
		; obviously.

		ldx #$0000
10		ldd ,x++
		std ,u++
		cmpu #$ff00
		blo 10B

		; switch to page 1 and load zipped segment from $0200
		; onwards
		sta reg_sam_p1s

no64k
		sta reg_sam_tyc
	endif

		orcc #$50

		ldu #textfont_a
		ldx #textfont_b
20		pulu d
		lsra
		rorb
		lsra
		rorb
		lsra
		rorb
		lsra
		rorb
		std ,x++
		cmpu #textfont_a_end
		blo 20B

		; patch reset vector
		ldd #init_reset
		std $0072
		lda #$55
		sta $0071

init_reset
		nop
		orcc #$50
		lds #$0100

		lda #gamedp
		tfr a,dp
		setdp gamedp

		; SAM display offset = $0200
		sta reg_sam_f0s
		sta reg_sam_f1c
		sta reg_sam_f2c

		; SAM VDG mode = G6R,G6C
		sta reg_sam_v0c
		sta reg_sam_v1s
		sta reg_sam_v2s

		ldy #thanks
		jsr write_screen
		clr reg_pia0_pdrb
5		lda reg_pia0_pdra
		ora #$80
		inca
		bne 5B
10		lda reg_pia0_pdra
		ora #$80
		inca
		bne 20F
		bra 10B
20

		lda $a000		; [$A000] points to ROM1 in CoCos
		anda #$20
		beq 10F			; Dragon - no patching necessary
		ldu #coco_patches	; Apply CoCo patches
		jsr apply_patches
10

		ldy #video_select
		jsr write_screen

vs_waitkey	ldx #fb0+24*fb_w+3*10*fb_w+128
		stx tmp0
		lda vs_want_ntsc
		beq 10F
		ldy #vsel_cursor
		jsr write_continue
		ldy #vsel_blank
		bra 20F
10		ldy #vsel_blank
		jsr write_continue
		ldy #vsel_cursor
20		jsr write_continue
		ldx #tbl_kdsp_vs
		jmp wait_keypress_jump
vs_pal		lda #$ff
		sta vs_want_ntsc
		bra vs_waitkey
vs_ntsc		clr vs_want_ntsc
		bra vs_waitkey
vs_toggle	com vs_want_ntsc
		bra vs_waitkey
vs_done

vs_want_ntsc	equ *+1
		lda #$ff
		bne ntsc_done

		; Query for VDG phase if NTSC and modify the palettes
		; accordingly.
		ldx #fb0_end
		stx >dzip_end
		ldu #fb0
		ldx #ntsc_check_dz
		jsr dunzip
		lda #$fa
		sta reg_pia1_pdrb
		ldx #tbl_kdsp_ntsc
		jmp wait_keypress_jump
ntsc_phase1	ldd #$0201
		sta ntsc_palette0+0
		stb ntsc_palette0+3
		std ntsc_palette1+2
		; Patch the patch!  For red sword hilts in stats screen.
		ldd #$10d4
		sta mod_PATCH_draw_ammo0
		stb mod_PATCH_draw_ammo1
		sta mod_PATCH_draw_ammo2
		ldd #$08a8
		std mod_PATCH_draw_key01
		lda #$88
		sta mod_PATCH_draw_key11
ntsc_phase0

		; Simple patches
		clra
		clrb
		std PATCH_draw_ammo3
		std PATCH_undraw_key
		std PATCH_undraw_speed

		ldu #ntsc_patches	; Apply NTSC patches
		bsr apply_patches
		ldx #ntsc_palette0	; Palette-swap tiles
		ldu #tiles_a_start
10		bsr palette_swap_a
		cmpu #tiles_a_end
		blo 10B
15		bsr palette_swap_a	; chalice_nw0
		bsr palette_swap_b	; chalice_ne0
		cmpu #chalice_end
		blo 15B
		ldu #lnum_tiles_start	; Palette-swap large numbers
20		bsr palette_swap_u
		cmpu #lnum_tiles_end
		blo 20B
		ldx #ntsc_palette1	; Palette-swap small numbers
		ldu #snum_tiles_start
30		bsr palette_swap_u
		cmpu #snum_tiles_end
		blo 30B

ntsc_done

		; generate shifted tiles
		ldu #tbl_tiles_a_start
		ldx #tbl_tiles_b_start
10		pulu d
		addd #tiles_b_start-tiles_a_start
		std ,x++
		cmpu #tbl_tiles_a_end
		blo 10B
		ldu #tiles_a_start
		ldx #tiles_b_start
20		pulu d
		lsra
		rorb
		lsra
		rorb
		lsra
		rorb
		lsra
		rorb
		std ,x++
		cmpu #tiles_a_end
		blo 20B

		; patch reset vector
		ldd #game_reset
		std $0072
		ldd #$55ff
		sta $0071
		; set level = -1
		stb level

		jmp game_reset

10		pulu x
20		lda ,u+
		sta ,x+
		decb
		bne 20B
apply_patches	ldb ,u+
		bne 10B
		rts

palette_swap_a	ldb #9
10		bsr palette_swap_u
		bsr palette_swap_u
		anda #$f0
		sta -1,u
		decb
		bne 10B
		rts

palette_swap_b	ldb #9
10		bsr palette_swap_u
		anda #$0f
		sta -1,u
		bsr palette_swap_u
		decb
		bne 10B
		rts

; Simple palette shifter - optimised version delicately lifted from
; Stewart Orchard's blog.

palette_swap_u	pshs b
		lda ,u
		ldb #4
		stb tmp0
10		clrb
		lsla
		rolb
		lsla
		rolb
		ora b,x
		dec tmp0
		bne 10B
		sta ,u+
		puls b,pc

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

; CoCo patches

coco_patches

		PATCH tbl_kdsp_menu
		KEYDSP_ENTRY 7,3,start_game	; SPACE
		KEYDSP_ENTRY 1,4,toggle_p1	; '1'
		KEYDSP_ENTRY 2,4,toggle_p2	; '2'
		KEYDSP_ENTRY 3,4,toggle_p3	; '3'
		KEYDSP_ENTRY 4,4,toggle_p4	; '4'
		KEYDSP_ENTRY 4,0,toggle_skill	; 'D'
		KEYDSP_ENTRY 3,2,toggle_sound	; 'S'
		KEYDSP_ENTRY 2,1,toggle_joystk	; 'J'
		ENDPATCH

		PATCH tbl_p1_keys
		KEYTBL_ENTRY 1,4,2			; '1' = magic
		KEYTBL_ENTRY 2,4,$80|facing_up		; '2' = up
		KEYTBL_ENTRY 7,2,$80|facing_down	; 'W' = down
		KEYTBL_ENTRY 4,4,$80|facing_right	; '4' = right
		KEYTBL_ENTRY 3,4,$80|facing_left	; '3' = left
		KEYTBL_ENTRY 5,4,1			; '5' = fire
		fdb 0
		KEYTBL_ENTRY 7,5,2			; '/' = magic
		KEYTBL_ENTRY 0,2,$80|facing_up		; 'P' = up
		KEYTBL_ENTRY 3,5,$80|facing_down	; ';' = down
		KEYTBL_ENTRY 6,5,$80|facing_right	; '.' = right
		KEYTBL_ENTRY 4,5,$80|facing_left	; ',' = left
		KEYTBL_ENTRY 0,4,1			; '0' = fire
		fdb 0
		ENDPATCH

		PATCH tbl_kdsp_vs
		KEYDSP_ENTRY 0,2,vs_pal		; 'P'
		KEYDSP_ENTRY 6,1,vs_ntsc	; 'N'
		KEYDSP_ENTRY 3,3,vs_toggle	; UP
		KEYDSP_ENTRY 4,3,vs_toggle	; DOWN
		; no patch required for ENTER
		ENDPATCH

		PATCH PATCH_p1ddrb
		fcb $f8		; lda #$f8 - VDG ONLY as outputs
		ENDPATCH

		fcb 0			; no more patches

		; - - - - - - - - - - - - - - - - - - - - - - -

; NTSC patches

ntsc_patches

		PATCH PATCH_vdgmode_game
		fcb $fa		; lda #$fa - VDG mode RG6, CSS1
		ENDPATCH

		PATCH PATCH_draw_key0
		fdb $0cfc	; ldd #$0cfc
		ENDPATCH

		PATCH PATCH_draw_key1
		fcb $cc		; lda #$cc
		ENDPATCH

		PATCH PATCH_draw_key01
mod_PATCH_draw_key01	equ *
		fdb $0454	; ldd #$0454
		ENDPATCH

		PATCH PATCH_draw_key11
mod_PATCH_draw_key11	equ *
		fcb $44		; lda #$44
		ENDPATCH

		PATCH PATCH_draw_speed0
		fdb $0c30	; ldd #$0c30
		ENDPATCH

		PATCH PATCH_draw_speed1
		fcb $c0		; lda #$c0
		ENDPATCH

		PATCH PATCH_draw_ammo0
mod_PATCH_draw_ammo0	equ *+1
		fdb $ff20	; ldd #$ff20
		ENDPATCH

		PATCH PATCH_draw_ammo1
mod_PATCH_draw_ammo1	equ *
		fcb $e8		; ldb #$e8
		ENDPATCH

		PATCH PATCH_draw_ammo2
mod_PATCH_draw_ammo2	equ *
		fcb $0		; ldb #$20
		ENDPATCH

		PATCH play_screen_dz
		includebin "play-screen-ntsc.bin.dz"
		ENDPATCH

		fcb 0			; no more patches

		; - - - - - - - - - - - - - - - - - - - - - - -

; NTSC data

ntsc_palette0	fcb 1,3,0,2		; blue, white, black, red
ntsc_palette1	fcb 0,3,1,2		; black, white, blue, red

tbl_kdsp_vs	KEYDSP_ENTRY 0,4,vs_pal		; 'P'
		KEYDSP_ENTRY 6,3,vs_ntsc	; 'N'
		KEYDSP_ENTRY 3,5,vs_toggle	; UP
		KEYDSP_ENTRY 4,5,vs_toggle	; DOWN
		KEYDSP_ENTRY 0,6,vs_done	; ENTER
		fdb 0

tbl_kdsp_ntsc	KEYDSP_ENTRY 0,6,ntsc_phase0	; ENTER
		KEYDSP_ENTRY 1,6,ntsc_phase1	; CLEAR
		fdb 0

thanks		fcb 10
		fdb fb0+6*fb_w+128+1
		includebin "thanks.bin"
video_select	fcb 10
		fdb fb0+24*fb_w+128
		includebin "video-select.bin"
vsel_cursor	fcb $84,$26,$88,$26,$ff,0
vsel_blank	fcb $84,$27,$88,$27,$ff,0
ntsc_check_dz	includebin "ntsc-check.bin.dz"

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

; Useful addresses for end of listing

		CODE
CODE_start	equ CODE_start_
CODE_end	equ *
		DATA
DATA_start	equ DATA_start_
DATA_end	equ *
		BSS
BSS_start	equ BSS_start_
BSS_end		equ *
		section "INIT"
INIT_end	equ *
