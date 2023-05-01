#! /usr/bin/env bash

#>> Keybinds
# ctrl-left/right
bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word

# ctrl-backspace/delete
#bindkey "\C-_" backward-kill-word
#bindkey "\e[3;5~" kill-word

# alt-backspace
#bindkey "\e\d" undo

bindkey "\e[3~" delete-char
bindkey '\e[H' beginning-of-line
bindkey '\e[F' end-of-line