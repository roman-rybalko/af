#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@advancedfiltering.net -t mail@unhandled.com -s $DST_HOST -q connect | grep "550 5.7.0 Access denied (system policy, sender host name)"
