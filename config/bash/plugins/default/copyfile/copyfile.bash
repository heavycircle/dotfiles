#!/usr/bin/env bash

# Copies the contents of a file to the system clipboard.
#
# Author: heavycircle
# Date: August 06, 2025
# License: MIT

# Check whether a command appears valid
_check-command() {
    command -v "$1" >/dev/null
}

# Copies the contents of a given file to the system clipboard.
copyfile() {
    source "$BASHPLUG_LIB"/clipboard.bash
    clipcopy "$1"
}
