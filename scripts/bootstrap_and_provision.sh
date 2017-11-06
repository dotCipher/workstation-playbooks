#!/usr/bin/env bash

pushd .

## Clone repo locally
git clone git@github.com:dotCipher/mac-dev-playbook.git ~/.mac-dev-playbook
cd ~/.mac-dev-playbook

## Run bootstrap script from local clone
./scripts/bootstrap.sh

## Run ansible provision
ansible-playbook -i ansible/inventory ansible/main.yml --ask-become-pass

popd
