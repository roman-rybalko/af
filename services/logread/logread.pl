#!/usr/bin/perl

use strict;
use warnings;

use Getopt::Std;
use Data::Dumper qw(Dumper);
use Fcntl qw(SEEK_SET);
use IPC::Open2 qw(open2);

my %opts;
sub parse_opts
{
	getopts('hl:b:s:p:r:m:v:', \%opts);
	if ($opts{h})
	{
		print "USAGE: $0 [options]\n",
			"OPTIONS:\n",
			"\t-h\tThis help screen\n",
			"\t-l logfile\tLog file\n",
			"\t-b logfile\tBackup Log file\n",
			"\t-s statefile\tState file\n",
			"\t-p processor\tCmd to feed the data to it's stdin and check the result on stdout (OK/FAIL/FATAL)\n",
			"\t-r regexp\tLog filter regexp\n",
			"\t-m max\tMax log lines to process for a single processor (-p) launch\n",
			"\t-v level\tLog verbosity level\n",
			"";
		exit 0;
	}
	die "-l -b -s -p options are required" unless $opts{l} && $opts{b} && $opts{s} && $opts{p};
	$opts{v} = 0 unless $opts{v};
	$opts{r} = "" unless $opts{r};
	$opts{m} = 1000 unless $opts{m};
}

sub load_state
{
	my $state;
	my $F;
	if (open $F, "<", $opts{s})
	{
		my @lines = <$F>;
		my $data = join "", @lines;
		$state = eval $data;
	}
	$state = {} unless $state;
	return $state;
}

sub save_state
{
	my $state = shift;
	my $F;
	open $F, ">", $opts{s} or die "Can't write file $opts{s}";
	print $F Dumper($state);
}

my $processor_stdin;
my $processor_stdout;
my $processor_pid;
sub relaunch_processor
{
	close $processor_stdin if $processor_pid;
	$processor_pid = open2($processor_stdout, $processor_stdin, $opts{p});
}

my $count = 1;
sub process_line
{
	my $line = shift;
	relaunch_processor unless $processor_pid;
	relaunch_processor if $count > $opts{m};
	print $processor_stdin $line, "\n";
	my $reply = <$processor_stdout>;
	warn "Processed: $line -> $reply" if $opts{v} > 1;
	warn "$line -> $reply" unless $reply =~ /^OK/;
	die "$line -> $reply" if $reply =~ /^FATAL/;
	++$count;
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
	seek $F, $state->{ofs}->{$fpath}, SEEK_SET if $state->{ofs}->{$fpath};
	warn "Opened $fpath at $state->{ofs}->{$fpath}" if $state->{ofs}->{$fpath} && $opts{v};
	while (<$F>)
	{
		chomp;
		process_line($opts{r} =~ /\(/ ? $1 : $_) if /$opts{r}/;
		$state->{ofs}->{$fpath} = tell $F;
	}
	if ($fpath ne $opts{l})  # finished backup
	{
		warn "Finished backup" if $opts{v};
		$state->{ofs}->{$opts{l}} = 0;
		delete $state->{ofs}->{$opts{b}};
	}
}

######################################################################

parse_opts;

my $state = load_state;
eval { process_log($state); };
if ($@)
{
	$state->{last_error}->{str} = $@;
	$state->{last_error}->{time} = time;
}
save_state($state);
