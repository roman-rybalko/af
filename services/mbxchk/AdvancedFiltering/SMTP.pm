package AdvancedFinltering::SMTP;

use strict;
use vars qw($VERSION @ISA);
use Net::Cmd;
use IO::Socket::SSL;

$VERSION = "0.01";
@ISA = qw(Net::SMTP);

sub starttls {
	my $self = shift;
	my $r = defined($self->supports('STARTTLS', 500, ["Command unknown: 'STARTTLS"])) && $self->_STARTTLS;
	return $r unless $r;
	
}

sub _STARTTLS { shift->command("STARTTLS")->response() == CMD_OK }
