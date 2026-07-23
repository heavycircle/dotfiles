function wezterm_osc7 --on-event fish_prompt
    # Don't clobber the status.
    set -l last_status $status

    switch "$TERM"
        case linux dumb
            # unsupported
        case '*'
            printf "\e]7;file://%s%s\a" $hostname (string escape --style=url $PWD)
    end

    return $last_status
end
