#!/bin/sh -ex

. ./remote.conf
#date `cat curtime` || true # may be in another time zone
pkg_add -r expect # for sshpass
./sshpass.sh deploy-init.pw ktutil get -p deploy/init host/`hostname`
tar -xvf k5login.tgz -C /root/
patch /etc/ssh/sshd_config sshd_config.diff
service sshd restart
#pw user mod root -w no # blocks deploy cleanup
