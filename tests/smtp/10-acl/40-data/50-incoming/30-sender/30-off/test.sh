#!/bin/sh -ex

. "$TESTCONF"

swaks -f test2@tests.advancedfiltering.net -t mbox2@test2.com -s $DST_HOST -h-Message-ID test-message-1 | grep -E "5[[:digit:]][[:digit:]].Bad sender \\(Several senders for the same message\\) id="
