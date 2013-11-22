#!/usr/bin/perl

use strict;
use warnings;

use Getopt::Std;
use Storable qw(lock_store lock_retrieve);
use Fcntl qw(SEEK_SET);

my %opts;
sub parse_opts
{
	getopts('hl:b:s:t:v:', \%opts);
	if ($opts{h})
	{
		print "USAGE: $0 [options]\n",
			"OPTIONS:\n",
			"\t-h\tThis help screen\n",
			"\t-l logfile\tLog file\n",
			"\t-b logfile\tBackup Log file\n",
			"\t-s statefile\tState file\n",
			"\t-t taskdir\tTask files directory\n",
			"\t-v level\tLog verbosity level\n",
			"";
		exit 0;
	}
	die "-l -b -s -t options are required" unless $opts{l} && $opts{b} && $opts{s} && $opts{t};
	$opts{v} = 0 unless $opts{v};
}

sub load_state
{
	my $state;
	eval {
		$state = lock_retrieve($opts{s});
	};
	$state = {} unless $state;
	return $state;
}

sub save_state
{
	my $state = shift;
	lock_store $state, $opts{s};
}

sub create_taskfile
{
	my $mailbox = shift;
	my $domain = shift;
	my $client = shift;
	my $realm = shift;
	
	my $fpath = "$opts{t}/$realm-$client-$domain-$mailbox";
	
	my $data = {
		mailbox => $mailbox,
		domain => $domain,
		client => $client,
		realm => $realm,
	};
	
	lock_store $data, $fpath;
}

sub process_log
{
	my $state = shift;
	my $F;
	my $fpath = $opts{l};
	if ($state->{ofs}->{$opts{l}})
	{
		if (-s $opts{l} < $state->{ofs}->{$opts{l}})
		{
			warn "Log rotation $fpath -> $opts{b}" if $opts{v};
			$fpath = $opts{b};
		}
	}
	open $F, "<", $fpath or die "Unable to open log file $fpath for reading";
	seek $F, $state->{ofs}->{$opts{l}}, SEEK_SET if $state->{ofs}->{$opts{l}};
	while (<$F>)
	{
		create_taskfile($1, $2, $3, $4) if /AdvancedFiltering:NewMailBox:<([^>]+)>Domain:<([^>]+)>Client:<([^>]+)>Realm:<([^>]+)>/;
	}
	$state->{ofs}->{$opts{l}} = $fpath eq $opts{l} ? tell $F : 0;
}

######################################################################

parse_opts;

my $state = load_state;
process_log($state);
save_state($state);
