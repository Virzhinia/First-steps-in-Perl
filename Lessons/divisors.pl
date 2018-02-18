#!/usr/bin/perl
use feature "switch";
no warnings 'experimental::smartmatch';

my $number = $ARGV[0]; 
my $favorite = $ARV[1];

print "Checking the number $number\n";

given ( $number ) {
    when ( !/^\d+$/ ) { print "It's not a number!\n"; }
    my @divisors = divisors ($number);

    when ( 2 ~~ @divisors ) { print "The number $number is even.\n"; continue; }
    when ( !(2 ~~ @divisors)) { print "The number $number is odd.\n"; continue; } 
    when ( $favorite ~~ @divisors ) { print "$number is divisible by my favorite number\n"; continue; }
    when ( $number ~~ $favorite ) { print "The two numbers are equals!\n"; continue; }

    my @empty;
    when ( @divisors ~~ @empty) { print "The number is prime!\n"; }
    default { print "$number is divisible by: @divisors \n"; }
}

sub divisors {
    my $num = shift;
    my @divisors = ();
    foreach my $divisor (2.. ($number / 2 + 1) ) {
        unless ($num % $divisor) {
            push @divisors, $divisor;
        }
    }
    return @divisors;
}
