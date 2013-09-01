#!/bin/sh -ex

host=$1
[ -n "$host" ]

openssl s_client -connect $host.hosts.advancedfiltering.net:636 \
 -cert ../../easy-rsa/keys/test-cli.crt -key ../../easy-rsa/keys/test-cli.key \
 -CApath ../../dist/system-ca -verify 10 \
 -showcerts -state

# -cert ../../easy-rsa/keys/test-crl.crt -key ../../easy-rsa/keys/test-crl.key \
