#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t test@test-r2.com -s $DST_HOST -q rcpt | grep -A1 RCPT | grep -E "4[[:digit:]][[:digit:]].R:O/ \\(Moved"
