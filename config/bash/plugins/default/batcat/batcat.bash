#!/usr/bin/env bash

# batcat replaces the default cat implementation.
# The default cat implementation is stored as 'rcat'.
#
# This code comes from the original zsh-bat plugin
# for oh-my-zsh: https://github.com/fdellwing/zsh-bat.
#
# Author: heavycircle
# Date: August 06, 2025
# License: MIT

if command -v batcat >/dev/null; then
    # Save cat -> rcat
    alias rcat=$(which cat)
    alias cat=$(which batcat)

    # Get the man page for batcat
    export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
    export MANROFFOPT="-c"
elif command -v bat >/dev/null; then
    # Save cat -> rcat
    alias rcat=$(which cat)
    alias cat=$(which bat)
    
    # Get the man page for bat
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
    export MANROFFOPT="-c"
else
    echo "batcat: Not installed!"
fi
