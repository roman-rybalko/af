#!/bin/sh

set -ex

ldapsearch -h deploy.hosts.advancedfiltering.net -ZZ -x -b "" -s base -LLL namingContexts
