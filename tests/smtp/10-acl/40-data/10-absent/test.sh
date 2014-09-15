#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t absent@test.com -s $DST_HOST | grep -E "5[[:digit:]][[:digit:]].MBA/ST Mail box does not exist\\. id="
wait_file server.env
