#!/bin/sh

set -ex

host="$1"
file="$2"
[ -n "$host" ]
[ -n "$file" ]
ldapmodify -h "$host" -ZZ -f "$file" -a -x -D cn=tvorg8TRpo1U,cn=config -w 1
