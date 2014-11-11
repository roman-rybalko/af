#!/bin/sh -ex

host=$1
[ -n "$host" ]
dn="$2"
[ -n "$dn" ] || dn="ou=system,o=advancedfiltering"
scope=$3
[ -n "$scope" ] || scope=base

ldapsearch -h $host.hosts.advancedfiltering.net \
 -ZZ \
 -x -D cn=admin,ou=auth -w admin \
 -LLL \
 -b "$dn" -s $scope
