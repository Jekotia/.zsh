#! /bin/bash

#origUser=`who am i | awk '{print $1}'`
origUser="$1"
echo "origUser = $origUser"

if which yum > /dev/null; then
	pkgMgr="yum"
elif which apt-get > /dev/null; then
	pkgMgr="apt-get"
elif which apt-cyg > /dev/null; then
	pkgMgr="apt-cyg"
fi

$pkgMgr -y install wget curl nano zsh git bc

echo --- Cloning \'.zsh\' from origin
sudo -u $origUser git clone http://git.jekotia.net/jekotia/.zsh.git
chown -R $origUser:$origUser /home/$origUser/.zsh

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

cd /home/$origUser/.zsh/extras/powerline-fonts/
sudo -u $origUser sh ./install.sh

cd /home/$origUser/.zsh/extras/
sudo -u $origUser sh ./awesome-terminal-fonts-setup.sh
