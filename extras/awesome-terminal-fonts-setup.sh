#!/bin/sh

cd ~/.zsh/extras/awesome-terminal-fonts

mkdir -p ~/.local/share/fonts/
cp -f ./build/*.ttf ~/.local/share/fonts/
cp -f ./build/*.sh ~/.local/share/fonts/
mkdir -p ~/.config/fontconfig/conf.d
cp -f ./config/* ~/.config/fontconfig/conf.d
fc-cache -fv ~/.local/share/fonts/
