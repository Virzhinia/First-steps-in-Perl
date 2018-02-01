#!/usr/bin/perl

use 5.010;
use strict;
use warnings;

print "What column width would you like? ";
chomp (my $width = <STDIN>);

print "Enter some lines, then press Ctrl-Z:\n";
chomp(my @lines = <STDIN>);

foreach (@lines){
	printf"%${width}s\n", $_;
}