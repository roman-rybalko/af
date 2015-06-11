#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t notfound@test.com -s $DST_HOST -q rcpt | smtp_rj.pl | grep -A1 RCPT | grep -E "5[[:digit:]][[:digit:]] U:NMBC,NF,!S:ST/ \\(Mail box does not exist\\)"
