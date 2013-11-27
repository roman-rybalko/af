#!/bin/sh -ex
. "$TESTCONF"

./export-cf.sh
./learn.sh
./export-st.sh
