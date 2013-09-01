#!/bin/sh

set -ex

host="$1"
file="$2"
[ -n "$host" ]
[ -n "$file" ]
ldapmodify -h $host.hosts.advancedfiltering.net -ZZ -f "$file" -a -x -D cn=admin,ou=system,o=advancedfiltering -w admin
