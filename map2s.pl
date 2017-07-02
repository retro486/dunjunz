#!/usr/bin/perl

my @teleports = ();
my @trapdoors = ();
my @doors = ();
my @keys = ();

my $eof = 0;
my $lno = 0;

print "leveldata\n";
while ($lno < 48) {
	my $line = <> or $eof = 1 if (!$eof);
	$lno++;
	if ($eof) {
		$line = "################################" if ($eof);
	} else {
		chomp $line;
	}
	my @args = split(/,\s*/, substr($line,33));
	my @fcb = ();
	for my $i (0..31) {
		my $m = substr($line, $i, 1);
		if ($m eq '#') {
			push @fcb, "stone01";
		} elsif ($m eq '$') {
			push @fcb, "money";
		} elsif ($m eq '+') {
			push @fcb, "cross";
		} elsif ($m eq 'M') {
			push @fcb, "trapdoor";
			push @trapdoors, ($lno * 32) + $i;
		} elsif ($m eq ')') {
			push @fcb, "weapon";
		} elsif ($m eq '?') {
			push @fcb, "power";
		} elsif ($m eq ']') {
			push @fcb, "armour";
		} elsif ($m eq '>') {
			push @fcb, "exit";
		} elsif ($m eq '%') {
			push @fcb, "food";
		} elsif ($m eq 'X') {
			my $dest = ord(shift @args) - ord('A');
			push @fcb, sprintf("\$\%02x|%s", $dest, "tport");
			push @teleports, ($lno * 32) + $i;
		} elsif ($m eq '^') {
			push @fcb, "drainer0";
		} elsif ($m eq '-') {
			push @fcb, "door_h";
			my $num = shift @args;
			$doors[$num-1] = ($lno * 32) + $i;
		} elsif ($m eq '|') {
			push @fcb, "door_v";
			my $num = shift @args;
			$doors[$num-1] = ($lno * 32) + $i;
		} elsif ($m eq '~') {
			push @fcb, "key";
			my $num = shift @args;
			$keys[$num-1] = ($lno * 32) + $i;
		} else {
			push @fcb, "floor";
		}
	}
	print "\tfcb\t".join(",",@fcb)."\n";
}
print "leveldata_end\n";

die "not a multiple of 8 lines\n" if (($lno % 8) != 0);
die "must be 8 trapdoors\n" if (scalar(@trapdoors) != 8);
die "too many keys (max 20)\n" if (scalar(@keys) > 20);
die "too many doors (max 20)\n" if (scalar(@doors) > 20);
die "too many teleports (max 16)\n" if (scalar(@teleports) > 16);  # XXX check this

print "\n";

print "doors\n";
for my $i (0..19) {
	if ($doors[$i]) {
		printf "\tfdb\tleveldata+\$\%04x\n", $doors[$i];
	} else {
		printf "\tfdb\t\$0000\n";
	}
}

print "keys\n";
for my $i (0..19) {
	if ($keys[$i]) {
		printf "\tfdb\tleveldata+\$\%04x\n", $keys[$i];
	} else {
		printf "\tfdb\t\$0000\n";
	}
}

print "teleports\n";
for (@teleports) {
	printf "\tfdb\tleveldata+\$\%04x\n", $_;
}
printf "\tfcb\t\$00\n";  # don't really have to include this when dzipped
