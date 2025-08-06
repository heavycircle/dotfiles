# Check whether a command appears valid
_check-command() {
    command -v "$1" >/dev/null
}

# Copies the contents of a given file to the system clipboard.
copyfile() {
    source "$BASHPLUG_LIB"/clipboard.bash
    clipcopy "$1"
}
