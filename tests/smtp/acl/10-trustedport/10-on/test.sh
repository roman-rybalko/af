#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@advancedfiltering.net -t mail@test.com -s $DST_HOST -p 445 -q helo | grep "ESMTP" | grep "trustedport"
