#!/usr/bin/env bash

# Load colors used
CYAN=$(echo -en '\033[00;36m')
RESTORE=$(echo -en '\033[0m')

pre_install_brew() {
    # Correct directory permissions
    echo "${CYAN}Correcting brew directory permissions...${RESTORE}"
    sudo chown -R $(whoami) /usr/local/bin
    sudo chown -R $(whoami) /usr/local/share
}

install_brew() {
    # Install or Update homebrew
    which -s brew
    if [[ $? != 0 ]] ; then
        echo "${CYAN}Installing homebrew...${RESTORE}"
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    else
        echo "${CYAN}Updating homebrew...${RESTORE}"
        brew update
    fi
}
