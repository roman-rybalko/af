#!/bin/sh -ex

. "$TESTCONF"

add_ldif system.ldif
"$TESTDIR"/ldaprepl.sh
