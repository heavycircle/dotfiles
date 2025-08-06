#!/usr/bin/env bash

# A bash-compliant version of the oh-my-zsh clipboard.zsh file that
# determines the clipboard to use for copy and paste operations.
#
# Author: heavycircle
# Date: August 06, 2025
# License: MIT

# Check whether a command appears valid.
_check_command() {
    command -v "$1" >/dev/null
}

# Determine the architecture and use their proper keyboard mechanism.
detect-clipboard() {
    # MacOS
    if [[ "$OSTYPE" =~ ^darwin ]] && _check_command "pbcopy"; then
        clipcopy() { cat "${1:-/dev/stdin}" | pbcopy; }

    # WSL
    elif [[ "$OSTYPE" =~ ^cygwin ]]; then
        clipcopy() { cat "${1:-/dev/stdin}" >/dev/clipboard; }

    # xsel
    elif _check_command "xsel"; then
        clipcopy() { cat "${1:-/dev/stdin}" | xsel --clipboard --input; }

    # xclip
    elif _check_command "xclip"; then
        clipcopy() { cat "${1:-/dev/stdin}" | xclip -selection clipboard -in &>/dev/null; }

    # Tmux
    elif [[ -n "${TMUX:-}" ]] && _check_command "tmux"; then
        clipcopy() { tmux load-buffer "${1:--}"; }

    # No suitable matches
    else
        printf "$0: Platform $OSTYPE not supported or xclip/xsel not installed" >&2
        return 1
    fi
}

# Override clipcopy and clippaste based on architecture needs
clipcopy() {
    unset -f clipcopy
    detect-clipboard || true
    clipcopy "$@"
}
clippaste() {
    unset -f clippaste
    detect-clipboard || true
    clippaste "$@"
}
