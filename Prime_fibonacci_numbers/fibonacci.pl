#!/usr/bin/perl

my ($first_num, $second_num, $end, @fib_arr);

print "Enter the range (first, second, end) of fibonnaci numbers:\n";
chomp($first_num = <STDIN>);
chomp($second_num = <STDIN>);
chomp($end = <STDIN>);

$fib_arr[0] = 0;
$fib_arr[1] = 1;

for my $i (2.. $end) {
    $fib_arr[$i] = $fib_arr[$i - 2] + $fib_arr[$i -1];
    if ($fib_arr[$i] > $end) {
        last;
    }
}

print "@fib_arr\n";

foreach $item (@fib_arr) {
    if ($item >= $first_num) {
        print "$item ";
    }
}

