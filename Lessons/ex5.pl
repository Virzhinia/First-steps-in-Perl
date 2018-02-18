#!/usr/bin/perl

use 5.010;
use strict;
use warnings;

print "Enter the input:\n";
chomp(my $input = <STDIN>);
print "Enter the number of repeats:\n";
chomp(my $num = <STDIN>);
while($num>0) {
$num-=1;
print "$input\n";
}