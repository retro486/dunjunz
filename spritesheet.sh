#!/bin/bash

# Generates sprites for players 1-4, monsters and player shots from image.

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

bitmap_01_ab () {
	local name="$1"
	local x="$2"
	local y="$3"
	shift 3
	bitmap_ab "${name}0" $x $y "$@"
	bitmap_ab "${name}1" $((x+W)) $y "$@"
}

bitmap_01_ab tile_p1_up    $((W*0)) $((H*0))
bitmap_01_ab tile_p1_down  $((W*0)) $((H*0)) -X -Y
bitmap_01_ab tile_p1_left  $((W*2)) $((H*0))
bitmap_01_ab tile_p1_right $((W*2)) $((H*0)) -X -Y

bitmap_01_ab tile_p2_up    $((W*0)) $((H*1))
bitmap_01_ab tile_p2_down  $((W*0)) $((H*1)) -X -Y
bitmap_01_ab tile_p2_left  $((W*2)) $((H*1))
bitmap_01_ab tile_p2_right $((W*2)) $((H*1)) -X -Y

bitmap_01_ab tile_p3_up    $((W*0)) $((H*2))
bitmap_01_ab tile_p3_down  $((W*0)) $((H*2)) -X -Y
bitmap_01_ab tile_p3_left  $((W*2)) $((H*2))
bitmap_01_ab tile_p3_right $((W*2)) $((H*2)) -X -Y

bitmap_01_ab tile_p4_up    $((W*0)) $((H*3))
bitmap_01_ab tile_p4_down  $((W*0)) $((H*3)) -X -Y
bitmap_01_ab tile_p4_left  $((W*2)) $((H*3))
bitmap_01_ab tile_p4_right $((W*2)) $((H*3)) -X -Y

bitmap_01_ab tile_monster_up    $((W*0)) $((H*4))
bitmap_01_ab tile_monster_down  $((W*0)) $((H*4)) -X -Y
bitmap_01_ab tile_monster_left  $((W*2)) $((H*4))
bitmap_01_ab tile_monster_right $((W*2)) $((H*4)) -X -Y

bitmap_ab tile_arrow_up    $((W*0)) $((H*5))
bitmap_ab tile_arrow_down  $((W*0)) $((H*5)) -X -Y
bitmap_ab tile_arrow_left  $((W*1)) $((H*5))
bitmap_ab tile_arrow_right $((W*1)) $((H*5)) -X -Y

bitmap_ab tile_fball_up    $((W*2)) $((H*5))
bitmap_ab tile_fball_down  $((W*2)) $((H*5)) -X -Y
bitmap_ab tile_fball_left  $((W*3)) $((H*5))
bitmap_ab tile_fball_right $((W*3)) $((H*5)) -X -Y

bitmap_ab tile_axe_up      $((W*0)) $((H*6))
bitmap_ab tile_axe_down    $((W*0)) $((H*6)) -X -Y
bitmap_ab tile_axe_left    $((W*1)) $((H*6))
bitmap_ab tile_axe_right   $((W*1)) $((H*6)) -X -Y

bitmap_ab tile_sword_up    $((W*2)) $((H*6))
bitmap_ab tile_sword_down  $((W*2)) $((H*6)) -X -Y
bitmap_ab tile_sword_left  $((W*3)) $((H*6))
bitmap_ab tile_sword_right $((W*3)) $((H*6)) -X -Y

