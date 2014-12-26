#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox2@test.com -s $DST_HOST -d test.mime | grep -E "2[[:digit:]][[:digit:]].MD:SP,U:SPT/S \\(Spam: message data: test"
swaks -f test@tests.advancedfiltering.net -t mbox2@test.com -s $DST_HOST -d test.mime | grep -E "2[[:digit:]][[:digit:]].+id="
