
add_ldif()
{
	cat $* \
		| ldif_nl.pl \
		| sed "s/src.hosts.advancedfiltering.net/$SRC_HOST/g;s/dst.hosts.advancedfiltering.net/$DST_HOST/g;" \
		| ldapadd.sh
}

del_ldif()
{
	cat $* \
		| ldif_nl.pl \
		| ldif_dn.pl \
		| sed "s/src.hosts.advancedfiltering.net/$SRC_HOST/g;s/dst.hosts.advancedfiltering.net/$DST_HOST/g;" \
		| ldapdel.sh
}
