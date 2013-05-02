 #!/usr/bin/perl
 %ends = ('Windows' => '\r\n', 'Unix'=>'\n');
 open(FILE, $ARGV[0]);
 while(<FILE>){
         $_ =~ s/(\\r)?\\n/$ends{$ARGV[1]}/g;
         print $_ ;
 }
 close(FILE);