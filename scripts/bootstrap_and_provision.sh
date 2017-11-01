#!/usr/bin/env bash

pushd .

## Clone repo locally
git clone ~/.mac-dev-playbook
cd ~/.mac-dev-playbook

## Run bootstrap script from local clone
./scripts/bootstrap.sh

## Run ansible provision
ansible-playbook -i ansible/inventory ansible/playbooks/main.yml --ask-sudo-pass

popd
