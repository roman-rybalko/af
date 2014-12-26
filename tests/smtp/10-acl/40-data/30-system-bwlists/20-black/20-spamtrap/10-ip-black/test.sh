#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST | grep -E "5[[:digit:]][[:digit:]].S:BL/ST,S \\(system policy: sender host address\\) id="
