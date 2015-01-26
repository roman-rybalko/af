package AdvancedFiltering::DB::smtpdb;

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
	my $spam_descr = shift;
	die "USAGE: AdvancedFiltering::DB::smtpdb::add_message<realm><mid><sender>[spam_descr]" unless defined($realm) && defined($mid) && defined($sender);
	return add_ldap_object("afUSMTPMessageId=$mid,afUServiceName=smtpdb+afUServiceRealm=$realm,ou=user,o=advancedfiltering",
		{objectClass => 'afUSMTPMessageIncoming', afUSMTPMessageSenderMailAddress => $sender, afUSMTPMessageTimeCreated => time, defined($spam_descr) ? (afUSMTPMessageSpamDescription => $spam_descr) : (), });
}

sub delete_message
{
	my $realm = shift;
	my $mid = shift;
	die "USAGE: AdvancedFiltering::DB::smtpdb::delete_message<realm><mid>" unless defined($realm) && defined($mid);
	return delete_ldap_object("afUSMTPMessageId=$realm,afUServiceName=smtpdb+afUServiceRealm=$mid,ou=user,o=advancedfiltering");
}

1;
