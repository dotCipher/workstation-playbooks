#!/usr/bin/env bash

# Load colors used
CYAN=$(echo -en '\033[00;36m')
RESTORE=$(echo -en '\033[0m')

pre_install_brew() {
    # Correct directory permissions
    DIRECTORIES_TO_CHOWN=("/usr/local/bin" "/usr/local/share")
    for directory in "${DIRECTORIES_TO_CHOWN[@]}"; do
        if [ -f "${directory}" ]; then
            sudo chown -R $(whoami) "${directory}"
            echo "${CYAN}Corrected directory permissions of: ${directory} ${RESTORE}"
        fi
    done
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
