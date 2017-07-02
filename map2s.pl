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
		# transformed x,y
		my $tx = $x & 7;
		my $ty = (int($x/8) * 48 + $y) - 128;
		my $m = substr($line, $x, 1);
		$bit <<= 1;
		if ($m eq '#') {
			$bit |= 1;
		} elsif ($m eq '$') {
			push @objects, [ $ty, $tx, "money" ];
		} elsif ($m eq '+') {
			push @objects, [ $ty, $tx, "cross" ];
		} elsif ($m eq 'M') {
			push @trapdoors, [ $ty, $tx ];
		} elsif ($m eq ')') {
			push @objects, [ $ty, $tx, "weapon" ];
		} elsif ($m eq '?') {
			push @objects, [ $ty, $tx, "power" ];
		} elsif ($m eq ']') {
			push @objects, [ $ty, $tx, "armour" ];
		} elsif ($m eq '!') {
			push @objects, [ $ty, $tx, "potion" ];
		} elsif ($m eq '>') {
			push @objects, [ $ty, $tx, "exit" ];
		} elsif ($m eq '%') {
			push @objects, [ $ty, $tx, "food" ];
		} elsif ($m eq 'X') {
			push @objects, [ $ty, $tx, "tport" ];
		} elsif ($m eq 's') {
			push @objects, [ $ty, $tx, "speed" ];
		} elsif ($m eq '^') {
			push @objects, [ $ty, $tx, "drainer" ];
		} elsif ($m eq '-') {
			$bit |= 1;
			my $dno = shift @line_doors or die "no door id on line $lno\n";
			$doors[$dno-1] = [ $ty, $tx ];
		} elsif ($m eq '|') {
			$bit |= 1;
			my $dno = shift @line_doors or die "no door id on line $lno\n";
			$doors[$dno-1] = [ $ty, 0x80|$tx ];
		} elsif ($m eq '~') {
			my $kno = shift @line_keys or die "no key id on line $lno\n";
			$keys[$kno-1] = [ $ty, $tx ];
		}
		if (($x & 7) == 7) {
			my $idx = int($x/8) * 48 + $y;
			$bitmap[$idx] = $bit;
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

while (scalar(@doors) < 20) {
	push @doors, [ 0x80, 0x80 ];
}

while (scalar(@keys) < 20) {
	push @keys, [ 0x80, 0x80 ];
}

while (scalar(@objects) < 30) {
	push @objects, [ 0x80, 0x80, 0x80 ];
}

# doors
{
	print "lvl_doors\n";
	for my $o (@doors) {
		print "\tfcb ".join(",",@{$o})."\n";
	}
	print "\n";
}

# keys
{
	print "lvl_keys\n";
	for my $o (@keys) {
		print "\tfcb ".join(",",@{$o})."\n";
	}
	print "\n";
}

# objects
{
	print "lvl_items\n";
	for my $o (@objects) {
		print "\tfcb ".join(",",@{$o}[2,0,1])."\n";
	}
}

# trapdoors
{
	print "lvl_trapdoors\n";
	for my $o (@trapdoors) {
		print "\tfcb ".join(",",@{$o})."\n";
	}
	# always 8 trapdoors, no need to pad
	print "\n";
}

print "\n";

print "lvl_bmp_wall\n";
for my $i (0..191) {
	print "\tfcb " if (($i & 3) == 0);
	printf "\%\%\%08b", 0+$bitmap[$i];
	print "," if (($i & 3) != 3);
	print "\n" if (($i & 3) == 3);
}

print "lvl_end\n";
