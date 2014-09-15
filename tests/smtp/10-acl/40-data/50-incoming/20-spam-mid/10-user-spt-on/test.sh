#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox2@test.com -s $DST_HOST -h-Message-ID 'test-spam-message-1' | grep -E "2[[:digit:]][[:digit:]].USPT/S \\(Test spam message\\) id="
wait_file server.env
