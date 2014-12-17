
get_ip()
{
	host $1 | awk '/has address/{sub(/.+ address /,"");print}{next}'
}

SRC_IP=`get_ip $SRC_HOST`
DST_IP=`get_ip $DST_HOST`
CUR_TIME=`date +%s`
YSTD_TIME=$(($CUR_TIME-86400))

add_ldif()
{

	cat $* \
		| ldif_nl.pl \
		| sed "s/src.hosts.advancedfiltering.net/$SRC_HOST/g;s/dst.hosts.advancedfiltering.net/$DST_HOST/g;" \
		| sed "s/1\\.2\\.3\\.4/$SRC_IP/g;s/4\\.3\\.2\\.1/$DST_IP/g;" \
		| sed "s/1234567890/$CUR_TIME/g;s/0987654321/$YSTD_TIME/g;" \
		| ldapadd.sh
}

del_ldif()
{
	cat $* \
		| ldif_nl.pl \
		| ldif_dn.pl \
		| sed "s/src.hosts.advancedfiltering.net/$SRC_HOST/g;s/dst.hosts.advancedfiltering.net/$DST_HOST/g;" \
		| sed "s/1\\.2\\.3\\.4/$SRC_IP/g;s/4\\.3\\.2\\.1/$DST_IP/g;" \
		| sed "s/1234567890/$CUR_TIME/g;s/0987654321/$YSTD_TIME/g;" \
		| ldapdel.sh
}

wait_file()
{
	local c f
	f=$1
	c=50
	while [ $c -gt 0 ]; do
		[ ! -e $f ] || break
		c=$(($c-1))
		usleep 100000
	done
	[ -e $f ]
}

start_server()
{
	local id
	id=$1
	shift
	if [ -e smtp_server_$id.pid ]; then
		if kill -0 `cat smtp_server_$id.pid`; then
			false
		fi
		rm -f smtp_server_$id.pid
	fi
	if echo $id | grep notls >/dev/null; then
		smtp_server -P smtp_server_$id.pid "$@" &
	else
		smtp_server -c "$TESTDIR"/.tools/tests.crt -k "$TESTDIR"/.tools/tests.key -C "$TESTDIR"/.tools/ca.crt -P smtp_server_$id.pid "$@" &
	fi
	wait_file smtp_server_$id.pid
}

stop_server()
{
	local id
	id=$1
	[ -e smtp_server_$id.pid ] || return 0
	kill `cat smtp_server_$id.pid` || true
	rm -f smtp_server_$id.pid
}
