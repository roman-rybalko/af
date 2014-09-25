#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST -d 'Subject: Test message\n\nThis is a test message\n' | grep -E "5[[:digit:]][[:digit:]].MI:MID/ \\(No Message\\-ID header\\) id="
