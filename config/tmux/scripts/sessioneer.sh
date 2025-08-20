#!/usr/bin/env bash

# The goal of this script is to turn my 2D Tmux experience into a
# 3D tmux ultra-based workflow.
#
# Rather than having multiple projects in the same tmux session,
# cycling back and forth between them, use this to establish a
# session per project. The session is named based on the folder you
# open. If, in another session, you try to open the same folder, it
# will spawn the session that already exists.
#
# Good keybinds to know:
#   <leader>s -- Show all sessions
#       x -- Kill highlighted session
#   <leader>( -- Go to previous session
#   <leader>) -- Go to next session
#
# Depending on your fzf setting, binding this is different. Since I
# alias fzf='fzf --tmux' (which makes it a popup), I source with:
#   bind-key <key> display-popup -E "/path/to/sessioneer.sh"
# Otherwise, you should just be able to do:
#   bind-key <key> run-shell "/path/to/sessioneer.sh"
#
# This method's forks include fzf, tmux, and find. It still runs
# without noticeable latency on a trash machine.
#
# Author: heavycircle
# Date: August 2025
# License: MIT

debug() {
    printf '[DEBUG] %02d: %s\n' "${BASH_LINENO[0]}" "$BASH_COMMAND" >>/tmp/tmux-debug
}

check-deps() {
    if ! command -v tmux &>/dev/null; then
        echo "tmux is not installed."
        exit 1
    fi

    if ! command -v fzf &>/dev/null; then
        echo "fzf is not installed."
        exit 1
    fi
}

main() {
    local sel name

    # Clear the debug file
    >/tmp/tmux-debug
    trap debug DEBUG

    check-deps

    # Check for selected window
    if (($# == 1)); then
        sel="$1"
    else
        sel=$(find "$HOME" -type d -maxdepth 2 | fzf)
    fi

    # Ensure they selected something
    [[ -n "$sel" ]] || exit 0

    # Make a session name. This cannot have any periods because tmux
    # uses this to denote panes within windows.
    name=${sel##*/}
    name=${name/./_}

    # Check if we have this session already
    if ! tmux has-session -t "$name"; then
        tmux new-session -ds "$name" -c "$sel"
        tmux select-window -t "$name:1"
    fi

    # Switch to this session
    tmux switch-client -t "$name"
}

main "$@"
