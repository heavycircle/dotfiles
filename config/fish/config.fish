# --- GENERAL ------------------

fish_vi_key_bindings
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_visual block

# fish_config theme choose catppuccin-mocha
# fish_config theme save catppuccin-mocha

# --- EDITOR -------------------

if set -q SSH_CONNECTION
    set -gx EDITOR vim
    set -gx VISUAL vim
else
    set -gx EDITOR nvim
    set -gx VISUAL nvim
end

set -gx MANPAGER 'nvim +Man!'

# --- PATH ---------------------

fish_add_path "$HOME/scripts"
fish_add_path "$HOME/.bun/bin"
fish_add_path "$HOME/.cargo/bin"
fish_add_path "$HOME/.local/bin"
fish_add_path /usr/local/bin
fish_add_path /opt/homebrew/bin

if status is-interactive
    fzf --fish | source
    zoxide init fish | source
end
