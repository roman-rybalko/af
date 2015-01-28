#!/bin/sh -ex
. "$TESTCONF"

export TESTPROC_OK=1

"$TESTDIR"/.target/logread.sh -i logread-test -f local0
