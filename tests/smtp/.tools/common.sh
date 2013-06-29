
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
