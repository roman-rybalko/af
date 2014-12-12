#!/bin/sh -ex

. "$TESTCONF"

swaks -f mbox@test.advancedfiltering.net -t test@dmarc.test.advancedfiltering.net -s $DST_HOST -p submission --h-Reply-To mbox@nomail.test.advancedfiltering.net | smtp_rj.pl | grep -E '5[[:digit:]][[:digit:]] "Reply-To:" domain nomail.test.advancedfiltering.net does not accept mail'
