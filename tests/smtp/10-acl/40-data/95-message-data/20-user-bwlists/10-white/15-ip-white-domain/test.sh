#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST -d test.mime | grep -E "2[[:digit:]][[:digit:]].U:WL/ \\(message data: user domain policy:"
swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST -d test.mime | grep -E "2[[:digit:]][[:digit:]].+sender host address\\) id="
wait_file mx.env
