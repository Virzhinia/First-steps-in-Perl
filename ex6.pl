#!/usr/bin/perl

use 5.010;
use strict;
use warnings;

print "Enter some lines than press Ctrl-Z:\n";

my @lines = <STDIN>;
my @reserved_lines = reverse @lines;
print @reserved_lines;