#!/bin/sh -e

zone=$1
host -t srv _kerberos-adm._tcp.$zone | awk '{print $8}'
