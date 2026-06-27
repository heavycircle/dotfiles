abbr fsrc 'source ~/.config/fish/config.fish'
abbr fedit '$EDITOR ~/.config/fish/config.fish'

# Color rebinds
alias fzf "fzf --preview 'bat --style=numbers --color=always {}'"

# Flag rebinds
abbr fzf 'fzf --tmux'
abbr shfmt 'shfmt -ci -i=4'

# Remaps
abbr sl ls

# Shortcuts
abbr c clear
abbr e exit
abbr n nvim
abbr r ranger
abbr cl 'clear && ls'
abbr nv 'nvim (fzf)'

# Fish
abbr reload 'source ~/.config/fish/config.fish'

# Python virtualenv
abbr mkenv 'uv venv --prompt "$(basename "$PWD")"'
abbr venv 'source .venv/bin/activate.fish'
