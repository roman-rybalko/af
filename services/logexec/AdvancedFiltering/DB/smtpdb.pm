package AdvancedFiltering::DB::smtpdb;

use strict;
use warnings;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(add_message delete_message);

use AdvancedFiltering::LDAP qw(add_ldap_object delete_ldap_object);

sub add_message
{
	my %params = @_;
	die "USAGE: AdvancedFiltering::DB::smtpdb::add_message<realm => ...><mid => ...><sender => ...>[spam_descr => ...]" unless defined(%params{realm}) && defined($params{mid}) && defined(%params{sender});
	return add_ldap_object("afUSMTPMessageId=$params{mid},afUServiceName=smtpdb+afUServiceRealm=$params{realm},ou=user,o=advancedfiltering",
		{objectClass => 'afUSMTPMessageIncoming', afUSMTPMessageSenderMailAddress => $params{sender}, afUSMTPMessageTimeCreated => time,
		defined($params{spam_descr}) ? (afUSMTPMessageSpamDescription => $params{spam_descr}) : (), });
}

sub delete_message
{
	my %params = @_;
	die "USAGE: AdvancedFiltering::DB::smtpdb::delete_message<realm => ...><mid => ...>" unless defined(%params{realm}) && defined($params{mid});
	return delete_ldap_object("afUSMTPMessageId=$params{realm},afUServiceName=smtpdb+afUServiceRealm=$params{mid},ou=user,o=advancedfiltering");
}

1;
