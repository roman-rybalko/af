#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST | grep -E "2[[:digit:]][[:digit:]].U:WL/ \\(user domain policy: sender host address\\) id="
wait_file server.env
