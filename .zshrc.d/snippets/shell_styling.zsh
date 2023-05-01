#! /usr/bin/env zsh

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
	if [ -e "${ZDOTDIR}"/extras/powerline-shell.sh ] ; then
		# shellcheck disable=SC1091
		source "${ZDOTDIR}"/extras/powerline-shell.sh || return 1
	fi

	### https://github.com/gabrielelana/awesome-terminal-fonts
	count=$(ls -1 ~/.local/share/fonts/*.sh >> /dev/null | wc -l)
	if [ $count != 0 ] ; then
		# shellcheck disable=SC1090 
		source "${HOME}"/.local/share/fonts/*.sh
	fi
else
	# To customize prompt, run `p10k configure` or edit ${ZDOTDIR}/.p10k.zsh.
	# shellcheck disable=SC1091
	[[ ! -f ${ZDOTDIR}/.p10k.zsh ]] || source "${ZDOTDIR}"/.p10k.zsh
	### https://github.com/romkatv/powerlevel10k
	if [[ -e ${ZDOTDIR}/extras/powerlevel10k/powerlevel10k.zsh-theme ]] ; then
		# shellcheck disable=SC1091
		source "${ZDOTDIR}"/extras/powerlevel10k/powerlevel10k.zsh-theme
	fi

	if [[ "$(hostname)" == "pan" ]] || [[ "$(hostname)" == "pan.jekotia.net" ]] ; then
		# shellcheck disable=SC2034
		POWERLEVEL9K_IP_INTERFACE="enp3s0f0"

	else
		# shellcheck disable=SC2034
		POWERLEVEL9K_IP_INTERFACE="eth0"
	fi
fi