#!/usr/bin/perl

print "Please enter a string: \n";
chomp (my $string = <STDIN>);

print "Please enter a substring: ";
chomp (my $sub = <STDIN>);

my @places;

for (my $pos = -1; ;) {
    $pos = index($string, $sub, $pos + 1);

    if ( $pos == -1) {
        last;
    }
    push @places, $pos;
}

print "Locations of '$sub' in '$string' were: @places\n";
