#!/bin/sh -ex

. "$TESTCONF"

which swaks
which ldapmodify
which ldapdelete
smtp_server.pl -t
