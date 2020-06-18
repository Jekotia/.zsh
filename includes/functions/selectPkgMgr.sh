#! /bin/zsh
function selectPkgMgr () {
	if which yum ; then
		pkgMgr="yum"
	elif which apt-get ; then
		pkgMgr="apt-get"
	elif which pact ; then
		pkgMgr="pact"
	fi
}
#pkgMgr=""
#selectPkgMgr
#echo Found $pkgMgr