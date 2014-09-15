#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST -h-Message-ID 'test-spam-message-1' | grep -E "5[[:digit:]][[:digit:]].Spam \\(Test spam message\\) id="
