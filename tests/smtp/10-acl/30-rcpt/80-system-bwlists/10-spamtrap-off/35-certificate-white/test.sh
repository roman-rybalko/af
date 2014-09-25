#!/bin/sh -ex

. "$TESTCONF"

swaks -tls --tls-cert tests-bwlist.crt --tls-key tests-bwlist.key -f test@tests.advancedfiltering.net -t mail@test.com -s $DST_HOST -q rcpt | grep -E "2[[:digit:]][[:digit:]].S:WL/ \\(system policy: certificate\\)"
