#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@advancedfiltering.net -t mail@test.com -s $DST_HOST -q helo | grep ESMTP | grep spamtrap
