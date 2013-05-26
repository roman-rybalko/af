#!/bin/sh -ex

adduser -f adduser.batch -M 0700 -w no
tar -zxvf k5login.tgz -C /home/deploy
