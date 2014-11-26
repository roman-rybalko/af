#!/bin/sh -ex

. "$TESTCONF"

swaks -tls -f mbox@test.advancedfiltering.net -t test@test.com -s $DST_HOST -p submission -q mail | grep 'Trusted host certificate verification failed'
