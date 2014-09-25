#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST -q RCPT | grep -A1 RCPT | grep -E "2[[:digit:]][[:digit:]].U:WL/ \\(user policy: sender host address\\)"
