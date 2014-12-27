#!/bin/sh -ex

. "$TESTCONF"

swaks -tls --tls-cert tests-bwlist.crt --tls-key tests-bwlist.key -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST | smtp_rj.pl | grep -E "2[[:digit:]][[:digit:]].U:WL/ \\(user domain policy: certificate\\) id="
