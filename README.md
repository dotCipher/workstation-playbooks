# OSX Dev Machine Ansible Playbook

> Inspired by [geerlingguy/mac-dev-playbook](https://github.com/geerlingguy/mac-dev-playbook) and [donnemartin/dev-setup](https://github.com/donnemartin/dev-setup).

### Usage (automatic)

Run the full osx provisioning script via the command:
```bash
bash <(curl -s https://git.io/vF3nW)
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

Or you can provision each playbook individually, see below.

### Playbooks
#### Dock
```bash
ansible-playbook -i ansible/inventory ansible/playbooks/dock.yml
```

#### Dotfiles
```bash
ansible-playbook -i ansible/inventory ansible/playbooks/dotfiles.yml
```

#### Homebrew
```bash
ansible-playbook -i ansible/inventory ansible/playbooks/homebrew.yml
```

#### Mac Apple Store
```bash
ansible-playbook -i ansible/inventory ansible/playbooks/mas.yml
```

#### OSX-Defaults
```bash
ansible-playbook -i ansible/inventory ansible/playbooks/osx-defaults.yml --ask-sudo-pass
```

#### pip
```bash
ansible-playbook -i ansible/inventory ansible/playbooks/pip.yml
```
