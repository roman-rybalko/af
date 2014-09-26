#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST -d test.mime | grep -E "5[[:digit:]][[:digit:]].U:BL/ \\(message data: user policy:"
swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST -d test.mime | grep -E "5[[:digit:]][[:digit:]].+sender mail address\\) id="
