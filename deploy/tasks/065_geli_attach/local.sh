#!/bin/sh -ex

host=$1
[ -n "$host" ]

. ./local.conf

[ -n "$geli" ]

cp $geli/$host.key ./
