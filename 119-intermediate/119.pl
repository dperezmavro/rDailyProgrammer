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
		if ($char eq 'S'){$positions[$counter][$i]= 'S';}
		elsif($char eq '.'){$positions[$counter][$i]= '.';}
		elsif($char eq 'E'){$positions[$counter][$i]= 'E';}
		elsif($char eq 'W'){$positions[$counter][$i]= 'W';}
		else{print "Illegal character found$char(), quiting!\n";exit;}
	}
	$counter++;
}

my @graph = get_graph( @positions) ;
print $graph[0][0]->{'left'}." $costs->{'.'}\n";

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
		
	print "$y $x $costs->{'.'} $pos[$y][$x] \n";

	$u = $y > 0 ? $costs->{$pos[$y-1][$x]} : 'W' ;
	
	my $val ={
		left => 0,
		right => 0 ,
		top => 0,
		bottom => 0 ,
		x => $x ,
		y => $y};

	return $val; 	
}
