#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t test@test2.com -s $DST_HOST -q rcpt | grep -A1 RCPT | grep -E "4[[:digit:]][[:digit:]].D/ \\(Replicating"
