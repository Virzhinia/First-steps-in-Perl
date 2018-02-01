#!/usr/bin/perl

use 5.010;
use strict;
use warnings;

sub total{
	my $sum;
	foreach (@_){
		$sum+=$_;
	}
	$sum;
}

my $sum = &total(1..1000);

print "The sum of numbers 1 to 1000 is $sum.\n";
