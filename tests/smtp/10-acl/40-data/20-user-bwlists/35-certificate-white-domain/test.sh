#!/bin/sh -ex

. "$TESTCONF"

swaks -tls --tls-cert tests-bwlist.crt --tls-key tests-bwlist.key -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST | grep -E "2[[:digit:]][[:digit:]].U:WL/ \\(user domain policy: certificate\\) id="
wait_file server.env
