#!/bin/sh -ex

. "$TESTCONF"

# spf should fail
swaks -f test@mcafee.com -t mail@test.com -s $DST_HOST -q rcpt | grep "550.Access denied (system policy: sender mail address)"
