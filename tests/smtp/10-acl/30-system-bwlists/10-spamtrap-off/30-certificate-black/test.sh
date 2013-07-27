#!/bin/sh -ex

. "$TESTCONF"

swaks -tls --tls-cert tests-bwlist.crt --tls-key tests-bwlist.key -f test@tests.advancedfiltering.net -t mail@unhandled.com -s $DST_HOST -q helo | grep -A1 EHLO | grep "550.Access denied (system policy, certificate)"
