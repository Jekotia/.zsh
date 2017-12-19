#! /bin/bash
if [[ "$USER" == "root" ]] ; then
	cd ~/.zsh
	--- echo Updating \'.zsh.git\' from origin
	git pull origin
else
	### https://github.com/gabrielelana/awesome-terminal-fonts
	if [ -d ~/.zsh/extras/awesome-terminal-fonts ] ; then
		cd ~/.zsh/extras/awesome-terminal-fonts
		echo --- Updating \'awesome-terminal-fonts.git\' from origin
		git pull origin
		echo  --- Installing awesome-terminal-fonts
		sh ~/.zsh/awesome-terminal-fonts-setup.sh
	fi
	### 
	if [ -d ~/.zsh/extras/powerline-fonts ] ; then
		cd ~/.zsh/extras/powerline-fonts
		echo --- Updating \'powerline-fonts.git\' from origin
		git pull origin
		echo --- Installing Powerline fonts
		./install.sh
	fi
	### 
	if [ -d ~/.zsh/extras/powerlevel9k ] ; then
		cd ~/.zsh/extras/powerlevel9k
		echo --- Updating \'powerlevel9k\' from origin
		git pull origin
	fi
	### https://github.com/seebi/dircolors-solarized
	if [ -d ~/.zsh/extras/dircolors-solarized ] ; then
		cd ~/.zsh/extras/dircolors-solarized
		echo --- Updating \`dircolors-solarized\`
		git pull origin
	fi
	### https://github.com/mavnn/mintty-colors-solarized
	if [ -d ~/.zsh/extras/mintty-colors-solarized ] ; then
		cd ~/.zsh/extras/mintty-colors-solarized
		echo --- Updating \'mintty-colors-solarized\'
		git pull origin
	fi
	### https://github.com/b-ryan/powerline-shell
	if [ -d ~/.zsh/extras/powerline-shell ] ; then
		cd ~/.zsh/extras/powerline-shell
		echo --- Updating \'powerline-shell\'
		git pull origin
	fi
fi
