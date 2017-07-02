#!/bin/bash

# Generate graphics data from supplied image.

sheet="$1"
test -z "$sheet" && { echo "usage: $0 imagefile" >&2; exit 1; }

TILE2S="./tile2s"

test -x "$TILE2S" || { echo "$TILE2S: not executable" >&2; exit 1; }

W=12
H=9

bitmap_a () {
	local name="$1"
	local x="$2"
	local y="$3"
	shift 3
	echo "${name}_a"
	"$TILE2S" -b -x $x -y $y -w $W -h $H "$@" "$sheet"
	echo
}

bitmap_b () {
	local name="$1"
	local x="$2"
	local y="$3"
	shift 3
	echo "${name}_b"
	"$TILE2S" -b -s 4 -x $x -y $y -w $W -h $H "$@" "$sheet"
	echo
}

bitmap_01_a () {
	local name="$1"
	local x="$2"
	local y="$3"
	shift 3
	bitmap_a "${name}0" $x $y "$@"
	bitmap_a "${name}1" $((x+W)) $y "$@"
}

# Everything between here and 'tiles_a_end' are unshifted tiles (set A).  INIT
# code generates the shifted set B from these.

echo "tiles_a_start"
echo

echo "; player/monster graphics"
echo

bitmap_01_a tile_p1_up    $((W*0)) $((H*0))
bitmap_01_a tile_p1_down  $((W*0)) $((H*0)) -X -Y
bitmap_01_a tile_p1_left  $((W*2)) $((H*0))
bitmap_01_a tile_p1_right $((W*2)) $((H*0)) -X -Y

bitmap_01_a tile_p2_up    $((W*0)) $((H*1))
bitmap_01_a tile_p2_down  $((W*0)) $((H*1)) -X -Y
bitmap_01_a tile_p2_left  $((W*2)) $((H*1))
bitmap_01_a tile_p2_right $((W*2)) $((H*1)) -X -Y

bitmap_01_a tile_p3_up    $((W*0)) $((H*2))
bitmap_01_a tile_p3_down  $((W*0)) $((H*2)) -X -Y
bitmap_01_a tile_p3_left  $((W*2)) $((H*2))
bitmap_01_a tile_p3_right $((W*2)) $((H*2)) -X -Y

bitmap_01_a tile_p4_up    $((W*0)) $((H*3))
bitmap_01_a tile_p4_down  $((W*0)) $((H*3)) -X -Y
bitmap_01_a tile_p4_left  $((W*2)) $((H*3))
bitmap_01_a tile_p4_right $((W*2)) $((H*3)) -X -Y

bitmap_01_a tile_monster_up    $((W*0)) $((H*4))
bitmap_01_a tile_monster_down  $((W*0)) $((H*4)) -X -Y
bitmap_01_a tile_monster_left  $((W*2)) $((H*4))
bitmap_01_a tile_monster_right $((W*2)) $((H*4)) -X -Y

echo "; player shots"
echo

bitmap_a tile_arrow_up    $((W*0)) $((H*5))
bitmap_a tile_arrow_down  $((W*0)) $((H*5)) -X -Y
bitmap_a tile_arrow_left  $((W*1)) $((H*5))
bitmap_a tile_arrow_right $((W*1)) $((H*5)) -X -Y

bitmap_a tile_fball_up    $((W*2)) $((H*5))
bitmap_a tile_fball_down  $((W*2)) $((H*5)) -X -Y
bitmap_a tile_fball_left  $((W*3)) $((H*5))
bitmap_a tile_fball_right $((W*3)) $((H*5)) -X -Y

bitmap_a tile_axe_up      $((W*0)) $((H*6))
bitmap_a tile_axe_down    $((W*0)) $((H*6)) -X -Y
bitmap_a tile_axe_left    $((W*1)) $((H*6))
bitmap_a tile_axe_right   $((W*1)) $((H*6)) -X -Y

bitmap_a tile_sword_up    $((W*2)) $((H*6))
bitmap_a tile_sword_down  $((W*2)) $((H*6)) -X -Y
bitmap_a tile_sword_left  $((W*3)) $((H*6))
bitmap_a tile_sword_right $((W*3)) $((H*6)) -X -Y

echo "; bones - death animation"
echo

bitmap_a tile_bones0      $((W*0)) $((H*7))
bitmap_a tile_bones1      $((W*1)) $((H*7))
bitmap_a tile_bones2      $((W*2)) $((H*7))
bitmap_a tile_bones3      $((W*3)) $((H*7))

bitmap_a tile_bones4      $((W*0)) $((H*8))
bitmap_a tile_bones5      $((W*1)) $((H*8))
bitmap_a tile_bones6      $((W*2)) $((H*8))
bitmap_a tile_bones7      $((W*3)) $((H*8))

echo "; exit animations"
echo

bitmap_a tile_p1_exit4 $((W*0)) $((H*9))
bitmap_a tile_p1_exit5 $((W*1)) $((H*9))
bitmap_a tile_p1_exit6 $((W*0)) $((H*9)) -X -Y
bitmap_a tile_p1_exit7 $((W*1)) $((H*9)) -X -Y

bitmap_a tile_p2_exit4 $((W*2)) $((H*9))
bitmap_a tile_p2_exit5 $((W*3)) $((H*9))
bitmap_a tile_p2_exit6 $((W*2)) $((H*9)) -X -Y
bitmap_a tile_p2_exit7 $((W*3)) $((H*9)) -X -Y

bitmap_a tile_p3_exit4 $((W*0)) $((H*10))
bitmap_a tile_p3_exit5 $((W*1)) $((H*10))
bitmap_a tile_p3_exit6 $((W*0)) $((H*10)) -X -Y
bitmap_a tile_p3_exit7 $((W*1)) $((H*10)) -X -Y

bitmap_a tile_p4_exit4 $((W*2)) $((H*10))
bitmap_a tile_p4_exit5 $((W*3)) $((H*10))
bitmap_a tile_p4_exit6 $((W*2)) $((H*10)) -X -Y
bitmap_a tile_p4_exit7 $((W*3)) $((H*10)) -X -Y

bitmap_a tile_exit8 $((W*0)) $((H*11))
bitmap_a tile_exit9 $((W*1)) $((H*11))
bitmap_a tile_exit10 $((W*0)) $((H*11)) -X -Y
bitmap_a tile_exit11 $((W*1)) $((H*11)) -X -Y

echo "; misc items"
echo

bitmap_a tile_floor    $((W*4)) $((H*0))
bitmap_a tile_exit     $((W*5)) $((H*0))
bitmap_a tile_trapdoor $((W*6)) $((H*0))
bitmap_a tile_tport    $((W*7)) $((H*0))

bitmap_a tile_drainer0 $((W*4)) $((H*1))
bitmap_a tile_drainer1 $((W*5)) $((H*1))
bitmap_a tile_money0   $((W*6)) $((H*1))
bitmap_a tile_money1   $((W*7)) $((H*1))

bitmap_a tile_power0   $((W*4)) $((H*2))
bitmap_a tile_power1   $((W*5)) $((H*2))
bitmap_a tile_weapon   $((W*6)) $((H*2))
bitmap_a tile_armour   $((W*7)) $((H*2))

bitmap_a tile_food     $((W*4)) $((H*3))
bitmap_a tile_potion   $((W*5)) $((H*3))
bitmap_a tile_cross    $((W*6)) $((H*3))
bitmap_a tile_speed    $((W*7)) $((H*3))

bitmap_a tile_door_v   $((W*4)) $((H*4))
bitmap_a tile_door_h   $((W*5)) $((H*4))
bitmap_a tile_key      $((W*6)) $((H*4))

echo "; stones"
echo

bitmap_a tile_stone01 $((W*4)) $((H*5))
bitmap_a tile_stone02 $((W*5)) $((H*5))
bitmap_a tile_stone03 $((W*6)) $((H*5))
bitmap_a tile_stone04 $((W*7)) $((H*5))

bitmap_a tile_stone05 $((W*4)) $((H*6))
bitmap_a tile_stone06 $((W*5)) $((H*6))
bitmap_a tile_stone07 $((W*6)) $((H*6))
bitmap_a tile_stone08 $((W*7)) $((H*6))

bitmap_a tile_stone09 $((W*4)) $((H*7))
bitmap_a tile_stone10 $((W*5)) $((H*7))
bitmap_a tile_stone11 $((W*6)) $((H*7))
bitmap_a tile_stone12 $((W*7)) $((H*7))

bitmap_a tile_stone13 $((W*4)) $((H*8))
bitmap_a tile_stone14 $((W*5)) $((H*8))
bitmap_a tile_stone15 $((W*6)) $((H*8))
bitmap_a tile_stone16 $((W*7)) $((H*8))

bitmap_a tile_stone17 $((W*4)) $((H*9))
bitmap_a tile_stone18 $((W*5)) $((H*9))
bitmap_a tile_stone19 $((W*6)) $((H*9))
bitmap_a tile_stone20 $((W*7)) $((H*9))

bitmap_a tile_stone21 $((W*4)) $((H*10))
bitmap_a tile_stone22 $((W*5)) $((H*10))
bitmap_a tile_stone23 $((W*6)) $((H*10))
bitmap_a tile_stone24 $((W*7)) $((H*10))

bitmap_a tile_stone25 $((W*4)) $((H*11))

echo "tiles_a_end"
echo

# Chalice graphics only ever appear in one position, and so shifted versions
# are not required.

echo "; chalice"
echo

bitmap_a tile_chalice_nw0 $((W*6)) $((H*11))
bitmap_b tile_chalice_ne0 $((W*6)) $((H*11)) -X
bitmap_a tile_chalice_sw0 $((W*6)) $((H*11)) -Y
bitmap_b tile_chalice_se0 $((W*6)) $((H*11)) -X -Y

bitmap_a tile_chalice_nw1 $((W*7)) $((H*11))
bitmap_b tile_chalice_ne1 $((W*7)) $((H*11)) -X
bitmap_a tile_chalice_sw1 $((W*7)) $((H*11)) -Y
bitmap_b tile_chalice_se1 $((W*7)) $((H*11)) -X -Y

echo "chalice_end"
echo

echo "; large digits"
echo

echo "lnum_tiles_start"
echo

for i in 0 1 2 3 4 5 6 7 8 9; do
	echo "tile_lnum_$i"
	"$TILE2S" -b -x $((i*8)) -y $((H*12)) -w 8 -h 7 "$sheet"
	echo
done

echo "lnum_tiles_end"
echo

echo "; small digits"
echo

echo "snum_tiles_start"
echo

for i in 1 2 3 4 5 6 7 8 9; do
	echo "tile_snum_$i"
	"$TILE2S" -b -x $(((i-1)*8)) -y $((H*12+7)) -w 8 -h 5 "$sheet"
	echo
done

echo "snum_tiles_end"
echo
