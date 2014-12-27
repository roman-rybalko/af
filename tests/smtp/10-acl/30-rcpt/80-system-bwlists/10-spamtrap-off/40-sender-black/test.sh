#!/bin/sh -ex

. "$TESTCONF"

# spf should fail
swaks -f test@mcafee.com -t mail@test.com -s $DST_HOST -q rcpt | smtp_rj.pl | grep -E "5[[:digit:]][[:digit:]].S:BL/ \\(system policy: sender mail address\\)"
