#!/usr/bin/perl

use strict;
use warnings;

use Getopt::Std;
use Net::LDAP;
use Net::SMTP;
use threads;
use threads::shared;

my %opts;
sub parse_opts
{
	getopts('hU:D:W:C:K:A:l:v:', \%opts);
	if ($opts{h})
	{
		print "USAGE: $0 [options]\n",
			"OPTIONS:\n",
			"\t-h\tThis help screen\n",
			"\t-U URI\tLDAP server URI\n",
			"\t-D DN\tLDAP bind DN\n",
			"\t-W pw\tLDAP bind password\n",
			"\t-C cert\t\tLDAP STARTTLS certificate file\n",
			"\t-K key\t\tLDAP STARTTLS key file\n",
			"\t-A ca\t\tLDAP STARTTLS CA path\n",
			"\t-l logfile\tLog file\n",
			"\t-b logfile\tBackup Log file\n",
			"\t-s stngsfile\tSettings file\n",
			"\t-t thrcnt\nThreads count\n",
			"\t-v level\tLog verbosity level\n",
			"";
		exit 0;
	}
	die "-U -l -b -s options are required" unless $opts{U} && $opts{l} && $opts{b} && $opts{s};
	$opts{v} = 0 unless $opts{v};
}

my $ldap :shared;
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

sub load_settings
{
	
}

sub save_settings
{
	
}

sub get_mx_sessings
{
	
}

sub check_mailbox
{
	
}

sub update_mailbox
{
	
}

sub process_mbox
{
	my $mailbox = shift;
	my $domain = shift;
	my $client = shift;
	my $realm = shift;
	my $mx_settings = get_mx_settings($mailbox, $domain, $client, $realm);
	my $check_data = check_mailbox($mx_settings);
	update_mailbox($mailbox, $domain, $client, $realm, $check_data);
}

my @process_queue :shared;
sub process_queue_push
{
	my $data = shift;
	lock(@process_queue);
	push @process_queue => $data;
	cond_signal(@process_queue);
}
sub process_queue_pop
{
	lock(@process_queue);
	return shift @process_queue if @process_queue;
	return shift @process_queue if cond_timedwait(@process_queue, time()+1);
	return undef;
}

my $exit_flag :shared = 0;
sub thread_run
{
	while(!$exit_flag)
	{
		while (my $data = process_queue_pop)
		{
			process_mbox(@$data);
		}
	}
}
my @threads;
sub threads_start
{
	for (my $i = 0; $i < $opts{t}; ++$i)
	{
		$threads[$i] = threads->create('thread_run');
	}
}
sub threads_stop
{
	$exit_flag = 1;
	$_->join foreach @threads;
}

sub process_log
{
	my $settings = shift;
	my $F;
	my $fname = $opts{l};
	if ($settings->{ofs}->{$opts{l}})
	{
		if (-s $opts{l} < $settings->{ofs}->{$opts{l}})
		{
			warn "Log rotation $fname -> $opts{b}" if $opts{v};
			$fname = $opts{b};
		}
	}
	open $F, "<", $fname or die "Unable to open log file $fname for reading";
	if ($settings->{ofs}->{$opts{l}})
	{
		seek $F, $settings->{ofs}->{$opts{l}}, 0;
	}
	while (<$F>)
	{
		process_queue_push([$1, $2, $3, $4]) if /AdvancedFiltering:NewMailBox:<([^>]+)>Domain:<([^>]+)>Client:<([^>]+)>Realm:<([^>]+)>/;
	}
	if ($fname eq $opts{l})
	{
		$settings->{ofs}->{$opts{l}} = tell $F;
	}
	else
	{
		$settings->{ofs}->{$opts{l}} = 0;
	}
}

######################################################################

parse_opts;
reconnect_ldap;

threads_start;

my $settings = load_settings;
process_log($settings);
save_settings($settings);

threads_stop;
