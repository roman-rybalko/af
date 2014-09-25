#!/bin/sh -ex

. "$TESTCONF"

# spf should fail
swaks -f test@mcafee.com -t mail@test.com -s $DST_HOST -q rcpt | grep -E "2[[:digit:]][[:digit:]].S:BL,\\(S:ST\\|U:SPT\\)/ \\(system policy: sender mail address\\)"
