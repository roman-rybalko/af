#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST | smtp_rj.pl | grep -E "2[[:digit:]][[:digit:]].U:WL/ \\(user policy: sender host address\\) id="
