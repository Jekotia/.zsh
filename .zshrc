# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export TERM="xterm-256color"

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


if [ -e ~/.zsh/rccommon ] ; then
	source ~/.zsh/rccommon
fi

if uname | grep "CYGWIN" > /dev/null 2>&1 ; then
	if [ -e ~/.zsh/rcwin ] ; then
		source ~/.zsh/rcwin
	fi
else
	if [ -e ~/.zsh/rclinux ] ; then
		# To customize prompt, run `p10k configure` or edit ~/.zsh/.p10k.zsh.
		[[ ! -f ~/.zsh/.p10k.zsh ]] || source ~/.zsh/.p10k.zsh
		source ~/.zsh/rclinux
	fi
fi

if [ -e ~/.profile ] ; then
	source ~/.profile
fi

