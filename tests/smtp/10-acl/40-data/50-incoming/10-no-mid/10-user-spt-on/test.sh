#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox2@test.com -s $DST_HOST -d 'Subject: Test message\n\nThis is a test message\n' | grep -E "2[[:digit:]][[:digit:]].MI:MID,U:SPT/S \\(No Message\\-ID header\\) id="
wait_file server.env
