#!/bin/bash

# Generates stone tiles.

sheet="$1"
test -z "$sheet" && { echo "usage: $0 imagefile" >&2; exit 1; }

W=12
H=9

bitmap_ab () {
	local name="$1"
	local x="$2"
	local y="$3"
	shift 3
	echo "${name}_a"
	./tile2s -b -x $x -y $y -w $W -h $H "$@" "$sheet"
	echo ""
}

bitmap_ab tile_stone01 $((W*0)) $((H*0))
bitmap_ab tile_stone02 $((W*1)) $((H*0))
bitmap_ab tile_stone03 $((W*2)) $((H*0))
bitmap_ab tile_stone04 $((W*3)) $((H*0))

bitmap_ab tile_stone05 $((W*0)) $((H*1))
bitmap_ab tile_stone06 $((W*1)) $((H*1))
bitmap_ab tile_stone07 $((W*2)) $((H*1))
bitmap_ab tile_stone08 $((W*3)) $((H*1))

bitmap_ab tile_stone09 $((W*0)) $((H*2))
bitmap_ab tile_stone10 $((W*1)) $((H*2))
bitmap_ab tile_stone11 $((W*2)) $((H*2))
bitmap_ab tile_stone12 $((W*3)) $((H*2))

bitmap_ab tile_stone13 $((W*0)) $((H*3))
bitmap_ab tile_stone14 $((W*1)) $((H*3))
bitmap_ab tile_stone15 $((W*2)) $((H*3))
bitmap_ab tile_stone16 $((W*3)) $((H*3))

bitmap_ab tile_stone17 $((W*0)) $((H*4))
bitmap_ab tile_stone18 $((W*1)) $((H*4))
bitmap_ab tile_stone19 $((W*2)) $((H*4))
bitmap_ab tile_stone20 $((W*3)) $((H*4))

bitmap_ab tile_stone21 $((W*0)) $((H*5))
bitmap_ab tile_stone22 $((W*1)) $((H*5))
bitmap_ab tile_stone23 $((W*2)) $((H*5))
bitmap_ab tile_stone24 $((W*3)) $((H*5))

bitmap_ab tile_stone25 $((W*0)) $((H*6))
