#include <ctype.h>
#include <getopt.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <SDL.h>
#include <SDL_image.h>

#ifdef main
# undef main
#endif

static int getpixel(SDL_Surface *surface, int x, int y);
static int cyc_indexed(int base, int offset);

static void helptext(void) {
	puts(
"Usage: tile2s [OPTION]... IMAGE-FILE\n"
"Compile tile image to 6809 code for Dragon graphics mode.\n"
"\n"
"  -W WIDTH     framebuffer width (offset per line) [32]\n"
"  -x PIXELS    offset to left edge [0]\n"
"  -y PIXELS    offset to top edge [0]\n"
"  -w PIXELS    width [from image]\n"
"  -h PIXELS    height [from image]\n"
"  -X           flip horizontally\n"
"  -Y           flip vertically\n"
"  -s SHIFT     initial right shift in pixels (0-7) [0]\n"
"  -i OFFSET    initial indexed offset [0]\n"
"  -p           preserve original value of index register\n"
"  -a           advance index register to next tile horizontally\n"
"  -b           bitmap only\n"
"  -r           resolution graphics (black & white)\n"
"  -o FILE      output filename [standard out]\n"
"\n"
"  -?, --help   show this help\n"
	);
}

static struct option long_options[] = {
	{ "help", no_argument, NULL, '?' },
	{ NULL, 0, NULL, 0 }
};

static int fb_w = 32;
static int h = 0;   // height of sprite
static char ireg = 'x';   // usually 'x', best assume that for now due to abx use
static int ioff;    // current index pointer offset
static int nbytes;  // total number of bytes
static int wbytes;  // bytes per line
static uint8_t *mask;
static uint8_t *data;
static int reg_a, reg_b;  // -1 means undefined
static int cycles;  // cycle counting
static int cyc;     // temporary for cycle counting

static int boff;  // next byte offset

// In some circumstances, we might prefer either to LDD #$0000 (faster) or
// CLRA,CLRB (smaller).  Right now this is all going to be pretty fast but I'd
// prefer to shave a few bytes if possible!
static _Bool prefer_speed = 0;

// in *_idx(), 'i' argument is index from zero into bitmap

static int ld8_imm(int d, int r, char a) {
	if (r == d)
		return d;
	if (d == 0) {
		cycles += (cyc = 2);
		printf("\tclr%c\t; %d\n", a, cyc);
		return 0;
	}
	if (r >= 0 && d == (r + 1) & 0xff) {
		cycles += (cyc = 2);
		printf("\tinc%c\t; %d\n", a, cyc);
		return d;
	}
	if (r >= 0 && d == (r + 0xff) & 0xff) {
		cycles += (cyc = 2);
		printf("\tdec%c\t; %d\n", a, cyc);
		return d;
	}
	if (r >= 0 && d == (r ^ 0xff)) {
		cycles += (cyc = 2);
		printf("\tcom%c\t; %d\n", a, cyc);
		return d;
	}
	if (r >= 0 && d == ((r ^ 0xff) + 1) & 0xff) {
		cycles += (cyc = 2);
		printf("\tneg%c\t; %d\n", a, cyc);
		return d;
	}
	if (r >= 0 && d == (r >> 1)) {
		cycles += (cyc = 2);
		printf("\tlsr%c\t; %d\n", a, cyc);
		return d;
	}
	if (r >= 0 && d == (r << 1) & 0xff) {
		cycles += (cyc = 2);
		printf("\tlsl%c\t; %d\n", a, cyc);
		return d;
	}
	cycles += (cyc = 2);
	printf("\tld%c\t#$%02x\t; %d\n", a, d, cyc);
	return d;
}

static void lda_imm(int d) {
	reg_a = ld8_imm(d, reg_a, 'a');
}

static void ldb_imm(int d) {
	reg_b = ld8_imm(d, reg_b, 'b');
}

static void ldd_imm(int d0, int d1) {
	if (reg_a == d0 && reg_b == d1)
		return;
	if (reg_a == d0) {
		ldb_imm(d1);
		return;
	}
	if (reg_b == d1) {
		lda_imm(d0);
		return;
	}
	// if either half is zero, it's fewer bytes to use CLR[AB]
	if (!prefer_speed && (d0 == 0 || d1 == 0)) {
		lda_imm(d0);
		ldb_imm(d1);
		return;
	}
	cycles += (cyc = 3);
	printf("\tldd\t#$%02x%02x\t; %d\n", d0, d1, cyc);
	reg_a = d0;
	reg_b = d1;
}

static void anda_imm(int m) {
	if (m == 0)
		return;
	cycles += (cyc = 2);
	printf("\tanda\t#$%02x\t; %d\n", m, cyc);
	if (reg_a >= 0)
		reg_a &= m;
}

static void andb_imm(int m) {
	if (m == 0)
		return;
	cycles += (cyc = 2);
	printf("\tandb\t#$%02x\t; %d\n", m, cyc);
	if (reg_b >= 0)
		reg_b &= m;
}

static void andd_imm(int m0, int m1) {
	anda_imm(m0);
	andb_imm(m1);
}

static void ora_imm(int d) {
	if (d == 0)
		return;
	if (reg_a >= 0 && (reg_a | d) == d)
		return;
	cycles += (cyc = 2);
	printf("\tora\t#$%02x\t; %d\n", d, cyc);
	if (reg_a >= 0)
		reg_a |= d;
}

static void orb_imm(int d) {
	if (d == 0)
		return;
	if (reg_b >= 0 && (reg_b | d) == d)
		return;
	cycles += (cyc = 2);
	printf("\torb\t#$%02x\t; %d\n", d, cyc);
	if (reg_b >= 0)
		reg_b |= d;
}

static void ord_imm(int d0, int d1) {
	if (reg_b >= 0 && (reg_b | d1) == d1) {
		ora_imm(d0);
	} else if (reg_a >= 0 && (reg_a | d0) == d0) {
		orb_imm(d1);
	} else {
		cycles += (cyc = 4);
		printf("\taddd\t#$%02x%02x\t; %d\n", d0, d1, cyc);
	}
}

// ld{a,b}_idx delegate to immediate fetches where possible, but do *not*
// perform the masking/setting, as the setting part may be optimisable to a
// 16-bit op.

static void lda_idx(int m, int d, int i) {
	if (m == 0) {
		lda_imm(d);
		return;
	}
	cycles += (cyc = cyc_indexed(4, i-ioff));
	printf("\tlda\t%d,%c\t; %d\n", i-ioff, ireg, cyc);
	reg_a = -1;
}

static void ldb_idx(int m, int d, int i) {
	if (m == 0) {
		ldb_imm(d);
		return;
	}
	cycles += (cyc = cyc_indexed(4, i-ioff));
	printf("\tldb\t%d,%c\t; %d\n", i-ioff, ireg, cyc);
	reg_b = -1;
}

// ldd_idx *does* perform masking/setting

static void ldd_idx(int m0, int d0, int i0, int m1, int d1, int i1) {
	_Bool is_contiguous = (i1 == i0+1);
	if (!is_contiguous) {
		lda_idx(m0, d0, i0);
		ldb_idx(m1, d1, i1);
	} else {
		if (m0 == 0 && m1 == 0) {
			ldd_imm(d0, d1);
		} else if (m0 == 0 || m1 == 0) {
			lda_idx(m0, d0, i0);
			ldb_idx(m1, d1, i1);
		} else {
			cycles += (cyc = cyc_indexed(5, i0-ioff));
			printf("\tldd\t%d,%c\t; %d\n", i0-ioff, ireg, cyc);
			reg_a = reg_b = -1;
		}
	}
	andd_imm(m0, m1);
	ord_imm(d0, d1);
}

static void sta_idx(int i) {
	cycles += (cyc = cyc_indexed(4, i-ioff));
	printf("\tsta\t%d,%c\t; %d\n", i-ioff, ireg, cyc);
}

static void stb_idx(int i) {
	cycles += (cyc = cyc_indexed(4, i-ioff));
	printf("\tstb\t%d,%c\t; %d\n", i-ioff, ireg, cyc);
}

static void std_idx(int i0, int i1) {
	_Bool is_contiguous = (i1 == i0+1);
	if (!is_contiguous) {
		sta_idx(i0);
		stb_idx(i1);
		return;
	}
	cycles += (cyc = cyc_indexed(5, i0-ioff));
	printf("\tstd\t%d,%c\t; %d\n", i0-ioff, ireg, cyc);
}

static int peek_next_byte(uint8_t *m, uint8_t *d, int *i, int *b) {
	while (boff < nbytes && mask[boff] == 0xff)
		boff++;
	if (boff >= nbytes)
		return 0;
	if (m)
		*m = mask[boff];
	if (d)
		*d = data[boff];
	if (i)
		*i = (boff/wbytes)*fb_w+(boff%wbytes);
	if (b)
		*b = boff;
	return 1;
}

static int next_byte(uint8_t *m, uint8_t *d, int *i, int *b) {
	if (!peek_next_byte(m, d, i, NULL))
		return 0;
	if (b)
		*b = boff;
	boff++;
	return 1;
}

/*
static int find_duplicate(int v, int *i, int *b) {
	if (v < 0)
		return 0;
	for (int btmp = boff; btmp < nbytes; btmp++) {
		if (mask[btmp] == 0 && data[btmp] == v) {
			if (i)
				*i = (btmp/wbytes)*fb_w+(btmp%wbytes);
			if (b)
				*b = btmp;
			return 1;
		}
	}
	return 0;
}
*/

static int is_optimisable(int m0, int d0, int i0, int m1, int d1, int i1) {
	// std possible if contiguous
	// ldd_idx possible if we need to mask both of them and they're contiguous
	// but that's already covered by above
	if (i1 == i0+1)
		return 1;
	// if i1 pushes indexing beyond 8-bit, drop it
	if (i1 > (ioff+127))
		return 0;
	// ldd_imm possible if mask neither, and either data non-zero
	// also, if prefer_speed, we'd ldd #$0000 rather than clra, clrb
	if (m0 == 0 && m1 == 0 && (prefer_speed || d0 != 0 || d1 != 0))
		return 1;
	// addd possible if both masked and both data are non-zero
	if (m0 != 0 && m1 != 0 && d0 != 0 && d1 != 0)
		return 1;
	return 0;
}

static void compile_sprite(void) {
	uint8_t m0, d0, m1, d1;
	int i0, b0, i1, b1;
	while (next_byte(&m0, &d0, &i0, &b0)) {
		if (i0 > (ioff+127)) {
			if (reg_b >= 32) {
				// XXX assuming index reg used is X
				cycles += (cyc = 3);
				printf("\tabx\t\t; %d\n", cyc);
				ioff += reg_b;
			} else {
				int add = (i0+128) - ioff;
				int last_linebase = (h-1) * fb_w;
				if (add > 127 && i0 >= ioff) {
					add = 127;
				}
				if ((ioff + add) > last_linebase) {
					add = last_linebase - ioff;
				}
				cycles += (cyc = cyc_indexed(4, add));
				printf("\tlea%c\t%d,%c\t; %d\n", ireg, add, ireg, cyc);
				ioff += add;
			}
		}
		if (peek_next_byte(&m1, &d1, &i1, &b1) && is_optimisable(m0,d0,i0,m1,d1,i1)) {
			// 16 bit handling
			// mark peeked byte as done
			mask[b1] = 0xff;
			ldd_idx(m0, d0, i0, m1, d1, i1);
			std_idx(i0, i1);
		} else {
			// 8 bit handling
			if (m0 == 0) {
				// no masking
				if (reg_a == d0) {
					sta_idx(i0);
				} else if (reg_b == d0) {
					stb_idx(i0);
				} else {
					lda_imm(d0);
					sta_idx(i0);
				}
			} else {
				// mask data
				lda_idx(m0, d0, i0);
				anda_imm(m0);
				ora_imm(d0);
				sta_idx(i0);
			}
		}

		/*
		// try and find other uses for current regs
		// XXX TODO loop once debugged
		// XXX actually trying to be clever here seems to
		// make things larger...
		int have_a, have_b;
		do {
			have_a = find_duplicate(reg_a, &i0, &b0);
			have_b = find_duplicate(reg_b, &i1, &b1);
			if (i0 == i1)
				have_b = 0;
			if (i0 > (ioff+127))
				have_a = 0;
			if (i1 > (ioff+127))
				have_b = 0;
			if (have_a) {
				mask[b0] = 0xff;
				if (have_b) {
					mask[b1] = 0xff;
					std_idx(i0, i1);
				} else {
					sta_idx(i0);
				}
			} else if (have_b) {
				mask[b1] = 0xff;
				stb_idx(i1);
			}
		} while (have_a || have_b);
		*/

	}
}

int main(int argc, char **argv) {
	int shift = 0;
	ioff = 0;
	boff = 0;
	fb_w = 32;
	int xoff = 0, yoff = 0;
	int origin = 0;
	int w = 0;
	h = 0;
	_Bool preserve = 0;
	_Bool advance = 0;
	_Bool bitmap_only = 0;
	_Bool resolution = 0;
	_Bool flip_horizontal = 0;
	_Bool flip_vertical = 0;

	int c;
	while ((c = getopt_long(argc, argv, "W:x:y:w:h:XYs:i:pabro:?",
				long_options, NULL)) != -1) {
		switch (c) {
		case 0:
			break;
		case 'W':
			fb_w = strtol(optarg, NULL, 0);
			break;
		case 'x':
			xoff = strtol(optarg, NULL, 0);
			break;
		case 'y':
			yoff = strtol(optarg, NULL, 0);
			break;
		case 'w':
			w = strtol(optarg, NULL, 0);
			break;
		case 'h':
			h = strtol(optarg, NULL, 0);
			break;
		case 'X':
			flip_horizontal = 1;
			break;
		case 'Y':
			flip_vertical = 1;
			break;
		case 's':
			shift = strtol(optarg, NULL, 0);
			if (shift < 0 || shift > 7) {
				fprintf(stderr, "shift out of range\n");
				exit(EXIT_FAILURE);
			}
			break;
		case 'i':
			ioff = strtol(optarg, NULL, 0);
			break;
		case 'p':
			preserve = 1;
			break;
		case 'a':
			advance = 1;
			break;
		case 'b':
			bitmap_only = 1;
			break;
		case 'r':
			resolution = 1;
			break;
		case 'o':
			if (freopen(optarg, "wb", stdout) == NULL) {
				fprintf(stderr, "Couldn't open '%s' for writing: ", optarg);
				perror(NULL);
				exit(EXIT_FAILURE);
			}
			break;
		case '?':
			helptext();
			exit(EXIT_SUCCESS);
		default:
			exit(EXIT_FAILURE);
		}
	}

	if (optind >= argc) {
		fputs("no input files\n", stderr);
		exit(EXIT_FAILURE);
	}

	SDL_Surface *in = IMG_Load(argv[optind]);
	if (!in) {
		fprintf(stderr, "Couldn't read image %s: %s\n", argv[optind], IMG_GetError());
		return 1;
	}

	if (!w)
		w = in->w;
	if (!h)
		h = in->h;
	wbytes = (w + shift + 7) >> 3;
	nbytes = wbytes * h;

	origin = ioff;
	if (advance) {
		preserve = 1;
		origin += wbytes;
		if (((w + shift) & 7) != 0)
			origin--;
	}

	mask = malloc(nbytes);
	data = malloc(nbytes);

	uint8_t *maskp = mask;
	uint8_t *datap = data;

	for (int y = 0; y < h; y++) {
		uint8_t m = 0xff;
		uint8_t d = 0;
		int n = shift;
		for (int x = 0; x < w; x++) {
			m <<= 1;
			d <<= 1;
			int getx = flip_horizontal ? (xoff + w - x - 1) : (xoff + x);
			int gety = flip_vertical ? (yoff + h - y - 1) : (yoff + y);
			int c = getpixel(in, getx, gety);
			if (resolution && c == 5) {
				c = 3;
			} else if (c == 7) {
				c = ((y*2+x)&2) ? 2 : 3;
			} else if (c <= 0) {
				c = 0;
			} else {
				c = c - 1;
			}
			if (!(n & 1)) {
				d |= (c >> 1) & 1;
			} else {
				d |= (c & 1);
			}
			n++;
			if (n == 8) {
				n = 0;
				*(maskp++) = m;
				*(datap++) = d;
			}
		}
		if (n) {
			while (n < 8) {
				d <<= 1;
				m = (m << 1) | 1;
				n++;
			}
			*(maskp++) = m;
			*(datap++) = d;
		}
	}

	SDL_FreeSurface(in);
	maskp = mask;
	datap = data;

	if (bitmap_only) {
		for (int y = 0; y < h; y++) {
			printf("\tfcb ");
			for (int x = 0; x < wbytes; x++) {
				printf("$%02x", *(datap++));
				if (x < (wbytes-1)) {
					printf(",");
				}
			}
			printf("\n");
		}
		return EXIT_SUCCESS;
	}

	reg_a = -1;
	reg_b = -1;

	cycles = 0;

	compile_sprite();

	if (preserve) {
		int add = origin - ioff;
		cycles += (cyc = cyc_indexed(4, add));
		printf("\tlea%c\t%d,%c\t; %d\n", ireg, add, ireg, cyc);
	}

	printf("\t; total = %d\n", cycles);

	return EXIT_SUCCESS;
}

/* black, blue, green, cyan, red, magenta, yellow, white, orange */
static int colour_map[9] = {
	0, 3, 1, 6, 4, 7, 2, 5, 8
};

static int getpixel(SDL_Surface *surface, int x, int y) {
	if (x < 0 || y < 0 || x >= surface->w || y >= surface->h)
		return -1;
	int bpp = surface->format->BytesPerPixel;
	Uint8 *p = (Uint8 *)surface->pixels + y * surface->pitch + x * bpp;
	Uint32 dp;
	switch(bpp) {
	case 1: dp = *p; break;
	case 2: dp = *(Uint16 *)p; break;
	case 3:
		if (SDL_BYTEORDER == SDL_BIG_ENDIAN)
			dp = p[0] << 16 | p[1] << 8 | p[2];
		else
			dp = p[0] | p[1] << 8 | p[2] << 16;
		break;
	case 4: dp = *(Uint32 *)p; break;
	default: dp = 0; break;
	}
	Uint8 dr, dg, db;
	SDL_GetRGB(dp, surface->format, &dr, &dg, &db);
	int colour = (dr >= 128) ? 4 : 0;
	colour |= (dg >= 128) ? 2 : 0;
	colour |= (db >= 128) ? 1 : 0;
	/* special case for orange: */
	if (colour == 6 && dg < 224) colour = 8;
	/* index into colour_map: */
	return colour_map[colour];
}

static int cyc_indexed(int base, int offset) {
	int add;
	if (offset == 0) {
		add = 0;
	} else if (offset >= -16 && offset < 16) {
		add = 1;
	} else if (offset >= -128 && offset < 128) {
		add = 1;
	} else if (offset >= -32768 && offset < 32768) {
		add = 4;
	}
	return base + add;
}
