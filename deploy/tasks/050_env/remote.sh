#!/bin/sh -ex
. ./remote.conf

echo 'setenv PACKAGEROOT http://deploy/packages' >> /root/.cshrc
echo 'export PACKAGEROOT=http://deploy/packages' >> /root/.profile

grep nameserver /etc/resolv.conf > /etc/resolv.conf.new
mv -f /etc/resolv.conf.new /etc/resolv.conf

pkg_add -r bash-completion

if [ -e /usr/local/bin/bash ]; then
    chsh -s /usr/local/bin/bash root
    echo ". /usr/local/share/bash-completion/bash_completion.sh" >> /root/.profile
fi

pkg_add -r screen
pkg_add -r mc
pkg_add -r rsync

tar -xvf mc-config.tgz -C /root/

patch /etc/ssh/ssh_config ssh_config.diff

rm -vf /.cshrc /.profile

ln -sv /usr/local/advancedfiltering/rc.conf /etc/rc.conf.local

patch /etc/mail/aliases aliases.diff
newaliases

cat /var/mail/* || true
rm -vf /var/mail/* || true
