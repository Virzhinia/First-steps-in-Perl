#!/usr/bin/perl

use 5.010;
use strict;
use warnings;

my @arr = qw(fred barney betty);
my @reversed_arr = reverse(@arr);
print "@reversed_arr\n";

print reverse<STDIN>;