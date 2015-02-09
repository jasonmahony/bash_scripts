#!/usr/bin/perl -w

use strict;

my @words = &input;

my @unique = &dedupe(@words);
my $unique = @unique;
my %count;
my @sorted;
my $i;

for ($i = 0; $i < $unique; $i++) {
  %count = ($unique[$i] => 0);
}

for my $word(@words) {
  for ($i = 0; $i < $unique; $i++) {
    if ( $word eq $unique[$i] ) {
      $count{$unique[$i]}++;
    }
  }
}

@sorted = reverse sort { $count{$a} <=> $count{$b} } keys %count;
my $m = 1;

foreach my $sort (@sorted) {
  print $m.". ".$sort.": ".$count{$sort}."\n";
  $m++;
}

sub input
{
  my $i = 0;
  my $j = 0;
  my @fulltext;
  my $pop = 0;
  my @werds;
  print "Please enter text:\n";
  while (<STDIN>) {
    chomp;
    my $text = $_;
    if ( $text !~ /^$/ ) {
      $fulltext[$i] = $text;
      $i++;
    }
    else {
      my $string = join(' ',@fulltext);
      @werds = split(' ', $string);
      my $werds = @werds;
      for ($j = 0; $j < $werds - $pop; $j++) { 
        $werds[$j] = lc($werds[$j]);
        $werds[$j] =~ s/(,$)|(^")|("$)|(\.$)//;
        if ($werds[$j - $pop] !~ /(\w)+/) { 
          splice(@werds,$j - $pop,1);
          $pop++;
        }
      }
      return @werds;
    }
  }
}
sub dedupe{
my @a = @_;
my $a = @a;
my $pop = 0;
my $k = 0;
my @array;

while ( $k < $a ) {
    $array[$k - $pop] = $a[$k];
    for (my $j = 0; $j < $k - $pop; $j++) {
      if ( $array[$j] eq $a[$k] ) {
        pop(@array);
        $pop++;
      }
    }
  $k++;
}
return @array;
}
