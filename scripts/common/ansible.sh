#!/usr/bin/env bash

# Load colors used
CYAN=$(echo -en '\033[00;36m')
RESTORE=$(echo -en '\033[0m')

# Assumes brew is already installed
install_ansible() {
    ## Install Ansible if needed
    which -s ansible-playbook
    if [[ $? != 0 ]] ; then
        echo "${CYAN}Installing Ansible...${RESTORE}"
        brew install ansible
    fi
}

# $1 = roles requires file location
install_ansible_roles() {
    ## Install Ansible dependencies
    echo "${CYAN}Installing Ansible role requirements...${RESTORE}"
    if [ ! -f "$1" ]; then
        echo "${RED}Unable to find requirements file: $1${RESTORE}"
    else
        ansible-galaxy install -r "$1"
    fi
}

# $1 = ansible vault file location (ie. $HOME/.ansible_vault_pass)
init_ansible_vault_file() {
    read -s -p "Type ansible vault password and press [ENTER]: " ansible_vault_password
    echo ""
    if [ -f "$1" ]; then
        echo "${ansible_vault_password}" > "$1"
    else
        rm -f "$1"
        echo "${ansible_vault_password}" > "$1"
    fi
}
