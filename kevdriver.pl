#!/usr/bin/env perl
# kevdriver.pl
# by Kevin Ersoy
# connect_IP_Port returns a socket
# write_Socket_Text returns 1
# read_Socket returns an array of text lines
# disconnect_Socket returns 1
use strict;
use warnings;

use IO::Socket::INET;
use IO::Select;

$| = 1;

sub connect_IP_Port {
	my ($socket);
	$socket = new IO::Socket::INET (
	PeerHost => $_[0],
	PeerPort => $_[1],
	Proto => 'tcp',
	Timeout => 1,
	) or die "ERROR in Socket Creation : $!\n";
	return $socket;
}

sub write_Socket_Text {
	my $socket=$_[0];
	print $socket $_[1];
	return 1;
}

sub read_Socket {
	my @lines;
	my $i=0;
	my $socket=$_[0];
	my $sel;
	my @ready;
	$sel = new IO::Select ( $socket );
	while ( @ready = $sel -> can_read(1)) {
		$lines[$i] = <$socket>;
		$i++;
	}
	return @lines;
}

1;
