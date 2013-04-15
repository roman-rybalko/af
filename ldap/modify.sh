#!/bin/sh

set -ex

host="$1"
file="$2"
[ -n "$host" ]
[ -n "$file" ]
ldapmodify -h "$host" -Z -f "$file"
