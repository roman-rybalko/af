#!/bin/sh -ex

. "$TESTCONF"

swaks -tls --tls-cert test-smtp-black.crt --tls-key test-smtp-black.key -f test@tests.advancedfiltering.net -t mail@test.com -s $DST_HOST -q rcpt | smtp_rj.pl | grep -E "5[[:digit:]][[:digit:]].S:BL/ \\(system policy: certificate\\)"
