#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox2@test.com -s $DST_HOST -d test.mime | grep -E "2[[:digit:]][[:digit:]].S:BL,U:SPT/ST,S \\(message data: system policy:"
swaks -f test@tests.advancedfiltering.net -t mbox2@test.com -s $DST_HOST -d test.mime | grep -E "2[[:digit:]][[:digit:]].+sender mail address\\) id="
swaks -f test@tests.advancedfiltering.net -t mbox2@test.com -s $DST_HOST -d test2.mime | grep -E "2[[:digit:]][[:digit:]].S:BL,U:SPT/ST,S \\(message data: system policy:"
swaks -f test@tests.advancedfiltering.net -t mbox2@test.com -s $DST_HOST -d test2.mime | grep -E "2[[:digit:]][[:digit:]].+sender mail address\\) id="
