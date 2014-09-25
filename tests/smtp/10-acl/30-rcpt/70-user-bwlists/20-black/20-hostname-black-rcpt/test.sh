#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST -q RCPT | grep -A1 RCPT | grep -E "5[[:digit:]][[:digit:]].U:BL/ \\(user recipient policy: sender host name\\)"
