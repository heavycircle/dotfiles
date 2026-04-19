# .bashrc

# Don't source anything if we're not running interactively
[[ -n "$PS1" ]] || return

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

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
export HISTFILE="$HOME/.bash_history"
export HISTSIZE=5000
export HISTFILESIZE=5000

# Shell Options
shopt -s cdspell
shopt -s checkwinsize
shopt -s extglob
shopt -s histappend
shopt -s globstar
shopt -s nullglob

# ---- Custom Configuration ------------------------------------

safe-source() {
    [[ -n "$1" ]] && source "$1"
}

safe-source "$HOME/.config/bash/bash-aliases"
safe-source "$HOME/.config/bash/bash-prompt"

export GRC_ALIASES=true
safe-source "/etc/profile.d/grc.sh"

# ---- Plugins -------------------------------------------------

path-add() {
    [[ ":$PATH:" == *":$1:"* ]] || export PATH="$1:$PATH"
}

path-add "$HOME/.cargo/bin"
path-add "$HOME/.bun/bin"
path-add "$HOME/.local/bin"
path-add "$HOME/scripts"

eval "$(fzf --bash)"
eval "$(zoxide init bash)"
