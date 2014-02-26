#!/bin/sh -ex
. ./remote.conf
pkg install -y sudo
adduser -f adduser.batch -M 0700 -w no
tar -xvf k5login.tgz -C /home/deploy/
tar -xvf sudoers.tgz -C /usr/local/etc/sudoers.d/
