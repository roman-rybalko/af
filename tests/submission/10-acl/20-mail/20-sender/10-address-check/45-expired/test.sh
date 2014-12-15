#!/bin/sh -ex
. "$TESTCONF"

swaks -f mbox2@test.advancedfiltering.net -t test@test.com -s $DST_HOST -p submission -q mail | grep ' EXP'
wait_ldif_del user.ldif
