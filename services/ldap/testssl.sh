#!/bin/sh

set -ex

openssl s_client -connect deploy.hosts.advancedfiltering.net:636 \
 -cert ../../easy-rsa/keys/test-cli.crt -key ../../easy-rsa/keys/test-cli.key \
 -showcerts -state
