#!/bin/sh -ex
. "$TESTCONF"

"$TESTDIR"/mbxlog.sh
[ -e state ]
[ -e .tasks/r1-cli1-test.com-mbox ]
