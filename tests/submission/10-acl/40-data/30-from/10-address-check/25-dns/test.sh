#!/bin/sh -ex
. "$TESTCONF"

swaks -f mbox@test.advancedfiltering.net -t nomail@dmarc.test.advancedfiltering.net -s $DST_HOST -p submission --h-From mbox@nomail.test.advancedfiltering.net | smtp_rj.pl | grep -E '5[[:digit:]][[:digit:]] "From:" domain nomail.test.advancedfiltering.net does not accept mail'
