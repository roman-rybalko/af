#!/bin/sh -ex

. "$TESTCONF"

# sender domain with no spf
swaks -f test@tests-nospf.advancedfiltering.net -t mbox@test.com -s $DST_HOST | grep -E "2[[:digit:]][[:digit:]] SWL/ \(system policy: sender mail address\) id="
wait_file server.env
