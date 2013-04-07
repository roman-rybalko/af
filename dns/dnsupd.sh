#!/bin/sh

{ echo "update $@"; echo send; } | nsupdate -y `cat key` -v
