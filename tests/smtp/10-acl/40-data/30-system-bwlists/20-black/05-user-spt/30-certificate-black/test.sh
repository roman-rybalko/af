#!/bin/sh -ex

. "$TESTCONF"

swaks -tls --tls-cert test-smtp-black.crt --tls-key test-smtp-black.key -f test@tests.advancedfiltering.net -t mbox2@test.com -s $DST_HOST | grep -E "2[[:digit:]][[:digit:]] SBL,USPT/ST,S \(system policy: certificate\) id="
wait_file server.env
