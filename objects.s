; object types.  multiples of 2, as most will also be used as the offset
; into various tables: tile rendering, pickup handling

next_oid	macro
\1		equ tileidx
tileidx		set tileidx+2
		endm

; OIDs <= 0 are not dereferenced into object structures
; OIDs < 0 are blocking

tileidx		set -6

		next_oid "door_v"
		next_oid "door_h"
		next_oid "stone"

		next_oid "floor"	; 0

		next_oid "exit"
		next_oid "trapdoor"
		next_oid "drainer"
		next_oid "money"
		next_oid "food"
		next_oid "tport"
		next_oid "power"
		next_oid "armour"
		next_oid "potion"
		next_oid "weapon"
		next_oid "cross"
		next_oid "speed"
		next_oid "key"

; deprecated - just here so things continue to build

		next_oid "monster_up0"
		next_oid "monster_up1"
		next_oid "monster_down0"
		next_oid "monster_down1"
		next_oid "monster_up"
		next_oid "monster_down"
		next_oid "monster_left"
		next_oid "monster_right"

		next_oid "fball_up"
		next_oid "fball_down"
		next_oid "fball_left"
		next_oid "fball_right"
