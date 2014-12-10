#!/bin/sh -ex
. "$TESTCONF"

swaks -tls -a -au test.advancedfiltering.net -ap domainpassword -f mbox@nodmarc.test.advancedfiltering.net -t mbox@test.com -s $DST_HOST -p submission -q mail | smtp_rj.pl | grep -E '5[[:digit:]][[:digit:]] Authenticated user test.advancedfiltering.net may not use Envelope-From address mbox@nodmarc.test.advancedfiltering.net'
