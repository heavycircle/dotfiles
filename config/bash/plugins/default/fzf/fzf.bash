#!/usr/bin/env bash

# Add fzf to PATH
if [[ ! "$PATH" == *$HOME/.fzf/bin* ]]; then
    PATH="${PATH:+${PATH}:}/$HOME/.fzf/bin"
fi

eval "$(fzf --bash)"
