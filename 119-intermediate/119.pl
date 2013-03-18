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
		#print "\$position[$counter][$i] =$positions[$counter][$i]\n";
	}
	$counter++;
}

my @graph = get_graph( @positions) ;
#print $graph[0][0]->{'left'}." $costs->{'.'}\n";

sub get_graph{
	my @pos = @_;
	my $h = @pos ; 
	my $w = $#{$pos[1]}+1;
	my $i, my $j, my @graph;
	
	print "sizes are $w,$h\n";

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
	$r = ($x > 0) ? $costs->{$pos[$y][$x-1]} : $costs->{'W'};

	my $val ={
		left => $l,
		right => $r ,
		top => $t,
		bottom => $b ,
		x => $x ,
		y => $y};

	return $val; 	
}
