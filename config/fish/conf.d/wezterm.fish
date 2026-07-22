# Only emit the sequence if we are actually running inside Wezterm
function wezterm_osc7 --on-event fish_prompt
    # fish_prompt event handlers fire before fish_prompt itself, so running
    # printf here clobbers $status before the real fish_prompt can read it.
    set -l last_status $status
    if set -q WEZTERM_PANE
        printf "\e]7;file://%s%s\a" $hostname (string escape --style=url $PWD)
    end
    return $last_status
end
