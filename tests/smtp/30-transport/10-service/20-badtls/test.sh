#!/bin/sh -ex

. "$TESTCONF"

sleep 1 # wait for retry time
swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST --h-Message-ID service-1 || true
swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST --h-Message-ID service-2 || true
swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST --h-Message-ID service-3 || true
wait_file mailproc.env
[ `grep MAIL mailproc.env | wc -l` = 3 ]
[ `grep RCPT mailproc.env | wc -l` = 3 ]
grep MAIL mailproc.env | grep error
grep RCPT mailproc.env | grep mailproc
