#!/usr/bin/perl

use 5.010;
use strict;
use warnings;
use feature "switch";

print "Hello World!\n";












This is a
bunch of information 
on multiple lines
END




my $second = 2;






say "5 - 4 = ", 5 - 4;
say "5 * 4 = ", 5 * 4;
say "5 / 4 = ", 5 / 4;
say "5 % 4 = ", 5 % 4;
say "5 ** 4 = ", 5 ** 4;

my $rand_num = 5;
$rand_num +=1;
say "Number Incremented ", $rand_num;

say "++6 = ", ++$rand_num;
say "6-- = ", $rand_num--;
say "--6 = ", --$rand_num;

say "3 + 2 * 5 = ", 3 + 2 *5;
say "( 3 + 2 ) * 5 = ", (3 + 2) * 5;

my $ageTwo =80;
my $is_not_intoxicated = 1;
my $age_last_exam = 16;


	say "You can't drive";
	}elsif(!$is_not_intoxicated){
		say "You can't drive";
	}else {
		say "You can drive";
	}
	
if (($ageTwo>=1) && ($ageTwo <16)){
	say "You can't drive";
}	elsif(!$is_not_intoxicated){
	say "You can't drive";
}elsif (($ageTwo>=80) && (($ageTwo>100) || 
(($ageTwo - $age_last_exam)>5))){
	say "You can't drive";
}else{
	say"You can drive";
	}

	say "a equals b";
}else{
	say "a doesn't equal b";
}


unless (!$is_not_intoxicated){
	say"Get Sober";
}


say (($age>18)? "Can Vote" : "Can't Vote");


	say $i;
}





	if ($i % 2 == 0){
		$i++;
		
		
}


say $i;
$i++;

}



my $guess;


	say "Guess a Number between 1 to 10";
	
	
} while $guess != $lucky_num;



my $age_old =18;


	when ($_>16){
		say "Drive";
		continue;
	}
	when ($_>17) {say "Go Vote";}
	default {say "Nothing Special";}
}



say "Length of String ", length $long_string;

$long_string, "Long");

$long_string, "g");

$long_string = $long_string.' isn\'t that long';



my $animal = "animals";



my $two_times ="What I said is " x 2;
say $two_times;

my @abcs =('a' .. 'z');
print join(", ", @abcs), "\n";
say "Next Letter ", ++$letter;