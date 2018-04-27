#! /bin/bash
export TERM="xterm-256color"
if [ -e ~/.zsh/rccommon ] ; then
	source ~/.zsh/rccommon
fi

if [[ "$USERNAME" == "root" || "$USERNAME" == "pi" || "$USERNAME" == "minecraft" || "$USERNAME" == "ysl" ]] || cat /etc/os-release 2>&1 | grep debian /dev/null ; then
	if [ -e ~/.zsh/rcroot ] ; then
		source ~/.zsh/rcroot
	fi
else
	if [ -e ~/.zsh/rclocal ] ; then
		source ~/.zsh/rclocal
	fi
fi

if [ -e ~/.profile ] ; then
	source ~/.profile
fi
