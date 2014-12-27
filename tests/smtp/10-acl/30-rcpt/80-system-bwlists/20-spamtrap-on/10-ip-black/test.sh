#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mail@test.com -s $DST_HOST -q rcpt | smtp_rj.pl | grep -E "2[[:digit:]][[:digit:]].S:BL,\\(S:ST\\|U:SPT\\)/ \\(system policy: sender host address\\)"
