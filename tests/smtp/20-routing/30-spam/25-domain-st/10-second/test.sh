#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST -h-Message-ID test-message-1 || true
wait_file server.env
grep RCPT server.env | grep spam@tests.advancedfiltering.net
grep RCPT server.env | grep spam2@tests.advancedfiltering.net
grep MAIL server.env | grep admin-domain-tech@tests.advancedfiltering.net
