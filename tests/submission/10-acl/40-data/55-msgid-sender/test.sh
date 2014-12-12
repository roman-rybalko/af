#!/bin/sh -ex

. "$TESTCONF"

swaks -f mbox@test.advancedfiltering.net -t test@dmarc.test.advancedfiltering.net -s $DST_HOST -p submission --h-Message-Id test-message-id-1 | smtp_rj.pl | grep -E '5[[:digit:]][[:digit:]] Duplicate message, original sender mbox2@test.advancedfiltering.net'
