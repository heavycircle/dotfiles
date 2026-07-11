# Only emit the sequence if we are actually running inside Wezterm
function wezterm_osc7 --on-event fish_prompt
    if set -q WEZTERM_PANE
        printf "\e]7;file://%s%s\a" $hostname (string escape --style=url $PWD)
    end
end
