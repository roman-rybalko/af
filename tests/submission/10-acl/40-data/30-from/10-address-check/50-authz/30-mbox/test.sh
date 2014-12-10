#!/bin/sh -ex
. "$TESTCONF"

swaks -tls -a -au mbox@test.advancedfiltering.net -ap mailboxpassword -f mbox@test.advancedfiltering.net -t nomail@dmarc.test.advancedfiltering.net -s $DST_HOST -p submission --h-From mbox2@test.advancedfiltering.net | smtp_rj.pl | grep -E '5[[:digit:]][[:digit:]] Authenticated user mbox@test.advancedfiltering.net may not use "From:" address mbox2@test.advancedfiltering.net'
