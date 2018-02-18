#!/usr/bin/perl
my ($first_num, $seecond_num, $end, $range_ar);
open ( FILE, ">prime_fib_file.txt");

my $numbers_type = shift @ARGV;

$first_num = is_number_argv();
$second_num = is_number_argv();

if ($first_num > $second_num) {
    my $temp = $first_num;
    $first_num = $second_num;
    $second_num = $temp;
}

print FILE "The first number in the range is: $first_num\n";
print FILE "The end of the range is: $second_num\n";

if ($numbers_type =~ /primes/) {
    print FILE "The prime numbers are:\n";
    $range_ar = get_primes($first_num, $second_num);
} elsif ($numbers_type =~ /fibonacci/) {
    print FILE "The Fibonacci numbers are:\n";
    $range_ar = get_fibonacci($first_num, $second_num, $end);
} else {
    die "The program doesn't recognise the numbers type!";
}
print_primes ($range_ar);
close (FILE);

sub is_number_argv {
    my $input = shift @ARGV;
    if ($input =~ /\D/) {
        return die "The input line is not a real number!\nThe program cannot calculate the numbers in the range!\n";
    }
    else {
        return $input;
    }
}

sub get_primes {
    my @list = ($first_num..$second_num);
    my @primes;

    for my $i (@list) {
        my $prime_condition = 1;
        if ($i == 0 || $i == 1) {
            $prime_condition = 0;
        }
        for my $j (2..($i - 1)) {
            if ( $i % $j == 0 ) {
                $prime_condition = 0;
                last;
            }
        }
        if ($prime_condition) {
            push @primes, $i;
        }
    }
    return \@primes;
}


sub get_fibonacci {
    my @fib_arr;
    $fib_arr[0] = 0;
    $fib_arr[1] = 1;

    for my $i (2..$second_num) {
        $fib_arr[$i] = $fib_arr[$i - 2] + $fib_arr[$i - 1];
        if ($fib_arr[$i] > $second_num) {
            last;
        }
    }
    my @fib_slice;
    foreach $item (@fib_arr) {
        if ($item >= $first_num && $item <= $second_num) {
            push (@fib_slice, $item);
        }
    }
    return \@fib_slice;
}


sub print_primes {

    my @primes_def = @$range_ar;

    foreach $_ (@primes_def) {
        print FILE "$_\n";
    }
}

