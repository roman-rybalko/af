#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST --h-Message-ID mailproc-1 || true
wait_file mailproc.env
grep MAIL mailproc.env | grep error
grep RCPT mailproc.env | grep mailproc
wait_file error.env
grep MAIL error.env | grep '<>'
grep RCPT error.env | grep error
