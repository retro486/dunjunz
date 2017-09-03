# Dunjunz - remade for the Dragon 32/64
# Copyright (c) 2017 Ciaran Anscomb
#
# See COPYING file for redistribution conditions.

.PHONY: all
all: dunjunz.cas dunjunz.wav dunjunz.dsk

PACKAGE = dunjunz
VERSION = 1.0
distdir = $(PACKAGE)-$(VERSION)

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

%.bin: %.txt
	perl -pe 'chomp if eof' $< | sed 's/            /\o213/g;s/        /\o207/g;s/       /\o206/g;s/      /\o205/g;s/     /\o204/g;s/    /\o203/g;s/   /\o202/g;s/  /\o201/g' | tr '123456()\!A-Z.,\- \012\014' '\001-\047\377\377' > $@
	/bin/echo -ne '\00' >> $@

%.s: %.map ./map2s.pl
	echo "	include \"objects.s\"" > $@
	echo >> $@
	./map2s.pl $< >> $@

####

tiles.s: ./tilesheet.sh tiles.png ./tile2s
	./tilesheet.sh tiles.png > $@

CLEAN += tiles.s

fonts.s: ./fontsheet.sh fonts.png ./tile2s
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
	scroll.bin \
	video-select.bin \
	select-screen.bin \
	death-screen.bin \
	end-screen.bin

CLEAN += $(TEXT_INCLUDES)

scroll.bin: scroll.txt
	perl -pe 'chomp if eof' $< | tr '123456()\!A-Z.,\- _<>*' '\001-\050\376\377\000' > $@

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

notefreq.s: ./gen_notefreq.pl
	./gen_notefreq.pl -c 58 > $@

CLEAN += notefreq.s

dunj64.bin: dunj64.s song.s press-key.bin.dz
	$(ASM6809) -B -l dunj64.lis -s dunj64.sym -o $@ $<
CLEAN += dunj64.lis dunj64.sym dunj64.bin dunj64.bin.dz

dunjunz.bin: dunjunz.s dunj64.bin notefreq.s tiles.s fonts.s $(TEXT_INCLUDES) ntsc-check.bin.dz play-screen.bin.dz play-screen-ntsc.bin.dz $(LEVELS_BIN_DZ)
	$(ASM6809) -B -l dunjunz.lis -s dunjunz.sym -o $@ $<
CLEAN += dunjunz.lis dunjunz.sym dunjunz.bin dunjunz.bin.dz

title.s: title.png ./tile2s
	./tile2s -b -o $@ $<

title.bin: title.s
	$(ASM6809) -B -o $@ $<

CLEAN += title.s title.bin title.bin.dz

copyright.s: copyright.png ./tile2s
	./tile2s -b -o $@ $<

copyright.bin: copyright.s
	$(ASM6809) -B -o $@ $<

CLEAN += copyright.s copyright.bin copyright.bin.dz

copyright64.s: copyright64.png ./tile2s
	./tile2s -b -o $@ $<

copyright64.bin: copyright64.s
	$(ASM6809) -B -o $@ $<

CLEAN += copyright64.s copyright64.bin copyright64.bin.dz

press-key.s: press-key.png ./tile2s
	./tile2s -b -o $@ $<

press-key.bin: press-key.s
	$(ASM6809) -B -o $@ $<

CLEAN += press-key.s press-key.bin press-key.bin.dz

####

# Tape image

TAPE_PARTS = tape-stage2 \
	tape-part1 \
	tape-part2 \
	tape-part3

TAPE_PARTS_CAS = $(TAPE_PARTS:%=%.cas)
TAPE_PARTS_WAV = $(TAPE_PARTS:%=%.wav)

# Second stage loader for tape (bin2cas.pl generates the first stage).  dzip
# doesn't save much for this (3 bytes at time of writing!), but it's required
# so that dunzip code used later on is included in the first stage by
# bin2cas.pl.

tape-stage2.bin: tape-stage2.s dunjunz.bin.dz tape-part1.bin
	$(ASM6809) -C -e start -l tape-stage2.lis -o $@ $<

CLEAN += tape-stage2.bin tape-stage2.lis

# Part 1 contains the loading screen (separately, so it can be reused as the
# title page on 64K machines) and copyright messages to be overlaid onto it.

tape-part1.bin: tape-part1.s title.bin.dz copyright.bin.dz copyright64.bin.dz
	$(ASM6809) -B -l tape-part1.lis -s tape-part1.sym -o $@ $<

CLEAN += tape-part1.bin tape-part1.lis tape-part1.sym

# Part 2 is the main game.

# Part 3 is only loaded on 64K machines, and contains the code to display the
# title graphics (contained in part 1), music data, and playback routine.

# Rules to create the tape images.

dunjunz.cas dunjunz.wav: tape-stage2.bin tape-part1.bin dunjunz.bin.dz dunj64.bin.dz
	$(BIN2CAS) $(B2CFLAGS) --autorun --eof-data --fast -o $@ -n DUNJUNZ \
		-C --dzip tape-stage2.bin \
		--omit --no-dzip \
		-B tape-part1.bin \
		-B dunjunz.bin.dz \
		-B dunj64.bin.dz

CLEAN += dunjunz.cas dunjunz.wav

####

# Disk image

DISK_PARTS = disk-boot.bin \
	disk-part1-dragon.bas \
	disk-part2-dragon.bin \
	disk-part3-dragon.bin \
	disk-part1-coco.bas \
	disk-part2-coco.bin \
	disk-part3-coco.bin

# Boot block.  Same image is used for DragonDOS and RSDOS disks.

disk-boot.bin: disk-boot.s
	$(ASM6809) -B -l disk-boot.lis -o $@ $<

# Part 1 is a BASIC loader that is simply transferred to the disk image.

# Part 2 contains the title screen, copyright messages and the extra data for
# 64K machines.  The extras will be thrown away on 32K machines, but that's ok:
# disks are fast!

disk-part2-dragon.bin: disk-part2.s title.bin.dz copyright.bin.dz copyright64.bin.dz dunj64.bin.dz
	$(ASM6809) -D -e DUNJ2_exec -l disk-part2-dragon.lis -o $@ $<

CLEAN += disk-part2-dragon.bin disk-part2-dragon.lis

disk-part2-coco.bin: disk-part2.s title.bin.dz copyright.bin.dz copyright64.bin.dz dunj64.bin.dz
	$(ASM6809) -C -e DUNJ2_exec -l disk-part2-coco.lis -o $@ $<

CLEAN += disk-part2-coco.bin disk-part2-coco.lis

# Part 3 contains the main game.

disk-part3-dragon.bin: disk-part3.s dunjunz.bin.dz
	$(ASM6809) -D -e DUNJ3_exec -l disk-part3-dragon.lis -o $@ $<

CLEAN += disk-part3-dragon.bin disk-part3-dragon.lis

disk-part3-coco.bin: disk-part3.s dunjunz.bin.dz
	$(ASM6809) -C -e DUNJ3_exec -l disk-part3-coco.lis -o $@ $<

CLEAN += disk-part3-coco.bin disk-part3-coco.lis

# Rules to create the disk image.

# Sadly, I don't have tools to manipulate DragonDOS filesystems yet, so they
# need to be copied on manually once the hybrid image is created.

dunjunz.dsk: $(DISK_PARTS)
	rm -f $@
	cp hybrid.dsk $@
	dd if=disk-boot.bin of=dunjunz.dsk bs=256 seek=2 conv=notrunc
	dd if=disk-boot.bin of=dunjunz.dsk bs=256 seek=$(shell expr 34 \* 18) conv=notrunc
	decb copy -0bt disk-part1-coco.bas dunjunz.dsk,DUNJUNZ.BAS
	decb copy -2b disk-part2-coco.bin $@,DUNJ2.BIN
	decb copy -2b disk-part3-coco.bin $@,DUNJ3.BIN
	@echo Copy Dragon files on manually for now

CLEAN += dunjunz.dsk

####

.PHONY: dist
dist: $(EXTRA_DIST)
	git archive --format=tar --output=./$(distdir).tar --prefix=$(distdir)/ HEAD
	tar -r -f ./$(distdir).tar --owner=root --group=root --mtime=./$(distdir).tar --transform "s,^,$(distdir)/," $(EXTRA_DIST)
	gzip -f9 ./$(distdir).tar

CLEAN += $(distdir).tar $(distdir).tar.gz

####

.PHONY: clean
clean:
	rm -f $(CLEAN)
