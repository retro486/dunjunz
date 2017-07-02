#!/usr/bin/perl

my @dragon_table = (
	[  '0',   '1',   '2',   '3',  '4',   '5',   '6',   '7' ],  # nope
	[  '8',   '9',   ':',   ';',  ',',   '-',   '.',   '/' ],  # nope
	[  '@',   'A',   'B',   'C',  'D',   'E',   'F',   'G' ],
	[  'H',   'I',   'J',   'K',  'L',   'M',   'N',   'O' ],
	[  'P',   'Q',   'R',   'S',  'T',   'U',   'V',   'W' ],
	[  'X',   'Y', '  Z',  'UP', 'DWN', 'LFT', 'RGT', 'SPC' ],
	[ 'ENT', 'CLR', 'BRK',  -1,   -1,    -1,    -1,   'SHF' ],
);

my @coco_table = (
	[  '@',   'A',   'B',   'C',  'D',   'E',   'F',   'G' ],  # nope
	[  'H',   'I',   'J',   'K',  'L',   'M',   'N',   'O' ],  # nope
	[  'P',   'Q',   'R',   'S',  'T',   'U',   'V',   'W' ],
	[  'X',   'Y', '  Z',  'UP', 'DWN', 'LFT', 'RGT', 'SPC' ],
	[  '0',   '1',   '2',   '3',  '4',   '5',   '6',   '7' ],
	[  '8',   '9',   ':',   ';',  ',',   '-',   '.',   '/' ],
	[ 'ENT', 'CLR', 'BRK',  -1,   -1,    -1,    -1,   'SHF' ],
);

my @table = @dragon_table;

if ($ARGV[0] eq '-C') {
	shift @ARGV;
	@table = @coco_table;
}

my %matrix = ();

{
	for my $row (0..6) {
		for my $col (0..7) {
			my $key = $table[$row][$col];
			next if ($key == -1);
			$matrix{$key} = [ $row, $col ];
		}
	}
}

my ($u1,$d1,$l1,$r1,$f1,$m1, $u2,$d2,$l2,$r2,$f2,$m2) = @ARGV;

my %keys = ();

for ($u1,$d1,$l1,$r1,$f1,$m1, $u2,$d2,$l2,$r2,$f2,$m2) {
	$keys{uc($_)} = 1;
}

my @m1tuples = (
	[ $u1, ],
	[ $u1, $f1 ],
	[ $u1, $m1 ],
	[ $d1, ],
	[ $d1, $f1 ],
	[ $d1, $m1 ],
	[ $l1, ],
	[ $l1, $f1 ],
	[ $l1, $m1 ],
	[ $r1, $f1 ],
	[ $r1, $m1 ],
);

my @m2tuples = (
	[ $u2, ],
	[ $u2, $f2 ],
	[ $u2, $m2 ],
	[ $d2, ],
	[ $d2, $f2 ],
	[ $d2, $m2 ],
	[ $l2, ],
	[ $l2, $f2 ],
	[ $l2, $m2 ],
	[ $r2, $f2 ],
	[ $r2, $m2 ],
);

for my $p1t (@m1tuples) {
	for my $p2t (@m2tuples) {
		check_keys(@$p1t, @$p2t);
	}
}

sub check_keys {
	my $kbd = init();
	my %legit = ();
	for (@_) {
		next if (!exists $matrix{uc($_)});
		$legit{uc($_)} = 1;
		press($kbd, uc($_));
	}
	for my $k (keys %keys) {
		next if (exists $legit{$k});
		next if (!exists $matrix{$k});
		my $mat = $matrix{$k};
		my $scan = scan($kbd, 0xff & ~(1 << $mat->[1]));
		if (($scan & (1 << $mat->[0])) == 0) {
			print join("+",@_)." -> ($k)\n";
		}
	}
}

sub init {
	return {
		row => [ 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff ],
		col => [ 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff ],
	};
}

sub press {
	my $kbd = shift;
	my $key = shift;
	return unless (exists $matrix{$key});
	my $mat = $matrix{$key};
	my $row = $mat->[0];
	my $col = $mat->[1];
	$kbd->{'row'}->[$row] &= ~(1<<$col);
	$kbd->{'col'}->[$col] &= ~(1<<$row);
	#print join(",",map { sprintf "\%02x",$_ } @{$kbd->{'col'}})."\n";
	#print join(",",map { sprintf "\%02x",$_ } @{$kbd->{'row'}})."\n";
}

sub scan {
	my $kbd = shift;
	my $col_sink = shift;
	my $row_sink = 0xff;
	my $old;
	# Ghosting: combine columns that share any pressed rows.  Repeat until
	# no change in the row mask.
	do {
		$old = $row_sink;
		for my $i (0..7) {
			if (~$row_sink & ~$kbd->{'col'}->[$i] & 0xff) {
				$col_sink &= ~(1 << $i);
				$row_sink &= $kbd->{'col'}->[$i];
			}
		}
	} while ($old != $row_sink);
	# Likewise combining rows.
	do {
		$old = $col_sink;
		for my $i (0..6) {
			if (~$col_sink & ~$kbd->{'row'}->[$i] & 0xff) {
				$row_sink &= ~(1 << $i);
				$col_sink &= $kbd->{'row'}->[$i];
			}
		}
	} while ($old != $col_sink);
	# Sink any directly connected rows.
	for my $i (0..7) {
		if (!($col_sink & (1 << $i))) {
			$row_sink &= $kbd->{'col'}->[$i];
		}
	}
	return $row_sink;
}
