#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t test@test2.com -s $DST_HOST -q rcpt | grep -A1 RCPT | grep "451 Replicating, please try again later"
