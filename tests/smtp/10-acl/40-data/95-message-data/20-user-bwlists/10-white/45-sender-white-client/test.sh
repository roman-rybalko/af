#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST -d test.mime | smtp_rj.pl | grep -E "2[[:digit:]][[:digit:]] U:WL/ \\(message data: user policy: sender mail address\\) id="
