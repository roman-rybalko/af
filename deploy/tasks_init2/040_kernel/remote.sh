#!/bin/sh -ex
. remote.conf
rm -Rf /boot/kernel.old
mv /boot/kernel /boot/kernel.old
fetch -o - http://deploy/deploy/kernel.txz | tar -Jxvf - -C /boot/
