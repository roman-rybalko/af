#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests-nospf.advancedfiltering.net -t mbox@test.com -s $DST_HOST -d test.mime | smtp_rj.pl | grep -E "2[[:digit:]][[:digit:]] U:WL/ \\(message data: user domain policy: sender mail address\\) id="
