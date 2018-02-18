#!/usr/bin/perl

use 5.010;
use strict;
use warnings;

my @fred = qw /1 3 5 7 9 /;
my $fred_total = &total(@fred);

sub total{
	my $sum;
	foreach (@_){
		$sum+=$_;
	}
	$sum;
}
print "The total of \@fred is $fred_total.\n";




