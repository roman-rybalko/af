package AdvancedFiltering::SMTP;

use strict;
use warnings;
use Net::Cmd;
use IO::Socket::SSL;
use Net::SMTP;

our $VERSION = "0.1";
our @ISA = @Net::SMTP::ISA;

no strict 'refs';
foreach (keys %Net::SMTP::)
{
	next unless defined *{$Net::SMTP::{$_}}{CODE};
	*{$_} = \&{"Net::SMTP::$_"};
}
use strict;

# NON-REENTERABLE

sub init {
	@ISA = @Net::SMTP::ISA;
}

sub starttls {
	my $self = shift;
	my $r = defined($self->supports('STARTTLS', 500, ["Command unknown: 'STARTTLS"])) && $self->_STARTTLS;
	return $r unless $r;
	@ISA = ('IO::Socket::SSL', grep { $_ !~ /IO::Socket/ } @Net::SMTP::ISA);
	$r = AdvancedFiltering::SMTP->start_SSL($self, @_);
	unless ($r)
	{
		@ISA = @Net::SMTP::ISA;
		return $r;
	}
	return 1;
}

sub _STARTTLS { shift->command("STARTTLS")->response() == CMD_OK }

1;
