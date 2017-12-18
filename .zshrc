#! /bin/bash

source ~/.zsh/rccommon

if [[ "$USERNAME" == "root" ]] ; then
	source ~/.zsh/rcroot
else
	source ~/.zsh/rclocal
fi
