#!/usr/bin/perl
use Math::BigFloat;

print "Enter end of the range and number of the columns:\n";
chomp(my $end_of_the_range = <STDIN>);
chomp(my $end_column = <STDIN>);

open(FILE_HNDL, ">random.txt");
my (@row, @randoms);
my $format = "\t%.2f";


print FILE_HNDL "Range of the numbers: $end_of_the_range\t\tNumber of the columns: $end_column\n\n\n";
for my $l (0..($end_column - 1)) {
    for my $c (0..($end_column - 1)) {
    $row[$l][$c] = rand($end_of_the_range);
    printf FILE_HNDL $format, $row[$l][$c];    
    }
    print FILE_HNDL"\n";
}


print FILE_HNDL "\nSum:\n";
my $sum = 0;
for my $i (0..$#row) {
    for my $y (0..$#row) {
    $sum += $row[$y][$i];
    }
    printf FILE_HNDL $format, $sum;
    $sum = 0;
}
print FILE_HNDL "\n";

close(FILE_HNDL);

open (FILE, "random.txt") or die ("Can not open the file!\n");
print <FILE>;
close (FILE);
