#!/bin/sh -ex

host=$1
[ -n "$host" ]

. ./local.conf

cp -a $ca ./ca
