# heavycircle.zsh-theme
#
# Inspired from the romkatv two-line prompt example. Has four components:
#
#   top-left                            top-right
#   bottom-left                      bottom-right
#
# Edit the respective functions to yield changes in output.
#
# You can symlink this file into the themes folder.
#
# sudo ln -s $(pwd)/heavycircle.zsh-theme ${ZSH}/themes/heavycircle.zsh-theme
# echo "export ZSH_THEME=heavycircle" >> ~/.zshrc

# Load zsh colors
autoload -Uz colors
colors

# Color vars
FG_CWD="%F{117}"        # Blue
FG_GIT="%F{141}"        # Mauve
FG_EXIT_OK="%F{114}"    # Green
FG_EXIT_FAIL="%F{203}"  # Red
FG_STATUS="%F{229}"     # Yellow
FG_PROMPT="%F{147}"     # Lavender
RESET="%f%k"

# Get the actual number of characters printed for a certain line.
#
# This function ignores ANSI characters used for printing colors
# and gets the post-load value for ZSH keywords.
function prompt-length() {
  emulate -L zsh
  local -i COLUMNS=${2:-COLUMNS}
  local -i x y=${#1} m
  if (( y )); then
    while (( ${${(%):-$1%$y(l.1.0)}[-1]} )); do
      x=y
      (( y *= 2 ))
    done
    while (( y > x + 1 )); do
      (( m = x + (y - x) / 2 ))
      (( ${${(%):-$1%$m(l.x.y)}[-1]} = m ))
    done
  fi
  typeset -g REPLY=$x
}

# Sets REPLY to LEFT<spaces>RIGHT with enough spaces in
# the middle to fill a terminal line.
function fill-line() {
  emulate -L zsh
  prompt-length $1
  local -i left_len=REPLY
  prompt-length $2 9999
  local -i right_len=REPLY
  local -i pad_len=$((COLUMNS - left_len - right_len - ${ZLE_RPROMPT_INDENT:-1}))
  if (( pad_len < 1 )); then
    # Not enough space for the right part. Drop it.
    typeset -g REPLY=$1
  else
    local pad=${(pl.$pad_len.. .)}  # pad_len spaces
    typeset -g REPLY=${1}${pad}${2}
  fi
}

# A quick function that gets the current git branch.
function git_branch() {
    git rev-parse --abbrev-ref HEAD 2>/dev/null
}

# Get the current git status.
function git_dirty() {
    [[ -n "$(git status --porcelain 2>/dev/null)" ]] && echo "*"
}

function top-left() {
    # Key values
    local cwd="%~"
    local branch=$(git_branch)

    # CWD
    local left="${FG_CWD}[ ${cwd} ]${RESET}"

    # Git Branch
    local right=""
    if [[ -n "$branch" ]]; then
        right="${FG_GIT}[ ${branch} ]${RESET}"
    fi

    # Echo the output
    echo -e "${left} ${right}"
}

function top-right() {
    # Key values
    local dirty=$(git_dirty)
    local status_code=$?

    local right=""

    # Status Code
    if [[ $status_code -ne 0 ]]; then
        right="${FG_EXIT_FAIL}[ ${status_code} ]${RESET}"
    else
        right="${FG_EXIT_OK}[ ${status_code} ]${RESET}"
    fi

    # Git Dirty
    if [[ -n "$dirty" ]]; then
        right+=" ${FG_STATUS}[ ${dirty} ]${RESET}"
    fi

    # Print the output
    echo -e "${right}"
}

function bottom-left() {
    echo -e "${FG_PROMPT}>>${RESET} "
}

function bottom-right() {
    echo -e ""
}

# Sets PROMPT and RPROMPT.
function set-prompt() {
  emulate -L zsh

  # Get the pieces
  local top_left=$(top-left)
  local top_right=$(top-right)
  local bottom_left=$(bottom-left)
  local bottom_right=$(bottom-right)

  # Print the pieces
  local REPLY
  fill-line "$top_left" "$top_right"
  PROMPT=$'\n'$REPLY$'\n'$bottom_left
  RPROMPT=$bottom_right
}

# Register the precmd hook
setopt no_prompt_{bang,subst} prompt_{cr,percent,sp}
autoload -Uz add-zsh-hook
add-zsh-hook precmd set-prompt
