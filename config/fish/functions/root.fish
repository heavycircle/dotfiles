function root --description 'cd to tmux session root, or print if piped'
    set -l path (tmux display-message -p '#{session_path}')
    or return

    if isatty stdout
        cd $path
    else
        echo $path
    end
end
