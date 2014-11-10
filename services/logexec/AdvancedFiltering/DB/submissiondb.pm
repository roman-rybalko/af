package AdvancedFiltering::DB::submissiondb;

use strict;
use warnings;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(add_messageid);

use AdvancedFiltering::LDAP qw(add_ldap_object);

sub add_messageid
{
	my $realm = shift;
	my $mid = shift;
	my $sender = shift;
	return add_ldap_object("afUSMTPMessageId=$mid,afUServiceName=submissiondb+afUServiceRealm=$realm,ou=user,o=advancedfiltering",
		{objectClass => 'afUSMTPMessageOutgoing', afUSMTPMessageSenderMailAddress => $sender});
}

1;
