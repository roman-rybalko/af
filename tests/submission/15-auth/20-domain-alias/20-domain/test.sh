#!/bin/sh -ex
. "$TESTCONF"

swaks -tls -a LOGIN -au test2.com -ap test.compassword -f mbox@test.com -t test@tests.advancedfiltering.net -s $DST_HOST -p submission -q auth
swaks -tls -a PLAIN -au test2.com -ap test.compassword -f mbox@test.com -t test@tests.advancedfiltering.net -s $DST_HOST -p submission -q auth
