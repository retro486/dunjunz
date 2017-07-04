# Dunjunz

For the Dragon 32/64 and Tandy Colour Computer.

Dragon version by Ciaran Anscomb <xroar@6809.org.uk>

BBC Micro/Master original by Julian Avis and Copyright Bug Byte 1987

This rewrite for the Dragon does not reference any original code, all
behaviour is inferred.

Level data was, however, converted from the BBC disk version using
information gleaned from David Boddie's Python scripts.

For binaries, check out the [home page].

[home page]: http://www.6809.org.uk/dunjunz/

## Building from source

The build system very much depends on a Unix-like environment.  You'll need
Perl for map2s.pl, and a C compiler plus the development files for SDL\_image
1.2 to build tile2s.  Also required: [asm6809], [bin2cas.pl], [dzip].

[asm6809]: http://www.6809.org.uk/asm6809/
[bin2cas.pl]: http://www.6809.org.uk/dragon/#castools
[dzip]: http://www.6809.org.uk/dragon/#dzip

If all that's available, just type 'make'.  'make clean' to tidy up.
