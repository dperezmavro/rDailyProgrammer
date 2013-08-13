use POSIX ;
print "Please give number range (use Q to quit):\n";
die 'Usage : sum.pl <num> <num>' unless <STDIN> =~ m/^(\d)+\s+(\d)+$/;
($start, $end ) = ($1, $2);
@ops = qw(- + *) ;

play();

sub play(){
    while (1){
        $eq = gen();
        print "> $eq\n";
        $ans = <STDIN>;
        if ($ans =~ m/^-?\d+$/){
           print "Correct!\n" if ($ans == eval($eq));
        }elsif ($ans =~ m/q/i){
            exit ;
        }
	}
}

sub gen(){
    $r = '' ;
	for(1 .. 4){
        $r .= ceil($start + rand($end - $start));
        $r .= $ops[-1 + ceil(rand(3))] unless $_ == 4;
	}
    return $r;
}
