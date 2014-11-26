#!/bin/sh -ex
. "$TESTCONF"

swaks -tls -a LOGIN -au test2.com -ap password -f mbox@test.com -t test@test.advancedfiltering.net -s $DST_HOST -p submission -q auth | grep Moved
swaks -tls -a PLAIN -au test2.com -ap password -f mbox@test.com -t test@test.advancedfiltering.net -s $DST_HOST -p submission -q auth | grep Moved
