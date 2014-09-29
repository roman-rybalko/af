#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST -d test.mime | grep -E "5[[:digit:]][[:digit:]].MD:SP/ \\(Spam: message data: test"
swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST -d test.mime | grep -E "5[[:digit:]][[:digit:]].+id="
