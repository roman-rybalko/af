#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox2@test.com -s $DST_HOST || true
wait_file server.env
grep RCPT server.env | grep spamtrap
