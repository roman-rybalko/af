#!/bin/sh -ex

pem=$1
[ -n "$pem" ]
[ -e $pem.pub ]
echo "v=DKIM1; k=rsa; p=`./pem2line.pl $pem.pub`; t=s;"
