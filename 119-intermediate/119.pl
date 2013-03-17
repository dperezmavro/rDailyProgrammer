#!/usr/bin/perl -w
use strict ;
use warnings ;

if($#ARGV != 0){
	print "Usage : 119.pl <file-to-read>\n";
	exit ;
}

print "Starting...\n";
print "Reading file $ARGV[0]...\n";
open (GRID, $ARGV[0]);
my @positions;
my $counter = 0 ;
while(<GRID>){
	chomp;
	print "$_ \n";
	my $i ;
	for($i = 0 ; $i < length($_);$i++){
		my $char = substr($_,$i,1);
		if ($char eq 'S'){$positions[$counter][$i]= 0;}
		elsif($char eq '.'){$positions[$counter][$i]= 1;}
		elsif($char eq 'E'){$positions[$counter][$i]= 1;}
		elsif($char eq 'W'){$positions[$counter][$i]= 10;}
		else{print "Illegal character found$char(), quiting!\n";exit;}
	}
	$counter++;
}

my @graph = get_graph( @positions) ;

sub get_graph{
	my $positions = shift;
	my $h = @positions;
	my $w = $#{$positions[1]}+1;
	print "Array size is $w,$h\n";
	my $i, my $j, my @graph;
	for ($i = 0 ; $i < $w; $i++){
		for ($j = 0 ; $j < $h ; $j++){
			$graph[$j][$i] = get_value($i,$j,@positions);		
		}
	}
	return @graph ; 
}

sub get_value{
	my ($x,$y,$pos) = @_;
	my %val = {
		left => 0,
		right => 0 ,
		top => 0,
		bottom => 0 ,
		x => $x ,
		y => $y};
	return %val ; 	
}
