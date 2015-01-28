#!/bin/sh -ex

. "$TESTCONF"

add_ldif system.ldif

rm -f smtp.env smtp2.env
