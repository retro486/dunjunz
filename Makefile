# Dunjunz

.PHONY: all
all: dunjunz.bin dunjunz.cas

####

ASM6809 = asm6809 -v
BIN2CAS = bin2cas.pl
CFLAGS += -std=c99
CLEAN =
EXTRA_DIST =

####

%.bin: %.s
	$(ASM6809) $(AFLAGS) -l $(<:.s=.lis) -o $@ $<

%.dz: %
	dzip -c $< > $@

####

TILES = \
	floor \
	armour cross food money \
	potion power speed weapon \
	exit tport \
	trapdoor drainer0 drainer1 \
	key door_h door_v \
	bones0 bones1 bones2 bones3 \
	bones4 bones5 bones6 bones7

EXTRA_TILES = \
	stone01 \
	fball_up fball_down fball_left fball_right

STONES = \
	stone01 stone02 stone03 \
	stone06 \
	stone10 stone12 \
	stone13 stone14 \
	stone17 stone18 stone20 \
	stone21 \
	stone25

SPRITES_U = monster_up0 monster_up1 p1_up0 p3_up0 p3_up1 p4_up0 p4_up1
SPRITES_D = monster_down0 monster_down1 p1_down0 p3_down0 p3_down1 p4_down0 p4_down1
SPRITES_L = monster_left0 monster_left1 p3_left0
SPRITES_R = monster_right0 monster_right1 p3_right0

SPRITES = $(SPRITES_U) $(SPRITES_D) $(SPRITES_L) $(SPRITES_R)

tiles.s: $(TILES:%=c_%.png) ./tile2s Makefile
	echo "; tile drawing routines" > $@
	echo "" >> $@
	for t in $(TILES) $(EXTRA_TILES); do \
		echo "tile_$${t}_a" >> $@; \
		./tile2s -b c_$$t.png >> $@; \
		echo "tile_$${t}_b" >> $@; \
		./tile2s -b -s 4 c_$$t.png >> $@; \
	done
	for s in 0 1 2 3 4 5 6 7 8 9; do \
		echo "draw_lnum_$$s" >> $@; \
		./tile2s -i -128 s_lnum_$$s.png >> $@; \
		echo "	rts" >> $@; \
	done
	for s in 1 2 3 4 5 6 7 8 9; do \
		echo "draw_snum_$$s" >> $@; \
		./tile2s -i -128 -n s_snum_$$s.png >> $@; \
		echo "	rts" >> $@; \
	done
	for s in key speed weapon; do \
		echo "draw_s_$$s" >> $@; \
		./tile2s -i -128 -n s_$$s.png >> $@; \
		echo "	rts" >> $@; \
	done

sprites.s: $(SPRITES:%=c_%.png) ./tile2s Makefile
	echo "; sprite drawing routines" > $@
	echo "" >> $@
	for t in $(SPRITES_U); do \
		echo "draw_$${t}_a2" >> $@; \
		echo "	leax -fb_w*3,x" >> $@; \
		echo "draw_$${t}_a1" >> $@; \
		echo "	leax -fb_w*3,x" >> $@; \
		echo "draw_$${t}_a0" >> $@; \
		./tile2s -i -128 -n c_$$t.png >> $@; \
		echo "	rts" >> $@; \
		echo "draw_$${t}_b2" >> $@; \
		echo "	leax -fb_w*3,x" >> $@; \
		echo "draw_$${t}_b1" >> $@; \
		echo "	leax -fb_w*3,x" >> $@; \
		echo "draw_$${t}_b0" >> $@; \
		./tile2s -i -128 -n -s 4 c_$$t.png >> $@; \
		echo "	rts" >> $@; \
	done
	for t in $(SPRITES_D); do \
		echo "draw_$${t}_a2" >> $@; \
		echo "	leax fb_w*3,x" >> $@; \
		echo "draw_$${t}_a1" >> $@; \
		echo "	leax fb_w*3,x" >> $@; \
		echo "draw_$${t}_a0" >> $@; \
		./tile2s -i -128 -n c_$$t.png >> $@; \
		echo "	rts" >> $@; \
		echo "draw_$${t}_b2" >> $@; \
		echo "	leax fb_w*3,x" >> $@; \
		echo "draw_$${t}_b1" >> $@; \
		echo "	leax fb_w*3,x" >> $@; \
		echo "draw_$${t}_b0" >> $@; \
		./tile2s -i -128 -n -s 4 c_$$t.png >> $@; \
		echo "	rts" >> $@; \
	done
	for t in $(SPRITES_L); do \
		echo "draw_$${t}_a2" >> $@; \
		echo "	leax -1,x" >> $@; \
		echo "draw_$${t}_b1" >> $@; \
		echo "draw_$${t}_a0" >> $@; \
		./tile2s -i -128 -n c_$$t.png >> $@; \
		echo "	rts" >> $@; \
		echo "draw_$${t}_b2" >> $@; \
		echo "draw_$${t}_a1" >> $@; \
		echo "	leax -1,x" >> $@; \
		echo "draw_$${t}_b0" >> $@; \
		./tile2s -i -128 -n -s 4 c_$$t.png >> $@; \
		echo "	rts" >> $@; \
	done
	for t in $(SPRITES_R); do \
		echo "draw_$${t}_a2" >> $@; \
		echo "draw_$${t}_b1" >> $@; \
		echo "	leax 1,x" >> $@; \
		echo "draw_$${t}_a0" >> $@; \
		./tile2s -i -128 -n c_$$t.png >> $@; \
		echo "	rts" >> $@; \
		echo "draw_$${t}_b2" >> $@; \
		echo "	leax 1,x" >> $@; \
		echo "draw_$${t}_a1" >> $@; \
		echo "draw_$${t}_b0" >> $@; \
		./tile2s -i -128 -n -s 4 c_$$t.png >> $@; \
		echo "	rts" >> $@; \
	done

CLEAN += tiles.s sprites.s

####

LEVELS = 01 02 03 04 05 06 \
	07 08 09 10 11 12 \
	13 14 15 16 17 18 \
	19 20 21 22 23 24

LEVELS_S = $(LEVELS:%=level%.s)
LEVELS_BIN = $(LEVELS:%=level%.bin)
CLEAN += $(LEVELS_S) $(LEVELS_BIN) $(LEVELS:%=level%.lis)
STONE = 01

level%.bin: level%.s
	$(ASM6809) -B -l $(<:.s=.lis) -o $@ $<

%.s: %.map ./map2s.pl
	echo "	include \"objects.s\"" > $@
	echo "" >> $@
	./map2s.pl $< >> $@

levels.s: $(LEVELS_S:.s=.map)
	echo "" > $@
	for t in $(LEVELS); do \
		echo "level$${t}_dz" >> $@; \
		echo "	includebin \"level$${t}.bin.dz\"" >> $@; \
	done
	echo "levels" >> $@
	for t in $(LEVELS); do \
		echo "	fdb level$${t}_dz" >> $@; \
	done
	echo "	fdb levels" >> $@

####

./tile2s: CFLAGS += $(shell sdl-config --cflags)
./tile2s: LDLIBS += $(shell sdl-config --libs) -lSDL_image

$(LEVELS_S): objects.s

play-screen.s: play-screen.png ./tile2s
	./tile2s -b -o $@ $<

play-screen.bin: play-screen.s
	$(ASM6809) -B -o $@ $<

CLEAN += play-screen.s play-screen.bin play-screen.bin.dz

dunjunz.bin: dunjunz.s tiles.s sprites.s dunzip.s play-screen.bin.dz $(LEVELS_BIN)
	$(ASM6809) -D -e start -l $(<:.s=.lis) -o $@ $<
CLEAN += dunjunz.lis dunjunz.bin

loading-screen.s: loading-screen.png ./tile2s
	./tile2s -br -o $@ $<

loading-screen.bin: loading-screen.s
	$(ASM6809) -B -o $@ $<

CLEAN += loading-screen.s loading-screen.bin

dunjunz.cas dunjunz.wav: loading-screen.bin dunjunz.bin
	$(BIN2CAS) $(B2CFLAGS) --autorun -o $@ -n DUNJUNZ --eof-data --dzip --fast \
		-B -l 0x0c00 loading-screen.bin \
		--vdg 0xf8 --sam-v 6 --sam-f 6 \
		-D dunjunz.bin

CLEAN += dunjunz.cas dunjunz.wav

####

dunjunz.shtml: dunjunz.head.html dunjunz.body.html dunjunz.foot.html
	cat dunjunz.head.html dunjunz.body.html dunjunz.foot.html > $@

dunjunz.body.html: dunjunz.md
	pandoc -t html5 -o $@ $<

CLEAN += dunjunz.body.html

####

.PHONY: dist
dist: $(EXTRA_DIST)
	git archive --format=tar --output=../dunjunz.tar --prefix=dunjunz/ HEAD
	#tar -r -f ../dunjunz.tar --owner=root --group=root --mtime=../dunjunz.tar --transform 's,^,dunjunz/,' $(EXTRA_DIST)
	gzip -f9 ../dunjunz.tar

####

.PHONY: clean
clean:
	rm -f $(CLEAN)
