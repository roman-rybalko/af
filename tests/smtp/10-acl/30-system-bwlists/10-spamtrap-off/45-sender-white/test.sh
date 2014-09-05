#!/bin/sh -ex

. "$TESTCONF"

# sender domain with no spf
swaks -f test@tests-nospf.advancedfiltering.net -t mail@test.com -s $DST_HOST -q rcpt | grep "250.OK (system policy: sender mail address)"
