#!/bin/sh -ex
. ./remote.conf
geli attach -k *.key -p -d /dev/gpt/advancedfiltering
fsck_ufs -p /dev/gpt/advancedfiltering.eli
[ ! -e /dev/gpt/advancedfiltering.eli ]
geli attach -k *.key -p -d /dev/gpt/advancedfiltering
mount /dev/gpt/advancedfiltering.eli /usr/local/advancedfiltering
