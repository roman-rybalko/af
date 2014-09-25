#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests-nospf.advancedfiltering.net -t mbox@test.com -s $DST_HOST -q RCPT | grep -A1 RCPT | grep -E "5[[:digit:]][[:digit:]].U:BL/ \\(user domain policy: sender mail address\\)"
