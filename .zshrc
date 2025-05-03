#! /usr/bin/env zsh


# shellcheck source=.zshrc.d/init.bash
source "${ZDOTDIR}"/.zshrc.d/init.bash || return 1

source_directory "${ZDOTDIR}/.zshrc.d/functions" "*" || return 1
source_directory "${ZDOTDIR}/.zshrc.d/widgets" "*" || return 1

if ! is_wsl ; then
	#shellcheck source=.zshrc.d/snippets/ssh.bash
	source "${ZDOTDIR}/.zshrc.d/snippets/ssh.bash" || return 1
fi
# source_directory "${ZDOTDIR}/.zshrc.d/snippets" "*" || return 1

#>> Config arrays


#>> Show the MOTD if it exists
if [ -e /etc/motd ] ; then
	cat /etc/motd
fi

##>> NO OUTPUT SHOULD BE GENERATED AFTER THIS POINT DUE TO P10K INSTANT PROMPT
#>> p10k instant prompt
verbose "p10k instant prompt"
#shellcheck disable=SC1091
source "${ZDOTDIR}"/.zshrc.d/snippets/p10k_instant_prompt.zsh || return 1

#>> Export values
#-> If we're NOT within TMUX, set the term. Otherwise, we leave it unset for .tmux.conf to handle
if [ -z "$TMUX" ] ; then
	export TERM=xterm-256color
fi
export MDV_THEME=960.847

# shellcheck source=.zshrc.d/snippets/options.bash
source "${ZDOTDIR}"/.zshrc.d/snippets/options.bash || return 1

#>> Solarized colouring for ls
### https://github.com/mavnn/mintty-colors-solarized
#if [[ -e ${ZDOTDIR}/extras/mintty-colors-solarized/sol.dark ]] ; then
#	source ${ZDOTDIR}/extras/mintty-colors-solarized/sol.dark
#fi

### https://github.com/seebi/dircolors-solarized
dircolorsPath="${ZDOTDIR}/extras/dircolors-solarized/dircolors.256dark"
if [[ -e ${dircolorsPath} ]] ; then
	eval "$(dircolors "${dircolorsPath}")"
fi

# shellcheck source=.zshrc.d/snippets/path_modification.bash
source "${ZDOTDIR}"/.zshrc.d/snippets/path_modification.bash || return 1


#>> Make sure nano syntax highlighting is turned on
if [[ ! -e ${HOME}/.nanorc ]] ; then
	ln -s "${ZDOTDIR}/extras/nanorc.custom" "${HOME}/.nanorc"
fi

## Syntax files from https://github.com/scopatz/nanorc
#if [[ ! -e ${HOME}/.nanorc ]] ; then
#	touch ${HOME}/.nanorc
#fi

#if ! cat ${HOME}/.nanorc | grep "set nowrap" > /dev/null ; then
#	echo "set nowrap" >> ${HOME}/.nanorc
#fi

#if ! grep -f ${ZDOTDIR}/extras/nanorc.custom ~/.nanorc > /dev/null ; then
#	cat ${ZDOTDIR}/extras/nanorc.custom >> ~/.nanorc
#fi

#>> Make sure git is configured the way I like it
if [[ ! -e ${HOME}/.gitconfig ]] ; then
	touch "${HOME}"/.gitconfig
fi

if ! grep -f "${ZDOTDIR}"/ref/gitconfig ~/.gitconfig > /dev/null ; then
	echo "Adding contents of '${ZDOTDIR}/ref/gitconfig' to '~/.gitconfig'"
	cat "${ZDOTDIR}"/ref/gitconfig >> ~/.gitconfig
fi

# shellcheck source=.zshrc.d/snippets/completions.bash
source "${ZDOTDIR}"/.zshrc.d/snippets/completions.bash || return 1
# shellcheck source=.zshrc.d/snippets/keybinds.bash
source "${ZDOTDIR}"/.zshrc.d/snippets/keybinds.bash || return 1
source "${ZDOTDIR}"/.zshrc.d/snippets/shell_styling.zsh || return 1
source_directory "${ZDOTDIR}/.zshrc.d/aliases" "*" || return 1


#>> Source default .profile file if it exists
	if [ -e "${HOME}"/.profile ] ; then
		source "${HOME}"/.profile || return 1
	fi

#>> Misc reference
	# User configuration

	#export PATH=$HOME/bin:/usr/local/bin:$PATH
	# export MANPATH="/usr/local/man:$MANPATH"

	# You may need to manually set your language environment
	# export LANG=en_US.UTF-8

	# Preferred editor for local and remote sessions
	# if [[ -n $SSH_CONNECTION ]]; then
	#   export EDITOR='vim'
	# else
	#   export EDITOR='mvim'
	# fi

	# Compilation flags
	# export ARCHFLAGS="-arch x86_64"

	# ssh
	# export SSH_KEY_PATH="~/.ssh/dsa_id"

	# Some example alias instructions
	# If these are enabled they will be used instead of any instructions
	# they may mask. For example, alias rm='rm -i' will mask the rm
	# application. To override the alias instruction use a \ before, ie
	# \rm will call the real rm not the alias.
	#
	# Interactive operation...
	# alias rm='rm -i'
	# alias cp='cp -i'
	# alias mv='mv -i'
	#
	# Default to human readable figures
	# alias df='df -h'
	# alias du='du -h'
	#
	# Misc :)
	# alias less='less -r'                          # raw control characters
	# alias whence='type -a'                        # where, of a sort
	# alias grep='grep --color'                     # show differences in colour
	# alias egrep='egrep --color=auto'              # show differences in colour
	# alias fgrep='fgrep --color=auto'              # show differences in colour
	#
	# Some shortcuts for different directory listings
	# alias ls='ls -hF --color=tty'                 # classify files in colour
	# alias dir='ls --color=auto --format=vertical'
	# alias vdir='ls --color=auto --format=long'
	# alias ll='ls -l'                              # long list
	# alias la='ls -A'                              # all but . and ..
	# alias l='ls -CF'                              #
