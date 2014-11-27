#!/bin/sh -ex
. "$TESTCONF"

swaks -f mbox@aliasalias.test.advancedfiltering.net -t test@test.com -s $DST_HOST -p submission -q mail | grep 'double domain alias'
