#!/usr/bin/env bash

# Copies the path of the given directory or file to the system clipboard.
# Adapted from the oh-my-zsh copypath method.
#
# Author: heavycircle
# Date: August 06, 2025
# License: MIT

copypath() {
    set -x
    source "${BASHPLUG_LIB}"/clipboard.bash

    # Get the item to copy
    local file="${1:-}"
    [[ "$file" = /* ]] || file="$PWD"/"$file"
    local abspath=$(realpath -- "$file") # TODO - Remove fork

    # Copy the absolute path without resolving symbols
    echo -n "$abspath" | clipcopy || return 1
    echo -e "\033[1m$abspath\033[0m copied to clipboard."
    set +x
}
