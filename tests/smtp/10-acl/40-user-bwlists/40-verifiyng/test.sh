#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t unexistent@test.com -s $DST_HOST -q rcpt | grep "451 Your data is verifying, please try again later"
