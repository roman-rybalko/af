#!/bin/sh -ex
. ./remote.conf
[ -n "$disk" ]
[ ! -e /usr/local/advancedfiltering ]
gpart add -t freebsd-ufs -l advancedfiltering $disk
geli init -s 4096 -K *.key -P /dev/gpt/advancedfiltering
geli attach -k *.key -p /dev/gpt/advancedfiltering
newfs -L advancedfiltering -S 4096 -U -j /dev/gpt/advancedfiltering.eli
geli detach /dev/gpt/advancedfiltering.eli
mkdir /usr/local/advancedfiltering
