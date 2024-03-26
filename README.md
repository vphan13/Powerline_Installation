# Powerline_Installation
Installs powerline rpms, configures bash, vim, and screenrc

# Usage
This shell script is meant to be source and the functions run individually

```
source powerline_install.sh
powerline_prereq
powerline_bash
powerline_vim
powerline_screenrc
```

# Ansible Playbook
## The ansible playbook depends on the following role
* geerlingguy.repo-epel

To use the ansible playbook powerline_install.yml:
On Fedora systems

```
ansible-playbook powerline_install.yml --skip-tags epel --ask-become-pass
```

For Red Hat/Rocky Linux

```
ansible-playbook powerline_install.yml --ask-become-pass
```
