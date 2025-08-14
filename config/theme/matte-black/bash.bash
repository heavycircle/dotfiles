# matte-black bash theme
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

export CWD_COLOR=$(rgb f5 9e 0b)
export GIT_COLOR=$(rgb 8a 8a 8d)
export VENV_COLOR=$(rgb b9 1c 1c)
export FG_COLOR=$(rgb ea ea ea)
