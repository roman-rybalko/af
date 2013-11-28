#!/bin/sh -ex
. "$TESTCONF"

"$TESTDIR"/mbxlog.sh -v 3
[ -e state ]
[ -e .tasks/r1-cli1-test.com-mbox ]
