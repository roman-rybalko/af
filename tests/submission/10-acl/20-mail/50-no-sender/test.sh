#!/bin/sh -ex
. "$TESTCONF"

swaks -f '<>' -t mbox@test.com -s $DST_HOST -p submission -q mail | grep 'none cli1 client SS:'
