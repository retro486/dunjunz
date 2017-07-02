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

static void helptext(void) {
	puts(
"Usage: tile2s [OPTION]... IMAGE-FILE\n"
"Compile tile image to 6809 code for Dragon graphics mode.\n"
"\n"
"  -b COLOUR    background colour\n"
"  -W WIDTH     framebuffer width (offset per line) [32]\n"
"  -x PIXELS    offset to left edge [0]\n"
"  -y PIXELS    offset to top edge [0]\n"
"  -w PIXELS    width [from image]\n"
"  -h PIXELS    height [from image]\n"
"  -s SHIFT     initial right shift in pixels (0-7) [0]\n"
"  -n           don't bother updating register to known value\n"
"  -N           don't return register to next tile address\n"
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
	int bg = 0;
	int shift = 0;
	int fb_w = 32;
	char *idx = "x";
	int xoff = 0, yoff = 0;
	int w = 0, h = 0;
	_Bool no_advance = 0;
	_Bool no_origin = 0;

	int c;
	while ((c = getopt_long(argc, argv, "b:W:x:y:w:h:s:nNo:?",
				long_options, NULL)) != -1) {
		switch (c) {
		case 0:
			break;
		case 'b':
			bg = strtol(optarg, NULL, 0);
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
			if (c < 0)
				c = 0;
			else
				c = c ? c-1 : 0;
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

	int reg_a = -1;
	int reg_b = -1;
	int idx_off = 0;
	int total_idx_off = 0;

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
						printf("\tldd\t#$%02x%02x\n", d0, d1);
					} else if (reg_a != d0) {
						printf("\tlda\t#$%02x\n", d0);
					} else if (reg_b != d0) {
						printf("\tldb\t#$%02x\n", d1);
					}
					reg_a = d0;
					reg_b = d1;
				} else if (m0 == 0) {
					if (reg_a != d0) {
						if (d0 == 0) {
							printf("\tclra\n");
						} else {
							printf("\tlda\t#$%02x\n", d0);
						}
					}
					printf("\tldb\t%d,%s\n", idx_off+x+1, idx);
					reg_a = d0;
					reg_b = -1;
				} else if (m1 == 0) {
					printf("\tlda\t%d,%s\n", idx_off+x, idx);
					if (reg_b != d1) {
						if (d1 == 0) {
							printf("\tclrb\n");
						} else {
							printf("\tldb\t#$%02x\n", d1);
						}
					}
					reg_a = -1;
					reg_b = d1;
				}
				if (m0 != 0 && m1 != 0) {
					printf("\tanda\t#$%02x\n", m0);
					printf("\tandb\t#$%02x\n", m1);
					if (d0 != 0 && d1 != 0) {
						printf("\taddd\t#$%02x%02x\n", d0, d1);
					} else if (d0 != 0) {
						printf("\tora\t#$%02x\n", d0);
					} else if (d1 != 0) {
						printf("\torb\t#$%02x\n", d1);
					}
					reg_a = reg_b = -1;
				} else if (m0 != 0) {
					printf("\tanda\t#$%02x\n", m0);
					if (d0 != 0) {
						printf("\tora\t#$%02x\n", d0);
					}
					reg_a = -1;
				} else if (m1 != 0) {
					printf("\tandb\t#$%02x\n", m1);
					if (d1 != 0) {
						printf("\torb\t#$%02x\n", d1);
					}
					reg_b = -1;
				}
				printf("\tstd\t%d,%s\n", idx_off+x, idx);
				x++;
			} else {
				/* 8 bits at a time */
				if (m0 == 0) {
					if (reg_a != d0) {
						if (d0 == 0) {
							printf("\tclra\n");
						} else {
							printf("\tlda\t#$%02x\n", d0);
						}
					}
					reg_a = d0;
				} else {
					printf("\tlda\t%d,%s\n", idx_off+x, idx);
					printf("\tanda\t#$%02x\n", m0);
					if (d0 != 0) {
						printf("\tora\t#$%02x\n", d0);
					}
					reg_a = -1;
				}
				printf("\tsta\t%d,%s\n", idx_off+x, idx);
			}
		}
		if (y < (h-1)) {
			if ((idx_off + fb_w * 2) > 127) {
				int add = idx_off + fb_w;
				idx_off = 0;
				total_idx_off += add;
				printf("\tlea%s\t%d,%s\n", idx, add, idx);
			} else {
				idx_off += fb_w;
			}
		} else {
			if (no_origin) {
				int add = idx_off + fb_w;
				idx_off = 0;
				total_idx_off += add;
				printf("\tlea%s\t%d,%s\n", idx, add, idx);
			} else if (!no_advance) {
				int sub = wbytes;
				if (((shift + w) % 8) != 0)
					sub--;
				total_idx_off -= sub;
				printf("\tlea%s\t%d,%s\n", idx, -total_idx_off, idx);
			}
		}
	}

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
