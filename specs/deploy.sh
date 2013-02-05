#!/bin/sh -ex
rm -Rvf /srv/www/roma/htdocs/romanr.info/tmp/af/*
cp -av spec-button.jpg result-error.xml result-ok-link.xml result-ok.xml static all.html spec-all.txt spec-form.jpg spec-page.jpg spec-table.jpg /srv/www/roma/htdocs/romanr.info/tmp/af/
cd /srv/www/roma/htdocs/romanr.info/tmp/
zip -9r af.zip af
mv -v af.zip af
rsync -aHSzv --progress --del af host.romanr.info:/var/www/romanr.info/tmp/
