#!/usr/bin/perl

use 5.010;
use strict;
use warnings;

my %family_name=qw(georgi georgiev virzhiniya nikolova alex todorova);

print"Enter first name:\n";
chomp(my $first_name=<STDIN>);

if(exists $family_name{$first_name}){
	print "The family name of $first_name is $family_name{$first_name}.\n";
}