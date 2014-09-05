#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox2@test.com -s $DST_HOST -h-Message-ID 'test-message-1' | grep --extended-regexp '550.+everal senders for the same message'
wait_file server.env
