#! /bin/bash
if yum --version ; then
	# Remove zsh install if it exists
	sudo yum remove zsh || exit

	# Move backed-up zshenv back into use
	if [ -e /etc/zshenv.rpmsave ] ; then
		mv /etc/zshenv.rpmsave /etc/zshenv
	fi

#	sudo yum update || exit
	sudo yum install -y git make ncurses-devel gcc autoconf man || exit
fi

git clone -b zsh-5.7.1 https://github.com/zsh-users/zsh.git /tmp/zsh || exit
cd /tmp/zsh || exit
./Util/preconfig || exit
./configure || exit
sudo make -j 20 install.bin install.modules install.fns || exit
rm -rf /tmp/zsh || exit
