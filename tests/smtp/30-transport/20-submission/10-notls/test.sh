#!/bin/sh -ex

. "$TESTCONF"

sleep 1 # wait for retry time
swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST --h-Message-ID submission-1
swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST --h-Message-ID submission-2
swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST --h-Message-ID submission-3
wait_file submission.env
[ `grep MAIL submission.env | wc -l` = 3 ]
[ `grep RCPT submission.env | wc -l` = 3 ]
grep MAIL submission.env | grep client-tech
grep RCPT submission.env | grep client-redirect
