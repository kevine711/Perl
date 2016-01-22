#!/usr/bin/env perl
# testclient.pl
# by Kevin Ersoy
use strict;
use warnings;

use IO::Socket::INET;
$| = 1;
require 'C:\perl\kevdriver.pl';
my $socket = connect_IP_Port('termserv-ip',23);
write_Socket_Text($socket,"cisco\n");
write_Socket_Text($socket,"enable\n");
write_Socket_Text($socket,"cisco\n");
write_Socket_Text($socket,"clear line 3\n");
write_Socket_Text($socket,"\n");
our @read_data;
@read_data = read_Socket($socket);
for (my $i=0 ; $i < $#read_data ; $i++) {
	print $read_data[$i];
}
$socket->close();

print "done.";