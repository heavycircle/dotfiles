# pf <remote> <port>: complete ssh hosts for the first argument, nothing for the port
complete -c pf -f
complete -c pf -n 'test (count (commandline -opc)) -eq 1' -d Remote -a '(__fish_complete_user_at_hosts)'
