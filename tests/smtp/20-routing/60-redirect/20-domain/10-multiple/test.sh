#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST -h-Message-ID test-message-id-2 -h-References test-outgoing-message-2
wait_file submission.env
grep MAIL submission.env | grep "domain\\-tech@"
grep RCPT submission.env | grep "domain\\-redirect@"
grep RCPT submission.env | grep "domain\\-redirect2@"
