#!/bin/sh -ex

. "$TESTCONF"

# spf should fail
swaks -f test@mcafee.com -t spf-test@test.com -s $DST_HOST | grep -E "2[[:digit:]][[:digit:]].SPF,USPT/ST,S \(SPF:"
wait_file server.env
