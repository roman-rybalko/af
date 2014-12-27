#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests-nospf.advancedfiltering.net -t mbox@test.com -s $DST_HOST -q rcpt | smtp_rj.pl | grep -A1 RCPT | grep -E "2[[:digit:]][[:digit:]].U:WL/ \\(user recipient policy: sender mail address\\)"
