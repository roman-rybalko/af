#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox4@test.com -s $DST_HOST -d test.mime | grep "Message loop detected" | grep mbox3@test.com | grep mbox4@test.com
