#!/bin/sh

#cd "$(dirname "$0")"

cd ~/.zsh/awesome-terminal-fonts

mkdir -p ~/.local/shared/fonts/
cp -f ./build/*.ttf ~/.local/shared/fonts/
cp -f ./build/*.sh ~/.local/shared/fonts/

#mkdir -p ~/.config/fontconfig/conf.d
#cp -f ./config/* ~/.config/fontconfig/conf.d
#fc-cache -fv ~/.local/shared/fonts/
