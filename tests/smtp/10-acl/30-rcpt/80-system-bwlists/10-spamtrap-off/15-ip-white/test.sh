#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mail@test.com -s $DST_HOST -q rcpt | grep -E "2[[:digit:]][[:digit:]].S:WL/ \\(system policy: sender host address\\)"
