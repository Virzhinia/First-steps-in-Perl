#!/usr/bin/perl
use feature "switch";
no warnings 'experimental::smartmatch';

print "open files..\n";
print "Enter the range of the calculations (first number and the end):\n";
chomp(my $begin = <STDIN>);
chomp(my $end = <STDIN>);

my @strings = ("by 2", "by 3", "by 5", "by 7");
my ($by_2_ref, $by_3_ref, $by_5_ref, $by_7_ref) = get_arrays($begin, $end);
my @two = @$by_2_ref;
my @three = @$by_3_ref;
my @five = @$by_5_ref;
my @seven =@$by_7_ref;

open ( FILE_HNDL, ">nums_in_columns.txt");
print_in_columns();
close (FILE_HNDL);

sub get_arrays {
    my (@arr2, @arr3, @arr5, @arr7);
    my @numbers = ($begin.. $end);

    foreach $num (@numbers) {
        given ($num) {
            when ( $num % 2 == 0) { push @arr2, $num; continue }
            when ( $num % 3 == 0) { push @arr3, $num; continue }
            when ( $num % 5 == 0) { push @arr5, $num; continue }
            when ( $num % 7 == 0) { push @arr7, $num; continue }
        }
    }    
    return (\@arr2, \@arr3, \@arr5, \@arr7);
}

sub print_in_columns {
    printf FILE_HNDL ("%s\t" x @strings . "\n", @strings);

    my $format = "%-2d\t";

    for my $i (0..$#two) {

        printf FILE_HNDL ($format, $two[$i]);
        if ($i <= $#three) {
            printf FILE_HNDL ($format, @three[$i]);
        }
        if ($i <= $#five) {
            printf FILE_HNDL ($format, @five[$i]);
        }
        if ($i <= $#seven) {
            printf FILE_HNDL ($format, @seven[$i]);
        }
        print FILE_HNDL ("\n");
    }
}

my $in_file = "nums_in_columns.txt";
my $out_file = "nums_in_rotate.txt";

open (IN, "<$in_file") or die "Can't open $in_file:\n";
open (OUT, ">$out_file") or die "Can't open $out_file:\n";

while (chomp ( my $line = <IN>)) {
    @fields = split /\t/, $line;
    (@fields[1], @fields[3]) = (@fields[3], @fields[1]);
    $line = join "\t\t", @fields; 

    print OUT $line;
    print OUT "\n\n";
}

close IN;
close OUT;

open (TEST, "<$out_file") or die "Can't open $out_file:\n";
while ( <TEST> ) {
        print;
}
close TEST;
