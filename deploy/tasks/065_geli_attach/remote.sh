#!/bin/sh -ex
. ./remote.conf
geli attach -k *.key -p -d /dev/gpt/advancedfiltering
mount /dev/gpt/advancedfiltering.eli /usr/local/advancedfiltering
