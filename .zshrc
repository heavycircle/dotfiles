ZSH_THEME="example" # set by `omz`

# Configurations
HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

# OH MY ZSH
export ZSH="$HOME/.oh-my-zsh"
zstyle ':omz:update' mode reminder

# OMZ Plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

# OMZ Activate
source $ZSH/oh-my-zsh.sh

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
. /usr/bin/z.sh

# PATH
export PATH=/home/ironforge/.local/bin:$PATH
export PATH=/opt/nvim-linux64/bin:$PATH

# Starship
eval "$(starship init zsh)"

# Override ls with eza
# unalias ls 2>/dev/null || true
# ls() {
#   command eza --icons -1 -F --group-directories-first "$@"
# }

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Cargo
. "$HOME/.cargo/env"
