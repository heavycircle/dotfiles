function fman --description "Fuzzy-find and open a man page"
    man -k . 2>/dev/null \
        | fzf --tmux \
        --prompt "Man > " \
        --preview "MANPAGER=cat man {1} 2>/dev/null | head -80" \
        | awk '{print $1}' \
        | xargs -r man
end
