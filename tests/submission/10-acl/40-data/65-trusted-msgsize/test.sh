#!/bin/sh -ex

. "$TESTCONF"

swaks -f mbox@test.advancedfiltering.net -t test@dmarc.test.advancedfiltering.net -s $DST_HOST -p submission --h-Message-Id test-message-id-2 | smtp_rj.pl | grep -E '2[[:digit:]][[:digit:]] id=[^[:space:]]+ .+ TMS'
wait_ldif_add user2.ldif
