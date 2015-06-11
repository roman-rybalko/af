#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t absent-expired@test.com -s $DST_HOST -q rcpt | smtp_rj.pl | grep -A1 RCPT | grep -E "2[[:digit:]][[:digit:]] U:NMBC,A,S:ST/ST \\(Mail box does not exist\\)"
