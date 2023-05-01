#! /usr/bin/env bash

#>> ZSH Options
# Don't save lines with leading spaces
setopt histignorespace
# Don't save duplicates of a command
setopt HIST_SAVE_NO_DUPS

export HISTFILE=${ZDOTDIR}/history
setopt INC_APPEND_HISTORY
export SAVEHIST=3000
setopt HIST_EXPIRE_DUPS_FIRST
export HISTSIZE=1000