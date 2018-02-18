#!/usr/bin/perl

my @array = ( [1, 2, 3], [4, 5, 6], [7, 8, 9]);

my $top_left = $array[0][0];
my $bottom_right = $array[2][2];

print "@$_\n" for @array;

my @row1 = qw(71 22 15 10 51);
my @row2 = qw(91 82 28 11 91);
my @row3 = qw(11 72 37 58 20);
my @row4 = qw(21 42 63 24 16);
my @row5 = qw(81 32 53 54 42);
my @array_2d = (\@row1, \@row2, \@row3, \@row4, \@row5);

print "Print Using Array Index\n";
for(my $i = 0; $i <= $#array_2d; $i++){
    for(my $j = 0; $j <= $#array_2d ; $j++){
        print "$array_2d[$i][$j] ";
    }
    print "\n";
}

print "Print Using ForEach\n";
foreach my $row(@array_2d){
    foreach my $val(@$row){
        print "$val ";
    }
    print "\n";
}

print "Sort Each Row\n";
foreach my $row(@array_2d){
    foreach my $val(sort(@$row)){
        print "$val ";
    }
    print "\n";
}

print "Reverse Each Row\n";
foreach my $row(@array_2d){
    foreach my $val(reverse(@$row)){
        print "$val ";
    }
    print "\n";
}

print "Sort Then Reverse Each Row\n";
foreach my $row(@array_2d){
    foreach my $val(reverse(sort(@$row))){
        print "$val ";
    }
    print "\n";
}

print "To sort arr  by the first element in each list, I would write: \n";
for my $list_ref ( sort { $a->[0] <=> $b->[0] } @array_2d ) {
        print " @$list_ref \n";
} 

my @array=([1,2,3],[4,5,6],[7,8,9]);
my $array_ref = \@array;

my $array_r = increase_array_element($array_ref);
my @array_r_r = @{$array_r};
print $array_r_r[1][1], "\n";

sub increase_array_element {
    my @array_tmp = @{$array_ref};
    print $array_tmp[2][2], "\n";
    return \@array_tmp;
}
