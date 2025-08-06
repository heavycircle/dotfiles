#!/usr/bin/env bash

# A copy of the default ~/.fzf.bash file provided during the fzf
# git installation.
#
# Author: junegunn
# License: MIT

# Add fzf to PATH
if [[ ! "$PATH" == *$HOME/.fzf/bin* ]]; then
    PATH="${PATH:+${PATH}:}/$HOME/.fzf/bin"
fi

eval "$(fzf --bash)"
