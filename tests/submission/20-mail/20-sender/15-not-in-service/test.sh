#!/bin/sh -ex
. "$TESTCONF"

swaks -f mbox@testxxx.advancedfiltering.net -t test@test.com -s $DST_HOST -p submission -q mail | grep 'is not in service'
