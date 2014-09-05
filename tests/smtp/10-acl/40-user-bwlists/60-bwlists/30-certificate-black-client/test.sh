#!/bin/sh -ex

. "$TESTCONF"

swaks -tls --tls-cert test-smtp-black.crt --tls-key test-smtp-black.key -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST -q RCPT | grep -A1 RCPT | grep "550.Access denied (user policy: certificate)"
