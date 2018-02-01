#!/usr/bin/perl

use 5.010;
use strict;
use warnings;

my $longest = 0;

foreach my $key (keys %ENV ) {
	my $key_length = length ($key);
	$longest = $key_length if $key_length> $longest;
}

foreach my $key (sort keys %ENV) {
	printf "%${longest}s	%s\n", $key, $ENV{$key};
}