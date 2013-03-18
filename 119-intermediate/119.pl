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
			$graph[$j][$i] = get_node($i,$j,@pos,$w,$h);		
		}
	}
	return @graph ; 
}

sub get_node{
	my ($x,$y,@pos,$w,$h) = @_;
	my $u,my $d,my $l, my $r ; 
	our %costs ; 
		
	print "$x $y $pos[$y][$x]\n";
	$u = $y > 0 ? $costs->{'.'} : $costs->{'W'} ;
	print "$x $y $pos[$y][$x] $u \n";

	my $val ={
		left => 0,
		right => 0 ,
		top => 0,
		bottom => 0 ,
		x => $x ,
		y => $y};

	return $val; 	
}
