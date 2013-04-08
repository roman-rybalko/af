#!/bin/sh

set -ex

host="$1"
[ -n "$host" ]
ldapsearch -h "$host" -x -b "" -s base -LLL supportedSASLMechanisms || ldapsearch -h "$host" -b "" -s base -LLL supportedSASLMechanisms
