#!/bin/sh -ex
. "$TESTCONF"

swaks -f mbox@dmarc.test.advancedfiltering.net -t test@test.com -s $DST_HOST -p submission -q mail | smtp_rj.pl | grep -E '4[[:digit:]][[:digit:]] Envelope-From domain dmarc.test.advancedfiltering.net \(alias to nodmarc.test.advancedfiltering.net\) has configuration problem \(double domain alias\)'
