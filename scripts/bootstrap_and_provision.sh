#!/usr/bin/env bash
# This script will clone this repo locally onto the system and run all provisioning scripts.

# Set defaults
ANSIBLE_VAULT_FILE="~/.ansible_vault_pass"
REPO_CLONE_LOCATION="~/.mac-dev-playbook"

# Load colors used
RESTORE=$(echo -en '\033[0m')
GREEN=$(echo -en '\033[00;32m')

# Clone repo locally
git clone git@github.com:dotCipher/mac-dev-playbook.git "${REPO_CLONE_LOCATION}"

# Assert clone was successful
if [ $? -ne 0 ]; then
    echo "Unable to clone repo successfully, exiting!"
    exit 1
fi

# Load all common functions / variables
source "${REPO_CLONE_LOCATION}/scripts/common/sudo.sh"
source "${REPO_CLONE_LOCATION}/scripts/common/brew.sh"
source "${REPO_CLONE_LOCATION}/scripts/common/ansible.sh"

# Run functions
ask_sudo
pre_install_brew
install_brew
install_ansible
install_ansible_roles "${REPO_CLONE_LOCATION}/ansible/role_requirements.yml"
init_ansible_vault_file "${ANSIBLE_VAULT_FILE}"

# Run ansible provision
ansible-playbook -i "${REPO_CLONE_LOCATION}/ansible/inventory" "${REPO_CLONE_LOCATION}/ansible/main.yml" \
    --ask-become-pass \
    --vault-password-file "${ANSIBLE_VAULT_FILE}"

# Print output for completion
echo -e "${GREEN}All done!${RESTORE}"
exit 0
