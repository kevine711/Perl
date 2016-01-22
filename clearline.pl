#!/usr/bin/env perl
#clearline.pl
# by Kevin Ersoy
#takes 2 arguments.  0 = terminal server IP or hostname.  1 = port to clear
use strict;
use warnings;


sub recv_packet {
	sleep(1);
    my ($sock) = @_;
    my ($header, $data);
    $sock->recv($header, 9) or die "$! receiving header";
    my ($type, $length) = unpack "H8S", $header;
    $sock->recv($data, $length) or die "$! receiving data";
    return ($type, $data);
}

use IO::Socket::INET;
use IO::Select;

unless ($#ARGV != 1){
	print $#ARGV + 1," arguments received\n";
	print "clearing line $ARGV[1] on $ARGV[0]\n";
	# flush after every write
	$| = 1;

	my ($socket,$sel);
	my $data;
	# creating object interface of IO::Socket::INET modules which internally creates 
	# socket, binds and connects to the TCP server running on the specific port.

	$socket = new IO::Socket::INET (
	PeerHost => $ARGV[0],
	PeerPort => '23',
	Proto => 'tcp',
	Timeout => 1,
	) or die "ERROR in Socket Creation : $!\n";
	$sel = new IO::Select ( $socket );
	
	print "TCP Connection Success.\n";
	# read the socket data sent by server.
	#$data = <$socket>;
	# we can also read from socket through recv()  in IO::Socket::INET
	# $socket->recv($data,1024);
	#print "Received from Server : $data\n";

	# write on the socket to server.
	#print recv_packet($socket);
	print $socket "cisco\n";
	#print "*****\n", recv_packet($socket);
	print $socket "enable\n";
	#print "enable\n",recv_packet($socket);
	print $socket "cisco\n";
	#print "*****\n",recv_packet($socket);
	print $socket "clear line $ARGV[1]\n";
	#print "clear line $ARGV[1]\n",recv_packet($socket);
	print $socket "\n";
	#print recv_packet($socket),"\n";

	my $line;
	my @ready;
	while ( @ready = $sel -> can_read(1)) {
		$line = <$socket>;
		print "$line\n";
	}

	#sleep(1);
	$socket->close();
} else {
	print "Error\; Expected 2 arguments, received ", $#ARGV + 1, " arguments";
}