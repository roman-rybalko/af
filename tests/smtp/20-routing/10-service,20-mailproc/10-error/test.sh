#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST --h-Message-ID mailproc-1 || true
wait_file server.env
grep RCPT server.env | grep error
