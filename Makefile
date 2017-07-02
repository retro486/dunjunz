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

%.cas:
	$(BIN2CAS) $(B2CFLAGS) -o $@ $<

%.wav:
	$(BIN2CAS) $(B2CFLAGS) --wav-out -o $@ $<

%.dz: %
	dzip -c $< > $@

####

TILES = \
	floor \
	armour cross food money \
	potion power speed weapon \
	exit tport \
	trapdoor drainer0 drainer1 \
	key door_h door_v

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

MONSTERS_UD = \
	monster_up0 monster_up1 \
	monster_down0 monster_down1
MONSTERS_LR = \
	monster_left0 monster_left1 \
	monster_right0 monster_right1

tiles.s: $(TILES:%=c_%.png) ./tile2s Makefile
	echo "tiles" > $@
	for t in $(TILES) $(EXTRA_TILES); do \
		echo "draw_$${t}_0" >> $@; \
		./tile2s -n c_$$t.png >> $@; \
		echo "	jmp	next_tile1" >> $@; \
		echo "draw_$${t}_1" >> $@; \
		./tile2s -n -s 4 c_$$t.png >> $@; \
		echo "	jmp	next_tile0" >> $@; \
	done
	for t in monster; do \
		for f in 0 1; do \
			for h in 0 1; do \
				s=""; test "$$h" = "1" && s="-s 4"; \
				n="1"; test "$$h" = "1" && n="0"; \
				echo "draw_$${t}_up$${f}_$${h}_p1" >> $@; \
				echo "	leax	96,x" >> $@; \
				echo "	bra	draw_$${t}_up$${f}_$${h}" >> $@; \
				echo "draw_$${t}_up$${f}_$${h}_p2" >> $@; \
				echo "	leax	192,x" >> $@; \
				echo "	; fall through" >> $@; \
				echo "draw_$${t}_up$${f}_$${h}" >> $@; \
				./tile2s -n $${s} c_$${t}_up$${f}.png >> $@; \
				echo "	jmp	next_tile$${n}" >> $@; \
				test "$$h" = "1" && s="-s 4" || s=""; \
				echo "draw_$${t}_down$${f}_$${h}_m1" >> $@; \
				echo "	leax	-96,x" >> $@; \
				echo "	bra	draw_$${t}_down$${f}_$${h}" >> $@; \
				echo "draw_$${t}_down$${f}_$${h}_m2" >> $@; \
				echo "	leax	-192,x" >> $@; \
				echo "	; fall through" >> $@; \
				echo "draw_$${t}_down$${f}_$${h}" >> $@; \
				./tile2s -n $${s} c_$${t}_down$${f}.png >> $@; \
				echo "	jmp	next_tile$${n}" >> $@; \
			done; \
		done; \
		for h in 0 1; do \
			s=""; test "$$h" = "1" && s="-s 4"; \
			n="1"; test "$$h" = "1" && n="0"; \
			echo "draw_$${t}_left_$${h}_p1" >> $@; \
			echo "	leax	1,x" >> $@; \
			echo "	; fall through" >> $@; \
			echo "draw_$${t}_left_$${h}" >> $@; \
			./tile2s -n $${s} c_$${t}_left$${h}.png >> $@; \
			echo "	jmp	next_tile$${n}" >> $@; \
			echo "draw_$${t}_right_$${h}_m1" >> $@; \
			echo "	leax	-1,x" >> $@; \
			echo "	; fall through" >> $@; \
			echo "draw_$${t}_right_$${h}" >> $@; \
			./tile2s -n $${s} c_$${t}_right$${h}.png >> $@; \
			echo "	jmp	next_tile$${n}" >> $@; \
		done; \
	done
	echo "tiles_0" >> $@
	for t in $(TILES) $(EXTRA_TILES) $(MONSTERS_UD); do \
		echo "	fdb	draw_$${t}_0" >> $@; \
	done
	for t in monster; do \
		echo "  fdb     draw_$${t}_up0_0" >> $@; \
		echo "  fdb     draw_$${t}_up1_0_p2" >> $@; \
		echo "  fdb     draw_$${t}_up0_0_p1" >> $@; \
		echo "  fdb     draw_$${t}_down0_0" >> $@; \
		echo "  fdb     draw_$${t}_down1_0_m2" >> $@; \
		echo "  fdb     draw_$${t}_down0_0_m1" >> $@; \
		echo "	fdb	draw_$${t}_left_0" >> $@; \
		echo "	fdb	draw_$${t}_left_1_p1" >> $@; \
		echo "	fdb	draw_$${t}_left_0_p1" >> $@; \
		echo "	fdb	draw_$${t}_right_0" >> $@; \
		echo "	fdb	draw_$${t}_right_1_m1" >> $@; \
		echo "	fdb	draw_$${t}_right_0" >> $@; \
	done
	echo "tiles_1" >> $@
	for t in $(TILES) $(EXTRA_TILES) $(MONSTERS_UD); do \
		echo "	fdb	draw_$${t}_1" >> $@; \
	done
	for t in monster; do \
		echo "  fdb     draw_$${t}_up0_1" >> $@; \
		echo "  fdb     draw_$${t}_up1_1_p2" >> $@; \
		echo "  fdb     draw_$${t}_up0_1_p1" >> $@; \
		echo "  fdb     draw_$${t}_down0_1" >> $@; \
		echo "  fdb     draw_$${t}_down1_1_m2" >> $@; \
		echo "  fdb     draw_$${t}_down0_1_m1" >> $@; \
		echo "	fdb	draw_$${t}_left_1" >> $@; \
		echo "	fdb	draw_$${t}_left_0_p1" >> $@; \
		echo "	fdb	draw_$${t}_left_1" >> $@; \
		echo "	fdb	draw_$${t}_right_1" >> $@; \
		echo "	fdb	draw_$${t}_right_0_m1" >> $@; \
		echo "	fdb	draw_$${t}_right_1_m1" >> $@; \
	done

tiledefs.s: Makefile
	echo "" > $@
	i=0; for t in $(TILES) $(EXTRA_TILES) $(MONSTERS_UD); do \
		echo "$$t	equ	$$i" >> $@; i=`expr $$i \+ 2`; \
	done; \
	echo "monster_up	equ	$$i" >> $@; i=`expr $$i \+ 6`; \
	echo "monster_down	equ	$$i" >> $@; i=`expr $$i \+ 6`; \
	echo "monster_left	equ	$$i" >> $@; i=`expr $$i \+ 6`; \
	echo "monster_right	equ	$$i" >> $@; i=`expr $$i \+ 6`
CLEAN += tiles.s tiledefs.s

####

LEVELS = 01 02 03 04 05 06 07 08 09 10 11 12 24 25

LEVELS_ALL = $(LEVELS:%=level%.s)
CLEAN += $(LEVELS_ALL)
STONE = 01

%.s: %.map ./map2s.pl ./tile2s
	echo "	include	\"tiledefs.s\"" > $@
	./map2s.pl $< >> $@

levels.s: $(LEVELS_ALL:.s=.bin.dz)
	echo "" > $@
	for t in $(LEVELS); do \
		echo "level$${t}_dz" >> $@; \
		echo "	includebin	\"level$${t}.bin.dz\"" >> $@; \
	done
	echo "levels" >> $@
	for t in $(LEVELS); do \
		echo "	fdb	level$${t}_dz" >> $@; \
	done
	echo "	fdb	levels" >> $@

####

./tile2s: CFLAGS += $(shell sdl-config --cflags)
./tile2s: LDLIBS += $(shell sdl-config --libs) -lSDL_image

levels_dz.bin: $(LEVELS_ALL:%=%.dz)

$(LEVELS_ALL): tiledefs.s

dunjunz.bin: AFLAGS = -D
dunjunz.bin: tiles.s level01.s
CLEAN += dunjunz.lis dunjunz.bin

dunjunz.cas dunjunz.wav: B2CFLAGS = -D --eof-data --dzip
dunjunz.cas dunjunz.wav: dunjunz.bin
CLEAN += dunjunz.cas dunjunz.wav

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
