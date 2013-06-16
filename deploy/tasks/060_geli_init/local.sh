#!/bin/sh -ex

host=$1
[ -n "$host" ]

. ./local.conf

[ -n "$geli" ]

[ -e $geli/$host.key ] || dd if=/dev/random of=$geli/$host.key bs=64 count=1

cp $geli/$host.key ./
