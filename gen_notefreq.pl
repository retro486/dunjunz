#!/usr/bin/perl -wT

use Getopt::Long;

my $cpu_freq = 14318180 / 16;
my $mixer_cyc = 59;

my $mbase = 69;   # A4
my $mfreq = 440;

Getopt::Long::Configure("bundling", "auto_help");

GetOptions("cycles|c=i" => \$mixer_cyc,
		"base|b=i", \$mbase,
		"base-freq|f=i", \$mfreq);

my @note_names = ( "c", "cs", "d", "ds", "e", "f", "fs", "g", "gs", "a", "as", "b" );
my @note_map = ( );

for my $m (0..255) {
	my $freq = (2 ** (($m - $mbase) / 12)) * $mfreq;
	my $f = (65536 * $freq) / ($cpu_freq / $mixer_cyc);
	next if ($f == 0);
	next if ($f >= 0x8000);
	next if ($m < 12);
	my $o = int(($m - 12) / 12);
	my $ni = $m % 12;
	my $name = "$note_names[$ni]$o";
	printf "\%s\tequ \$\%04x\n", $name, int($f+0.5);
}
print "\n";

__END__

=head1 gen_notefreq.pl

gen_notefreq.pl - Generate a list of note frequencies by name

=head1 SYNOPSIS

gen_ftable.pl [OPTION]...

 Options:
  -c, --cycles C       mixer loop takes C cycles [71]
  -b, --base N         note base [69]
  -f, --base-freq HZ   frequency at note base [440]

=cut
