#!/bin/sh -ex

. "$TESTCONF"

swaks --version | grep --extended-regexp '201[345][[:digit:]]{4}'
ldapmodify -V -n </dev/null
which ldapdelete
smtp_server -h
host localhost
usleep 1
