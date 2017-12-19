#! /bin/bash

if which yum > /dev/null; then
	pkgMgr="yum"
elif which apt-get > /dev/null; then
	pkgMgr="apt-get"
elif which apt-cyg > /dev/null; then
	pkgMgr="apt-cyg"
fi

$pkgMgr -y install wget curl nano zsh git bc

echo --- Cloning \'.zsh\' from origin
git clone http://saturn.jekotia.net:3000/jekotia/.zsh.git

if ( grep -Fxq "ZDOTDIR=\"\${ZDOTDIR:-\$HOME/.zsh}\"" "/etc/zshenv" ) ; then
	echo --- WARNING: Did not update /etc/zshenv
else
	echo --- Updating local /etc/zshenv
	echo "ZDOTDIR=\"\${ZDOTDIR:-\$HOME/.zsh}\"" >> /etc/zshenv
fi

cd ~/.zsh/extras/powerline-fonts/
sh ./install.sh

~/.zsh/extras/awesome-terminal-fonts-setup.sh