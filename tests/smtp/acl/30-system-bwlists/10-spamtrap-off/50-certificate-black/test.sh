#!/bin/sh -ex

. "$TESTCONF"

swaks -tls --tls-cert tests-bwlist.crt --tls-key tests-bwlist.key -f test@advancedfiltering.net -t mail@unhandled.com -s $DST_HOST -q helo | grep -A1 --extended-regexp 'EHLO|HELO' | grep "5.7.0 Access denied (system policy, certificate)"
