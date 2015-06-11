#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t expired@test.com -s $DST_HOST -q rcpt | smtp_rj.pl | grep -A1 RCPT | grep -E "4[[:digit:]][[:digit:]] !U:NMBC,E/ \\(Your data is verifying, please try again later\\)"
