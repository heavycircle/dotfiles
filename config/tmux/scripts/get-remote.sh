#!/usr/bin/env bash

# Open the remote git repo for this project.
# This script accepts SSH or HTTPS URLs for any domain.
#
# If you're on MacOS, you might need to change this script to use
# open instead of xdg-open.
#
# This script's forks include git and xdg-open.
#
# Author: heavycircle
# Date: August 2025
# License: MIT

strip-url() {
    local url="$1"
    url=${url%.git}

    # Check for HTTPS URLs
    if [[ $url =~ ^https?://([^/]+)/(.+)/(.+)$ ]]; then
        # HTTPS URL
        echo "${BASH_REMATCH[1]}/${BASH_REMATCH[2]}/${BASH_REMATCH[3]}"
    elif [[ $url =~ ^[^@]+@([^:]+):(.+)/(.+)$ ]]; then
        # SSH URL
        echo "${BASH_REMATCH[1]}/${BASH_REMATCH[2]}/${BASH_REMATCH[3]}"
    else
        # Should never get here
        exit 1
    fi
}

main() {
    local url min

    # Ensure we're in a git repo
    url=$(git remote get-url origin 2>/dev/null)
    [[ -n "$url" ]] || exit 0

    # Parse the URL and open it
    min="$(strip-url "$url")"
    xdg-open "https://$min" >/dev/null # Ignore "opening in existing session"
}

main "$@"
