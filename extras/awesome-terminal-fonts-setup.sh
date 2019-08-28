#!/bin/sh

fontDir="${HOME}/.local/share/fonts"
fontConfigDir="${HOME}/.config/fontconfig"

cd "${HOME}/.zsh/extras/awesome-terminal-fonts" || exit 1

mkdir -p "${fontDir}"
cp -f ./build/*.ttf "${fontDir}"
cp -f ./build/*.sh "${fontDir}"
mkdir -p "${fontConfigDir}/conf.d"
cp -f ./config/* "${fontConfigDir}/conf.d"
fc-cache -fv "${fontDir}"
