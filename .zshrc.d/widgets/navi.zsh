#! /usr/bin/env zsh

# Import the navi widget, if it's available
#-> https://stackoverflow.com/a/677212/1871306
if hash navi 2>/dev/null ; then
	#shellcheck disable=SC1090
	source <(navi widget zsh)
fi