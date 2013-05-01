#!/bin/sh

set -ex

base=$1
attr=$2
[ -n "$base" ]

ldapsearch -h h01.hosts.advancedfiltering.net -Z -b $base -s base -LLL $attr
