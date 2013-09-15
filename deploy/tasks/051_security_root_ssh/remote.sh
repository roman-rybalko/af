#!/bin/sh -ex
. ./remote.conf

chmod o-rwx,g-w /root
pw user mod root -w no
patch /etc/ssh/sshd_config sshd_config.diff
service sshd restart
