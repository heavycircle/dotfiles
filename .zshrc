# ~/.zshrc
# Standard ZSH config with starship & antibody
# author: echoscorpion

# --- ZSH Configs --------------------------------

# Configurations
HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

# ZSH Options
setopt autocd               # Change directory by typing name
setopt correct              # Allow correction of mistakes
setopt interactivecomments  # Enable filename expansion
setopt magicequalsubst      # Enable expansion in form anything=expression
setopt nonomatch            # Hide error message when no match
setopt notify               # Report background error status immediately
setopt numericglobsort      # Sort filenames numerically when it makes sense
setopt promptsubst          # Enable command substitution in prompt

# History Options
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=20000
setopt hist_expire_dups_first   # Delete duplicates first when HISTFILE > HISTSIZE
setopt hist_ignore_dups         # Ignore duplicates in history
setopt hist_ignore_space        # Ignore commands starting with space
setopt hist_verify              # Show command with history expansion

# ZSH Aliases
if [ -f ~/.zsh_aliases ]; then
	. ~/.zsh_aliases
fi

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# --- Plugins ------------------------------------

# Antibody
antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh
source ~/.zsh_plugins.sh

# Plugin Rebinds
bindkey "^ " autosuggest-accept
bindkey "^\n" autosuggest-execute

# Z jumper (OS-Specific location)
if [[ $OSTYPE == 'darwin'* ]]; then
    # Homebrew while we're at it
    export PATH=/opt/homebrew/bin:$PATH
    . $HOMEBREW_PREFIX/etc/profile.d/z.sh
else
    . /usr/bin/z.sh
fi

# Override ls with eza
unalias ls 2>/dev/null || true
ls() {
  command eza --icons -1 -F --group-directories-first "$@"
}

# Starship
eval "$(starship init zsh)"
export FUNCNEST=100

# --- PATH ---------------------------------------

# PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=/opt/nvim-linux64/bin:$PATH

# User configuration
export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Cargo
. "$HOME/.cargo/env"
