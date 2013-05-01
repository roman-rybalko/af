#!/bin/sh

set -ex

host="$1"
[ -n "$host" ]
ldapsearch -h "$host" -Z -b "" -s base -LLL namingContexts
