#! /bin/bash
#>> init script
	#shellcheck source=includes/init
	source "${ZDOTDIR}/includes/init"

#>> Config arrays
	declare -a ssh_keyfiles=(
		"${HOME}/.ssh/id_rsa"
		"${HOME}/.ssh/id_jameli"
		"${HOME}/.ssh/id_git"
	)

	ssh_host="atlas"	; hostname | grep -q "$ssh_host" && { ssh_keyfiles+=("${HOME}/.ssh/id_$ssh_host"); }
	ssh_host="ganymede"	; hostname | grep -q "$ssh_host" && { ssh_keyfiles+=("${HOME}/.ssh/id_$ssh_host"); }
	ssh_host="hyperion"	; hostname | grep -q "$ssh_host" && { ssh_keyfiles+=("${HOME}/.ssh/id_$ssh_host"); }
	ssh_host="jupiter"	; hostname | grep -q "$ssh_host" && { ssh_keyfiles+=("${HOME}/.ssh/id_$ssh_host"); }
	ssh_host="mars"		; hostname | grep -q "$ssh_host" && { ssh_keyfiles+=("${HOME}/.ssh/id_$ssh_host"); }
	ssh_host="mercury"	; hostname | grep -q "$ssh_host" && { ssh_keyfiles+=("${HOME}/.ssh/id_$ssh_host"); }
	ssh_host="saturn"	; hostname | grep -q "$ssh_host" && { ssh_keyfiles+=("${HOME}/.ssh/id_$ssh_host"); }

	[[ "$USERNAME" == "pi" ]] &&  { ssh_keyfiles+=("id_interpi"); }

	declare -a binPaths=(
		"/usr/local/sbin"
		"/snap/bin"
		"${HOME}/.cabal/bin"
		"${HOME}/.cargo/bin"
		"${HOME}/.fzf/bin"
		"${HOME}/bin"
		"${HOME}/bin/unix-tools"
		"${HOME}/bin/work"
		"${HOME}/bin/work/unix-tools"
		"${HOME}/Dockerfiles/bin"
		"${HOME}/go/bin"
		"${ZDOTDIR}/bin"
		"${HOME}/.local/bin"
	)


#>> ssh-agent setup
	if is_cygwin ; then
		# startup of the ssh-agent
		AGENT_PID=$(pgrep -x ssh-agent)
		#if [ $? -ne 0 ]; then
			#echo "---- INFO: ${ZDOTDIR}/rcwin: Starting SSH Agent!"

			eval `ssh-agent -s` > /dev/null
			trap 'kill $SSH_AGENT_PID' EXIT

			set SSH_AUTH_SOCK $SSH_AUTH_SOCK
			set SSH_AGENT_PID $SSH_AGENT_PID

			#echo "---- INFO: ${ZDOTDIR}/rcwin: SSH Agent running (PID: $SSH_AGENT_PID)"
		#else
			#echo "---- INFO: ${ZDOTDIR}/rcwin: SSH Agent already running (PID: $AGENT_PID)"
		#fi
	else
        #-> https://stackoverflow.com/a/18915067
        SSH_ENV="$HOME/.ssh/environment"
        # Source SSH settings, if applicable
        if [ -f "${SSH_ENV}" ]; then
            . "${SSH_ENV}" > /dev/null
            #ps ${SSH_AGENT_PID} doesn't work under cywgin
            ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
                start_ssh_agent "${SSH_ENV}"
            }
        else
            start_ssh_agent "${SSH_ENV}"
        fi
	fi
#>> Add keyfiles to ssh-agent
	for keyfile in "${ssh_keyfiles[@]}" ; do
		if [ -f "${keyfile}" ] ; then
			echo "s" ssh-add -l | grep "${keyfile}"
			# https://unix.stackexchange.com/a/132812
			if ! ssh-add -l | grep -q $(ssh-keygen -lf "${keyfile}"  | awk '{print $2}') ; then
				ssh-add "${keyfile}"
			fi
		fi
	done



#>> Show the MOTD if it exists
	if [ -e /etc/motd ] ; then
		cat /etc/motd
	fi

##>> NO OUTPUT SHOULD BE GENERATED AFTER THIS POINT DUE TO P10K INSTANT PROMPT
#>> p10k instant prompt
	if ! is_cygwin ; then
		#shellcheck disable=SC1091
		#shellcheck source=./includes/p10k_instant_prompt.zsh
		source "${ZDOTDIR}/includes/p10k_instant_prompt.sh"
	fi
#>> Export values
	#-> If we're NOT within TMUX, set the term. Otherwise, we leave it unset for .tmux.conf to handle
	if [ -z "$TMUX" ] ; then
		export TERM=xterm-256color
	fi
	export MDV_THEME=960.847

#>> ZSH Options
	# Don't save lines with leading spaces
	setopt histignorespace
	# Don't save duplicates of a command
	setopt HIST_SAVE_NO_DUPS

	export HISTFILE=${ZDOTDIR}/history
	setopt INC_APPEND_HISTORY
	export SAVEHIST=3000
	setopt HIST_EXPIRE_DUPS_FIRST
	export HISTSIZE=1000

#>> Solarized colouring for ls
	### https://github.com/mavnn/mintty-colors-solarized
	#if [[ -e ${ZDOTDIR}/extras/mintty-colors-solarized/sol.dark ]] ; then
	#	source ${ZDOTDIR}/extras/mintty-colors-solarized/sol.dark
	#fi

	### https://github.com/seebi/dircolors-solarized
	dircolorsPath="${ZDOTDIR}/extras/dircolors-solarized/dircolors.256dark"
	if [[ -e ${dircolorsPath} ]] ; then
		eval `dircolors "${dircolorsPath}"`
	fi


#>> PATH modification
	for binPath in "${binPaths[@]}" ; do
		if [ -d "${binPath}" ] && ! ( [[ $PATH =~ ^$binPath: ]] || [[ $PATH =~ :$binPath: ]] || [[ $PATH =~ :$binPath$ ]] ) ; then
			PATH="${binPath}:${PATH}"
			#echo "${binPath}:${PATH}"
		fi
	done

	is_cygwin && _fixpath

	#>> Enable `fuck` as an alias for `thefuck`
	eval $(thefuck --alias)

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
		touch ${HOME}/.gitconfig
	fi

	if ! grep -f ${ZDOTDIR}/ref/gitconfig ~/.gitconfig > /dev/null ; then
		echo "Adding contents of '${ZDOTDIR}/ref/gitconfig' to '~/.gitconfig'"
		cat ${ZDOTDIR}/ref/gitconfig >> ~/.gitconfig
	fi

#>> Completions for zsh
	if [ -d ${ZDOTDIR}/completion ] ; then
		fpath=(${ZDOTDIR}/completion $fpath)
	fi

	autoload -Uz compinit promptinit
	compinit -d ${ZDOTDIR}/compdump
	promptinit

	#autoload bashcompinit

	#if [ -e ${ZDOTDIR}/completion/bash/* ] ; then
	#	source ${ZDOTDIR}/completion/bash/*
	#fi

#>> Keybinds
	# ctrl-left/right
	bindkey "\e[1;5C" forward-word
	bindkey "\e[1;5D" backward-word

	# ctrl-backspace/delete
	#bindkey "\C-_" backward-kill-word
	#bindkey "\e[3;5~" kill-word

	# alt-backspace
	#bindkey "\e\d" undo

	bindkey "\e[3~" delete-char
	bindkey '\e[H' beginning-of-line
	bindkey '\e[F' end-of-line

#>> Shell styling
	if is_cygwin ; then
		export PYTHONIOENCODING=UTF-8

		### https://github.com/bhilburn/powerlevel9k
		# Powerlevel9k theme and preferences
		#if [ -e ${ZDOTDIR}/extras/powerlevel9k/powerlevel9k.zsh-theme ] ; then
		#	source ${ZDOTDIR}/extras/powerlevel9k/powerlevel9k.zsh-theme
		#	POWERLEVEL9K_DISABLE_RPROMPT=true
		#	POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="↱"
		#	POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="↳ "
		#	POWERLEVEL9K_PROMPT_ON_NEWLINE=true
		#	POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir)
		#	POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status )
		#	POWERLEVEL9K_COLOR_SCHEME='light'
		#fi

		### https://github.com/b-ryan/powerline-shell
		if [ -e ${ZDOTDIR}/extras/powerline-shell.sh ] ; then
			source ${ZDOTDIR}/extras/powerline-shell.sh
		fi

		### https://github.com/gabrielelana/awesome-terminal-fonts
		count=`ls -1 ~/.local/share/fonts/*.sh >> /dev/null | wc -l`
		if [ $count != 0 ] ; then 
			source ~/.local/share/fonts/*.sh
		fi
	else
		# To customize prompt, run `p10k configure` or edit ${ZDOTDIR}/.p10k.zsh.
		#shellcheck source=.p10k.zsh
		#shellcheck disable=SC1094
		[[ ! -f ${ZDOTDIR}/.p10k.zsh ]] || source ${ZDOTDIR}/.p10k.zsh
		### https://github.com/romkatv/powerlevel10k
		if [[ -e ${ZDOTDIR}/extras/powerlevel10k/powerlevel10k.zsh-theme ]] ; then
			source ${ZDOTDIR}/extras/powerlevel10k/powerlevel10k.zsh-theme
		fi

		if [[ "$(hostname)" == "jameli-10P64D" ]] ; then
			POWERLEVEL9K_IP_INTERFACE="eth6"

		elif [[ "$(hostname -s)" == "userowncloud" ]] ; then
			POWERLEVEL9K_IP_INTERFACE="enp2s0"

		elif [[ "$(hostname -s)" == "owncloud" ]] ; then
			POWERLEVEL9K_IP_INTERFACE="ens3"

		elif [[ "$(hostname -s)" == "bugzilla" ]] ; then
			POWERLEVEL9K_IP_INTERFACE="eth0"

		else
			POWERLEVEL9K_IP_INTERFACE="eth0"
		fi
	fi


#>> Navi
	# Import the navi widget, if it's available
	#-> https://stackoverflow.com/a/677212/1871306
	if hash navi 2>/dev/null ; then
		#shellcheck disable=SC1090
		source <(navi widget zsh)
	fi

#>> Aliases
	if hub --version > /dev/null 2>&1 ; then
		eval "$(hub alias -s)"
	fi
	# If microk8s is installed, alias its kubectl to mkctl
	if hash microk8s > /dev/null 2>&1 ; then
		alias mkctl="microk8s kubectl"
	fi

	#>> Set an alias for nano that is tailored to the capabilities of the installed version.
		#alias nano='nano--tabsize=4 --linenumbers --wordbounds --softwrap --constantshow'
		nanohelp=$(nano --help)
		nanolist=("--linenumbers" "--wordbounds" "--softwrap" "--constantshow")
		for i in "${nanolist[@]}" ; do
			echo "$nanohelp" | grep --silent "\\$i"
			if [ $? -eq 0 ] ; then
				nanoargs="${nanoargs} ${i}"
			fi
		done
		echo "$nanohelp" | grep --silent "\--tabsize"
		if [ $? -eq 0 ] ; then
			nanoargs="${nanoargs} --tabsize=4"
		fi
		alias nano="nano ${nanoargs}"
	#<< nano

	alias rm='rm -i'
	alias ls='ls -F --group-directories-first --color=tty'
	#-> Use gits diff feature on any files
		alias diff="git diff --no-index --color-words"
	#-> Use dig to show public IP address
		alias wanip='dig +short myip.opendns.com @resolver1.opendns.com'
	#-> Force allocation of a tty
		alias ssh='ssh -t'
	#-> Prevent execution of configured SSH RemoteCommand
		alias sftp="sftp -o 'RemoteCommand none'"
	#-> Easier access to listing packages installed on a device connected via ADB
		alias adb-packages='adb shell "pm list packages"'
	alias grep='grep --color=auto'

	#irccert='sudo su -l weechat -c "irccert $1"'

	if is_linux ; then
		if [[ -e /var/www/html/owncloud/occ ]] ; then
			alias occ="sudo -uapache /var/www/html/owncloud/occ"
		fi
		alias apt-search="dpkg-query -L"
		alias composer="sudo -uapache composer"
	#elif is_wsl ; then
		#alias
	elif is_cygwin ; then
		#alias ping='cygping'
		#alias cyg-update
		alias tracert='mtr'
	fi

#>> Source default .profile file if it exists
	if [ -e "${HOME}".profile ] ; then
		#shellcheck source=../.profile
		source "${HOME}"/.profile
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
