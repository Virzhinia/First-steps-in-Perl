#!/usr/bin/perl
use feature "switch";
no warnings 'experimental::smartmatch';

my $secret_num = int (1 + rand 100);

#    print "The secret number is $secret_num.\n";

LOOP: {
          print "Please enter a quess from 1 to 100: ";
          chomp(my $guess = <STDIN>);

          my $found_it = 0;

          given ( $guess ) {
              when ($_ ~~ /quit|exit|^\s*$/i) { print "Sorry, you gave up. The secret number was $secret_num.\n"; $found_it++;}
              when ( ! /^\d+$/ ) { print "This is not a number!\n"; }
              when ( $_ > $secret_num) { print "Too high!\n"; }
              when ( $_ < $secret_num) { print "Too low!\n"; }
              default { print "Just right!\n"; $found_it++; }
          }

          if ($found_it) {
              last LOOP;
          } else {
              redo LOOP;
          }

      }
