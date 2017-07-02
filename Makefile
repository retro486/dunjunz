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
	door_v door_h \
	floor \
	exit trapdoor money food \
	tport power armour potion \
	weapon cross speed \
	drainer0 drainer1 key \
	stone01 stone02 stone03 stone06 \
	stone10 stone12 stone13 stone14 \
	stone17 stone18 stone20 stone21 \
	stone25 \
	arrow_up arrow_down arrow_left arrow_right \
	fball_up fball_down fball_left fball_right \
	axe_up axe_down axe_left axe_right \
	sword_up sword_down sword_left sword_right \
	bones0 bones1 bones2 bones3 \
	bones4 bones5 bones6 bones7

SPRITES = p1 p2 p3 p4 monster

SPRITES_SRC = \
	$(SPRITES:%=c_%_up0.png) \
	$(SPRITES:%=c_%_up1.png) \
	$(SPRITES:%=c_%_down0.png) \
	$(SPRITES:%=c_%_down1.png) \
	$(SPRITES:%=c_%_left0.png) \
	$(SPRITES:%=c_%_left1.png) \
	$(SPRITES:%=c_%_right0.png) \
	$(SPRITES:%=c_%_right1.png)

tiles.s: $(TILES:%=c_%.png) $(EXTRA_TILES:%=c_%.png) $(SPRITES_SRC) ./tile2s Makefile
	echo "; tile bitmaps" > $@
	echo "" >> $@
	for t in $(TILES) $(EXTRA_TILES); do \
		echo "tile_$${t}_a" >> $@; \
		./tile2s -b c_$$t.png >> $@; \
		echo "" >> $@; \
		echo "tile_$${t}_b" >> $@; \
		./tile2s -b -s 4 c_$$t.png >> $@; \
		echo "" >> $@; \
	done
	for s in $(SPRITES); do \
		for d in up down left right; do \
			for f in 0 1; do \
				echo "tile_$${s}_$${d}$${f}_a" >> $@; \
				./tile2s -b c_$${s}_$${d}$${f}.png >> $@; \
				echo "" >> $@; \
				echo "tile_$${s}_$${d}$${f}_b" >> $@; \
				./tile2s -b -s 4 c_$${s}_$${d}$${f}.png >> $@; \
				echo "" >> $@; \
			done; \
		done; \
	done
	echo "; large digits" >> $@
	echo "" >> $@
	for s in 0 1 2 3 4 5 6 7 8 9; do \
		echo "tile_lnum_$$s" >> $@; \
		./tile2s -b s_lnum_$$s.png >> $@; \
		echo "" >> $@; \
	done
	echo "; small digits" >> $@
	echo "" >> $@
	for s in 1 2 3 4 5 6 7 8 9; do \
		echo "tile_snum_$$s" >> $@; \
		./tile2s -b s_snum_$$s.png >> $@; \
		echo "" >> $@; \
	done

CLEAN += tiles.s

####

LEVELS = 01 02 03 04 05 06 \
	07 08 09 10 11 12 \
	13 14 15 16 17 18 \
	19 20 21 22 23 24 25

LEVELS_S = $(LEVELS:%=level%.s)
LEVELS_BIN = $(LEVELS:%=level%.bin)
LEVELS_BIN_DZ = $(LEVELS:%=level%.bin.dz)
CLEAN += $(LEVELS_S) $(LEVELS_BIN) $(LEVELS_BIN_DZ) $(LEVELS:%=level%.lis)
STONE = 01

level%.bin: level%.s
	$(ASM6809) -B -l $(<:.s=.lis) -o $@ $<

%.s: %.map ./map2s.pl
	echo "	include \"objects.s\"" > $@
	echo "" >> $@
	./map2s.pl $< >> $@

####

./tile2s: CFLAGS += $(shell sdl-config --cflags)
./tile2s: LDLIBS += $(shell sdl-config --libs) -lSDL_image

$(LEVELS_S): objects.s

TEXT_SCREENS = select-screen.bin death-screen.bin end-screen.bin
TEXT_SCREENS_DZ = $(TEXT_SCREENS:%=%.dz)

play-screen.s: play-screen.png ./tile2s
	./tile2s -b -o $@ $<

play-screen.bin: play-screen.s
	$(ASM6809) -B -o $@ $<

CLEAN += play-screen.s play-screen.bin play-screen.bin.dz
CLEAN += $(TEXT_SCREENS_DZ)

dunjunz.bin: dunjunz.s tiles.s dunzip.s play-screen.bin.dz $(TEXT_SCREENS_DZ) $(LEVELS_BIN_DZ)
	$(ASM6809) -D -e start -l $(<:.s=.lis) -o $@ $<
CLEAN += dunjunz.lis dunjunz.bin

loading-screen.s: loading-screen.png ./tile2s
	./tile2s -br -o $@ $<

loading-screen.bin: loading-screen.s
	$(ASM6809) -B -o $@ $<

CLEAN += loading-screen.s loading-screen.bin

dunjunz.cas dunjunz.wav: loading-screen.bin dunjunz.bin
	$(BIN2CAS) $(B2CFLAGS) --autorun -o $@ -n DUNJUNZ --eof-data --dzip --fast \
		-B -l 0x0400 loading-screen.bin \
		--vdg 0xe0 --sam-v 6 --sam-f 2 --flasher \
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
