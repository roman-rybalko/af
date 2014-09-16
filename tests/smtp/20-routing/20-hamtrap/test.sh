#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST -h-Message-ID test-message-id-2 -h-References test-outgoing-message-2
wait_file mx.env
grep MAIL mx.env | grep test
grep RCPT mx.env | grep mbox
wait_file hamtrap.env
grep MAIL hamtrap.env | grep error
grep RCPT hamtrap.env | grep hamtrap
