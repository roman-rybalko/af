#!/bin/sh

set -ex

ldapsearch -h h01.hosts.advancedfiltering.net -Z -b "" -s base -LLL supportedSASLMechanisms
