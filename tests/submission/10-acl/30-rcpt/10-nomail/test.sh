#!/bin/sh -ex
. "$TESTCONF"

swaks -f mbox@test.advancedfiltering.net -t test@nomail.test.advancedfiltering.net -s $DST_HOST -p submission -q rcpt | smtp_rj.pl | grep -E '5[[:digit:]][[:digit:]] Recipient domain nomail.test.advancedfiltering.net does not accept mail'
