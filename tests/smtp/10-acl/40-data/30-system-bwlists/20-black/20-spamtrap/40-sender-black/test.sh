#!/bin/sh -ex

. "$TESTCONF"

# spf should fail
swaks -f test@mcafee.com -t mbox@test.com -s $DST_HOST | grep -E "5[[:digit:]][[:digit:]].S:BL/ST,S \\(system policy: sender mail address\\) id="
wait_file spamtrap.env
