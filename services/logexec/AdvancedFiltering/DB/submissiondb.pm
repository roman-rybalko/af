package AdvancedFiltering::DB::submissiondb;

use strict;
use warnings;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(add_message delete_message);

use AdvancedFiltering::LDAP qw(add_ldap_object delete_ldap_object);

sub add_message
{
	my $realm = shift;
	my $mid = shift;
	my $sender = shift;
	die "USAGE: AdvancedFiltering::DB::submissiondb::add_message<realm><mid><sender>" unless defined($realm) && defined($mid) && defined($sender);
	return add_ldap_object("afUSMTPMessageId=$mid,afUServiceName=submissiondb+afUServiceRealm=$realm,ou=user,o=advancedfiltering",
		{objectClass => 'afUSMTPMessageOutgoing', afUSMTPMessageSenderMailAddress => $sender, afUSMTPMessageTimeCreated => time});
}

sub delete_message
{
	my $realm = shift;
	my $mid = shift;
	die "USAGE: AdvancedFiltering::DB::submissiondb::delete_message<realm><mid>" unless defined($realm) && defined($mid);
	return delete_ldap_object("afUSMTPMessageId=$mid,afUServiceName=submissiondb+afUServiceRealm=$realm,ou=user,o=advancedfiltering");
}

1;
