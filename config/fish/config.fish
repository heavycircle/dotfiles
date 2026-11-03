# --- GENERAL ------------------

fish_vi_key_bindings
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_visual block

# fish_config theme choose kanagawa-dragon  # theme file in ~/.config/fish/themes
# fish_config theme save kanagawa-dragon

# --- EDITOR -------------------

set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx MANPAGER 'nvim +Man!'

# --- PATH ---------------------

fish_add_path "$HOME/.bun/bin"
fish_add_path "$HOME/.cargo/bin"
fish_add_path "$HOME/.local/bin"
fish_add_path /usr/local/bin
fish_add_path /opt/homebrew/bin
fish_add_path "$HOME/scripts"

if test -f "$HOME/tools/init.fish"
    source "$HOME/tools/init.fish"
end

if status is-interactive
    fzf --fish | source
    zoxide init fish | source
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
