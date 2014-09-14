#!/bin/sh -ex

. "$TESTCONF"

# spf should fail
swaks -f test@mcafee.com -t spf-test@test.com -s $DST_HOST | grep -E "5[[:digit:]][[:digit:]].SPF/ST,S \(SPF:"
wait_file server.env
