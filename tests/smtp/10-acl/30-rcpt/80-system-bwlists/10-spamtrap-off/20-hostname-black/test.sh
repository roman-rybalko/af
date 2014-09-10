#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mail@test.com -s $DST_HOST -q rcpt | grep -E "5[[:digit:]][[:digit:]] SBL/ \(system policy: sender host name\)"
