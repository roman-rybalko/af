#!/bin/sh -ex
. remote.conf

chmod o-rwx,g-w /root
echo 'setenv PACKAGEROOT http://deploy/packages' >> /root/.cshrc
echo 'export PACKAGEROOT=http://deploy/packages' >> /root/.profile

# TODO: add search hosts.advancedfiltering.net to /etc/resolv.conf

pkg_add -r bash-completion

if [ -e /usr/local/bin/bash ]; then
    chsh -s /usr/local/bin/bash root
    echo ". /usr/local/share/bash-completion/bash_completion.sh" >> /root/.profile
fi

pkg_add -r screen
pkg_add -r mc

tar -xvf mc-config.tgz -C /root/

patch /etc/ssh/ssh_config ssh_config.diff

rm -vf /.cshrc /.profile
