#! /usr/bin/env bash

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

for binPath in "${binPaths[@]}" ; do
	if [ -d "${binPath}" ] && ! { [[ $PATH =~ ^$binPath: ]] || [[ $PATH =~ :$binPath: ]] || [[ $PATH =~ :$binPath$ ]] ; } ; then
		PATH="${binPath}:${PATH}"
		#echo "${binPath}:${PATH}"
	fi
done