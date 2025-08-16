#!/usr/bin/env bash

# Standard bash configuration using bashplug for plugin management.
#
# Author: heavycircle
# Date: 2025
# License: MIT

# ---- GENERAL -------------------------------------------------

# If not running interactively, don't do anything
[[ -n "$PS1" ]] || return

# Set Editor
if [[ -n "$SSH_CONNECTION" ]]; then
    export EDITOR="vim"
    export VISUAL="vim"
else
    export EDITOR="nvim"
    export VISUAL="nvim"
fi

# Use nvim for man paging
export MANPAGER="nvim +Man!"

# History Settings
export HISTCONTROL=ignoreboth
export HISTFILE="$HOME"/.bash_history
export HISTSIZE=5000
export HISTFILESIZE=5000

# Shell options
shopt -s cdspell
shopt -s checkwinsize
shopt -s extglob
shopt -s histappend

# ---- BASH CONFIGURATION ---------------------------------------

BASH_CONFIG="$HOME"/.config/bash

# Source custom files
. "$BASH_CONFIG"/bash-prompt    # Terminal Prompt
. "$BASH_CONFIG"/bash-aliases   # Function aliases

# ---- UTILITIES -----------------------------------------------

plugins=(copyfile copypath follow fzf z)

# Bashplug
. "$HOME"/.bashplug/bashplug -v

# Cargo
export PATH="$HOME/.cargo/bin:$PATH"

# Source packages
. "$HOME"/.local/share/bob/env/env.sh
