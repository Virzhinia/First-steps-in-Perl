#!/usr/bin/perl

my %last_name = qw /fred flintstone Wilma Flintstone Barney Rubble betty rubble Bamm-Bamm Rubble PEBBLES FLINTSTONE/;

print "The names are:\n";
print_original_hash();

my @keys = sort {"\L$last_name{$a}" cmp "\L$last_name{$b}"
or
"\L$a" cmp "\L$b"
} keys %last_name;

print_sorted_hash();

sub print_original_hash {
foreach $person (keys %last_name) {
   my $family = $last_name{$person};
    print "$person => $family\n";
    }
}

sub print_sorted_hash {
    foreach (@keys) {
        print "$last_name{$_} ~ $_\n";
    }
}
