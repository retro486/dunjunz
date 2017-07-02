#!/usr/bin/perl -wT

# usage: conflict.pl [-c] "key,key,key" "key,key,key"...

# Basically you're specifying groups of keys, and this script checks that no
# combination picking one from each group of keys conflicts with any other key
# that's of interest.
#
# e.g., assume Q,A,O,P,SPACE = up,down,left,right,fire
#
# conflict.pl "q,a" "o,p" "space"
#
# Verifies that a user could press either vertical key AND either horizontal
# key AND fire at the same time without conflict.  No output is good, otherwise
# it'll list the combinations of keys that conflict (no guarantees it's going
# to print the shortest combination in each case).
#
# Specify RFIRE1, LFIRE1, RFIRE2, LFIRE2 (last two are CoCo3 only I think) to
# check conflicts with firebuttons.  This is what the "-c" option affects.

use strict;

use Getopt::Long;

my %map = (
	'!' => '1', '"' => '2', '#' => '3', '$' => '4',
	'%' => '5', '&' => '6', "'" => '7', '(' => '8',
	'*' => ':', '=' => '-', ';' => '+', ',' => '<',
	'.' => '>', '?' => '/',
);

my @dragon_table = (
	[  '0',   '1',   '2',   '3',  '4',   '5',   '6',   '7' ],
	[  '8',   '9',   ':',   '+',  '<',   '-',   '>',   '/' ],
	[  '@',   'A',   'B',   'C',  'D',   'E',   'F',   'G' ],
	[  'H',   'I',   'J',   'K',  'L',   'M',   'N',   'O' ],
	[  'P',   'Q',   'R',   'S',  'T',   'U',   'V',   'W' ],
	[  'X',   'Y',   'Z',  'UP', 'DOWN', 'LEFT', 'RIGHT', 'SPACE' ],
	[ 'ENTER', 'CLEAR', 'BREAK',  '',   '',    '',    '',   'SHIFT' ],
);

my @coco_table = (
	[  '@',   'A',   'B',   'C',  'D',   'E',   'F',   'G' ],
	[  'H',   'I',   'J',   'K',  'L',   'M',   'N',   'O' ],
	[  'P',   'Q',   'R',   'S',  'T',   'U',   'V',   'W' ],
	[  'X',   'Y',   'Z',  'UP', 'DOWN', 'LEFT', 'RIGHT', 'SPACE' ],
	[  '0',   '1',   '2',   '3',  '4',   '5',   '6',   '7' ],
	[  '8',   '9',   ':',   '+',  '<',   '-',   '>',   '/' ],
	[ 'ENTER', 'CLEAR', 'BREAK',  '',   '',    '',    '',   'SHIFT' ],
);

my %firebuttons = (
	'RFIRE1' => 0,
	'LFIRE1' => 1,
	'RFIRE2' => 2,
	'LFIRE2' => 3,
);

my @fbnames = ( 'RFIRE1', 'LFIRE1', 'RFIRE2', 'LFIRE2' );

my @table = @dragon_table;

Getopt::Long::Configure("gnu_getopt", "pass_through");

GetOptions(
	"coco|c" => sub { @table = @coco_table; }
) or exit(2);

my %matrix = ();

{
	for my $row (0..6) {
		for my $col (0..7) {
			my $key = $table[$row][$col];
			next if ($key eq '');
			$matrix{$key} = [ $row, $col ];
		}
	}
}

my @groups = ();

for (@ARGV) {
	push @groups, [ split(/,/, $_) ];
}

my %keys = ();
my %row_sink = ();

for my $g (@groups) {
	for my $k (@{$g}) {
		$k = uc($k);
		if ($k =~ /^[LR]FIRE[12]$/) {
			$row_sink{$firebuttons{$k}} = 1;
			next;
		}
		if (exists $map{$k}) {
			$k = $map{$k};
		}
		if (!exists $matrix{$k}) {
			print STDERR "unknown key: $k\n";
			exit 1;
		}
		$keys{$k} = 1;
	}
}

check_groups([], @groups);

sub check_groups {
	my $keys = shift;
	my $group = shift;
	my @rest = @_;
	if (!$group) {
		check_keys(@{$keys});
		return;
	}
	for my $k (@{$group}) {
		next if ($k =~ /^[LR]FIRE[12]$/);
		my @to_check = (@{$keys}, $k);
		return if (check_keys(@to_check) == 1);
		check_groups(\@to_check, @rest);
	}
}

sub check_keys {
	my $kbd = init();
	my %legit = ();
	my $ret = 0;
	for my $key (@_) {
		next if (!exists $matrix{$key});
		$legit{$key} = 1;
		my $mat = $matrix{$key};
		if (exists $row_sink{$mat->[0]}) {
			print $fbnames[$mat->[0]]." -> $key\n";
			$ret = 1;
		}
		press($kbd, $key);
	}
	for my $k (keys %keys) {
		next if (exists $legit{$k});
		next if (!exists $matrix{$k});
		my $mat = $matrix{$k};
		my $scan = scan($kbd, 0xff & ~(1 << $mat->[1]));
		if (($scan & (1 << $mat->[0])) == 0) {
			print join(" ",@_)." -> ($k)\n";
			$ret = 1;
		}
	}
	return $ret;
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
