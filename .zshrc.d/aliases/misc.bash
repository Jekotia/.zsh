#! /usr/bin/env bash

#irccert='sudo su -l weechat -c "irccert $1"'

if is_linux ; then
	if [[ -e /var/www/html/owncloud/occ ]] ; then
		alias occ="sudo -uapache /var/www/html/owncloud/occ"
	fi
	alias apt-search="dpkg-query -L"
	alias composer="sudo -uapache composer"
#elif is_wsl ; then
	#alias
elif is_cygwin ; then
	#alias ping='cygping'
	#alias cyg-update
	alias tracert='mtr'
fi