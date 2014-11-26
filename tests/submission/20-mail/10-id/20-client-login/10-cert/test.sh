#!/bin/sh -ex
. "$TESTCONF"

swaks -tls --tls-sni submission.submission-test.clients.advancedfiltering.net -f mbox@test.advancedfiltering.net -t test@test.com -s $DST_HOST -p submission -q mail | grep 'Client certificate verification failed'
