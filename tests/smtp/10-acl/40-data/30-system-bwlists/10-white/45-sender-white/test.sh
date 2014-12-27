#!/bin/sh -ex

. "$TESTCONF"

# sender domain with no spf
swaks -f test@tests-nospf.advancedfiltering.net -t mbox@test.com -s $DST_HOST | smtp_rj.pl | grep -E "2[[:digit:]][[:digit:]].S:WL/ \\(system policy: sender mail address\\) id="
