#!/usr/bin/perl

use 5.010;
use strict;
use warnings;

print "Enter some lines, then press Ctrl-Z:\n";
chomp (my @lines = <STDIN>);

#print"1234567890" x7, "12345\n";

foreach (@lines) {
	printf "%20s\n", $_;
}