#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST -d test.mime | grep -E "2[[:digit:]][[:digit:]].S:WL/ \\(message data: system policy:"
swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST -d test.mime | grep -E "2[[:digit:]][[:digit:]].+certificate\\) id="
