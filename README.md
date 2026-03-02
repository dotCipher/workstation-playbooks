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
cd workstation-playbooks/osx-dev

# 5. Sign into the Mac App Store (required for mas automation)

# 6. Install Ansible dependencies
ansible-galaxy install -r requirements.yml

# 7. Run the playbook
ansible-playbook main.yml --ask-become-pass
```

> **Note:** Run from within the `osx-dev/` directory so `ansible.cfg` and
> `inventory` are picked up automatically.

## What It Configures

The `osx-dev` playbook runs these steps in order:

1. **Xcode CLI Tools** - Ensures they're installed
2. **Homebrew** - Installs ~80 formulae, ~45 casks, and 6 taps
3. **Dotfiles** - Clones and symlinks from [dotCipher/dotfiles](https://github.com/dotCipher/dotfiles)
4. **Mac App Store** - Installs apps via `mas` (Tailscale)
5. **Dock** - Removes default apps, sets minimal layout (System Settings only)
6. **Sudoers** - Passwordless sudo for admin group
7. **macOS Defaults** - Dark mode, keyboard, Finder, Dock, screenshots, etc.
8. **Shell Setup** - Fish as default shell, Fisher plugins, base SSH config
9. **Node.js** - Installs Node via NVM, plus global npm packages (pnpm, newman)
10. **Rust** - Installs toolchain via rustup, plus cargo packages
11. **Go Tools** - Installs dev tools via `go install` (gopls, staticcheck, etc.)
12. **pipx** - Installs Python CLI tools (vastai, wandb)

## Running Individual Tags

```bash
ansible-playbook main.yml --ask-become-pass --tags homebrew
ansible-playbook main.yml --ask-become-pass --tags dotfiles
ansible-playbook main.yml --ask-become-pass --tags osx
ansible-playbook main.yml --ask-become-pass --tags dock
ansible-playbook main.yml --ask-become-pass --tags mas
ansible-playbook main.yml --ask-become-pass --tags shell
ansible-playbook main.yml --ask-become-pass --tags node
ansible-playbook main.yml --ask-become-pass --tags rust
ansible-playbook main.yml --ask-become-pass --tags go
ansible-playbook main.yml --ask-become-pass --tags pipx
ansible-playbook main.yml --ask-become-pass --tags sudoers
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
  requirements.yml        # Galaxy roles and collections (pinned versions)
  tasks/
    go-tools.yml          # Go dev tools via go install
    node-setup.yml        # NVM + Node.js + global npm packages
    osx-defaults.yml      # macOS system preferences via osx_defaults
    pipx-setup.yml        # Python CLI tools via pipx
    rust-setup.yml        # Rust toolchain + cargo packages
    shell-setup.yml       # Fish shell + Fisher + SSH config
    sudoers.yml           # Passwordless sudo config
  roles/                  # Galaxy-installed roles (gitignored, install via requirements.yml)
```
