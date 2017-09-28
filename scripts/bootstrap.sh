#!/usr/bin/env bash

## Colors, because it looks pretty
RESTORE=$(echo -en '\033[0m')
RED=$(echo -en '\033[00;31m')
#GREEN=$(echo -en '\033[00;32m')
#YELLOW=$(echo -en '\033[00;33m')
#BLUE=$(echo -en '\033[00;34m')
#MAGENTA=$(echo -en '\033[00;35m')
#PURPLE=$(echo -en '\033[00;35m')
CYAN=$(echo -en '\033[00;36m')
#LIGHTGRAY=$(echo -en '\033[00;37m')
#LRED=$(echo -en '\033[01;31m')
#LGREEN=$(echo -en '\033[01;32m')
#LYELLOW=$(echo -en '\033[01;33m')
#LBLUE=$(echo -en '\033[01;34m')
#LMAGENTA=$(echo -en '\033[01;35m')
#LPURPLE=$(echo -en '\033[01;35m')
#LCYAN=$(echo -en '\033[01;36m')
#WHITE=$(echo -en '\033[01;37m')

# Ask for sudo password upfront if needed
if ! sudo -n true 2>/dev/null; then
    echo -en "Enter Sudo "
    sudo -v
    # Keep-alive: update existing sudo time stamp if set, otherwise do nothing.
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
fi

### Correct directory permissions
echo "${CYAN}Correcting brew directory permissions...${RESTORE}"
sudo chown -R $(whoami) /usr/local/bin
sudo chown -R $(whoami) /usr/local/share

### Install or Update Homebrew
which -s brew
if [[ $? != 0 ]] ; then
    echo "${CYAN}Installing Homebrew...${RESTORE}"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo "${CYAN}Updating Homebrew...${RESTORE}"
    brew update
fi

## Install Ansible if needed
which -s ansible-playbook
if [[ $? != 0 ]] ; then
    echo "${CYAN}Installing Ansible...${RESTORE}"
    brew install ansible
fi

## Install Ansible dependencies
echo "${CYAN}Installing Ansible requirements for mac-dev-playbook...${RESTORE}"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REQUIREMENTS_FILE=$(readlink -f "${DIR}/../requirements.yml")
if [ ! -f "${REQUIREMENTS_FILE}" ]; then
    echo "${RED}Unable to find requirements file: ${REQUIREMENTS_FILE}${RESTORE}"
else
    ansible-galaxy install -r "${REQUIREMENTS_FILE}"
fi
