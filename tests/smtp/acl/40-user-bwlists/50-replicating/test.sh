#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@advancedfiltering.net -t test@test2.com -s $DST_HOST -q rcpt | grep -A1 RCPT | grep "451 Replicating, try again later"
