#!/bin/sh -ex

export PACKAGESITE=http://deploy/packages/All/

pkg_add -r expect-5.43.0_3

H=`hostname`
expect -c "spawn ktutil get -p deploy/init host/$H ; \
    expect assword: ; \
    send \"YiKr1vWrvnn8iLVeiqJUww04tq6gwwoDOiQuOIVEH9\\n\" ; \
    interact ; \
    catch wait result; exit [lindex \$result 3]"

tar -zxvf k5login.tgz -C /root
