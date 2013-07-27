#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t absentmbox@test.com -s $DST_HOST -h-Message-ID test-message-1 || true
wait_file server.env
grep RCPT server.env | grep spam@tests.advancedfiltering.net
grep MAIL server.env | grep admin-client-tech@tests.advancedfiltering.net
