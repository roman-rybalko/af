#!/bin/sh -ex

host=$1
[ -n "$host" ]

. local.conf

host=$host.$domain

if [ ! -e $easyrsa/keys/$host.crt ]
then
	workdir="`pwd`"
	cd $easyrsa
	. vars
	./build-key $host
	cd "$workdir"
fi

cp $easyrsa/keys/$host.crt $easyrsa/keys/$host.key ./
cp -a $ca ./ca
