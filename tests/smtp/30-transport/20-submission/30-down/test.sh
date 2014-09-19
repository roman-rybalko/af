#!/bin/sh -ex

. "$TESTCONF"

sleep 1 # wait for retry time
swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST --h-Message-ID submission-1 || true
swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST --h-Message-ID submission-2 || true
wait_file submission1.env
wait_file submission2.env
grep MAIL submission1.env
grep MAIL submission2.env
