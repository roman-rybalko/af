#!/bin/sh -ex
. "$TESTCONF"

swaks -f mbox@test.advancedfiltering.net -t nomail@dmarc.test.advancedfiltering.net -s $DST_HOST -p submission --h-From mbox@nodmarc.test.advancedfiltering.net | smtp_rj.pl | grep -E '5[[:digit:]][[:digit:]] DMARC is absent for "From:"'
