#!/usr/bin/perl -w
use strict;
use warnings;
use DBI;
use Math::BigFloat;
use Proc::Queue size => 10;
use POSIX ":sys_wait_h";

my $dbh = dbh_connect();
create_table_operations($dbh);

my @operation_arr = (   "Electricity bills",  
        "Sending cash from abroad" , 
        "Utility bills payments" , 
        "Mass payments" , 
        "Telephone bills" , 
        "Transfer to bank account" , 
        "Mortgage" , 
        "Buy tickets for different events" , 
        "Local taxes and fees" );

$SIG{CHLD} = \&reap_kids;
my %kids;

for my $operation_num ( 1.. 1090) {
    my $rand_arr = int(rand($#operation_arr + 1));
    my $current_operation = $operation_arr[$rand_arr];
    my $rand_amount = Math::BigFloat -> new (rand(1000));
    my $round_amount = $rand_amount-> bfround('-2');
    my $rand_fee = Math::BigFloat -> new (rand(100));
    my $round_fee = $rand_fee -> bfround('-2');
    my $total = $rand_amount + $rand_fee;
    my $cashier_id = int(rand(5)) + 1;
    my %hash_operations = ("current_operation" => $current_operation, "cashier_id" => $cashier_id, "amount" => $round_amount, "fee" => $round_fee, "total" => $total );

    insert_operations(\%hash_operations); 

    if ($operation_num % 100 == 0) {
        $dbh->commit();

        my $pid = fork();
        die if not defined $pid;

        if ( $pid ) {
            $kids{$pid} = 1;
            while( scalar(keys %kids) > 0 ) {
                sleep 1;
            }
        } 
        else {
            my $dbh_child = dbh_connect();
            $dbh_child->do(qq{UPDATE CASHIERS SET BALANCE = (SELECT OPERATIONS.TOTAL FROM OPERATIONS 
                        WHERE OPERATIONS.CASHIER = CASHIERS.ROWID), BALANCE = (SELECT SUM(TOTAL) FROM OPERATIONS WHERE CASHIER = CASHIERS.ROWID);});
            $dbh_child->commit();
            $dbh_child->disconnect();
            exit(0);
        }
    }
} 

$dbh->commit();
$dbh->do(qq{UPDATE CASHIERS SET BALANCE = (SELECT OPERATIONS.TOTAL FROM OPERATIONS 
            WHERE OPERATIONS.CASHIER = CASHIERS.ROWID), BALANCE = (SELECT SUM(TOTAL) FROM OPERATIONS WHERE CASHIER = CASHIERS.ROWID);});
$dbh->commit();

create_html();

$dbh->disconnect();

#------- Functions------>

sub dbh_connect {

    my $driver   = "SQLite";
    my $database = "bills.db";
    my $dsn = "DBI:$driver:dbname = $database";
    my ($userid, $password) = get_usr_pass();
    my $dbh = DBI->connect($dsn, $userid, $password, { AutoCommit => 0, RaiseError => 1 })
        or die $DBI::errstr;
}

sub get_usr_pass {
    my ($userid, $password);
    open(CONFIG, "config_file.txt") or die "Can not open the configuration file!";
    while (chomp ( my $conf_line = <CONFIG>)) {
        my @fields = split /\s=\s/, $conf_line;
        if ($fields[0] eq "DB_user") {
            $userid = $fields[1];
        }
        if ($fields[0] eq "DB_password") {
            $password = $fields[1];
        }
    }
    close CONFIG;
    return $userid, $password;
}

sub create_table_operations {

    $dbh->do("DROP TABLE IF EXISTS OPERATIONS;");
    $dbh->do("UPDATE CASHIERS SET BALANCE = 0;");

    my $stmt = qq(CREATE TABLE OPERATIONS
            (OPERATIONS_TYPE        TEXT      NOT NULL,
             CASHIER    TEXT     NOT NULL,
             AMOUNT      REAL     NOT NULL,
             FEE         REAL     NOT NULL,
             TOTAL       REAL     NOT NULL););

    $dbh->do($stmt);
}

sub insert_operations {

    my $hash_values = shift;

    $dbh->do('INSERT INTO OPERATIONS (OPERATIONS_TYPE, CASHIER, AMOUNT, FEE, TOTAL) VALUES (?, ?, ?, ?, ?)',
            undef,  ${ $hash_values }{ "current_operation" }, ${ $hash_values }{ "cashier_id" },${ $hash_values }{ "amount" }, ${ $hash_values }{ "fee" }, ${ $hash_values }{ "total" });
}

sub reap_kids {
    while (1) {
        my $kid = waitpid( -1, POSIX->WNOHANG );
        last unless ($kid > 0); 
        delete $kids{$kid}; 
    }
}

sub create_html {
    open (FILE_HNDL, ">bills.html");
    print FILE_HNDL header();
    print FILE_HNDL body();
    print FILE_HNDL footer();
    close FILE_HNDL;
}

sub header {

    open ( HEADER, "header_bills.html" ) or die "Can not open the file!";
    return <HEADER>;
    close HEADER;
}


sub body {

    my $body = qq{
        <body>
            <CENTER><img src = "http://www.krem.com/img/resize/content.krem.com/photo/2017/01/05/bill_1483630092063_7538658_ver1.0.PNG?preset=534-401" height = "200" width = "350" /><br></br>\n};
    $body .= qq{<div class="navbar">\n<a href="#home">Home</a>\n<a href="https://www.google.bg/" target="_blank">BillsCheck</a>\n<div class="dropdown">\n<button class="dropbtn">Operations\n</button>\n<div class="dropdown-content">\n};


    for my $operation (0..$#operation_arr) {
        $body .= qq{<a href="#">$operation_arr[$operation]</a>\n};
    }
    $body .= qq{</div>\n</div>\n</div>\n};

    $body.= qq{<h1><font color = "#0052cc"> Tables of bills operations for last month</font></h1>\n</CENTER><br>\n};

#-----Table of operations order by count of the type

    $body .= qq{<h3><ul>\n<li>Table of operations order by count of the type</li>\n</ul>\n</h3><br>\n};

    my @columns = ( "COUNT", "OPERATIONS TYPE", "AMOUNT", "FEE", "TOTAL" );

    $body .= qq{<table><tr>\n};
    for my $col (0..$#columns) {
        $body .= qq{<th>$columns[$col]</th>\n};

    }
    $body .= qq{</tr>\n};

    my $stmt_all_operations = qq(SELECT COUNT(OPERATIONS_TYPE) AS COUNT, OPERATIONS_TYPE, printf("%.2f",SUM(AMOUNT)) AS TotalSums, printf("%.2f",SUM(FEE)) AS TotalFee, printf("%.2f",SUM(TOTAL)) AS TotalTOTALS 
            FROM OPERATIONS GROUP BY (OPERATIONS_TYPE) ORDER BY COUNT(OPERATIONS_TYPE) DESC;);
    my $all_operations = $dbh->prepare( $stmt_all_operations );
    $all_operations->execute() or die $DBI::errstr;

    my $finally_sum;

    while(my @row = $all_operations->fetchrow_array()) {
        $body .= qq{<tr>\n};
        for my $sel (0..$#row) {
            $body .= qq{<td width= "300" align="center"> $row[$sel] </td>\n}; 
        }
        $body .= qq{</tr>\n};
        $finally_sum +=$row[$#row];
    }

    $body .= qq{<tr>\n<th></th>\n<th></th>\n<th></th>\n<th>TOTAL MONEY:</th>\n<th>$finally_sum</th>\n</tr></table>\n};

    $body .= qq{<br></br>\n};


#---- Table of cashier order by count of operations

    $body .= qq{<h3><ul>\n<li>Table of cashiers order by count of operations</li>\n</ul></h3><br>\n<table>\n<tr>\n};

    my @operations_cashiers = ("COUNT OF OPERATIONS", "CASHIER NAME", "AMOUNT BY CASHIER", "FEE BY CASHIER", "TOTAL BY CASHIER" );
    for my $col (0..$#operations_cashiers) {
        $body .= qq{<th>$operations_cashiers[$col]</th>\n};
    }

    $body .= qq{</tr>\n};

    my $stmt_cashiers_operations = qq(SELECT  COUNT(CASHIERS.NAME) DESC,CASHIERS.NAME AS "CASHIER NAME", printf("%.2f",SUM(OPERATIONS.AMOUNT)) AS "SUM AMOUNT", printf("%.2f", SUM(OPERATIONS.FEE)) AS "SUM FEE", 
            printf("%.2f", SUM(OPERATIONS.TOTAL)) AS "SUM TOTAL" FROM OPERATIONS 
            JOIN CASHIERS WHERE OPERATIONS.CASHIER=CASHIERS.ROWID GROUP BY  CASHIERS.NAME ORDER BY COUNT(CASHIERS.NAME) DESC;);

    my $cashiers_operations = $dbh->prepare( $stmt_cashiers_operations );
    $cashiers_operations->execute() or die $DBI::errstr;

    while(my @row = $cashiers_operations->fetchrow_array()) {
        $body .= qq{<tr>\n};
        for my $sel (0..$#row) {
            $body .= qq{<td width= "300" align="center"> $row[$sel] </td>\n}; 
        }
        $body .= qq{</tr>\n};
    }

    $body .= qq{<tr>\n<th></th>\n<th></th>\n<th></th>\n<th></th>\n<th></th>\n</tr></table>\n<br></br>\n};

#-----Table of Cashiers order by their balance

    $body .= qq{<h3><ul>\n<li>Table of cashiers order by their balance</li>\n</ul></h3><br>\n<table>\n<tr>\n};

    my @cashiers = ( "CASHIER NAME", "BALANCE" );
    for my $col (0..$#cashiers) {
        $body .= qq{<th>$cashiers[$col]</th>\n};
    }

    $body .= qq{</tr>\n};

    my $stmt_cashiers = qq(SELECT NAME, PRINTF("%.2f", BALANCE) AS BALANCE FROM CASHIERS ORDER BY (BALANCE) DESC;);

    my $cashiers = $dbh->prepare( $stmt_cashiers );
    $cashiers->execute() or die $DBI::errstr;

    while(my @row = $cashiers->fetchrow_array()) {
        $body .= qq{<tr>\n};
        for my $sel (0..$#row) {
            $body .= qq{<td width= "300" align="center"> $row[$sel] </td>\n}; 
        }
        $body .= qq{</tr>\n};
    }

    $body .= qq{<tr>\n<th></th>\n<th></th>\n</tr>\n</table>\n};

    $body .= qq{<br>\n</body>\n};

    return $body;
}

sub footer {
    my $footer = qq{<br>\n<footer>1000 Sofia, Bulgaria<br>\n &copy; V. Nikolova All rights reserved.\n</footer>\n};
    $footer .= qq{</html>};
    return $footer;
}

