#!/usr/bin/env bash

# Get directory of this script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Load colors used
RESTORE=$(echo -en '\033[0m')
GREEN=$(echo -en '\033[00;32m')

# Load all common functions / variables
source "${DIR}/common/sudo.sh"
source "${DIR}/common/brew.sh"
source "${DIR}/common/ansible.sh"

# Run functions
ask_sudo
pre_install_brew
install_brew
install_ansible
install_ansible_roles "${DIR}/../ansible/role_requirements.yml"

# Print output for completion
echo -e "${GREEN}All done!${RESTORE}"
exit 0
