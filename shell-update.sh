#! /bin/bash
if [[ "$USER" == "root" ]] ; then
	cd ~/.zsh
	--- echo Updating \'.zsh.git\' from origin
	git pull origin
else
	cd ~/.zsh/fonts
	echo --- Updating \'powerline/fonts.git\' from origin
	git pull origin
	echo --- Installing Powerline fonts
	./install.sh

	cd ~/.zsh/powerlevel9k
	echo --- Updating \'powerlevel9k\' from origin
	git pull origin
	
	cd ~/.zsh/dircolors-solarized/
	echo --- Updating \`dircolors-solarized\`
	git pull origin
	
	cd ~/.zsh/mintty-colors-solarized
	echo --- Updating \'mintty-colors-solarized\'
	git pull origin
fi
