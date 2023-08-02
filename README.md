# Dev Workstation Playbooks

> Inspired by [geerlingguy/mac-dev-playbook](https://github.com/geerlingguy/mac-dev-playbook) and [donnemartin/dev-setup](https://github.com/donnemartin/dev-setup).

This repo contains platform-agnostic Ansible playbooks to provision all 
aspects of my developer setup in a modular fashion. 


## Workstations

All individual workstation types are isolated in their own nested folders under this
project root.

The following workstations are supported:
- `osx-dev` 



### OSX Developer Workstation (`osx-dev`)

This playbook is designed to be ran on a fresh OSX install and will install all
the necessary tools and packages to get a developer workstation up and running.


#### Pre-requisites (manual)

1. Install Apple's command line tools (`xcode-select --install` to launch the installer).
2. [Install Homebrew](https://brew.sh/) (automated in the task, but should be done manually for the ansible install)

    1. `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

3. [Install Ansible](https://docs.ansible.com/ansible/latest/installation_guide/index.html):

    1. `brew install ansible` (https://formulae.brew.sh/formula/ansible)

3. Clone this repo: `git clone git@github.com:dotCipher/workstation-playbooks.git`
4. **Sign into App Store** (since the `mas` automation playbook can't sign in automatically)
5. Run `ansible-galaxy install -r requirements.yml` inside this directory to install required Ansible roles.
6. Run `ansible-playbook main.yml --ask-become-pass` inside this directory. Enter your macOS account password when prompted for the 'BECOME' password.

### Usage (automatic)

Bootstrap and provision via the command:
```bash
bash <(curl -s -L https://git.io/vF3nW)
```

### Usage (manual)

Clone this repo into whatever directory you want on your machine then setup your environment:
```bash
./scripts/bootstrap.sh
```

Then provision everything with:
```bash
ansible-playbook -i ansible/inventory ansible/main.yml --ask-become-pass
```

Or you can provision each playbook individually, see **Playbooks** below.

### Directory Structure

```
ansible/        # Contains all the ansible code
  configs/      # Configuration variables for all ansible playbooks
  playbooks/    # Playbook bindings between configs/ tasks/ and handlers/
  tasks/        # Sets of tasks groups by intended output
  handlers/     # All ansible handlers for the associated playbooks/
gradle/         # Gradle specific project generation & dev
scripts/        # Convenience scripts for local ansible calls
```

### Playbooks
Playbooks are broken up to be ran independently of each other.
If you want to just provision a specific aspect of your machine, 
to run any individual playbook use the combined command:
```bash
ansible-playbook -i ansible/inventory <PLAYBOOK>
```

Currently the following playbooks can be used:

##### OSX
 - `ansible-playbook -i ansible/inventory ansible/playbooks/osx/dock.yml`
 - `ansible-playbook -i ansible/inventory ansible/playbooks/osx/homebrew.yml`
 - `ansible-playbook -i ansible/inventory ansible/playbooks/osx/defaults.yml`
 - `ansible-playbook -i ansible/inventory ansible/playbooks/osx/mas.yml --vault-password-file ~/.ansible_vault_pass`

##### WSL / Unix / Linux
 - `ansible-playbook -i ansible/inventory ansible/playbooks/packages.yml --ask-become-pass`
 - `ansible-playbook -i ansible/inventory ansible/playbooks/dotfiles.yml`
 - `ansible-playbook -i ansible/inventory ansible/playbooks/packages.yml`
 - `ansible-playbook -i ansible/inventory ansible/playbooks/fish-shell.yml --ask-become-pass`
 - `ansible-playbook -i ansible/inventory ansible/playbooks/python.yml`
