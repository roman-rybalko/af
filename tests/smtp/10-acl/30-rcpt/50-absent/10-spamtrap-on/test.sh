#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t absent@test.com -s $DST_HOST -q rcpt | grep -A1 RCPT | grep -E "2[[:digit:]][[:digit:]].MB:A,S:ST/MBA \\(Mail box does not exist\\)"
