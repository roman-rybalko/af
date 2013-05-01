#!/bin/sh

set -ex

cd /

export PACKAGESITE=http://deploy/packages/All/

pkg_add -r bash-completion-2.0,1
if [ -e /usr/local/bin/bash ]; then
    chsh -s /usr/local/bin/bash root
    chsh -s /usr/local/bin/bash roma
    echo ". /usr/local/share/bash-completion/bash_completion.sh" >> /root/.profile
    echo ". /usr/local/share/bash-completion/bash_completion.sh" >> /home/roma/.profile
fi

pkg_add -r screen-4.0.3_14
pkg_add -r mc-4.8.1.7

pkg_add -r expect-5.43.0_3
H=`hostname`
expect -c "spawn ktutil get -p deploy/init host/$H ; \
    expect assword: ; \
    send \"YXwC0qcEGICs0DqkWltMaTStiRB9W5zooQd4Z1hUk3\\n\" ; \
    interact"
pw groupadd krb5kt
chgrp krb5kt /etc/krb5.keytab
chmod g+r /etc/krb5.keytab

fetch http://deploy/etc-ssh.tgz
tar -zxv -f etc-ssh.tgz -C /
service sshd restart
rm -vf etc-ssh.tgz

pw user mod root -w no
chmod u=rwx,g=rx,o-rwx /root

pw user mod roma -w no

rm -vf /`basename $0`
