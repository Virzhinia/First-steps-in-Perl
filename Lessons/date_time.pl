#!/usr/bin/perl/

open (FILE_HNDL, ">date_time.txt");
my @months = qw( Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec );
my @days = qw(Sun Mon Tue Wed Thu Fri Sat Sun);

my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime();
print FILE_HNDL "$mday $months[$mon] $days[$wday]\n\n";

my $datestring = localtime();
print FILE_HNDL "Local date and time $datestring\n\n";

my $datestring = gmtime();
print FILE_HNDL "GMT date and time $datestring\n\n";



($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime();

printf FILE_HNDL ("Time Format - HH:MM:SS - ");
printf FILE_HNDL ("%02d:%02d:%02d", $hour, $min, $sec);


my $epoc = time();

print FILE_HNDL "\n\nNumber of seconds since Jan 1, 1970 - $epoc\n\n";



my $datestring1 = localtime();
print FILE_HNDL "Current date and time $datestring1\n\n";

my $epoc1 = time();
$epoc1 = $epoc1 - 24 * 60 * 60;   # one day before of current date.

$datestring1 = localtime($epoc1);
print FILE_HNDL "Yesterday's date and time $datestring1\n\n";

close (FILE_HNDL);

open (FILE, "date_time.txt");

while (<FILE>) {
    print;
}

close(FILE);
