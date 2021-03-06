#!/bin/sh -ex
. ./remote.conf

pkg install -y bash-completion

if [ -e /usr/local/bin/bash ]; then
    chsh -s /usr/local/bin/bash root
    echo ". /usr/local/share/bash-completion/bash_completion.sh" >> /root/.profile
fi

pkg install -y screen
pkg install -y mc
pkg install -y rsync

tar -xvf mc-config.tgz -C /root/

patch /etc/ssh/ssh_config ssh_config.diff

rm -vf /.cshrc /.profile

patch /etc/mail/aliases aliases.diff
newaliases

cat /var/mail/* || true
rm -vf /var/mail/* || true
