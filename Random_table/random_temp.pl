#!/usr/bin/perl

use strict;
use warnings;


print "Enter end of the range, number of the columns and number of the lines:\n";
chomp(my $end_of_the_range = <STDIN>);
chomp(my $end_column = <STDIN>);
chomp(my $line = <STDIN>);

my(@row, $sum, @sum_arr);

for my $l(0..($line-1)) {
    for my $c (0..($end_column -1)) {
        $row[$l][$c] = int(rand($end_of_the_range + 1));
    }
}

for my $s (0..$end_column -1) {
    for my $j (0..($#row)) {
        $sum += $row[$j][$s];
    }
    push @sum_arr, $sum;
    $sum = 0;
}


open (FILE, ">random_table.html");

print FILE header();
print FILE body();
print FILE footer();
close FILE;

sub header {

    return qq{
<html>
<head>
<title>Random table</title>
<link rel="icon" href = "numbers.png" />
<link rel="stylesheet" href = "styles.css" type="text/css" mesia="screen, projection"/>
</head>};
}


sub body {
    
    my $body = qq{
<body>
<CENTER><img src = "numbers.png" height = "200" width = "200" />
<h1><font color = "blue"> Table of random numbers</font></h1>
<br>
<h3> Range of the numbers: $end_of_the_range &nbsp&nbsp&nbsp Number of the lines:$line &nbsp&nbsp&nbsp Number of the columns: $end_column</h3>
<table>
};

    $body .= qq{<tr>\n};
    for my $col (1..$end_column) {
        $body .= qq{<th>Col $col</th>\n};

    }
    $body .= qq{</tr>\n};

    for my $arr_ref ( @row ) {
        $body .= qq{<tr>\n};
        for my $el (@$arr_ref) {
            $body .= qq{<td width="80" align="center">$el</td>\n};
        }     
        $body .= qq{</tr>\n};     
    }
    
    $body .= qq{<tr>\n<th>Sum:</th>\n};
    $body .= qq{<th></th>\n} x ($end_column - 1);
    $body .= qq{</tr>\n<tr>};
    
    for my $k (0.. $end_column - 1) {
        $body .= qq{\n<td width ="80" align="center"> $sum_arr[$k]</td>};
    }
    $body .= qq{\n</tr>\n};

    $body .= qq{</table>\n</CENTER>\n</body>\n};
    
    return $body;
}

sub footer {

    return qq{</html>};
}
