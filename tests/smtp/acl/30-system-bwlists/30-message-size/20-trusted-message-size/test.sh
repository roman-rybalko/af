#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST --h-Message-ID message-size-1 --body user.ldif | grep 'trusted message size'
wait_file server.env
