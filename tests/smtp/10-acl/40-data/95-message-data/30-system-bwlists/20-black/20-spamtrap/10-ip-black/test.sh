#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST -d test.mime | grep -E "5[[:digit:]][[:digit:]].S:BL/ST,S \\(message data: system policy:"
swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST -d test.mime | grep -E "5[[:digit:]][[:digit:]].+sender host address\\) id="
wait_file spamtrap.env
