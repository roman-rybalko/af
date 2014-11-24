#!/bin/sh -ex
. "$TESTCONF"

swaks -tls -a LOGIN -au cli1 -ap cli1password -f mbox@test.com -t test@tests.advancedfiltering.net -s $DST_HOST -p submission -q auth
swaks -tls -a PLAIN -au cli1 -ap cli1password -f mbox@test.com -t test@tests.advancedfiltering.net -s $DST_HOST -p submission -q auth
