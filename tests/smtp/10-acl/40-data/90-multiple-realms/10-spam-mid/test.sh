#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox2@test2.com -s $DST_HOST -h-Message-ID 'test-spam-message-1' | grep -E "5[[:digit:]][[:digit:]].Spam \\(Test spam message\\) id="
