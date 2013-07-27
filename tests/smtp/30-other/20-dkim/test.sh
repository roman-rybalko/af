#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST --h-Message-ID message-dkim-1
wait_file server.mime
dkim_verifier server.mime | grep advancedfiltering | grep pass
