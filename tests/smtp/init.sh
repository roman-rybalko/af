#!/bin/sh -ex

. "$TESTCONF"

swaks --version | grep --extended-regexp '201[345][[:digit:]]{4}'
which ldapmodify
which ldapdelete
smtp_server -h
which host
