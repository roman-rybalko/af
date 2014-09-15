#!/bin/sh -ex

. "$TESTCONF"

# spf should fail
swaks -f test@mcafee.com -t mbox2@test.com -s $DST_HOST | grep -E "2[[:digit:]][[:digit:]].SBL,USPT/ST,S \(system policy: sender mail address\) id="
wait_file server.env
