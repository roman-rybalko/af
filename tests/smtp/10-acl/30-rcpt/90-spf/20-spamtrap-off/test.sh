#!/bin/sh -ex

. "$TESTCONF"

# spf should fail
swaks -f test@mcafee.com -t spf-test@test.com -s $DST_HOST -q rcpt | grep -E "5[[:digit:]][[:digit:]] SPF/ \(SPF:"
