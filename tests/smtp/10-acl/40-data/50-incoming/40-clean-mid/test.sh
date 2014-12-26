#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST -h-Message-ID 'test-message-1'
swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST -h-Message-ID ' <test-message-1>' | grep -E "2[[:digit:]][[:digit:]].MI/ \\(Ham\\) id="
