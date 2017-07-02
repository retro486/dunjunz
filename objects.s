; object types.  multiples of 2, as most will also be used as the offset
; into various tables: tile rendering, pickup handling

next_oid	macro
\1		equ tileidx
tileidx		set tileidx+2
		endm

tileidx		set -8

; OIDs < 0 are blocking
; OIDs <= 0 are not dereferenced into object structures
; OIDs < -6 are placeholders, not real objects

		next_oid "monster"	; -8

		next_oid "door_v"	; - 6
		next_oid "door_h"	; - 4
		next_oid "stone"	; - 2

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

