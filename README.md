# Workstation Playbooks

Ansible playbooks to provision a macOS developer workstation from a clean install.
Dotfiles live in a [separate repo](https://github.com/dotCipher/dotfiles) and are
symlinked via the `geerlingguy.dotfiles` role.

## Quick Start

```bash
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install ansible
git clone git@github.com:dotCipher/workstation-playbooks.git
cd workstation-playbooks/osx-dev
ansible-galaxy install -r requirements.yml
ansible-playbook main.yml --ask-become-pass   # sign into the App Store first
```

> Run from inside `osx-dev/` so `ansible.cfg` and `inventory` are found.

## What It Does

| Step | Tag | Description |
|------|-----|-------------|
| 1 | `xcode` | Xcode CLI Tools |
| 2 | `homebrew` | 80 formulae, 47 casks, 6 taps |
| 3 | `dotfiles` | Clone & symlink [dotfiles](https://github.com/dotCipher/dotfiles) |
| 4 | `mas` | Mac App Store (Tailscale) |
| 5 | `dock` | Minimal dock (System Settings only, autohide) |
| 6 | `sudoers` | Passwordless sudo for admin group |
| 7 | `osx` | macOS defaults (dark mode, keyboard, Finder, screenshots, etc.) |
| 8 | `shell` | Fish default shell, Fisher plugins, SSH + 1Password agent |
| 9 | `node` | Node.js via NVM, global npm packages (pnpm, newman) |
| 10 | `rust` | Toolchain via rustup, cargo packages |
| 11 | `go` | Dev tools via `go install` (gopls, staticcheck, etc.) |
| 12 | `pipx` | Python CLI tools (vastai, wandb) |

Run a single step: `ansible-playbook main.yml --ask-become-pass --tags osx`

## Overriding Defaults

Create `osx-dev/config.yml` to override any variable in `default.config.yml`.
This file is gitignored.

## Layout

```
osx-dev/
  ansible.cfg          default.config.yml   inventory
  main.yml             requirements.yml
  tasks/
    go-tools.yml       node-setup.yml       osx-defaults.yml
    pipx-setup.yml     rust-setup.yml       shell-setup.yml
    sudoers.yml
  roles/               # installed via ansible-galaxy, gitignored
```
