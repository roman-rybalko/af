#!/bin/sh -ex

. "$TESTCONF"

swaks -f mbox@test.advancedfiltering.net -t test@dmarc.test.advancedfiltering.net -s $DST_HOST -p submission | smtp_rj.pl | grep -E '2[[:digit:]][[:digit:]] id=[^[:space:]]+ .+ TMS'
