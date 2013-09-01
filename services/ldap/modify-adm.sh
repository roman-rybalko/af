#!/bin/sh

set -ex

host="$1"
file="$2"
[ -n "$host" ]
[ -n "$file" ]
ldapmodify -h $host.hosts.advancedfiltering.net -ZZ -f "$file" -a -x -D cn=deploy,cn=config -w deploy
