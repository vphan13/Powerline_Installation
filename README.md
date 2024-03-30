# Powerline_Installation
Installs powerline rpms, configures bash, vim, and screenrc

# Usage
## Shell script 
The powerline_install.sh shell script is meant to be source and the functions run individually

```
source powerline_install.sh
powerline_prereq  #This needs to be run as root/sudo
powerline_bash
powerline_vim
powerline_screenrc
```

# Ansible Playbook
## The ansible playbook depends on the following role
* geerlingguy.repo-epel

To use the ansible playbook powerline_install.yml:
Install the required role first

```
ansible-playbook role_install.yml
```

Then install powerline and all prerequisites
You will need the sudo password to use this playbook

```
ansible-playbook powerline_install.yml -K
```
