#!/bin/sh -ex
. ./remote.conf

adduser -f adduser.batch -M 0700 -w no -G wheel
tar -xvf k5login.tgz -C /home/roma/
tar -xvf mc-config.tgz -C /home/roma/

if [ -e /usr/local/bin/bash ]; then
    chsh -s /usr/local/bin/bash roma
    echo ". /usr/local/share/bash-completion/bash_completion.sh" >> /home/roma/.profile
fi
