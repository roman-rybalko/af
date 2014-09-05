#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mail@test.com -s $DST_HOST -q rcpt | grep "550.Access denied (system policy: sender host name)"
