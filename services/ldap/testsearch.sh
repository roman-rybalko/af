#!/bin/sh -ex

host=$1
[ -n "$host" ]

ldapsearch -h $host.hosts.advancedfiltering.net \
 -ZZ \
 -x -D cn=admin,ou=system,o=advancedfiltering -w admin \
 -LLL \
 -b ou=system,o=advancedfiltering -s base
