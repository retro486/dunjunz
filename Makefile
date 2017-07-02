# Dunjunz

.PHONY: all
all: dunjunz.bin dunjunz.cas

####

ASM6809 = asm6809 -v
BIN2CAS = bin2cas.pl
B2CFLAGS = -r 44100
CFLAGS += -std=c99
CLEAN =
EXTRA_DIST =

####

%.bin: %.s
	$(ASM6809) $(AFLAGS) -l $(<:.s=.lis) -o $@ $<

%.dz: %
	dzip -c $< > $@

####

.PHONY: version.s
version.s:
	echo " fcc /    DUNJUNZ  ALPHA `date +%Y%m%d`/,0" > $@

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
	stone25

TILES_SRC = $(TILES:%=c_%.png) c_bones.png

tiles.s: $(TILES_SRC) sprites.png ./spritesheet.sh ./exitsheet.sh ./tile2s Makefile
	echo "; tile bitmaps" > $@
	echo "" >> $@
	for t in $(TILES); do \
		echo "tile_$${t}_a" >> $@; \
		./tile2s -b c_$$t.png >> $@; \
		echo "" >> $@; \
	done
	for s in 0 1 2 3 4 5 6 7; do \
		echo "tile_bones$${s}_a" >> $@; \
		./tile2s -b -x `expr $$s \* 12` -w 12 c_bones.png >> $@; \
		echo "" >> $@; \
	done
	./spritesheet.sh sprites.png >> $@
	./exitsheet.sh exit.png >> $@

utiles.s: s_lnum.png s_snum.png ./tile2s Makefile
	echo "; large digits" > $@
	echo "lnum_tiles_start" >> $@
	echo "" >> $@
	for s in 0 1 2 3 4 5 6 7 8 9; do \
		echo "tile_lnum_$$s" >> $@; \
		./tile2s -x `expr $$s \* 8` -w 8 -b s_lnum.png >> $@; \
		echo "" >> $@; \
	done
	echo "" >> $@
	echo "lnum_tiles_end" >> $@
	echo "" >> $@
	echo "; small digits" >> $@
	echo "snum_tiles_start" >> $@
	echo "" >> $@
	for s in 1 2 3 4 5 6 7 8 9; do \
		echo "tile_snum_$$s" >> $@; \
		./tile2s -x `expr \( $$s - 1 \) \* 8` -w 8 -b s_snum.png >> $@; \
		echo "" >> $@; \
	done
	echo "" >> $@
	echo "snum_tiles_end" >> $@

CLEAN += tiles.s utiles.s

####

LEVELS = 01 02 03 04 05 06 \
	07 08 09 10 11 12 \
	13 14 15 16 17 18 \
	19 20 21 22 23 24 25

LEVELS_S = $(LEVELS:%=level%.s)
LEVELS_BIN = $(LEVELS:%=level%.bin)
LEVELS_BIN_DZ = $(LEVELS:%=level%.bin.dz)
CLEAN += $(LEVELS_S) $(LEVELS_BIN) $(LEVELS_BIN_DZ) $(LEVELS:%=level%.lis)

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

TEXT_SCREENS = video-select.bin select-screen.bin death-screen.bin end-screen.bin
TEXT_SCREENS_DZ = $(TEXT_SCREENS:%=%.dz)

play-screen.s: play-screen.png ./tile2s
	./tile2s -b -o $@ $<

play-screen-ntsc.s: play-screen-ntsc.png ./tile2s
	./tile2s -b -r -o $@ $<

ntsc-check.s: ntsc-check.png ./tile2s
	./tile2s -b -o $@ $<

play-screen.bin: play-screen.s
	$(ASM6809) -B -o $@ $<

play-screen-ntsc.bin: play-screen-ntsc.s
	$(ASM6809) -B -o $@ $<

ntsc-check.bin: ntsc-check.s
	$(ASM6809) -B -o $@ $<

CLEAN += play-screen.s play-screen.bin play-screen.bin.dz
CLEAN += play-screen-ntsc.s play-screen-ntsc.bin play-screen-ntsc.bin.dz
CLEAN += ntsc-check.s ntsc-check.bin ntsc-check.bin.dz
CLEAN += $(TEXT_SCREENS_DZ)

dunjunz.bin: dunjunz.s version.s tiles.s utiles.s ntsc-check.bin.dz play-screen.bin.dz play-screen-ntsc.bin.dz $(TEXT_SCREENS_DZ) $(LEVELS_BIN_DZ)
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
		--vdg 0xe0 --sam-v 6 --sam-f 2 \
		-D dunjunz.bin

dunjunz-nl.cas dunjunz-nl.wav: dunjunz.bin
	$(BIN2CAS) $(B2CFLAGS) --autorun -o $@ -n DUNJUNZ --eof-data --dzip --fast \
		-D dunjunz.bin

CLEAN += dunjunz.cas dunjunz.wav dunjunz-nl.cas dunjunz-nl.wav

####

dunjunz.body.html: dunjunz.md
	pandoc -t html5 -o $@ $<

dunjunz.shtml: dunjunz.head.html dunjunz.body.html dunjunz.foot.html
	sed "s/%UPDATED%/`date '+%e %b %Y'`/" < dunjunz.head.html > $@
	cat dunjunz.body.html dunjunz.foot.html >> $@

README.body.html: README.md
	pandoc -t html5 -o $@ $<

README.shtml: README.head.html README.body.html dunjunz.foot.html
	sed "s/%UPDATED%/`date '+%e %b %Y'`/" < README.head.html > $@
	cat README.body.html dunjunz.foot.html >> $@

CLEAN += dunjunz.body.html dunjunz.shtml README.body.html README.shtml

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
