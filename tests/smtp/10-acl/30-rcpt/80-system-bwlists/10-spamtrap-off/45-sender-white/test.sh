#!/bin/sh -ex

. "$TESTCONF"

# sender domain with no spf
swaks -f test@tests-nospf.advancedfiltering.net -t mail@test.com -s $DST_HOST -q rcpt | grep -E "2[[:digit:]][[:digit:]].S:WL/ \\(system policy: sender mail address\\)"
