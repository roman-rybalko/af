#!/bin/sh -ex
. "$TESTCONF"

swaks -f mbox@nodmarc.test.advancedfiltering.net -t test@test.com -s $DST_HOST -p submission -q mail | smtp_rj.pl | grep -E '4[[:digit:]][[:digit:]] Envelope-From domain nodmarc.test.advancedfiltering.net is moved, please try another host'
