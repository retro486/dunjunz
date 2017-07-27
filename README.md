# Dunjunz

*25 levels of monsters & magic for the Dragon 32/64 and Tandy Colour Computer.
Up to four simultaneous players! Written in Machine Code!*

Dragon version by Ciaran Anscomb, 2017.

Original BBC Micro version by Julian Avis for Bug-Byte, Copyright 1987.

For downloads, check out the [home page](http://www.6809.org.uk/dunjunz/).

## Building from source

The build system very much depends on a Unix-like environment, and depends on
many commonly-available Unix tools and library.  You'll need a C compiler, the
[SDL\_image 1.2] development files, Perl, [asm6809], [bin2cas.pl], and [dzip].

Building the tape images requires [SoX].  Building the disk image requires the
decb tool from [ToolShed].

[SDL\_image 1.2]: https://www.libsdl.org/projects/SDL_image/release-1.2.html
[asm6809]: http://www.6809.org.uk/asm6809/
[bin2cas.pl]: http://www.6809.org.uk/dragon/#castools
[dzip]: http://www.6809.org.uk/dragon/#dzip
[SoX]: http://sox.sourceforge.net/
[ToolShed]: http://toolshed.sourceforge.net/

If all that's available, just type `make`.  `make clean` to tidy up.
