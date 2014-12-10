#!/bin/sh -ex
. "$TESTCONF"

swaks -f mbox@test.advancedfiltering.net -t nomail@dmarc.test.advancedfiltering.net -s $DST_HOST -p submission --h-From mbox@dmarc.test.advancedfiltering.net | smtp_rj.pl | grep -E '4[[:digit:]][[:digit:]] "From:" domain dmarc.test.advancedfiltering.net \(alias to nodmarc.test.advancedfiltering.net\) has configuration problem \(double domain alias\)'
