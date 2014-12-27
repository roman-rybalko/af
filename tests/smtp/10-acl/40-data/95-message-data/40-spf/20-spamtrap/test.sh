#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST -d test.mime | smtp_rj.pl | grep -E "5[[:digit:]][[:digit:]].SPF/ST,S \(SPF: message data: test.+ id="
