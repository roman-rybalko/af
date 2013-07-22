#!/bin/sh -ex

. "$TESTCONF"

sleep 1 # wait for retry time
swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST -h-Message-ID 'test-message-1'
wait_file server2.env
grep MAIL server2.env | grep test@tests.advancedfiltering.net
grep RCPT server2.env | grep mbox@test.com
grep AUTH server2.env
grep STARTTLS server2.env
