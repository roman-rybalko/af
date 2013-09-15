#!/bin/sh -ex
. ./remote.conf

grep nameserver /etc/resolv.conf > /etc/resolv.conf.new
echo "search services.advancedfiltering.net hosts.advancedfiltering.net" >> /etc/resolv.conf.new
mv -f /etc/resolv.conf.new /etc/resolv.conf
