#!/usr/bin/perl

use 5.010;
use strict;
use warnings;

print "Enter the first number:\n";
chomp(my $first_num = <STDIN>);
print "Enter the second number:\n";
chomp(my $second_num = <STDIN>);
my $result = $first_num * $second_num;

print "The result is $result.\n";
