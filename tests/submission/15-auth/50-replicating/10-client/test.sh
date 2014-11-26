#!/bin/sh -ex
. "$TESTCONF"

swaks -tls -a LOGIN -au cli1 -ap password -f mbox@test.com -t test@test.advancedfiltering.net -s $DST_HOST -p submission -q auth | grep Replicating
swaks -tls -a PLAIN -au cli1 -ap password -f mbox@test.com -t test@test.advancedfiltering.net -s $DST_HOST -p submission -q auth | grep Replicating
