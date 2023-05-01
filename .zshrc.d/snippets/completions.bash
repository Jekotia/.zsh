#! /usr/bin/env bash

#>> Completions for zsh
if [ -d "${ZDOTDIR}"/.zshrc.d/completions ] ; then
	# shellcheck disable=SC2206 # This is specifically for the warning corresponding with $fpath, as quoting it breaks things
	fpath=("${ZDOTDIR}"/.zshrc.d/completions $fpath)
fi

autoload -Uz compinit promptinit
compinit -d "${ZDOTDIR}"/compdump
promptinit

#autoload bashcompinit

#if [ -e ${ZDOTDIR}/.zshrc.d/completions/bash/* ] ; then
#	source ${ZDOTDIR}/.zshrc.d/completions/bash/*
#fi