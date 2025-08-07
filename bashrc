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
. "$BASH_CONFIG"/bash-prompt  # Terminal Prompt
. "$BASH_CONFIG"/bash-aliases # Function aliases and shortcuts
. "$BASH_CONFIG"/bashplug     # Bash plugin manager

# Start our plugin manager
bashplug init

# Source packages
. "$HOME/.cargo/env"
. "$HOME"/.local/share/bob/env/env.sh

# Load NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
