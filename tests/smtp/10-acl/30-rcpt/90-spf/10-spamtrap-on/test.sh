#!/bin/sh -ex

. "$TESTCONF"

# spf should fail
swaks -f test@mcafee.com -t spf-test@test.com -s $DST_HOST -q rcpt | grep -E "2[[:digit:]][[:digit:]].SPF,\(USPT|SST\)/ \(SPF:"
