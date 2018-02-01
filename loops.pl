#!/usr/bin/perl

use 5.010;
use strict;
use warnings;
use feature 'say';
use feature "switch";

print "Hello World!\n";

my $lucky_num = 7;

my $guess;


do {
	say "Guess a Number between 1 to 10";
	
	
$guess = <STDIN>;
} while $guess != $lucky_num;


say "You Guessed 7";
