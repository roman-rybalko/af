#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST -h-Message-ID test-message-id-2 -h-References test-outgoing-message-2
wait_file bounce.env
grep MAIL bounce.env | grep "error@"
grep RCPT bounce.env | grep "bounce@"
