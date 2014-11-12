#!/bin/sh -ex

. `dirname $0`/logread.conf
`dirname $0`/logread.pl -h
exec `dirname $0`/logread.pl -l "$LOG" -b "$BAK" -s "$STATE" -p "$PROC" -r "$FILTER" -m "$MAX" "$@"
