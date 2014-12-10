#!/bin/sh -ex
. "$TESTCONF"

#swaks -f mbox -t test@test.com -s $DST_HOST -p submission --h-From mbox | smtp_rj.pl | grep -E '5[[:digit:]][[:digit:]] Envelope-From address mbox does not have a domain'
swaks -f mbox -t test@test.com -s $DST_HOST -p submission -q mail | grep 'sender address must contain a domain' # exim unqualified sender
