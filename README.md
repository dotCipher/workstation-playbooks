# OSX Dev Machine Ansible Playbook

> Inspired by [geerlingguy/mac-dev-playbook](https://github.com/geerlingguy/mac-dev-playbook) and [donnemartin/dev-setup](https://github.com/donnemartin/dev-setup).

### Usage

1.  Clone this repo into whatever directory you want on your machine.

2.  Setup your environment:
```bash
./scripts/bootstrap.sh
```

3.  Run the playbook:
```bash
ansible-playbook -i ansible/inventory ansible/playbooks/main.yml -K
```

