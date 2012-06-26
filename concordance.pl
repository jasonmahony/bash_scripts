#!/usr/bin/perl -w

print "Hi, enter a word and press enter.\n";
my $special = <STDIN>;
chomp($special);

my @words = &input;

unshift(@words,$special);
my $count = &check_word(@words);

print "Total occorances of the word \"$special\" in your text is $count.\n";

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

sub check_word
{
  my @textwords = @_;
  my $spesh = shift(@textwords);
  my $textwords = @textwords;
  my $count = 0;
  for $textword(@textwords) {
    if ($textword eq $spesh) {
      $count++;
    }
  }
  return $count;
}
