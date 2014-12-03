#!/bin/sh -ex
. "$TESTCONF"

#swaks -f mbox -t test@test.com -s $DST_HOST -p submission -q mail | grep 'is not set'
swaks -f mbox -t test@test.com -s $DST_HOST -p submission -q mail | grep 'sender address must contain a domain' # exim unqualified sender
