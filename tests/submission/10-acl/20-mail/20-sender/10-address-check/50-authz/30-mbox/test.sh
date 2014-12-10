#!/bin/sh -ex
. "$TESTCONF"

swaks -tls -a -au mbox@test.advancedfiltering.net -ap mailboxpassword -f mbox2@test.advancedfiltering.net -t mbox@test.com -s $DST_HOST -p submission -q mail | smtp_rj.pl | grep -E '5[[:digit:]][[:digit:]] Authenticated user mbox@test.advancedfiltering.net may not use Envelope-From address mbox2@test.advancedfiltering.net'
