#!/bin/sh -ex
. "$TESTCONF"

swaks -tls -a LOGIN -au test.com -ap password -f mbox@test.com -t test@tests.advancedfiltering.net -s $DST_HOST -p submission -q auth | grep Replicating
swaks -tls -a PLAIN -au test.com -ap password -f mbox@test.com -t test@tests.advancedfiltering.net -s $DST_HOST -p submission -q auth | grep Replicating
