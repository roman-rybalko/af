#!/bin/sh -ex
. "$TESTCONF"

swaks -tls -a -au cli1 -ap clientpassword -f mbox@test.advancedfiltering.net -t nomail@dmarc.test.advancedfiltering.net -s $DST_HOST -p submission --h-From mbox@nodmarc.test.advancedfiltering.net | smtp_rj.pl | grep -E '5[[:digit:]][[:digit:]] Authenticated user cli1 may not use "From:" address mbox@nodmarc.test.advancedfiltering.net'
