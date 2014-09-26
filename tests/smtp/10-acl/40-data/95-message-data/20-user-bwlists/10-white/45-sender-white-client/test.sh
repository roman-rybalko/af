#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST -d test.mime | grep -E "2[[:digit:]][[:digit:]].U:WL/ \\(message data: user policy:"
swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST -d test.mime | grep -E "2[[:digit:]][[:digit:]].+sender mail address\\) id="
wait_file mx.env
