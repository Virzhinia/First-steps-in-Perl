#!/usr/bin/perl

use strict;
use warnings;
use Math::BigFloat;


print "Enter range of the numbers, number of the columns and number of the lines:\n";
chomp(my $minimum_range = <STDIN>);
chomp(my $maximum_range = <STDIN>);
chomp(my $end_column = <STDIN>);
chomp(my $line = <STDIN>);

my(@row, $sum, @sum_arr);

for my $l ( 0..( $line - 1) ) {
    for my $c ( 0.. ( $end_column -1) ) {
        my $rand = Math::BigFloat -> new ($minimum_range + rand($maximum_range - $minimum_range));
        my $round_num = $rand -> bfround('-2');
        $row[$l][$c] = $round_num; 
    }
}

for my $s ( 0..$end_column -1 ) {
    for my $j ( 0.. ($#row) ) {
        $sum += $row[$j][$s];
    }
    push @sum_arr, $sum;
    $sum = 0;
}

open (FILE_HNDL, ">www_random_table.html");

header();
print FILE_HNDL body();
print FILE_HNDL footer();
close FILE_HNDL;

sub header {

    open ( HEADER, "header_html.html" ) or die "Can not open the file!";
    return print FILE_HNDL <HEADER>;
}

sub body {
    
    my $body = qq{
<body>
<CENTER><img src = "numbers.png" height = "200" width = "200" />
<h1><font color = "blue"> Table of random numbers</font></h1>
<br>
<h3><ul>\n<li> Range of the numbers: $minimum_range - $maximum_range</li>\n<br>\n<li>Number of the lines: $line</li>\n<br>\n<li>Number of the columns: $end_column</li>\n</ul></h3>
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
