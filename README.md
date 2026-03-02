# Dev Workstation Playbooks

> Inspired by [geerlingguy/mac-dev-playbook](https://github.com/geerlingguy/mac-dev-playbook).

Ansible playbooks to provision developer workstations from a clean OS install.
Dotfiles are managed in a [separate repo](https://github.com/dotCipher/dotfiles)
and deployed via the `geerlingguy.dotfiles` role.

## Workstations

| Playbook | Status | Description |
|----------|--------|-------------|
| `osx-dev` | Active | macOS developer workstation |

## Quick Start (macOS)

On a fresh macOS install:

```bash
# 1. Install Xcode Command Line Tools
xcode-select --install

# 2. Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 3. Install Ansible
brew install ansible

# 4. Clone this repo
git clone git@github.com:dotCipher/workstation-playbooks.git
cd workstation-playbooks

# 5. Sign into the Mac App Store (required for mas automation)

# 6. Install Ansible dependencies
ansible-galaxy install -r osx-dev/requirements.yml

# 7. Run the playbook
ansible-playbook osx-dev/main.yml --ask-become-pass
```

## What It Configures

The `osx-dev` playbook runs these steps in order:

1. **Xcode CLI Tools** - Ensures they're installed
2. **Homebrew** - Installs ~75 formulae, 28 casks, and 5 taps
3. **Dotfiles** - Clones and symlinks from [dotCipher/dotfiles](https://github.com/dotCipher/dotfiles)
4. **Mac App Store** - Installs apps via `mas` (Tailscale)
5. **Dock** - Removes default apps, sets minimal layout
6. **Sudoers** - Passwordless sudo for admin group
7. **macOS Defaults** - Dark mode, keyboard, Finder, Dock, screenshots, etc.
8. **Shell Setup** - Fish as default shell, Fisher plugins, base SSH config
9. **Node.js** - Installs default Node version via NVM

## Running Individual Tags

```bash
# Only run specific sections
ansible-playbook osx-dev/main.yml --ask-become-pass --tags homebrew
ansible-playbook osx-dev/main.yml --ask-become-pass --tags dotfiles
ansible-playbook osx-dev/main.yml --ask-become-pass --tags osx
ansible-playbook osx-dev/main.yml --ask-become-pass --tags dock
ansible-playbook osx-dev/main.yml --ask-become-pass --tags mas
ansible-playbook osx-dev/main.yml --ask-become-pass --tags shell
ansible-playbook osx-dev/main.yml --ask-become-pass --tags node
```

## Overriding Defaults

Create `osx-dev/config.yml` (gitignored) to override any variable in
`osx-dev/default.config.yml` without modifying the defaults file.

## Directory Structure

```
osx-dev/
  ansible.cfg             # Ansible config
  default.config.yml      # Default variables (packages, casks, settings)
  inventory               # Localhost inventory
  main.yml                # Main playbook
  requirements.yml        # Galaxy roles and collections
  tasks/
    osx-defaults.yml      # macOS system preferences via osx_defaults
    node-setup.yml        # NVM + Node.js setup
    shell-setup.yml       # Fish shell + Fisher + SSH config
    sudoers.yml           # Passwordless sudo config
  roles/                  # Galaxy-installed roles (not committed)
```
