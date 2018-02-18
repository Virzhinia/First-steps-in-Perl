#!/usr/bin/perl

use 5.010;
use strict;
use warnings;

print "Enter some input and CTRL-Z to END:\n";
 chomp(my @lines=<STDIN>); 
 @lines = sort @lines;
# print "@lines\n"; - input on one line

foreach (@lines){
 print "$_\n";
}
