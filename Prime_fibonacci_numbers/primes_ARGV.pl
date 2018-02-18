#!/usr/bin/perl
my ($first_num, $second_num);

open ( FILE, ">prime_file.txt");

#my $numbers_type = $ARGV[0];

#if ($numbers_type == "primes") {

$first_num = is_number_argv();
print FILE "The first number in the range is: $first_num\n";
#$first_num = is_number_str();

$second_num = is_number_argv();
print FILE "The second number in the range is: $second_num\n";
#$second_num = is_number_str();

if ($first_num > $second_num) {
    my $temp = $first_num;
    $first_num = $second_num;
    $second_num = $temp;
}

my $primes_ar = get_primes($first_num, $second_num);
print_primes ($primes_ar);
close (FILE);

sub is_number_argv {
    my $input = shift @ARGV;
    if ($input =~ /\D/) {
       return die "The input line is not a real number!\nThe program cannot calculate the prime numbers in the range!\n";
    }
    else {
        return $input;
    }
}

#sub is_number_str {
#    chomp(my $input = <STDIN>);
#    while ($input =~ /\D/) {
#        print "This is not a real number! Please enter again:\n";
#        chomp($input = <STDIN>);
#    }
#    return $input;
#}

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

#sub is_prime {
#    my $i = shift;
#
#    for my $j (2..($i - 1)) {
#        if ($i % $j == 0) {
#            return 0;
#        }
#    }
#
#    return 1;
#}

sub print_primes {
    
    print FILE "The prime numbers are:\n";

    my @primes_def = @$primes_ar;

    foreach $_ (@primes_def) {
        print FILE "$_\n";
    }
}
