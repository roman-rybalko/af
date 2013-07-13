#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t absent@test-alias.com -s $DST_HOST -q rcpt | grep -A1 RCPT | grep "550 Mail box does not exist"
