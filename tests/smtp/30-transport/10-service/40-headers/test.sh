#!/bin/sh -ex

. "$TESTCONF"

sleep 1 # wait for retry time
swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST --h-Message-ID mailproc-1 || true
wait_file mailproc.mime
grep ^X-Envelope-From: mailproc.mime
grep ^X-Envelope-To: mailproc.mime
