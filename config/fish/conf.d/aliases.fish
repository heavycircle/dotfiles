abbr reload 'source ~/.config/fish/config.fish'

# Configurations
abbr fishconf '$EDITOR ~/.config/fish/config.fish'
abbr nvimconf '$EDITOR ~/.config/nvim/'
abbr wezconf '$EDITOR ~/.config/wezterm/wezterm.lua'

# Flag rebinds
abbr ff "fzf --preview 'bat --style=numbers --color=always {}'"
abbr fzf 'fzf --tmux'
abbr gdb 'gdb -q'
abbr shfmt 'shfmt -ci -i=4'

# Bash-like things
abbr !! --position anywhere --function history_last

# Remaps
abbr sl ls

# Shortcuts
abbr c clear
abbr e exit
abbr n nvim
abbr r ranger
abbr cl 'clear && ls'
abbr nv 'nvim (fzf)'

# Python virtualenv
abbr mkenv 'uv venv --prompt "$(basename "$PWD")"'
abbr venv 'source .venv/bin/activate.fish'
