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
"  -s SHIFT     initial right shift in pixels (0-7) [0]\n"
"  -n           don't bother updating register to known value\n"
"  -N           don't return register to next tile address\n"
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

int main(int argc, char **argv) {
	int shift = 0;
	int fb_w = 32;
	char *idx = "x";
	int xoff = 0, yoff = 0;
	int w = 0, h = 0;
	_Bool no_advance = 0;
	_Bool no_origin = 0;
	_Bool bitmap_only = 0;
	_Bool resolution = 0;

	int c;
	while ((c = getopt_long(argc, argv, "W:x:y:w:h:s:nNbro:?",
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
		case 's':
			shift = strtol(optarg, NULL, 0);
			if (shift < 0 || shift > 7) {
				fprintf(stderr, "shift out of range\n");
				exit(EXIT_FAILURE);
			}
			break;
		case 'n':
			no_advance = 1;
			break;
		case 'N':
			no_origin = 1;
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
	int wbytes = (w + shift + 7) >> 3;

	uint8_t *mask = malloc(wbytes * h);
	uint8_t *data = malloc(wbytes * h);

	uint8_t *maskp = mask;
	uint8_t *datap = data;

	for (int y = 0; y < h; y++) {
		uint8_t m = 0xff;
		uint8_t d = 0;
		int n = shift;
		for (int x = 0; x < w; x++) {
			m <<= 1;
			d <<= 1;
			int c = getpixel(in, x + xoff, y + yoff);
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

	int reg_a = -1;
	int reg_b = -1;
	int idx_off = 0;
	int total_idx_off = 0;

	int cycles = 0;
	int cyc;

	for (int y = 0; y < h; y++) {
		for (int x = 0; x < wbytes; x++) {
			uint8_t m0 = *(maskp++);
			uint8_t d0 = *(datap++);
			if (x < (wbytes-1)) {
				/* 16 bits at a time */
				uint8_t m1 = *(maskp++);
				uint8_t d1 = *(datap++);
				if (m0 == 0 && m1 == 0) {
					if (reg_a != d0 && reg_b != d1) {
						cycles += (cyc = 3);
						printf("\tldd\t#$%02x%02x\t; %d\n", d0, d1, cyc);
					} else if (reg_a != d0) {
						cycles += (cyc = 2);
						printf("\tlda\t#$%02x\t; %d\n", d0, cyc);
					} else if (reg_b != d0) {
						cycles += (cyc = 2);
						printf("\tldb\t#$%02x\t; %d\n", d1, cyc);
					}
					reg_a = d0;
					reg_b = d1;
				} else if (m0 == 0) {
					if (reg_a != d0) {
						if (d0 == 0) {
							cycles += (cyc = 2);
							printf("\tclra\t\t; %d\n", cyc);
						} else {
							cycles += (cyc = 2);
							printf("\tlda\t#$%02x\t; %d\n", d0, cyc);
						}
					}
					cycles += (cyc = cyc_indexed(4, idx_off+x+1));
					printf("\tldb\t%d,%s\t; %d\n", idx_off+x+1, idx, cyc);
					reg_a = d0;
					reg_b = -1;
				} else if (m1 == 0) {
					cycles += (cyc = cyc_indexed(4, idx_off+x));
					printf("\tlda\t%d,%s\t; %d\n", idx_off+x, idx, cyc);
					if (reg_b != d1) {
						if (d1 == 0) {
							cycles += (cyc = 2);
							printf("\tclrb\t\t; %d\n", cyc);
						} else {
							cycles += (cyc = 2);
							printf("\tldb\t#$%02x\t; %d\n", d1, cyc);
						}
					}
					reg_a = -1;
					reg_b = d1;
				}
				if (m0 != 0 && m1 != 0) {
					printf("\tanda\t#$%02x\t; %d\n", m0, cyc);
					printf("\tandb\t#$%02x\t; %d\n", m1, cyc);
					if (d0 != 0 && d1 != 0) {
						cycles += (cyc = 4);
						printf("\taddd\t#$%02x%02x\t; %d\n", d0, d1, cyc);
					} else if (d0 != 0) {
						cycles += (cyc = 2);
						printf("\tora\t#$%02x\t; %d\n", d0, cyc);
					} else if (d1 != 0) {
						cycles += (cyc = 2);
						printf("\torb\t#$%02x\t; %d\n", d1, cyc);
					}
					reg_a = reg_b = -1;
				} else if (m0 != 0) {
					cycles += (cyc = 2);
					printf("\tanda\t#$%02x\t; %d\n", m0, cyc);
					if (d0 != 0) {
						cycles += (cyc = 2);
						printf("\tora\t#$%02x\t; %d\n", d0, cyc);
					}
					reg_a = -1;
				} else if (m1 != 0) {
					cycles += (cyc = 2);
					printf("\tandb\t#$%02x\t; %d\n", m1, cyc);
					if (d1 != 0) {
						cycles += (cyc = 2);
						printf("\torb\t#$%02x\t; %d\n", d1, cyc);
					}
					reg_b = -1;
				}
				cycles += (cyc = cyc_indexed(5, idx_off+x));
				printf("\tstd\t%d,%s\t; %d\n", idx_off+x, idx, cyc);
				x++;
			} else {
				/* 8 bits at a time */
				if (m0 == 0) {
					if (reg_a != d0) {
						if (d0 == 0) {
							cycles += (cyc = 2);
							printf("\tclra\t\t; %d\n", cyc);
						} else {
							cycles += (cyc = 2);
							printf("\tlda\t#$%02x\t; %d\n", d0, cyc);
						}
					}
					reg_a = d0;
				} else {
					cycles += (cyc = cyc_indexed(4, idx_off+x));
					printf("\tlda\t%d,%s\t; %d\n", idx_off+x, idx, cyc);
					cycles += (cyc = 2);
					printf("\tanda\t#$%02x\t; %d\n", m0, cyc);
					if (d0 != 0) {
						cycles += (cyc = 2);
						printf("\tora\t#$%02x\t; %d\n", d0, cyc);
					}
					reg_a = -1;
				}
				cycles += (cyc = cyc_indexed(4, idx_off+x));
				printf("\tsta\t%d,%s\t; %d\n", idx_off+x, idx, cyc);
			}
		}
		if (y < (h-1)) {
			if ((idx_off + fb_w * 2) > 127) {
				int add = idx_off + fb_w * 4;
				idx_off = -fb_w * 3;
				total_idx_off += add;
				cycles += (cyc = cyc_indexed(4, add));
				printf("\tlea%s\t%d,%s\t; %d\n", idx, add, idx, cyc);
			} else {
				idx_off += fb_w;
			}
		} else {
			if (no_origin) {
				int add = idx_off + fb_w * 4;
				idx_off = -fb_w * 3;
				total_idx_off += add;
				cycles += (cyc = cyc_indexed(4, add));
				printf("\tlea%s\t%d,%s\t; %d\n", idx, add, idx, cyc);
			} else if (!no_advance) {
				int sub = wbytes;
				if (((shift + w) % 8) != 0)
					sub--;
				total_idx_off -= sub;
				cycles += (cyc = cyc_indexed(4, -total_idx_off));
				printf("\tlea%s\t%d,%s\t; %d\n", idx, -total_idx_off, idx, cyc);
			}
		}
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
