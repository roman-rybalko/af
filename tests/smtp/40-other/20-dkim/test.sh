#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST --h-Message-ID message-dkim-1
wait_file mx.mime
dkim_verifier mx.mime | grep advancedfiltering | grep pass
