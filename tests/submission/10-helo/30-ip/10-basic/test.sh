#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@test.advancedfiltering.net -t mail@test.com -s $DST_HOST -p submission -q helo | grep Hallo | grep 'cli1 IP'
