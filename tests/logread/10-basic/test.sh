#!/bin/sh -ex
. "$TESTCONF"

export TESTPROC_OK=1
"$TESTDIR"/.target/logread.sh -v 2
grep -v TEST/1 testproc.log
grep Test/2 testproc.log
grep -v TEST/3 testproc.log
grep -v test/4 testproc.log
grep Test/5 testproc.log
