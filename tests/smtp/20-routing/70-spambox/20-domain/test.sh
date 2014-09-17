#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST -h-Message-ID test-spam-message-1
wait_file mx.env
grep MAIL mx.env | grep "test@"
grep RCPT mx.env | grep "domain-spam+mbox@"
