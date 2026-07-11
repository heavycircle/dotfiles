function root --description 'cd to terminal workspace/session root, or print if piped'
    set -l target_path ""

    if set -q WEZTERM_PANE
        set -l workspace (wezterm cli list | awk -v id="$WEZTERM_PANE" '$3 == id {print $4}')
        set target_path (string replace -r '^~' $HOME $workspace)
    else if set -q TMUX
        set target_path (tmux display-message -p '#{session_path}')
    else
        echo "Error: Not inside a Wezterm workspace or Tmux session." >&2
        return 1
    end

    if not test -d "$target_path"
        echo "Error: Target path '$target_path' is not a valid directory." >&2
        return 1
    end

    if isatty stdout
        cd $target_path
    else
        echo $target_path
    end
end
