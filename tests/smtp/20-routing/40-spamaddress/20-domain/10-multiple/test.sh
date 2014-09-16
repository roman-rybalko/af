#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST -h-Message-ID test-spam-message-1 || true
wait_file submission.env
grep MAIL submission.env | grep "domain\\-tech@"
grep RCPT submission.env | grep "domain\\-spam@"
grep RCPT submission.env | grep "domain\\-spam2@"
