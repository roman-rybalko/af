#!/bin/sh -ex
. "$TESTCONF"

"$TESTDIR"/mbxlog.sh
[ -e state ]
