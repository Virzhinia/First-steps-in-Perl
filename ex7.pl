#!/usr/bin/perl

use 5.010;
use strict;
use warnings;

my @names = qw (fred betty barney dino wilma pebbles bamm-bamm);

print "Enter a number from 1 to 7 and Cntrl-Z to End:\n";
chomp(my @numbers=<STDIN>);


foreach (@numbers) {
	if($_>0 && $_<8) {
	print "$names[$_ - 1]\n";
}
else{
	print"$_ in't in diapazon!\n";
}
}
