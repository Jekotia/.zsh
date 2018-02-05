#! /bin/bash

user=$USER

if which yum > /dev/null; then
	pkgMgr="yum"
elif which apt-get > /dev/null; then
	pkgMgr="apt-get"
elif which apt-cyg > /dev/null; then
	pkgMgr="apt-cyg"
fi

sudo $pkgMgr -y install wget curl nano zsh git bc

echo --- Cloning \'.zsh\' from origin
git clone http://git.jekotia.net/jekotia/.zsh.git

if ( grep -Fxq "ZDOTDIR=\"\${ZDOTDIR:-\$HOME/.zsh}\"" "/etc/zshenv" || grep -Fxq "ZDOTDIR=\"\${ZDOTDIR:-\$HOME/.zsh}\"" "/etc/zsh/zshenv" ) ; then
	echo --- WARNING: Did not update zshenv
else
	if [ -e /etc/zshenv ] ; then
		echo --- Updating local /etc/zshenv
		sudo echo "ZDOTDIR=\"\${ZDOTDIR:-\$HOME/.zsh}\"" >> /etc/zshenv
	elif [ -e /etc/zsh/zshenv ] ; then
		echo --- Updating local /etc/zsh/zshenv
		sudo echo "ZDOTDIR=\"\${ZDOTDIR:-\$HOME/.zsh}\"" >> /etc/zsh/zshenv
	else
		echo "WARNING: Failed to find zshenv file!"
	fi
fi

cd /home/$user/.zsh/extras/powerline-fonts/
sh ./install.sh

cd /home/$user/.zsh/extras/
sh ./awesome-terminal-fonts-setup.sh
