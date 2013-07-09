#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@advancedfiltering.net -t test@test-r2.com -s $DST_HOST -q rcpt | grep -A1 RCPT | grep "451 Moved, try another host"
