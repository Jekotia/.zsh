#! /bin/bash

#origUser=`who am i | awk '{print $1}'`
origUser="$1"
echo "origUser = $origUser"

#if [[ "$origuser" == "" ]] ; then
#	echo "ERROR: Unable to determine which user invoked this script"
#	exit 1
#elif [[ "$origUser" == "root" ]] ; then
#	origHome="/root"
#else
#	origHome="/home/$origUser"
#fi


if which yum > /dev/null; then
	pkgMgr="yum"
elif which apt-get > /dev/null; then
	pkgMgr="apt-get"
elif which apt-cyg > /dev/null; then
	pkgMgr="apt-cyg"
fi

$pkgMgr -y install wget curl nano zsh git bc

if [[ ! "$2" == "--local" ]] ; then
	cd $HOME
	echo --- Cloning \'.zsh\' from origin
	sudo -u $origUser git clone http://git.jekotia.net/jekotia/.zsh.git
	chown -R $origUser:$origUser $origHome/.zsh
fi

if ( grep -Fxq "ZDOTDIR=\"\${ZDOTDIR:-\$HOME/.zsh}\"" "/etc/zshenv" || grep -Fxq "ZDOTDIR=\"\${ZDOTDIR:-\$HOME/.zsh}\"" "/etc/zsh/zshenv" ) ; then
	echo --- WARNING: Did not update zshenv
else
	if [ -e /etc/zshenv ] ; then
		echo --- Updating local /etc/zshenv
		echo "ZDOTDIR=\"\${ZDOTDIR:-\$HOME/.zsh}\"" >> /etc/zshenv
	elif [ -e /etc/zsh/zshenv ] ; then
		echo --- Updating local /etc/zsh/zshenv
		echo "ZDOTDIR=\"\${ZDOTDIR:-\$HOME/.zsh}\"" >> /etc/zsh/zshenv
	else
		echo "WARNING: Failed to find zshenv file!"
	fi
fi

cd $origHome/.zsh/extras/powerline-fonts/
sudo -u $origUser sh ./install.sh

cd $origHome/.zsh/extras/
sudo -u $origUser sh ./awesome-terminal-fonts-setup.sh
