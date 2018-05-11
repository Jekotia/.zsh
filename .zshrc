#! /bin/bash
export TERM="xterm-256color"
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
