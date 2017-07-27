; Dunjunz - remade for the Dragon 32/64
; Copyright (c) 2017 Ciaran Anscomb
;
; See COPYING file for redistribution conditions.

; Tape first part.  Contains title screen, copyright message, etc.

		org $1c00

		export PART1_start
		export PART1_title_dz
		export PART1_title_dz_end
		export PART1_copyright64_dz
		export PART1_copyright64_dz_end
		export PART1_copyright_dz
		export PART1_copyright_dz_end
		export PART1_end

PART1_start

PART1_title_dz
		includebin "title.bin.dz"
PART1_title_dz_end
PART1_copyright64_dz
		includebin "copyright64.bin.dz"
PART1_copyright64_dz_end
PART1_copyright_dz
		includebin "copyright.bin.dz"
PART1_copyright_dz_end

PART1_end
