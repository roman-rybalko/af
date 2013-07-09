#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@advancedfiltering.net -t absent@test.com -s $DST_HOST -q rcpt | grep -A1 RCPT | grep "550 Mail box does not exist"
