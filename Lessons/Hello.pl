#!/usr/bin/perl

use 5.010;
use strict;
use warnings;
use feature "switch";

print "Hello World!\n";

my $name = 'Virzhiniya';

my ($age, $street) = (25, 'Stambolyski');

my $my_info = "$name lives on \"$street\"\n";

$my_info = qq{$name lives on "$street"\n};

print $my_info;

my $bunch_on_info =<<"END";
This is a
bunch of information 
on multiple lines
END

say $bunch_on_info;

my $first = 1;
my $second = 2;

($first,$second) = ($second, $first);

say"$first,$second";

say "5 +4 =", 5 + 4;
say "5 - 4 = ", 5 - 4;
say "5 * 4 = ", 5 * 4;
say "5 / 4 = ", 5 / 4;
say "5 % 4 = ", 5 % 4;
say "5 ** 4 = ", 5 ** 4;

my $rand_num = 5;
$rand_num +=1;
say "Number Incremented ", $rand_num;
say "6++ = ", $rand_num ++;
say "++6 = ", ++$rand_num;
say "6-- = ", $rand_num--;
say "--6 = ", --$rand_num;

say "3 + 2 * 5 = ", 3 + 2 *5;
say "( 3 + 2 ) * 5 = ", (3 + 2) * 5;

my $ageTwo =80;
my $is_not_intoxicated = 1;
my $age_last_exam = 16;

if($ageTwo<16){
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
if ('a' eq 'b'){
	say "a equals b";
}else{
	say "a doesn't equal b";
}


unless (!$is_not_intoxicated){
	say"Get Sober";
}


say (($age>18)? "Can Vote" : "Can't Vote");

for (my $i=0; $i <10; $i++){
	say $i;
}


my $i = 1;

while ($i<10){
	if ($i % 2 == 0){
		$i++;
		
		next;
}

if ($i == 7) {last;}
say $i;
$i++;

}

my $lucky_num = 7;

my $guess;

do {
	say "Guess a Number between 1 to 10";
	
	$guess = <STDIN>;
} while $guess != $lucky_num;

say "You Guessed 7";

my $age_old =18;

given ($age_old){
	when ($_>16){
		say "Drive";
		continue;
	}
	when ($_>17) {say "Go Vote";}
	default {say "Nothing Special";}
}

my $long_string ="Random Long String";

say "Length of String ", length $long_string;
printf ("Long is at %d \n", rindex
$long_string, "Long");
printf ("Last g is at %d \n", rindex
$long_string, "g");

$long_string = $long_string.' isn\'t that long';

say "Index 7 through 10 " , substr $long_string, 7, 4;

my $animal = "animals";

printf("Last character is %s\n", chop $animal);

my $two_times ="What I said is " x 2;
say $two_times;

my @abcs =('a' .. 'z');
print join(", ", @abcs), "\n";my $letter = 'v';
say "Next Letter ", ++$letter;
