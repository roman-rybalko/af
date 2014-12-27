#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox2@test.com -s $DST_HOST -d test.mime | smtp_rj.pl | grep "Message loop detected" | grep mbox2@test.com
