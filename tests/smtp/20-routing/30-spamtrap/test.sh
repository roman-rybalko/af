#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t absent@test.com -s $DST_HOST || true
wait_file spamtrap.env
grep MAIL spamtrap.env | grep error
grep RCPT spamtrap.env | grep spamtrap
