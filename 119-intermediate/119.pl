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
my $costs = {
		'.' =>1,
		W => 500,
		E => 1,
		S => 500
		};

while(<GRID>){
	chomp;
	print "$_ \n";
	my $i ;
	for($i = 0 ; $i < length($_);$i++){
		my $char = substr($_,$i,1);
		$positions[$counter][$i] = $char;
	}
	$counter++;
}

my @graph = get_graph( @positions) ;
#print $graph[0][0]->{'left'}." $costs->{'.'}\n";

sub get_graph{
	my $pos = shift;
	my $h = @positions;
	my $w = $#{$positions[1]}+1;
	my $i, my $j, my @graph;

	for ($i = 0 ; $i < $w; $i++){
		for ($j = 0 ; $j < $h ; $j++){
			$graph[$j][$i] = get_node($i,$j,$pos,$w,$h);		
		}
	}
	return @graph ; 
}

sub get_node{
	my ($x,$y,@pos,$w,$h) = @_;
	my $u,my $d,my $l, my $r ; 
	our $costs ; 
		
	print "$y $x $pos[0][0]\n";

	$u = $y > 0 ? 0 : $costs->{'W'} ;
	
	my $val ={
		left => 0,
		right => 0 ,
		top => 0,
		bottom => 0 ,
		x => $x ,
		y => $y};

	return $val; 	
}
