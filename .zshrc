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

ZSH_PATH="${HOME}/.config/zsh"
export ZSH="${ZSH_PATH}/oh-my-zsh"

# oh-my-zsh
plugins=(
    command-not-found
    copybuffer
    copyfile
    copypath
    vi-mode
    z
    zsh-autosuggestions
    zsh-bat
    zsh-syntax-highlighting
)

# omz plugin options
VI_MODE_SET_CURSOR=true     # vi-mode

# oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Source anything in $ZSH_PATH
for f in ${ZSH_PATH}/*; do
    [ -f "$f" ] && source "$f"
done

# Plugin Rebinds
bindkey "^ " autosuggest-accept
bindkey "^\n" autosuggest-execute

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
export PATH=/opt/nvim-linux-x86_64/bin:$PATH

# Auto-source .venv
function auto_venv() {
    if [[ -n "$VIRTUAL_ENV" && ! -f ".venv/bin/activate" ]]; then
        deactivate
    fi

    if [[ -f ".venv/bin/activate" && "$VIRTUAL_ENV" != "$(pwd)/.venv" ]]; then
        source .venv/bin/activate
    fi
}
autoload -U add-zsh-hook
add-zsh-hook chpwd auto_venv # Hook to cd
auto_venv # Once on shell start

export PATH=~/scripts:$PATH
for dir in ~/scripts/** ; do
    [[ -d "$dir" ]] && PATH="$dir:$PATH"
done

# User configuration
export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Cargo
. "$HOME/.cargo/env"

# Tinychain
source ~/Documents/tinychain/tinychain/tinychain.env
