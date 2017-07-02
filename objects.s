; Object tiles

; In general, the obj_tile field of an obj struct, but in many cases just
; used to index into tile tables.

OBJ_TILE_MULTIPLE	equ 1
OBJ_PAIR_SIZE	equ OBJ_TILE_MULTIPLE*2

OBJ_PAIR_ALIGN	macro
		rmb (OBJ_PAIR_SIZE-*%OBJ_PAIR_SIZE)%OBJ_PAIR_SIZE
		endm

OBJ_TILE	macro
		rmb OBJ_TILE_MULTIPLE
		endm

		org -obj_tile_zero_offset
100

; Doors, drawn only on initial viewport render.  Negative values
; distinguish them from pickups.

door_v1		OBJ_TILE
door_h1		OBJ_TILE
door_v		OBJ_TILE
door_h		OBJ_TILE

obj_tile_zero_offset	equ *-100B

; No object has tile 'floor', but the zero value is used for undrawing.

floor		OBJ_TILE	; == 0

; Normal objects, drawn on initial viewport render.  Only redrawn when
; undrawing something else.

exit		OBJ_TILE
trapdoor	OBJ_TILE
food		OBJ_TILE
tport		OBJ_TILE
armour		OBJ_TILE
potion		OBJ_TILE
weapon		OBJ_TILE
cross		OBJ_TILE
speed		OBJ_TILE

; Normal objects that are redrawn every frame.

always_draw_tile

drainer		OBJ_TILE
money		OBJ_TILE
power		OBJ_TILE

		; ensure pair alignment of following
		OBJ_PAIR_ALIGN

key		OBJ_TILE
key1		OBJ_TILE

; Player graphics.  Not real objects, just used to index into graphics
; tables.  It's important that *0 and *1 are aligned to an even multiple
; so that bit twiddling can change which frame is to be drawn.

; Player shots aren't real objects, but are treated as such to redraw
; every frame.  Like with player tiles, it's important up/down and
; left/right are aligned to an even multiple so that reversing the
; direction is a simple bit twiddle (ie, when shots are "reflected" by
; drainers).

		; ensure pair alignment of following
		OBJ_PAIR_ALIGN

p1_tilebase
p1_up0		OBJ_TILE
p1_up1		OBJ_TILE
p1_down0	OBJ_TILE
p1_down1	OBJ_TILE
p1_left0	OBJ_TILE
p1_left1	OBJ_TILE
p1_right0	OBJ_TILE
p1_right1	OBJ_TILE
arrow_up	OBJ_TILE
arrow_down	OBJ_TILE
arrow_left	OBJ_TILE
arrow_right	OBJ_TILE
p1_exit4	OBJ_TILE
p1_exit5	OBJ_TILE
p1_exit6	OBJ_TILE
p1_exit7	OBJ_TILE
p1_exit8	OBJ_TILE
p1_exit9	OBJ_TILE
p1_exit10	OBJ_TILE
p1_exit11	OBJ_TILE

p2_tilebase
p2_up0		OBJ_TILE
p2_up1		OBJ_TILE
p2_down0	OBJ_TILE
p2_down1	OBJ_TILE
p2_left0	OBJ_TILE
p2_left1	OBJ_TILE
p2_right0	OBJ_TILE
p2_right1	OBJ_TILE
fball_up	OBJ_TILE
fball_down	OBJ_TILE
fball_left	OBJ_TILE
fball_right	OBJ_TILE
p2_exit4	OBJ_TILE
p2_exit5	OBJ_TILE
p2_exit6	OBJ_TILE
p2_exit7	OBJ_TILE
p2_exit8	OBJ_TILE
p2_exit9	OBJ_TILE
p2_exit10	OBJ_TILE
p2_exit11	OBJ_TILE

p3_tilebase
p3_up0		OBJ_TILE
p3_up1		OBJ_TILE
p3_down0	OBJ_TILE
p3_down1	OBJ_TILE
p3_left0	OBJ_TILE
p3_left1	OBJ_TILE
p3_right0	OBJ_TILE
p3_right1	OBJ_TILE
axe_up		OBJ_TILE
axe_down	OBJ_TILE
axe_left	OBJ_TILE
axe_right	OBJ_TILE
p3_exit4	OBJ_TILE
p3_exit5	OBJ_TILE
p3_exit6	OBJ_TILE
p3_exit7	OBJ_TILE
p3_exit8	OBJ_TILE
p3_exit9	OBJ_TILE
p3_exit10	OBJ_TILE
p3_exit11	OBJ_TILE

p4_tilebase
p4_up0		OBJ_TILE
p4_up1		OBJ_TILE
p4_down0	OBJ_TILE
p4_down1	OBJ_TILE
p4_left0	OBJ_TILE
p4_left1	OBJ_TILE
p4_right0	OBJ_TILE
p4_right1	OBJ_TILE
sword_up	OBJ_TILE
sword_down	OBJ_TILE
sword_left	OBJ_TILE
sword_right	OBJ_TILE
p4_exit4	OBJ_TILE
p4_exit5	OBJ_TILE
p4_exit6	OBJ_TILE
p4_exit7	OBJ_TILE
p4_exit8	OBJ_TILE
p4_exit9	OBJ_TILE
p4_exit10	OBJ_TILE
p4_exit11	OBJ_TILE

monster_tilebase
monster_up0	OBJ_TILE
monster_up1	OBJ_TILE
monster_down0	OBJ_TILE
monster_down1	OBJ_TILE
monster_left0	OBJ_TILE
monster_left1	OBJ_TILE
monster_right0	OBJ_TILE
monster_right1	OBJ_TILE

bones0		OBJ_TILE
bones1		OBJ_TILE
bones2		OBJ_TILE
bones3		OBJ_TILE
bones4		OBJ_TILE
bones5		OBJ_TILE
bones6		OBJ_TILE
bones7		OBJ_TILE
