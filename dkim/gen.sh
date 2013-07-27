#!/bin/sh -ex

name=$1
[ -n "$name" ]
[ ! -e $name.key ]
openssl genrsa -out $name.key 1024
openssl rsa -in $name.key -out $name.pub -pubout -outform PEM
