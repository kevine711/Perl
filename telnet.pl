#!/usr/bin/env perl
# telnet.pl
# by Kevin Ersoy
# takes 2 arguments.  0 = terminal server IP or hostname.  1 = port to clear
use strict;
use warnings;

use NET::Telnet;
unless ($#ARGV != 1){
	print $#ARGV + 1," arguments received\n";
	print "clearing line $ARGV[1] on $ARGV[0]\n";
	# flush after every write
	$| = 1;

	my  $t;
	my $line;
	# creating object interface of IO::Socket::INET modules which internally creates 
	# socket, binds and connects to the TCP server running on the specific port.
	$t = new Net::Telnet (Timeout  => 1,Errmode=>'return');
    $t->open("$ARGV[0]");
	## Wait for first prompt and enter password.
    $t->waitfor('/Password:.*/');
	
    $t->print("cisco\n");
	$t->print("enable\n");
	$t->print("cisco\n");
	$t->print("clear line $ARGV[1]\n");
	
	while ($line = $t -> getline) {
        print "$line\n";
	}
	#sleep (1);
	$t->close();
} else {
	print "Error\; Expected 2 arguments, received ", $#ARGV + 1, " arguments";
}