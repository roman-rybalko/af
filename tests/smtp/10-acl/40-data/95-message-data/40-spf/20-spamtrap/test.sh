#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST -d test.mime | grep -E "5[[:digit:]][[:digit:]].SPF/ST,S \(SPF: message data: test"
swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST -d test.mime | grep -E "5[[:digit:]][[:digit:]].+id="
