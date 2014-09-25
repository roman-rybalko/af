#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST --h-Message-ID message-size-1 --body system-mms-init.ldif | grep 'SIZE 128'
swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST --h-Message-ID message-size-1 --body system-mms-init.ldif | grep -i -E '5[[:digit:]][[:digit:]].+message size'
