#! /bin/bash
if [[ "$USER" == "root" ]] ; then
	cd ~/.zsh
	--- echo Updating \'.zsh.git\' from origin
	git submodule update --init --recursive || exit 1
	git pull origin || exit 1
else
	cd ~/.zsh
	--- echo Updating \'.zsh.git\' from origin
	git submodule update --init --recursive || exit 1
	git pull origin || exit 1

	### https://github.com/gabrielelana/awesome-terminal-fonts
	if [ -d ~/.zsh/extras/awesome-terminal-fonts ] ; then
		cd ~/.zsh/extras/awesome-terminal-fonts
		echo  --- Installing awesome-terminal-fonts
		sh ~/.zsh/awesome-terminal-fonts-setup.sh
	fi
	### 
	if [ -d ~/.zsh/extras/powerline-fonts ] ; then
		cd ~/.zsh/extras/powerline-fonts
		echo --- Installing Powerline fonts
		./install.sh
	fi
fi
