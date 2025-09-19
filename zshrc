# Standard zsh configuration.
#
# Author: heavycircle
# Date: 2025
# License: MIT

# ---- GENERAL -------------------------------------------------

# Configurations
HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

# ZSH Options
setopt autocd              # Change directory by typing name
setopt correct             # Allow correction of mistakes
setopt interactivecomments # Enable filename expansion
setopt magicequalsubst     # Enable expansion in form anything=expression
setopt nonomatch           # Hide error message when no match
setopt notify              # Report background error status immediately
setopt numericglobsort     # Sort filenames numerically when it makes sense
setopt promptsubst         # Enable command substitution in prompt

# History Options
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=20000
setopt hist_expire_dups_first # Delete duplicates first when HISTFILE > HISTSIZE
setopt hist_ignore_dups       # Ignore duplicates in history
setopt hist_ignore_space      # Ignore commands starting with space
setopt hist_verify            # Show command with history expansion

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

# ---- ZSH CONFIGURATION ---------------------------------------

ZSH_CONFIG="${HOME}/.config/zsh"

. "$ZSH_CONFIG"/zsh-prompt  # Terminal prompt
. "$ZSH_CONFIG"/zsh-aliases # Function aliases
. "$ZSH_CONFIG"/zsh-plugins # Manual plugin management

# Source custom scripts
export PATH=${HOME}/scripts:$PATH
for dir in ${HOME}/scripts/**; do
    [ -d "${dir}" ] && PATH="${dir}:${PATH}"
done

# ---- UTILITIES -----------------------------------------------

# Pip
export PATH=$HOME/.local/bin:$PATH
export PATH=/usr/local/bin:$PATH

# Cargo
. "$HOME/.cargo/env"

source <(fzf --zsh)         # FZF
eval "$(zoxide init zsh)"   # Zoxide
