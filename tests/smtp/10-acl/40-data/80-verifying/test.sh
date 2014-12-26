#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST -h-Message-ID test-message-1 | grep -E "4[[:digit:]][[:digit:]]./MP \\(Your data is verifying, please try again later\\) id="
