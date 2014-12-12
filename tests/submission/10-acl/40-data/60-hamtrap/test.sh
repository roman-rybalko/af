#!/bin/sh -ex

. "$TESTCONF"

swaks -f mbox@test.advancedfiltering.net -t test@dmarc.test.advancedfiltering.net -s $DST_HOST -p submission --h-In-Reply-To test-message-id-1 | smtp_rj.pl | grep -E '2[[:digit:]][[:digit:]] id=[^[:space:]]+ .+ HT'
swaks -f mbox@test.advancedfiltering.net -t test@dmarc.test.advancedfiltering.net -s $DST_HOST -p submission --h-References test-message-id-1 | smtp_rj.pl | grep -E '2[[:digit:]][[:digit:]] id=[^[:space:]]+ .+ HT'
