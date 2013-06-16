#!/bin/sh -ex

. ./remote.conf
date `cat curtime` || true
pkg_add -r expect # for sshpass
./sshpass.sh deploy-init.pw ktutil get -p deploy/init host/`hostname`
tar -zxvf k5login.tgz -C /root/
