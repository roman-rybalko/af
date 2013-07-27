#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox2@test.com -s $DST_HOST -d 'Subject: Test message\n\nThis is a test message\n' | grep --extended-regexp "550.+No Message-ID header"
