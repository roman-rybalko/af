#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox2@test.com -s $DST_HOST -d test.mime | smtp_rj.pl | grep -E "2[[:digit:]][[:digit:]].SPF,U:SPT/ST,S \\(SPF: message data: test.+ id="
