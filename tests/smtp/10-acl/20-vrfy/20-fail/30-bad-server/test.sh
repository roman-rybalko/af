#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST -vrfy -q vrfy | smtp_rj.pl | grep -A1 VRFY | grep 'FATAL: no smtp hosts available' | grep '499 temporary reject'
