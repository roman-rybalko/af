#!/bin/sh -ex
. "$TESTCONF"

"$TESTDIR"/mbxlog.sh -v 3
[ -e state ]
