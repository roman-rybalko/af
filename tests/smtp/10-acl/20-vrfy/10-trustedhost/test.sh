#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST -vrfy -q vrfy | grep -A1 VRFY | grep 252
