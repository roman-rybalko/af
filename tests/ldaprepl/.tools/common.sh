
CUR_TIME=`date +%s`
YSTD_TIME=$(($CUR_TIME-86400))

add_ldif()
{

	cat $* \
		| ldif_nl.pl \
		| sed "s/src.hosts.advancedfiltering.net/$SRC_HOST/g;s/src2.hosts.advancedfiltering.net/$SRC2_HOST/g;s/dst.hosts.advancedfiltering.net/$DST_HOST/g;" \
		| sed "s/1234567890/$CUR_TIME/g;s/0987654321/$YSTD_TIME/g;" \
		| ldapadd.sh
}

del_ldif()
{
	cat $* \
		| ldif_nl.pl \
		| ldif_dn.pl \
		| sed "s/src.hosts.advancedfiltering.net/$SRC_HOST/g;s/src2.hosts.advancedfiltering.net/$SRC2_HOST/g;s/dst.hosts.advancedfiltering.net/$DST_HOST/g;" \
		| sed "s/1234567890/$CUR_TIME/g;s/0987654321/$YSTD_TIME/g;" \
		| ldapdel.sh
}

match_ldif()
{
	local dn re ldif
	dn="$1"
	re="$2"
	ldif="$3"
	[ -n "$dn" ]
	[ -n "$re" ]
	[ -n "$ldif" ]
	ldapget.sh "$dn" | ldif_nl.pl | grep -i "$re" > .match_tmp.ldif
	diff -u "$ldif" .match_tmp.ldif
	rm .match_tmp.ldif
}
