#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests-nospf.advancedfiltering.net -t mbox@test.com -s $DST_HOST | smtp_rj.pl | grep -E "2[[:digit:]][[:digit:]].U:WL/ \\(user recipient policy: sender mail address\\) id="
