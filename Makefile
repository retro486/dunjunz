# Dunjunz

.PHONY: all
all: dunjunz.cas dunjunz.wav dunjunz.dsk

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

scroll.bin: scroll.txt Makefile
	perl -pe 'chomp if eof' $< | tr '123456()\!A-Z.,\- _' '\001-\050' > $@

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

# XXX won't really work now - tackle 64K
dunjunz-coco.bin: dunjunz-wrap.s dunjunz.bin.dz
	$(ASM6809) -C -e wrap_exec -l dunjunz-coco.lis -o $@ $<
CLEAN += dunjunz-coco.bin

# XXX won't really work now - tackle 64K
dunjunz-dragon.bin: dunjunz-wrap.s dunjunz.bin.dz
	$(ASM6809) -D -e wrap_exec -l dunjunz-dragon.lis -o $@ $<
CLEAN += dunjunz-dragon.bin

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

TAPE_PARTS = tape-part1 \
	tape-part2 \
	tape-part4 \
	tape-part5

TAPE_PARTS_CAS = $(TAPE_PARTS:%=%.cas)
TAPE_PARTS_WAV = $(TAPE_PARTS:%=%.wav)

CLEAN += $(TAPE_PARTS_CAS) $(TAPE_PARTS_WAV)

tape-part1.bin: tape-part1.s dunjunz.bin.dz tape-part2.bin
	$(ASM6809) -C -e start -l tape-part1.lis -o $@ $<

CLEAN += tape-part1.bin tape-part1.lis

tape-part1.cas tape-part1.wav: tape-part1.bin
	$(BIN2CAS) $(B2CFLAGS) --autorun -o $@ -n DUNJUNZ \
		--eof-data --dzip --fast \
		-C $<

tape-part2.bin: tape-part2.s title.bin.dz copyright.bin.dz copyright64.bin.dz
	$(ASM6809) -B -l tape-part2.lis -s tape-part2.sym -o $@ $<

tape-part2.cas tape-part2.wav: tape-part2.bin
	$(BIN2CAS) $(B2CFLAGS) -o $@ \
		--fast --eof-data --no-filename \
		-B $<

#tape-part3.cas tape-part3.wav: copyright.bin.dz
#	$(BIN2CAS) $(B2CFLAGS) -o $@ \
#		--fast --eof-data --no-filename \
#		-B $<

tape-part4.cas tape-part4.wav: dunjunz.bin.dz
	$(BIN2CAS) $(B2CFLAGS) -o $@ \
		--fast --eof-data --no-filename \
		-B $<

tape-part5.cas tape-part5.wav: dunj64.bin.dz
	$(BIN2CAS) $(B2CFLAGS) -o $@ \
		--fast --eof-data --no-filename --pause \
		-B $<

dunjunz.cas: $(TAPE_PARTS_CAS)
	cat $(TAPE_PARTS_CAS) > $@

dunjunz.wav: $(TAPE_PARTS_WAV)
	sox $(TAPE_PARTS_WAV) $@

CLEAN += dunjunz.cas dunjunz.wav

DISK_PARTS = disk-boot.bin \
	disk-part1-dragon.bas \
	disk-part2-dragon.bin \
	disk-part3-dragon.bin \
	disk-part1-coco.bas \
	disk-part2-coco.bin \
	disk-part3-coco.bin

disk-boot.bin: disk-boot.s
	$(ASM6809) -B -l disk-boot.lis -o $@ $<

disk-part2-dragon.bin: disk-part2.s title.bin.dz copyright.bin.dz copyright64.bin.dz dunj64.bin.dz
	$(ASM6809) -D -e DUNJ2_exec -l disk-part2-dragon.lis -o $@ $<

CLEAN += disk-part2-dragon.bin disk-part2-dragon.lis

disk-part3-dragon.bin: disk-part3.s dunjunz.bin.dz
	$(ASM6809) -D -e DUNJ3_exec -l disk-part3-dragon.lis -o $@ $<

CLEAN += disk-part3-dragon.bin disk-part3-dragon.lis

disk-part2-coco.bin: disk-part2.s title.bin.dz copyright.bin.dz copyright64.bin.dz dunj64.bin.dz
	$(ASM6809) -C -e DUNJ2_exec -l disk-part2-coco.lis -o $@ $<

CLEAN += disk-part2-coco.bin disk-part2-coco.lis

disk-part3-coco.bin: disk-part3.s dunjunz.bin.dz
	$(ASM6809) -C -e DUNJ3_exec -l disk-part3-coco.lis -o $@ $<

CLEAN += disk-part3-coco.bin disk-part3-coco.lis

#dunjunz.vdk: disk-part1-dragon.bin disk-part3-dragon.bin

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
	git archive --format=tar --output=../dunjunz.tar --prefix=dunjunz/ HEAD
	#tar -r -f ../dunjunz.tar --owner=root --group=root --mtime=../dunjunz.tar --transform 's,^,dunjunz/,' $(EXTRA_DIST)
	gzip -f9 ../dunjunz.tar

####

.PHONY: clean
clean:
	rm -f $(CLEAN)
