#!/bin/sh -ex
. "$TESTCONF"

#swaks -f mbox@test.advancedfiltering.net -t nomail@dmarc.test.advancedfiltering.net -s $DST_HOST -p submission --h-From mbox | smtp_rj.pl | grep -E '5[[:digit:]][[:digit:]] "From:" address mbox does not have a domain'
swaks -f mbox@test.advancedfiltering.net -t nomail@dmarc.test.advancedfiltering.net -s $DST_HOST -p submission --h-From mbox | smtp_rj.pl | grep -E '5[[:digit:]][[:digit:]] Invalid message headers'
