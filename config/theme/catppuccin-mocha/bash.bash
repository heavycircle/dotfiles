# catppuccin-mocha bash theme
# This is entirely based on my current bash-prompt.

# Print an RGB value
rgb() {
    # Convert hex to decimal.
    local r=$(printf '%d' "0x$1")  
    local g=$(printf '%d' "0x$2") 
    local b=$(printf '%d' "0x$3")

    # Write RGB
    echo "\[\033[38;2;$r;$g;${b}m\]"
}

export CWD_COLOR=$(rgb c7 a6 f4)
export GIT_COLOR=$(rgb 8c aa ee)
export VENV_COLOR=$(rgb a6 d1 89)
export FG_COLOR=$(rgb c6 d0 f5)
