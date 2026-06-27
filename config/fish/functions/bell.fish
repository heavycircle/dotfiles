function bell --description 'Run the terminal bell, optionally around a command'
    if test (count $argv) -eq 0
        printf '\a'
        return 0
    end

    # Run the subcommand, then ring
    $argv
    set -l exit_code $status
    printf '\a'
    return $exit_code
end
