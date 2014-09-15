#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t expired@test.com -s $DST_HOST -q rcpt | grep -A1 RCPT | grep -E "2[[:digit:]][[:digit:]].UNMBC,SST/MBA Mail box does not exist"
