
get_ip()
{
	host $1 | awk '/address/{sub(/.+ address /,"");print}'
}

SRC_IP=`get_ip $SRC_HOST`
DST_IP=`get_ip $DST_HOST`

add_ldif()
{

	cat $* \
		| ldif_nl.pl \
		| sed "s/src.hosts.advancedfiltering.net/$SRC_HOST/g;s/dst.hosts.advancedfiltering.net/$DST_HOST/g;" \
		| sed "s/1\\.2\\.3\\.4/$SRC_IP/g;s/4\\.3\\.2\\.1/$DST_IP/g;" \
		| ldapadd.sh
}

del_ldif()
{
	cat $* \
		| ldif_nl.pl \
		| ldif_dn.pl \
		| sed "s/src.hosts.advancedfiltering.net/$SRC_HOST/g;s/dst.hosts.advancedfiltering.net/$DST_HOST/g;" \
		| sed "s/1\\.2\\.3\\.4/$SRC_IP/g;s/4\\.3\\.2\\.1/$DST_IP/g;" \
		| ldapdel.sh
}

start_server()
{
	local id
	id=$1
	shift
	smtp_server -c "$TESTDIR"/.tools/tests.crt -k "$TESTDIR"/.tools/tests.key $* &
	echo $! >smtp_server_$id.pid
}

stop_server()
{
	local id
	id=$1
	[ -e smtp_server_$id.pid ] || return
	kill `cat smtp_server_$id.pid` || true
	rm -f smtp_server_$id.pid
}

wait_file()
{
	local c f
	f=$1
	c=5
	while [ $c -gt 0 ]; do
		[ ! -e $f ] || break
		c=$(($c-1))
		sleep 1
	done
	[ -e $f ]
}
