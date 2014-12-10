#!/bin/sh -ex
. "$TESTCONF"

swaks -tls -a -au cli1 -ap clientpassword -f mbox@nodmarc.test.advancedfiltering.net -t mbox@test.com -s $DST_HOST -p submission -q mail | smtp_rj.pl | grep -E '5[[:digit:]][[:digit:]] Authenticated user cli1 may not use Envelope-From address mbox@nodmarc.test.advancedfiltering.net'
