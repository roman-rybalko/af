#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST | smtp_rj.pl | grep -E "2[[:digit:]][[:digit:]].S:WL/ \\(system policy: sender host name\\) id="
