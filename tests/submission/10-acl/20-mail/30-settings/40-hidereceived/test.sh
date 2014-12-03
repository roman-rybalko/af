#!/bin/sh -ex
. "$TESTCONF"

swaks -f mbox@test.advancedfiltering.net -t mbox@test.com -s $DST_HOST -p submission -q mail | grep 'cli1 client HR:client'
