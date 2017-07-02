#!/bin/bash

# Generates exit animation tiles.

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

bitmap_ab tile_p1_exit4 $((W*0)) $((H*0))
bitmap_ab tile_p1_exit5 $((W*1)) $((H*0))
bitmap_ab tile_p1_exit6 $((W*0)) $((H*0)) -X -Y
bitmap_ab tile_p1_exit7 $((W*1)) $((H*0)) -X -Y

bitmap_ab tile_p2_exit4 $((W*0)) $((H*1))
bitmap_ab tile_p2_exit5 $((W*1)) $((H*1))
bitmap_ab tile_p2_exit6 $((W*0)) $((H*1)) -X -Y
bitmap_ab tile_p2_exit7 $((W*1)) $((H*1)) -X -Y

bitmap_ab tile_p3_exit4 $((W*0)) $((H*2))
bitmap_ab tile_p3_exit5 $((W*1)) $((H*2))
bitmap_ab tile_p3_exit6 $((W*0)) $((H*2)) -X -Y
bitmap_ab tile_p3_exit7 $((W*1)) $((H*2)) -X -Y

bitmap_ab tile_p4_exit4 $((W*0)) $((H*3))
bitmap_ab tile_p4_exit5 $((W*1)) $((H*3))
bitmap_ab tile_p4_exit6 $((W*0)) $((H*3)) -X -Y
bitmap_ab tile_p4_exit7 $((W*1)) $((H*3)) -X -Y

bitmap_ab tile_exit8 $((W*0)) $((H*4))
bitmap_ab tile_exit9 $((W*1)) $((H*4))
bitmap_ab tile_exit10 $((W*0)) $((H*4)) -X -Y
bitmap_ab tile_exit11 $((W*1)) $((H*4)) -X -Y
