#! /bin/bash

#zshSource="https://git.jekotia.net/jekotia/.zsh.git"
zshSource="https://github.com/Jekotia/.zsh.git"
#origUser=`who am i | awk '{print $1}'`
origUser="$1"
echo "origUser = $origUser"

#if [[ "$origuser" == "" ]] ; then
#	echo "ERROR: Unable to determine which user invoked this script"
#	exit 1
if [[ "$origUser" == "root" ]] ; then
	origHome="/root"
else
	origHome="/home/$origUser"
fi


if which yum > /dev/null; then
	pkgMgr="yum"
elif which apt-get > /dev/null; then
	pkgMgr="apt-get"
elif which apt-cyg > /dev/null; then
	pkgMgr="apt-cyg"
fi

$pkgMgr -y install wget curl nano zsh git bc

if [[ ! "$2" == "--local" ]] ; then
	cd $origHome
	echo --- Cloning \'.zsh\' from origin
	sudo -u $origUser git clone --recurse-submodules ${zshSource} \
	&& chown -R $origUser:$origUser $origHome/.zsh

	if [[ "$?" != "0" ]] ; then exit 1 ; fi
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

	if [ ! -e "${origHome}/.nanorc" ] ; then
		echo "Linking ~/.nanorc to ~/.zsh/extras/nanorc/nanorc.custom"
		ln -s "${origHome}/.zsh/extras/nanorc.custom" "${origHome}/.nanorc" || echo "Failed to create link"

		echo "Setting ownership of ~/.nanorc"
		chown $origUser:$origUser $origHome/.nanorc || echo "Failed to set ownership"
	fi
fi

cd $origHome/.zsh/extras/powerline-fonts/
sudo -u $origUser sh ./install.sh

cd $origHome/.zsh/extras/
sudo -u $origUser sh ./awesome-terminal-fonts-setup.sh

echo "Linking .tmux.conf"
ln -s $origHome/.zsh/.tmux.conf $origHome/.tmux.conf
ln -s $origHome/.zsh/.tmux $origHome/.tmux
