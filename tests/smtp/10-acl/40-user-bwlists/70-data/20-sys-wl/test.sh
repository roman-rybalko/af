#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox2@test.com -s $DST_HOST
wait_file mx.env
wait_file mailproc.env
grep RCPT mx.env | grep mbox2@test.com
grep RCPT mailproc.env | grep mailproc
