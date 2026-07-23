# Emit OSC 7 so wezterm can track the cwd. Deliberately does NOT gate on
# $WEZTERM_PANE: that var is local-only and most sshd configs strip it via
# AcceptEnv, so it's never set on the remote end of a `wezterm ssh` session
# -- which is exactly where cwd tracking is needed most. Terminals that
# don't understand OSC 7 just ignore it, so the only real guard needed is
# skipping terminals known to choke on OSC sequences.
function wezterm_osc7 --on-event fish_prompt
    # fish_prompt event handlers fire before fish_prompt itself, so running
    # printf here clobbers $status before the real fish_prompt can read it.
    set -l last_status $status
    switch "$TERM"
        case linux dumb
            # unsupported
        case '*'
            printf "\e]7;file://%s%s\a" $hostname (string escape --style=url $PWD)
    end
    return $last_status
end
