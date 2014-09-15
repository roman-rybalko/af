#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST --h-Message-ID message-size-1 --body system-tms-init.ldif | grep -E "2[[:digit:]][[:digit:]].TMS/"
wait_file server.env
