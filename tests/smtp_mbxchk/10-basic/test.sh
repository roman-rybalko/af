#!/bin/sh -ex
. "$TESTCONF"

"$TESTDIR"/work.sh
[ -e mbxchk_state ]
