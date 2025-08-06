#!/usr/bin/env bash

# Standard BASH configuration using bashplug for plugin
# management.
#
# Author: heavycircle
# Date: 2025
# License: MIT

# If not running interactively, don't do anything
[[ -n "$PS1" ]] || return

# Set Editor
if [[ -n "$SSH_CONNECTION" ]]; then
    export EDITOR='vim'
    export VISUAL='vim'
else
    export EDITOR='nvim'
    export VISUAL='nvim'
fi

# History
export HISTCONTROL=ignoreboth
export HISTFILE="$HOME"/.bash_history
export HISTSIZE=5000
export HISTFILESIZE=5000

# Shell Options
shopt -s cdspell
shopt -s checkwinsize
shopt -s extglob
shopt -s histappend

BASH_CONFIG="$HOME"/.config/bash

# Source custom files
. "$BASH_CONFIG"/bash-aliases   # Function aliases and shortcuts
. "$BASH_CONFIG"/bashplug       # Bash plugin manager

# Start our plugin manager
bashplug init

# Set Terminal Prompt
PS1='\[\e[32m\]\u@\h:\W \$\[\e[m\] '

# Source packages
. "$HOME/.cargo/env"
. "$HOME"/.local/share/bob/env/env.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
