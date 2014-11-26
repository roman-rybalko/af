#!/bin/sh -ex

. "$TESTCONF"

swaks -tls -f test@test.advancedfiltering.net -t mbox@test.com -s $DST_HOST -p submission -q helo | grep Hallo | grep 'submission-test IP'
swaks -tls -f test@test.advancedfiltering.net -t mbox@test.com -s $DST_HOST -p submission -q helo | grep O=advancedfiltering | grep OU=tests | grep CN=submission
