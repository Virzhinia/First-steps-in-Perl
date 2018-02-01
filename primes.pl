#!/usr/bin/perl

use 5.010;
use strict;
use warnings;

my ($first_num, $second_num);

print "Enter the first number:\n";
$first_num = &is_number();

print "Enter the second number:\n";
$second_num = &is_number();

if ($first_num > $second_num) {
	my $temp = $first_num;
	$first_num = $second_num;
	$second_num = $temp;
}

my @primes = &Get_primes ($first_num, $second_num);
&Print_primes(@primes);

sub is_number {
	chomp (my $input = <STDIN>);
	while ($input =~/\D/) {
		print "This is not a number! Please enter again:\n";
		chomp($input = <STDIN>);
	}
	return $input;
}

sub Get_primes {
	my @list = ($first_num..$second_num);
	my (@prime_list, $prime_num);
	
for my $i (@list) {
	if ($i < 2) {
		$prime_num = 0;
	}
	my $prime_num = 1;
	
	for my $j (2..$first_num - 1) {
		if ($i % $j == 0)
		{
			$prime_num = 0;
			last;
		}
	}
	if ($prime_num) {
		push @prime_list,$i;
		}
	}   
   return @prime_list;
}
	
sub Print_primes {
	print "The prime numbers are:\n";
	
	foreach $_ (@_) {
		print "$_\n";
	}
}