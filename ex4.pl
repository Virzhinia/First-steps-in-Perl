#!/usr/bin/perl

use 5.010;
use strict;
use warnings;


chomp(my $first_num = <STDIN>);

chomp(my $second_num = <STDIN>);
my $result = $first_num * $second_num;

print "The result is $result.\n";