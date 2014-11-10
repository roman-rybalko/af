#!/bin/sh -ex

. "$TESTCONF"

ldapmodify -V -n </dev/null
which ldapdelete
smtp_server -h
host localhost
usleep 1
