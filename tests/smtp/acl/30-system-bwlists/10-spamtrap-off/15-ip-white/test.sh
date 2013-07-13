#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mail@unhandled.com -s $DST_HOST -q connect | grep --extended-regexp "220.+OK \(system policy, sender host"
swaks -f test@tests.advancedfiltering.net -t mail@unhandled.com -s $DST_HOST -q connect | grep --extended-regexp "220.+address\)"
