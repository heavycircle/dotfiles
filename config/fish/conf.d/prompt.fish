# Disable venv default prompt
set -gx VIRTUAL_ENV_DISABLE_PROMPT 1

function prompt_git --description "Get Git branch"
    git rev-parse --is-inside-work-tree &>/dev/null; or return
    git symbolic-ref --short HEAD 2>/dev/null
end

function fish_prompt
    set -l code $status

    echo ""

    # --- CWD ---
    set_color --bold $fish_color_command
    echo -n (prompt_pwd)
    set_color normal

    # --- git branch ---
    set -l branch (prompt_git)
    if test -n "$branch"
        set_color --bold $fish_color_comment
        echo -n " [ $branch]"
        set_color normal
    end

    # --- python venv ---
    if set -q VIRTUAL_ENV
        set_color --bold $fish_color_comment
        echo -n " [ "(basename $VIRTUAL_ENV)"]"
        set_color normal
    end

    # --- last exit code ---
    if test $code -ne 0
        set_color --bold $fish_color_status
        echo -n "  $code"
        set_color normal
    end

    # --- prompt sign on its own line ---
    echo ""
    set_color --bold $fish_color_normal
    echo -n "\$ "
    set_color normal
end
