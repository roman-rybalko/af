#!/bin/sh

{ echo server 10.255.255.1; echo "update $@"; echo send; } | nsupdate -y `cat key` -v
