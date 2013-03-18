#!/usr/bin/perl -w
use strict ;
use warnings ;
use Heap::Priority;
use AutoLoader ;

if($#ARGV != 0){
	print "Usage : 119.pl <file-to-read>\n";
	exit ;
}

my @positions; #2D array thatA represents the grid as read from file 
my @graph ; 
my $fringe ;
my $counter = 0 ;
my $costs = { #costs of moving to each tile. W and S have huge costs because they are not meant to be moved into
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

@graph = get_graph( @positions) ;
$fringe = Heap::Priority->new  ;
$fringe->add('aad',3);
print "fringe hasfringe has ".$fringe->count()." items,".$fringe->pop()."\n";

#############################################################################
#  auxiliary subroutines and functions from now on
############################################################################
sub get_graph{ #returns a 2D array of hashes, where each hash represents the relationships with its neighboors
	my @pos = @_;
	my $h = @pos ; 
	my $w = $#{$pos[1]}+1;
	my $i, my $j, my @graph;
	
	for ($i = 0 ; $i < $w; $i++){
		for ($j = 0 ; $j < $h ; $j++){
			$graph[$j][$i] = get_node($i,$j,$w,$h,@pos);		
		}
	}
	return @graph ; 
}

sub get_node{
	my ($x,$y,$w,$h,@pos) = @_;
	my $u,my $d,my $l, my $r ; 
	our %costs ; 
		
	$u = ($y > 0) ? $costs->{$pos[$y-1][$x]} : $costs->{'W'} ;
	$d = ($y < $h-1) ? $costs->{$pos[$y+1][$x]} : $costs->{'W'};
	$r = ($x < $w-1) ? $costs->{$pos[$y][$x+1]} : $costs->{'W'};
	$l = ($x > 0) ? $costs->{$pos[$y][$x-1]} : $costs->{'W'};

	my $val ={
		left => $l,
		right => $r ,
		up => $u,
		down => $d ,
		x => $x ,
		y => $y
	};

	return $val; 	
}

sub g{#function that calculates cost of going from node n to n'
	return 0 ;
}

sub h{#this is the heuristic function
	return 0 ;
}
