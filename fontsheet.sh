#!/bin/bash

# Generate graphics data from supplied image.

sheet="$1"
test -z "$sheet" && { echo "usage: $0 imagefile" >&2; exit 1; }

TILE2S="./tile2s"

test -x "$TILE2S" || { echo "$TILE2S: not executable" >&2; exit 1; }

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

# Everything between here and 'textfont_a_end' are unshifted tiles (set A).
# INIT code generates the shifted set B from these.

echo "textfont_a"
echo

W=12
H=6

for i in {0..38}; do
	x=$(((i%8)*W))
	y=$(((i/8)*H))
	bitmap_a "textfont_$i" $x $y -r
done

echo "textfont_a_end"
echo

echo "; large digits"
echo

echo "lnum_tiles_start"
echo

for i in 0 1 2 3 4 5 6 7 8 9; do
	echo "tile_lnum_$i"
	"$TILE2S" -b -x $((i*8)) -y $((H*5)) -w 8 -h 7 "$sheet"
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
	"$TILE2S" -b -x $((i*8)) -y $((H*5+7)) -w 8 -h 5 "$sheet"
	echo
done

echo "snum_tiles_end"
echo
