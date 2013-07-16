#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox2@test.com,mbox2@test2.com,mbox2@test3.com -s $DST_HOST -h-Message-ID 'test-spam-message-1' | grep "550.Spam detected: Test spam message"
