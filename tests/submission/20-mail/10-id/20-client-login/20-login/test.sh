#!/bin/sh -ex
. "$TESTCONF"

swaks -tls -a LOGIN -au submission-test -ap cli1password -f mbox@test.advancedfiltering.net -t test@test.com -s $DST_HOST -p submission -q mail
