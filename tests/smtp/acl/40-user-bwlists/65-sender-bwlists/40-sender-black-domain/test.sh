#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests-nospf.advancedfiltering.net -t mbox@test.com -s $DST_HOST -q RCPT | grep -A1 RCPT | grep "550.Access denied (user domain policy, sender mail address)"
