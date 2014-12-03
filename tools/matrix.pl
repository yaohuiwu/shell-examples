#!/usr/bin/perl
use v5.14;
use Getopt::Long;

my $file='';
my $line_n='';

GetOptions('l=s'=>\$line_n,'f=s'=>\$file);

my @line_ns=split(/,/,$line_n);

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

my $i=1;
for my $line (@all_lines){
	for my $j (@line_ns) {	
   	 	if($i==$j){
   			chomp($line);
			#say $line;
			my @tmpa=split(" ",$line);
			#say $tmpa[3];
			#$tmpb[++$#tmpb]=$tmpa[3];
			if($#tmpa >=3){
				push @tmpb,$tmpa[3];
			}
		}
   }
   $i++;
}



my $res=join(",",@tmpb);
say $res;
#for my $s (@tmpb){
#	say $s;
#}
