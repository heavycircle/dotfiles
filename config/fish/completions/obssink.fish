# Completions for ~/scripts/obssink

function __obssink_tokens
    commandline -opc
end

function __obssink_at --argument-names n
    test (count (__obssink_tokens)) -eq $n
end

function __obssink_pos2_is --argument-names val
    set -l t (__obssink_tokens)
    test (count $t) -ge 2; and test "$t[2]" = $val
end

function __obssink_toplevel
    __obssink_at 1
end

function __obssink_app_pos2
    __obssink_at 2; and __obssink_pos2_is app
end

function __obssink_app_wants_program
    set -l t (__obssink_tokens)
    __obssink_at 3; and __obssink_pos2_is app; and contains -- $t[3] add del
end

function __obssink_bare_wants_program
    set -l t (__obssink_tokens)
    __obssink_at 2; and contains -- $t[2] add del
end

function __obssink_mic_pos2
    __obssink_at 2; and __obssink_pos2_is mic
end

function __obssink_mic_wants_source
    set -l t (__obssink_tokens)
    __obssink_at 3; and __obssink_pos2_is mic; and test "$t[3]" = add
end

# top level
complete -c obssink -f -n __obssink_toplevel -a app -d "which app's audio goes into OBS"
complete -c obssink -f -n __obssink_toplevel -a mic -d "whether your mic goes into OBS"
complete -c obssink -f -n __obssink_toplevel -a list -d "alias: app list"
complete -c obssink -f -n __obssink_toplevel -a show -d "alias: app show"
complete -c obssink -f -n __obssink_toplevel -a add -d "alias: app add"
complete -c obssink -f -n __obssink_toplevel -a del -d "alias: app del"
complete -c obssink -f -n __obssink_toplevel -a help -d "show usage"

# app subcommand
complete -c obssink -f -n __obssink_app_pos2 -a list -d "every active stream and its sink"
complete -c obssink -f -n __obssink_app_pos2 -a show -d "streams currently routed into OBS"
complete -c obssink -f -n __obssink_app_pos2 -a add -d "route a program's audio into OBS"
complete -c obssink -f -n __obssink_app_pos2 -a del -d "route a program's audio back out"
complete -c obssink -f -n __obssink_app_wants_program -a "(obssink _complete-apps)"
# bare add/del can mean either half, so offer app streams, mic sources, and
# the literal "mic" keyword that always means the mic regardless of device
complete -c obssink -f -n __obssink_bare_wants_program -a "(obssink _complete-apps-and-mics)"
complete -c obssink -f -n __obssink_bare_wants_program -a mic -d "the mic, whichever device it is"

# mic subcommand
complete -c obssink -f -n __obssink_mic_pos2 -a list -d "input devices available (* = default)"
complete -c obssink -f -n __obssink_mic_pos2 -a add -d "loopback a mic into OBS"
complete -c obssink -f -n __obssink_mic_pos2 -a del -d "disconnect the mic from OBS"
complete -c obssink -f -n __obssink_mic_pos2 -a mute -d "silence the OBS copy only"
complete -c obssink -f -n __obssink_mic_pos2 -a unmute -d "undo mic mute"
complete -c obssink -f -n __obssink_mic_pos2 -a show -d "is the mic routed in, and muted?"
complete -c obssink -f -n __obssink_mic_wants_source -a "(obssink _complete-mics)"
