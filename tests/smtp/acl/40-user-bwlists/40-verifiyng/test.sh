#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@advancedfiltering.net -t unexistent@test.com -s $DST_HOST -q rcpt | grep -A1 RCPT | grep "451 Your data is verifying, try again later"
