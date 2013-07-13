#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mail@unhandled.com -s $DST_HOST -q connect | grep "550.Access denied (system policy, sender host name)"
