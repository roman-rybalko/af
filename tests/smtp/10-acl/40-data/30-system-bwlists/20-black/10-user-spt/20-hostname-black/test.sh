#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox2@test.com -s $DST_HOST | grep -E "2[[:digit:]][[:digit:]] SBL,USPT/ST,S \(system policy: sender host name\) id="
wait_file server.env
