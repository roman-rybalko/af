#!/bin/sh -ex

. "$TESTCONF"

# spf should fail
swaks -f test@mcafee.com -t spf-test@test.com -s $DST_HOST -q rcpt | grep -A1 RCPT | grep "550.Access denied (SPF:"
