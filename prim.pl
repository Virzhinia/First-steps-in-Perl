#!/usr/bin/perl

use 5.010;
use strict;
use warnings;
use feature 'state';

my ($first_num, $second_num);

print "Enter the first number:\n";
$first_num = is_number();

print "Enter the second number:\n";
$second_num = is_number();

if ($first_num > $second_num) {
    my $temp = $first_num;
    $first_num = $second_num;
    $second_num = $temp;
}

my @prime_list = get_primes($first_num, $second_num);
print_primes(@prime_list);

sub is_number {
    chomp(my $input = <STDIN>);
    while ($input =~ /\D/) {
        print "This is not a real number! Please enter again:\n";
        chomp($input = <STDIN>);
    }
    return $input;
}

sub get_primes {
    my @list = ($first_num..$second_num);
    my @primes;

    for my $i (@list) {
        my $numm = $i;
        my $prime_num = 1; 
        if ($i == 0 || $i == 1) {
            $prime_num = 0;
        }

        for my $j (2..sqrt($i)) {
            if ($i % $j == 0) {
                $prime_num = 0;
                last;
            }
        }
        my @primes = is_prime ($numm);
#           if ($prime_num) {            #            push (@primes, $i);
#        }
    }
    return @primes;
}

sub is_prime {
    state @arr;
#    if (my $prime_num) {
        push (@arr, $numm);
#   }
    
    return @arr;
}


sub print_primes {
    print "The prime numbers are:\n";

    foreach $_ (@_) {
        print "$_\n";
    }
}

