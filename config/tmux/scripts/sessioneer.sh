#!/usr/bin/env bash

set -x

# The goal of this script is to turn my 2D Tmux experience into a
# 3D tmux ultra-based workflow.

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

    check-deps

    # Check for selected window
    if (($# == 1)); then
        sel="$1"
    else
        sel=$(find "$HOME" -type d | fzf)
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
