#!/bin/sh -ex
. "$TESTCONF"

swaks -tls -a LOGIN -au mbox@test2.com -ap password -f mbox@test.com -t test@tests.advancedfiltering.net -s $DST_HOST -p submission -q auth | grep Moved
swaks -tls -a PLAIN -au mbox@test2.com -ap password -f mbox@test.com -t test@tests.advancedfiltering.net -s $DST_HOST -p submission -q auth | grep Moved
