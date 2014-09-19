#!/bin/sh -ex

. "$TESTCONF"

sleep 1 # wait for retry time
swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST --h-Message-ID mailproc-1 || true
swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST --h-Message-ID mailproc-2 || true
wait_file mailproc1.env
wait_file mailproc2.env
grep MAIL mailproc1.env
grep MAIL mailproc2.env
