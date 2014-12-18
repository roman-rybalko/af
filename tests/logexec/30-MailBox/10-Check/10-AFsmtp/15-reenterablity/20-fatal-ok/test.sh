#!/bin/sh -ex
. "$TESTCONF"

export AF_private_tls_cert="$TESTDIR"/.tools/tests.crt
export AF_private_tls_key="$TESTDIR"/.tools/tests.key
export AF_private_tls_ca=

rm -f smtp.env smtp2.env
cnt=10
while ! [ -e smtp.env -a -e smtp2.env ]; do
	rm -vf smtp.env smtp2.env
	# 252
	start_server smtp -s 1 -e smtp.env -p 12525 -r test2@test.com -y '252 Test'
	start_server smtp2 -s 2 -e smtp2.env -p 2525
	"$TESTDIR"/.target/logexec-cli.sh 'AdvancedFiltering/MailBox/Check/AFsmtp<test2@test.com> ? AdvancedFiltering/MailBox/Check/AFsmtp<test3@test.com> : AdvancedFiltering/MailBox/Check/AFsmtp<test4@test.com>' || true
	stop_server smtp
	stop_server smtp2
	cnt=$(($cnt-1))
	[ $cnt -gt 0 ]
done
grep test2@test.com smtp.env
grep test3@test.com smtp2.env

rm -f smtp.env smtp2.env
cnt=10
while ! [ -e smtp.env -a -e smtp2.env ]; do
	rm -vf smtp.env smtp2.env
	# 450
	start_server smtp -s 1 -e smtp.env -p 12525 -r test2@test.com -y '450 Test'
	start_server smtp2 -s 2 -e smtp2.env -p 2525
	"$TESTDIR"/.target/logexec-cli.sh 'AdvancedFiltering/MailBox/Check/AFsmtp<test2@test.com> ? AdvancedFiltering/MailBox/Check/AFsmtp<test3@test.com> : AdvancedFiltering/MailBox/Check/AFsmtp<test4@test.com>' || true
	stop_server smtp
	stop_server smtp2
	cnt=$(($cnt-1))
	[ $cnt -gt 0 ]
done
grep test2@test.com smtp.env
grep test3@test.com smtp2.env
