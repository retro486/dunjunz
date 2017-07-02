#!/usr/bin/perl -wT

use strict;

# Maximums:
#
#   29 ordinary objects
#    1 exit
#   20 keys
#   20 doors

my @bitmap = ();
my @trapdoors = ();
my @doors = ();
my @keys = ();
my @objects = ();

my @lines = ();
my $y = 0;
while (<>) {
	chomp;
	push @lines, $_ if ($y < 48);
	$y++;
}

for $y (0..47) {
	my $lno = $y+1;
	my $line = $lines[$y] // "#" x 32;
	my @line_doors = ();
	my @line_keys = ();
	if (length($line) > 33) {
		for (split(/\s+/, substr($line,33))) {
			if (/^d:(.*)/i) {
				@line_doors = split(/,/, $1);
			} elsif (/^k:(.*)/i) {
				@line_keys = split(/,/, $1);
			}
		}
	}
	my $bit = 0;
	for my $x (0..31) {
		my $pos = $y * 32 + $x;
		my $m = substr($line, $x, 1);
		$bit <<= 1;
		if ($m eq '#') {
			$bit |= 1;
			if (($y == 11 || $y == 12) && ($x == 11 || $x == 12)) {
				# a stone in the starting position should be
				# recorded as an object so it's redrawn when
				# player moves off it
				# XXX maybe not...
				#push @objects, [ $pos, "stone" ];
			}
		} elsif ($m eq '$') {
			push @objects, [ $pos, "money" ];
		} elsif ($m eq '+') {
			push @objects, [ $pos, "cross" ];
		} elsif ($m eq 'M') {
			push @trapdoors, [ $pos, "trapdoor" ];
		} elsif ($m eq ')') {
			push @objects, [ $pos, "weapon" ];
		} elsif ($m eq '?') {
			push @objects, [ $pos, "power" ];
		} elsif ($m eq ']') {
			push @objects, [ $pos, "armour" ];
		} elsif ($m eq '!') {
			push @objects, [ $pos, "potion" ];
		} elsif ($m eq '>') {
			push @objects, [ $pos, "exit" ];
		} elsif ($m eq '%') {
			push @objects, [ $pos, "food" ];
		} elsif ($m eq 'X') {
			push @objects, [ $pos, "tport" ];
		} elsif ($m eq '^') {
			push @objects, [ $pos, "drainer" ];
		} elsif ($m eq '-') {
			$bit |= 1;
			my $dno = shift @line_doors or die "no door id on line $lno\n";
			$doors[$dno-1] = [ $pos, "door_h" ];
		} elsif ($m eq '|') {
			$bit |= 1;
			my $dno = shift @line_doors or die "no door id on line $lno\n";
			$doors[$dno-1] = [ 0x8000 | $pos, "door_v" ];
		} elsif ($m eq '~') {
			my $kno = shift @line_keys or die "no key id on line $lno\n";
			$keys[$kno-1] = [ $pos, "key" ];
		}
		if (($x & 7) == 7) {
			push @bitmap, $bit;
			$bit = 0;
		}
	}
}

die "must be 8 trapdoors\n" if (scalar(@trapdoors) != 8);  # must there?
die "too many doors (max 20)\n" if (scalar(@doors) > 20);
die "too many keys (max 20)\n" if (scalar(@keys) > 20);
die "too many objects (max 30)\n" if (scalar(@objects) > 30);

{
	for my $i (0..$#keys-1) {
		if (!defined $doors[$i]) {
			die "no door for key ".($i+1)."\n";
		}
	}
}

{
	for my $i (0..$#doors-1) {
		if (!defined $keys[$i]) {
			die "no key for door ".($i+1)."\n";
		}
	}
}

printf "; %d objects\n", scalar(@objects);
print "\n";

print "level_bitmap\n";
for my $i (0..191) {
	print "\tfcb " if (($i & 3) == 0);
	printf "\%\%\%08b", 0+$bitmap[$i];
	print "," if (($i & 3) != 3);
	print "\n" if (($i & 3) == 3);
}
print "\n";

# doors
{
	print "doors\n";
	my $i = 0;
	for my $door (@doors) {
		printf "\tfdb \$\%04x\n", $door->[0];
		$i++;
	}
	while ($i < 20) {
		print "\tfdb \$0000\n";
		$i++;
	}
	print "\n";
}

# keys
{
	print "keys\n";
	my $i = 0;
	for my $key (@keys) {
		printf "\tfdb \$\%04x\n", $key->[0];
		$i++;
	}
	while ($i < 20) {
		print "\tfdb \$0000\n";
		$i++;
	}
	print "\n";
}

# trapdoors
{
	print "trapdoors\n";
	my $i = 0;
	for my $trapdoor (@trapdoors) {
		printf "\tfdb \$\%04x\n", $trapdoor->[0];
		$i++;
	}
	while ($i < 8) {
		print "\tfdb \$0000\n";
		$i++;
	}
	print "\n";
}

# objects
{
	print "objects\n";
	my $i = 0;
	for my $object (@objects) {
		my ($pos, $name) = @{$object};
		printf "\tfdb \$\%04x\n", $pos;
		printf "\tfcb \%s\n", $name;
		$i++;
	}
	while ($i < 30) {
		print "\tfdb \$0000\n";
		print "\tfcb 0\n";
		$i++;
	}
}
