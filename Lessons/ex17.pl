#!/usr/bin/perl

use 5.010;
use strict;
use warnings;
use feature 'state';

my $num;

for my $i (1..9) {
	$num = $i;
my @arr = Add($num);
	print "@arr\n";
	}
	
	sub Add {
		state @other;
		state $num;
		push @other, $num;
#		my $two=2;
#		@other = Add2($two);		
		return @other;
		}
		
		#sub Add2 {
#	state @two;
#	push @two, $two;
#	return @two;
#}