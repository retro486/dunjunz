# Dunjunz

.PHONY: all
all: dunjunz.bin dunjunz.cas dunjunz.wav dunjunz.dsk

####

ASM6809 = asm6809 -v
BIN2CAS = bin2cas.pl
B2CFLAGS = -r 44100
CFLAGS += -std=c99
CLEAN =
EXTRA_DIST =

####

./tile2s: CFLAGS += $(shell sdl-config --cflags)
./tile2s: LDLIBS += $(shell sdl-config --libs) -lSDL_image

CLEAN += ./tile2s

####

%.bin: %.s
	$(ASM6809) $(AFLAGS) -l $(<:.s=.lis) -o $@ $<

%.dz: %
	dzip -c $< > $@

%.bin: %.txt Makefile
	perl -pe 'chomp if eof' $< | sed 's/            /\o213/g;s/        /\o207/g;s/       /\o206/g;s/      /\o205/g;s/     /\o204/g;s/    /\o203/g;s/   /\o202/g;s/  /\o201/g' | tr '123456()\!A-Z.,\- \012\014' '\001-\047\377\377' > $@
	/bin/echo -ne '\00' >> $@

%.s: %.map ./map2s.pl
	echo "	include \"objects.s\"" > $@
	echo >> $@
	./map2s.pl $< >> $@

####

.PHONY: version.txt
version.txt:
	echo "   DUNJUNZ - BETA3" > $@

CLEAN += version.txt

tiles.s: ./tilesheet.sh tiles.png ./tile2s Makefile
	./tilesheet.sh tiles.png > $@

CLEAN += tiles.s

fonts.s: ./fontsheet.sh fonts.png ./tile2s Makefile
	./fontsheet.sh fonts.png > $@

CLEAN += fonts.s

####

LEVELS = 01 02 03 04 05 06 \
	07 08 09 10 11 12 \
	13 14 15 16 17 18 \
	19 20 21 22 23 24 25 25d

LEVELS_S = $(LEVELS:%=level%.s)
LEVELS_BIN = $(LEVELS:%=level%.bin)
LEVELS_BIN_DZ = $(LEVELS:%=level%.bin.dz)

CLEAN += $(LEVELS_S) $(LEVELS_BIN) $(LEVELS_BIN_DZ) $(LEVELS:%=level%.lis)

level%.bin: level%.s objects.s
	$(ASM6809) -B -l $(<:.s=.lis) -o $@ $<

####

$(LEVELS_S): objects.s

TEXT_INCLUDES = \
	version.bin \
	thanks.bin \
	video-select.bin \
	select-screen.bin \
	death-screen.bin \
	end-screen.bin

CLEAN += $(TEXT_INCLUDES)

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

notefreq.s: ./gen_notefreq.pl Makefile
	./gen_notefreq.pl -c 59 > $@

CLEAN += notefreq.s

dunjunz.bin: dunjunz.s notefreq.s tiles.s fonts.s $(TEXT_INCLUDES) ntsc-check.bin.dz play-screen.bin.dz play-screen-ntsc.bin.dz $(LEVELS_BIN_DZ)
	$(ASM6809) -C -e start -l $(<:.s=.lis) -o $@ $<
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
		-C dunjunz.bin

dunjunz-nl.cas dunjunz-nl.wav: dunjunz.bin
	$(BIN2CAS) $(B2CFLAGS) --autorun -o $@ -n DUNJUNZ --eof-data --dzip --fast \
		-C dunjunz.bin

dunjunz.dsk: dunjunz.bin
	rm -f $@
	decb dskini $@
	decb copy -2b dunjunz.bin $@,DUNJUNZ.BIN

CLEAN += dunjunz.cas dunjunz.wav dunjunz-nl.cas dunjunz-nl.wav dunjunz.dsk

####

dunjunz.body.html: dunjunz.md
	pandoc -t html5 -o $@ $<

dunjunz.shtml: dunjunz.head.html dunjunz.body.html dunjunz.foot.html
	sed "s/%UPDATED%/`date '+%e %b %Y'`/" < dunjunz.head.html > $@
	cat dunjunz.body.html dunjunz.foot.html >> $@

CLEAN += dunjunz.body.html dunjunz.shtml

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
