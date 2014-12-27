#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST -d test.mime | smtp_rj.pl | grep -E "5[[:digit:]][[:digit:]].S:BL/ST,S \\(message data: system policy: sender mail address\\) id="
