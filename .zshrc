#! /bin/bash
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
		source ~/.zsh/rclinux
	fi
fi

if [ -e ~/.profile ] ; then
	source ~/.profile
fi
