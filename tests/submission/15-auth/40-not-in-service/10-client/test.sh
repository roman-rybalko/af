#!/bin/sh -ex
. "$TESTCONF"

swaks -tls -a LOGIN -au cli2 -ap password -f mbox@test.com -t test@test.advancedfiltering.net -s $DST_HOST -p submission -q auth | grep "Not in service"
swaks -tls -a PLAIN -au cli2 -ap password -f mbox@test.com -t test@test.advancedfiltering.net -s $DST_HOST -p submission -q auth | grep "Not in service"
