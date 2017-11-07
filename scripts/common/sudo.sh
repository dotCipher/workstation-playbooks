#!/usr/bin/env bash

# Load colors used
CYAN=$(echo -en '\033[00;36m')
RESTORE=$(echo -en '\033[0m')

ask_sudo() {
    # Ask for sudo password upfront if needed
    if ! sudo -n true 2>/dev/null; then
        echo -en "Enter Sudo "
        sudo -v
        # Keep-alive: update existing sudo time stamp if set, otherwise do nothing.
        while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
    fi
}
