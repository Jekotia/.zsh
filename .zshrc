#! /bin/bash

if [ -e ~/.zsh/rccommon ] ; then
	source ~/.zsh/rccommon
fi

if [[ "$USERNAME" == "root" || "$USERNAME" == "pi" ]] ; then
	if [ -e ~/.zsh/rcroot ] ; then
		source ~/.zsh/rcroot
	fi
else
	if [ -e ~/.zsh/rclocal ] ; then
		source ~/.zsh/rclocal
	fi
fi
