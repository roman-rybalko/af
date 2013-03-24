#!/bin/sh -ex
rm -Rvf /srv/www/roma/htdocs/romanr.info/tmp/af/*
cp -av html xslt spec-*.txt spec-*.jpg design.* /srv/www/roma/htdocs/romanr.info/tmp/af/
cd /srv/www/roma/htdocs/romanr.info/tmp/
zip -9r af.zip af
mv -v af.zip af
rsync -aHSzv --progress --del af host.romanr.info:/var/www/romanr.info/tmp/
