#!/usr/bin/perl

use 5.010;
use strict;
use warnings;

print "What is the radius?\n";
chomp(my $radius = <STDIN>);
if ($radius<0) {
	$radius = 0; 
}
my $pi = 3.141592654;
my $circ = 2 * $pi * $radius; 

print "The circumference of a circle of radius $radius is $circ.\n";
