
pkgdep_install()
{
	service=$1
	shift
	for pkg in "$@"; do
		pkg install -y $pkg
		mkdir -vp /usr/local/advancedfiltering/pkgdep/$pkg
		touch /usr/local/advancedfiltering/pkgdep/$pkg/$service
	done
	chmod u=rwx,g=rx,o= /usr/local/advancedfiltering/pkgdep
}

pkgdep_uninstall()
{
	service=$1
	shift
	for pkg in "$@"; do
		rm -vf /usr/local/advancedfiltering/pkgdep/$pkg/$service
		for f in /usr/local/advancedfiltering/pkgdep/$pkg/*; do
			[ ! -e $f ] || break
			pkg delete -y $pkg || true
			rm -Rvf /usr/local/advancedfiltering/pkgdep/$pkg
			break
		done
	done
	pkg autoremove -y
}

pkgdep_cleanup()
{
	while [ -n "$1" ]; do
		pkg=$1
		shift
		cmd=$1
		shift
		[ -e /usr/local/advancedfiltering/pkgdep/$pkg ] || $cmd
	done
}
