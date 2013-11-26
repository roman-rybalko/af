#!/usr/bin/perl

use strict;
use warnings;

use Getopt::Std;
use Mail::SpamAssassin;
use Net::LDAP;
use Fcntl qw(:flock);
use Data::Dumper;
use MIME::Base64;

my %opts;
sub parse_opts
{
	getopts('hc:s:u:U:D:W:C:K:A:m:lx:d:v:', \%opts);
	if ($opts{h})
	{
		print "USAGE: $0 [options]\n",
			"OPTIONS:\n",
			"\t-h\tThis help screen\n",
			"\t-c dir\tConfig/Rules directory (cf)\n",
			"\t-s dir\tSite Config/Rules deirectory (cf-site)\n",
			"\t-u dir\tUpdates/State directory (db)\n",
			"\t-U URI\tLDAP server URI\n",
			"\t-D DN\tLDAP bind DN\n",
			"\t-W pw\tLDAP bind password\n",
			"\t-C cert\t\tLDAP STARTTLS certificate file\n",
			"\t-K key\t\tLDAP STARTTLS key file\n",
			"\t-A ca\t\tLDAP STARTTLS CA path\n",
			"\t-m dir\tMIME directory\n",
			"\t-l\tLocal tests only\n",
			"\t-x cnt\tCheck cnt mimes then exit\n",
			"\t-d opt\tDebugging options for SA\n",
			"\t-v level\tLog verbosity level",
			"";
		exit 0;
	}
	die "-c -s -u -U -x -m options are required" unless $opts{c} && $opts{s} && $opts{u} && $opts{U} && $opts{x} && $opts{m};
	$opts{v} = 0 unless $opts{v};
}

my $ldap;
sub reconnect_ldap
{
	$ldap = Net::LDAP->new($opts{U}) or die "LDAP connection error";
	
	if ($opts{C})
	{
		die '-K option is required' unless $opts{K};
		my @options = (
			clientcert => $opts{C},
			clientkey => $opts{K},
			);
		if ($opts{A})
		{
			push @options =>
				verify => 'require',
				capath => $opts{A},
				checkcrl => 1;
		}
		my $ldap_msg = $ldap->start_tls(@options);
		die "start_tls: " . $ldap_msg->error_text if $ldap_msg->is_error;
	}
	
	if ($opts{D})
	{
		die "-W option is required" unless $opts{W};
		my $ldap_msg = $ldap->bind($opts{D}, password => $opts{W});
		die "bind: " . $ldap_msg->error_text if $ldap_msg->is_error;
	}
}

my $sa;
sub reload_sa
{
	$sa->finish if $sa;
	$sa = Mail::SpamAssassin->new(
		{
			rules_filename => $opts{c},
			site_rules_filename => $opts{s},
			userstate_dir => $opts{u},
			require_rules => 1,
			local_tests_only => $opts{l} ? 1 : 0,
			dont_copy_prefs => 1,
			debug => $opts{d},
		}
	);
}

my ($rules_mtime, $site_rules_mtime, $bayes_mtime) = (-1,-1,-1);
sub rules_updated
{
	my $sa_bayes = $opts{u}."/bayes_seen";
	if (
		(stat($opts{c}))[9] != $rules_mtime
		|| (stat($opts{s}))[9] != $site_rules_mtime
		|| (stat($sa_bayes))[9] != $bayes_mtime
	)
	{
		warn "Base updated" if $opts{v} > 0;
		$rules_mtime = (stat($opts{c}))[9];
		$site_rules_mtime = (stat($opts{s}))[9];
		$bayes_mtime = (stat($sa_bayes))[9];
		return 1;
	}
	return 0;
}

sub parse_mime_file
{
	my $file_name = shift;
	my $F;
	open $F, "<", $file_name or die "Unable to open file $file_name";
	my $mime = $sa->parse($F);
	return $mime;
}

sub finish_mime
{
	my $mime = shift;
	$mime->finish;
}

sub check_mime
{
	my $mime = shift;
	my $sa_status = $sa->check($mime);
	my $result = {spam => $sa_status->is_spam, report => $sa_status->get_report};
	$sa_status->finish;
	return $result;
}

sub get_mime_id
{
	my $mime = shift;
	my $hdr = $mime->get_pristine_header("message-id");
	return undef unless $hdr;
	$hdr =~ s/^\s+//;
	$hdr =~ s/\s+$//;
	$hdr =~ s/^[^<]*<//;
	$hdr =~ s/>[^>]*$//;
	$hdr = encode_base64($hdr, '');
	$hdr =~ tr~/\+=~\.\-_~;
	return $hdr;
}

sub get_mime_creds
{
	my $mime = shift;
	my $sender = $mime->get_pristine_header("x-advancedfiltering-sender");
	my $realms = $mime->get_pristine_header("x-advancedfiltering-realms");
	my $mid = get_mime_id($mime);
	unless ($sender && $realms && $mid)
	{
		$mid = "Message-Id:unknown" unless $mid;
		warn "Message $mid has no credentials (Message-Id,X-AdvancedFiltering-Sender,X-AdvancedFiltering-Realms)" if $opts{v} > 0;
		return undef;
	}
	my @realms = split /\s+/, $realms;
	return {sender => $sender, realm => $realms[0], mid => get_mime_id($mime)};
}

sub store_check_result
{
	my $mime_creds = shift;
	my $mime_result = shift;
	my @attr = (
		objectClass => 'afUSMTPMessageIncoming',
		afUSMTPMessageId => $mime_creds->{mid},
		afUSMTPMessageSenderMailAddress => $mime_creds->{sender},
		afUSMTPMessageTimeCreated => time,
	);
	push @attr => afUSMTPMessageSpamDescription => $mime_result->{report} if $mime_result->{spam};
	my $base = "afUSMTPMessageId=$mime_creds->{mid},afUServiceRealm=$mime_creds->{realm}+afUServiceName=smtpdb,ou=user,o=advancedfiltering";
	my $ldap_msg = $ldap->add($base, attr => [@attr]);
	if ($ldap_msg->is_error)
	{
		my $last_error_text = $ldap_msg->error_text;
		$ldap_msg = $ldap->search(
			filter => '(objectClass=*)',
			base => $base,
			scope => 'base',
			attrs => ['dn']);
		die "LDAP(" . Dumper({base => $base, attr => {@attr}}) . ") Error: " . $ldap_msg->error_text . " ($last_error_text)" if $ldap_msg->is_error;
		warn "Message $mime_creds->{mid} already checked" if $opts{v} > 1;
	}
}

sub get_file_names
{
	my $dir = shift;
	my $D;
	opendir $D, $dir or die "Unable to open dir $dir";
	my @file_names = readdir $D;
	for(my $i = 0; $i <= $#file_names; ++$i)
	{
		if ($file_names[$i] eq "." || $file_names[$i] eq "..")
		{
			splice @file_names, $i, 1;
			--$i;
			next;
		}
		$file_names[$i] = $dir . "/" . $file_names[$i];
	}
	return @file_names;
}

######################################################################

parse_opts;
reconnect_ldap;

my $mime_cnt = $opts{x};
while($mime_cnt > 0)
{
	my @file_names = get_file_names($opts{m});
	unless (@file_names)
	{
		sleep 1;
		next;
	}
	foreach my $file_name (@file_names)
	{
		my $L;
		open $L, ">>", $file_name or next;
		#flock $L, LOCK_EX|LOCK_NB or next;
		unless (flock $L, LOCK_EX|LOCK_NB)
		{
			warn "File $file_name is locked" if $opts{v} > 1;
			next;
		}
		reload_sa if rules_updated;
		my $mime = parse_mime_file($file_name);
		my $creds = get_mime_creds($mime);
		store_check_result($creds, check_mime($mime)) if $creds;
		finish_mime($mime);
		unlink $file_name;
		--$mime_cnt;
		last if $mime_cnt <= 0;
	}
}
