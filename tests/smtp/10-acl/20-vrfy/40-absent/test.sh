#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST -vrfy -q vrfy | grep -E "5[[:digit:]][[:digit:]].+FAIL: 599 rejected"
wait_ldif_add user2.ldif
