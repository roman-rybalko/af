#!/bin/sh -ex

. "$TESTCONF"

swaks -tls --tls-cert test-smtp-black.crt --tls-key test-smtp-black.key -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST | grep -E "5[[:digit:]][[:digit:]].S:BL/ST,S \\(system policy: certificate\\) id="
