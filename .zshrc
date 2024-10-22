# Configurations
HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

# Antibody
antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh
source ~/.zsh_plugins.sh

# Plugin Rebinds
bindkey "^ " autosuggest-accept
bindkey "^\n" autosuggest-execute

# User configuration
export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# ZSH Aliases
if [ -f ~/.zsh_aliases ]; then
	. ~/.zsh_aliases
fi

# Z jumper
if [[ $OSTYPE == 'darwin'* ]]; then
    # Homebrew
    export PATH=/opt/homebrew/bin:$PATH
    . $HOMEBREW_PREFIX/etc/profile.d/z.sh
else
    . /usr/bin/z.sh
fi

# PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=/opt/nvim-linux64/bin:$PATH

# Starship
eval "$(starship init zsh)"
export FUNCNEST=100

# Override ls with eza
unalias ls 2>/dev/null || true
ls() {
  command eza --icons -1 -F --group-directories-first "$@"
}

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"


# Cargo
. "$HOME/.cargo/env"
