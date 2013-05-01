#!/bin/sh

set -ex

host="$1"
file="$2"
[ -n "$host" ]
[ -n "$file" ]
ldapmodify -h "$host" -Z -f "$file" -a -D cn=tvorg8TRpo1U,cn=config -w 1
