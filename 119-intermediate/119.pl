#!/usr/bin/perl -w
use strict ;
use warnings ;
use AutoLoader ;
use Heap::Priority;

if($#ARGV != 0){
	print "Usage : 119.pl <file-to-read>\n";
	exit ;
}

our @positions; #2D array thatA represents the grid as read from file 
our @graph ;
our ($startX,$startY,$endX,$endY);
our $fringe ;
our $counter = 0 ;
our $costs = { #costs of moving to each tile. W and S have huge costs because they are not meant to be moved into
		'.' =>1,
		W => 500,
		E => 1,
		S => 500
		};

open (GRID, $ARGV[0]);
print "Reading file $ARGV[0]...\n";
while(<GRID>){
	chomp;
	print "$_ \n";
	my $i ;
	for($i = 0 ; $i < length($_);$i++){
		$positions[$counter][$i] = substr($_,$i,1);
	}
	$counter++;
}
$fringe = Heap::Priority->new  ;
$fringe->lowest_first ;
@graph = get_graph() ;
print "Fringe size is ".  $fringe->count() .', '. $fringe->pop() ."\n";
start();

#############################################################################
#  auxiliary subroutines and functions from now on
############################################################################
sub get_graph{ #returns a 2D array of hashes, where each hash represents the relationships with its neighboors
	my $h = @positions ; 
	my $w = $#{$positions[1]}+1;
	my ($i, $j, @graph);
	for ($i = 0 ; $i < $w; $i++){
		for ($j = 0 ; $j < $h ; $j++){
			$graph[$j][$i] = get_node($i,$j,$w,$h);		
			if($positions[$j][$i] eq 'S'){
				$startX = $i;
				$startY = $j;
				$fringe->add($i.','.$j,0);
				print "Start at $i,$j \n";
			}
			elsif( $positions[$j][$i] eq 'E' ){
				$endY = $j;
				$endX = $i;
				print "End at $i,$j \n";
			}
		}
	}
	return @graph ; 
}

sub get_node{
	my ($x,$y,$w,$h) = @_;
	my $u,my $d,my $l, my $r ; 
		
	$u = ($y > 0) ? $costs->{$positions[$y-1][$x]} : $costs->{'W'} ;
	$d = ($y < $h-1) ? $costs->{$positions[$y+1][$x]} : $costs->{'W'};
	$r = ($x < $w-1) ? $costs->{$positions[$y][$x+1]} : $costs->{'W'};
	$l = ($x > 0) ? $costs->{$positions[$y][$x-1]} : $costs->{'W'};

	my $val ={
		left => $l,
		right => $r,
		up => $u,
		down => $d ,
		x => $x ,
		y => $y
	};

	return $val; 	
}

sub start{
	my $found = 1 ;
	my ($x,$y);
	while($found){
		my @arr = split(',',$fringe->pop());	
		$x = $arr[0];
		$y = $arr[1];
		if ($positions[$y][$x] eq 'E'){
			$found = 0 ;
		}else{
			my $a = $fringe->pop();
			print "$a \n";
			#expand($fringe->pop());
			$found = 0 ;
		}
	}	
	print "Done, exit found at ($x,$y)";
}

sub expand{
	my ($coords) = @_ ;
	my ($x,$y) = split(',',$coords);
	
	print "Expanding node $x,$y...\n";

	if($graph[$y][$x]->{left} == 1 ){$fringe->add($x-1 .','.$y,f($x-1,$y));}
	if($graph[$y][$x]->{up} == 1 ){$fringe->add($x.','.$y-1,f($x,$y-1))};
	if($graph[$y][$x]->{right} == 1 ){$fringe->add($x+1 .','.$y,f($x+1,$y));}
	if($graph[$y][$x]->{down} == 1 ){$fringe->add($x.','.$y+1,f($x,$y+1));}
}

sub f{
	my ($x,$y) = @_ ;
	return g($x,$y) + h($x,$y);
}

sub g{#function that calculates cost of going from node n to n'
	my ($x,$y) = @_ ;
	return $costs->{$positions[$y][$x]} ;
}

sub h{#this is the heuristic function
#heuristic here assumes straight distance from node to end 
	my ($x,$y) = @_ ;
	return sqrt( ($endY - $y )**2 + ($endX - $x)**2 ) ;
}
