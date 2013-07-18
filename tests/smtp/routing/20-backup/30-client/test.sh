#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST
wait_file server.env
grep RCPT server.env | grep backup@tests.advancedfiltering.net
grep MAIL server.env | grep admin-client-tech@tests.advancedfiltering.net
