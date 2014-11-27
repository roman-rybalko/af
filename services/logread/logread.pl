#!/usr/bin/perl

use strict;
use warnings;

use Getopt::Std;
use Data::Dumper qw(Dumper);
$Data::Dumper::Purity = 1;
use Fcntl qw(SEEK_SET);
use IPC::Open2 qw(open2);
use Time::HiRes qw(usleep);

my %opts;
sub parse_opts
{
	getopts('hl:b:s:p:r:m:M:t:v:', \%opts);
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
			"\t-m max\tMax processed lines for a single processor (-p) run\n",
			"\t-M max\tMax log lines to read before exit\n",
			"\t-t msec\tMilliseconds between log file polls\n",
			"\t-v level\tLog verbosity level\n",
			"SIGNALS:\n",
			"\tUSR1\tSave state\n",
			"\tUSR2\tReset line counters\n",
			"\tTERM\tSave state & exit\n",
			"\tINT\tSave state & exit\n",
			"";
		exit 0;
	}
	die "-l -b -s -p options are required" unless $opts{l} && $opts{b} && $opts{s} && $opts{p};
	$opts{v} = 0 unless $opts{v};
	$opts{r} = "" unless $opts{r};
	$opts{m} = 1000 unless $opts{m};
	$opts{M} = 10000 unless $opts{M};
	$opts{t} = 100 unless $opts{t};
}

sub load_state
{
	my $state;
	my $F;
	if (open $F, "<", $opts{s})
	{
		my @lines = <$F>;
		my $data = join "", @lines;
		no strict;
		$state = eval $data;
		use strict;
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
sub stop_processor
{
	warn "Terminating processor $processor_pid" if $opts{v} > 1;
	close $processor_stdin;
	waitpid $processor_pid, 0;
	$processor_pid = $processor_stdin = $processor_stdout = undef;
}
sub restart_processor
{
	stop_processor if $processor_pid;
	$processor_pid = open2($processor_stdout, $processor_stdin, $opts{p});
}

my $process_count = 0;
sub process_line
{
	my $line = shift;
	restart_processor unless $processor_pid;
	if ($process_count >= $opts{m})
	{
		warn "Max processed lines $opts{m} reached, restarting processor" if $opts{v} > 1;
		restart_processor;
		$process_count = 0;
	}
	print $processor_stdin $line, "\n";
	my $reply = <$processor_stdout>;
	warn "Processed: $line -> $reply" if $opts{v} > 1;
	warn "$line -> $reply" unless $reply =~ /^OK/;
	die "$line -> $reply" if $reply =~ /^FATAL/;
	++$process_count;
}

my $signal_flag = 0;

my $log_count = 0;
sub process_log
{
	my $state = shift;
	my $F;
	if ($state->{file})
	{
		my $fsize = -s $state->{file} || 0;
		if ($fsize < $state->{size})
		{
			if ($state->{file} ne $opts{l})
			{
				delete $state->{file};
				delete $state->{size};
				delete $state->{ofs};
				die "Log backup ($opts{b}) rotated, data lost";
			}
			else
			{
				warn "Log rotated: $opts{l} -> $opts{b}" if $opts{v};
				$state->{file} = $opts{b};
			}
		}
		else
		{
			$state->{size} = $fsize;
		}
	}
	else
	{
		$state->{file} = $opts{l};
		$state->{size} = -s $opts{l};
		$state->{ofs} = 0;
		warn "New log file: $state->{file}; size: $state->{size}" if $opts{v};
	}
	open $F, "<", $state->{file} or die "Unable to open log file $state->{file} for reading";
	if ($state->{ofs})
	{
		seek $F, $state->{ofs}, SEEK_SET;
		warn "Opened $state->{file} at $state->{ofs}" if $opts{v};
	}
	while ($log_count < $opts{M})
	{
		while (<$F>)
		{
			$state->{ofs} = tell $F;
			$state->{size} = $state->{ofs} if $state->{size} < $state->{ofs};
			chomp;
			process_line($opts{r} =~ /\(/ ? $1 : $_) if /$opts{r}/;
			++$log_count;
			if ($log_count >= $opts{M})
			{
				warn "Max log lines $opts{M} reached, exiting at " . tell $F if $opts{v} > 1;
				last;
			}
			die "Exit by signal" if $signal_flag;
		}
		my $fsize = -s $state->{file} || 0;
		if ($log_count < $opts{M} && $fsize < $state->{size})
		{
			warn "Log ($state->{file}) rotated" if $opts{v};
			last;
		}
		last if $state->{file} ne $opts{l};
		die "Exit by signal" if $signal_flag;
		usleep($opts{t} * 1000) if $log_count < $opts{M};
	}
	if ($state->{file} ne $opts{l} && $log_count < $opts{M})  # finished backup
	{
		warn "Finished backup" if $opts{v};
		delete $state->{file};
		delete $state->{size};
		delete $state->{ofs};
	}
}

######################################################################

parse_opts;

my $state = load_state;

$SIG{USR1} = sub { save_state($state); };
$SIG{USR2} = sub { $log_count = 0; $process_count = 0; };
$SIG{INT} = $SIG{TERM} = sub { $signal_flag = 1; };

my $exitcode = 0;
eval { process_log($state); };
if ($@)
{
	$state->{last_error}->{str} = $@;
	$state->{last_error}->{time} = time;
	$exitcode = 1;
	warn $state->{last_error}->{str};
}

save_state($state);

stop_processor if $processor_pid;

exit $exitcode
