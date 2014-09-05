#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mail@test.com -s $DST_HOST -q helo | grep ESMTP | grep -E ' ST($|\s)'
