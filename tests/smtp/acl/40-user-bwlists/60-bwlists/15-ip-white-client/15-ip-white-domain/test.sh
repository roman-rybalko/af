#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@advancedfiltering.net -t mbox@test.com -s $DST_HOST -q RCPT | grep -A1 RCPT | grep "250.OK (user domain policy, sender host address)"
