#!/usr/bin/perl

# draft-kucherawy-dmarc-base-05

use strict;
use warnings;

use Net::DNS;
use File::Basename; # dirname

my $from_domain = shift;
my $spf_domain = shift;
my $dkim_domain = shift;

# https://publicsuffix.org/list/effective_tld_names.dat
my $tld_file = dirname($0) . "/dmarc_verifier_effective_tld_names.dat";

sub msg_ok
{
	print @_;
	exit 0;
}

sub msg_fail
{
	print @_;
	exit 1;
}

sub msg_fatal
{
	print @_;
	exit 2;
}

msg_fatal("USAGE: $0 <from_domain> [<spf_domain> <dkim_domain>]") if !$from_domain || ($spf_domain && !$dkim_domain);

my %tld;
sub load_tld
{
	my $F;
	open $F, "<", $tld_file or msg_fatal("Unable to open file $tld_file");
	while (<$F>)
	{
		chomp;
		next unless $_; # empty str
		next if m~^//~; # comment
		next if /^#/; # comment
		next if /\s/; # broken (probably comment)
		$tld{$_} = 1;
	}
}

sub get_org_domain
{
	my $domain = shift;
	$domain =~ s/\.$//;
	my @domain = split /\./, $domain;
	my $user_domain;
	for (;;)
	{
		last unless @domain;
		last if $tld{join '.', @domain};
		$user_domain = shift @domain;
	}
	return $user_domain . '.' . join('.', @domain) if $user_domain && @domain;
	msg_fail("$domain: organizational domain can not be determined");
}

my $resolver = Net::DNS::Resolver->new;
sub get_policy
{
	my $domain = shift;
	my $packet = $resolver->query('_dmarc.'.$domain, 'TXT');
	if ($packet && $packet->answer)
	{
		foreach my $rr ($packet->answer)
		{
			my $data = $rr->rdatastr;
			$data =~ s/^"//;
			$data =~ s/"$//;
			$data =~ s/\s//g;
			my %tags = map { split /=/ } split /\\;/, $data;
			next unless $tags{v} && $tags{v} eq 'DMARC1';
			$tags{aspf} = 'r' unless $tags{aspf};
			$tags{adkim} = 'r' unless $tags{adkim};
			msg_fail("$domain: \"p\" tag is missing") unless $tags{p};
			return \%tags;
		}
	}
	return undef;
}

sub check_policy
{
	my $policy = shift;
	my $policy_domain = shift;
	my $from_org_domain; # optimization
	if ($policy->{aspf} eq 'r')
	{
		$from_org_domain = get_org_domain($from_domain) unless $from_org_domain;
		my $spf_org_domain = get_org_domain($spf_domain);
		msg_fail("policy_src=$policy_domain, from_org=$from_org_domain, spf_org=$spf_org_domain: SPF validation failed in \"relaxed\" identifier alignment mode") if $from_org_domain ne $spf_org_domain;
	}
	elsif ($policy->{aspf} eq 's')
	{
		msg_fail("policy_src=$policy_domain, from=$from_domain, spf=$spf_domain: SPF validation failed in \"strict\" identifier alignment mode") if $from_domain ne $spf_domain;
	}
	else
	{
		msg_fail("$policy_domain: unsupported \"aspf\" tag value \"$policy->{aspf}\"");
	}
	if ($policy->{adkim} eq 'r')
	{
		$from_org_domain = get_org_domain($from_domain) unless $from_org_domain;
		my $dkim_org_domain = get_org_domain($dkim_domain);
		msg_fail("policy_src=$policy_domain, from_org=$from_org_domain, dkim_org=$dkim_org_domain: DKIM validation failed in \"relaxed\" identifier alignment mode") if $from_org_domain ne $dkim_org_domain;
	}
	elsif ($policy->{adkim} eq 's')
	{
		msg_fail("policy_src=$policy_domain, from=$from_domain, dkim=$dkim_domain: DKIM validation failed in \"strict\" identifier alignment mode") if $from_domain ne $dkim_domain;
	}
	else
	{
		msg_fail("$policy_domain: unsupported \"adkim\" tag value \"$policy->{adkim}\"");
	}
}

load_tld;
my $policy = get_policy($from_domain);
if ($policy)
{
	check_policy($policy, $from_domain) if $spf_domain && $dkim_domain;
	msg_ok($from_domain, ": ", $policy->{p});
}
else
{
	my $org_domain = get_org_domain($from_domain);
	if ($org_domain ne $from_domain)
	{
		$policy = get_policy($org_domain);
		if ($policy)
		{
			check_policy($policy, $org_domain) if $spf_domain && $dkim_domain;
			msg_ok($org_domain, ": ", $policy->{sp} ? $policy->{sp} : $policy->{p});
		}
	}
}
msg_fail("$from_domain: no policy published");
