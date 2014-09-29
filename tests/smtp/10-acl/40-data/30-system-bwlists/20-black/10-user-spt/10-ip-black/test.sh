#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox2@test.com -s $DST_HOST | grep -E "2[[:digit:]][[:digit:]].S:BL,U:SPT/ST,S \\(system policy: sender host address\\) id="
wait_file mx.env
