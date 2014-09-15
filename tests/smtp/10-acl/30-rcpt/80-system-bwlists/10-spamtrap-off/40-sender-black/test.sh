#!/bin/sh -ex

. "$TESTCONF"

# spf should fail
swaks -f test@mcafee.com -t mail@test.com -s $DST_HOST -q rcpt | grep -E "5[[:digit:]][[:digit:]].SBL/ \(system policy: sender mail address\)"
