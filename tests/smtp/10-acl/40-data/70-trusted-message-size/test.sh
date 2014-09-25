#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST --h-Message-ID message-size-1 --body system-tms-init.ldif | grep -E "2[[:digit:]][[:digit:]].S:TMS/ \\(Ham\\) id="
wait_file server.env
