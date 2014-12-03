#!/usr/bin/perl
use v5.14;
use Getopt::Long;

if((1+$#ARGV)<3){
	say "usage: ./matrix.pl --r=3,5,7 --c=4 --f='matrix.file'";
	exit 0;
}

my $file='';
my $rows='';
my $col=1;

GetOptions('r=s'=>\$rows,'c=i'=>\$col,'f=s'=>\$file);

my @line_ns=split(/,/,$rows);

#say "f ".$file ;
#say "l ".$line_n;
#say "ls: @line_ns";

open(M_FILE,$file) || die "Can't open $file:$!\n";

#for my $k (@line_ns) {
#	say "k:".$k;
#}

my @tmpb=();

my @all_lines=<M_FILE>;
close M_FILE;

for my $j (@line_ns) {
	my $line = $all_lines[$j-1];
	chomp($line);
	#say $line;
	my @tmpa=split(/\s+/,$line);
	#say $tmpa[3];
	#$tmpb[++$#tmpb]=$tmpa[3];
	if($#tmpa >= ($col-1)){
		push @tmpb,$tmpa[$col-1];
	}
}

my $res=join(",",@tmpb);
say $res;
