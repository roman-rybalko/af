#!/bin/sh -ex

host=$1
[ -n "$host" ]

ldapsearch -h $host.hosts.advancedfiltering.net -ZZ -x -b "" -s base -LLL namingContexts
