#! /bin/bash
if $(which yum) ; then
	sudo yum update
	sudo yum install -y git make ncurses-devel gcc autoconf man
fi

git clone -b zsh-5.7.1 https://github.com/zsh-users/zsh.git /tmp/zsh
cd /tmp/zsh
./Util/preconfig
./configure
sudo make -j 20 install.bin install.modules install.fns
