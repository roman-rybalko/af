#!/bin/sh -ex

. "$TESTCONF"

swaks -f test2@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST -h-Message-ID test-message-1 | grep -E "5[[:digit:]][[:digit:]].SST/ST,S \\(Several senders for the same message\\) id="
wait_file server.env
