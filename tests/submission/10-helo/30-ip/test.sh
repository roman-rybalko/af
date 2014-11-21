#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mail@test.com -s $DST_HOST -p submission -q helo | grep Hallo | grep -E 'submission-test IP'
