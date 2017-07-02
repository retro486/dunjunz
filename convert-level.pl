#!/usr/bin/perl

# Dunjunz level format reverse engineered by David Boddie.

my %items = (
	0x28 => '$',
	0x29 => '%',
	0x2a => '+',
	0x2b => 'X',
	0x51 => '>',
	0x53 => '^',
	0x5f => 's',
	0x60 => ']',
	0x61 => '!',
	0x62 => ')',
	0x63 => '?',
);

binmode STDIN;
binmode STDOUT;

# read level
read(STDIN, my $packed, 688);

# "decrypt" level into array of byte values
my @data = ();
for my $i (0..687) {
	$data[$i] = unpack("C", substr($packed, $i, 1)) ^ ($i & 0xff);
}

# populate map with stone/floor
my @map = ();
for my $n (0..5) {
	for my $x (0..3) {
		for my $y (0..7) {
			my $di = 0xe0 + ($n * 32) + ($x * 8) + $y;
			my $c = $data[$di];
			for my $b (0..7) {
				$mi = ($n * 256) + ($y * 32) + ($x * 8) + $b;
				if ($c & 128) {
					$map[$mi] = '#';
				} else {
					$map[$mi] = ' ';
				}
				$c <<= 1;
			}
		}
	}
}

# track which lines doors and keys appear on
my @doors = ();
my @keys = ();

# doors
for my $i (1..21) {
	my $x = $data[0x60 + $i];
	my $y = $data[0x75 + $i];
	my $o = $data[0x8a + $i];
	next if ($x == 0xff || $y == 0xff || $o == 0xff);
	my $mi = $y * 32 + $x;
	next if ($map[$mi] eq '-' || $map[$mi] eq '|');
	$map[$mi] = ($o == 0x1d) ? '-' : '|';
	push @{$doors[$y]}, [ $x, $i ];
}

# keys
for my $i (1..21) {
	my $x = $data[0xa0 + $i];
	my $y = $data[0xb5 + $i];
	next if ($x == 0xff || $y == 0xff);
	my $mi = $y * 32 + $x;
	next if ($map[$mi] eq '-' || $map[$mi] eq '|');
	$map[$mi] = '~';
	push @{$keys[$y]}, [ $x, $i ];
}

# items
for my $i (1..0x20) {
	my $x = $data[$i];
	my $y = $data[0x20 + $i];
	my $t = $data[0x40 + $i];
	next if ($x == 0xff || $y == 0xff || $t == 0xff);
	next unless (exists $items{$t});
	my $mi = $y * 32 + $x;
	$map[$mi] = $items{$t};
}

# trapdoors
for my $i (0..7) {
	my $x = $data[0xd0 + $i];
	my $y = $data[0xd8 + $i];
	my $mi = $y * 32 + $x;
	$map[$mi] = 'M';
}

# print it all
for my $y (0..47) {
	for my $x (0..31) {
		my $mi = $y * 32 + $x;
		my $t = $map[$mi];
		print $t;
	}
	if (@{$doors[$y]} || @{$keys[$y]}) {
		if (@{$doors[$y]}) {
			my @d = sort { $a->[0] <=> $b->[0] } @{$doors[$y]};
			print " D:".join(",", map { $_->[1] } @d);
		}
		if (@{$keys[$y]}) {
			my @k = sort { $a->[0] <=> $b->[0] } @{$keys[$y]};
			print " K:".join(",", map { $_->[1] } @k);
		}
	}
	print "\n";
}
