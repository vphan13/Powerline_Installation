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
## The ansible playbook depends on the following role if this is a Rocky or RHEL distro
* geerlingguy.repo-epel 
## The following collection is required
* community.general

## The playbook requires sudo privileges to install rpms/repos; make sure the user running this is in the sudoers file

```
ansible-playbook powerline_install.yml --tags epel -K
```

Then run the playbook skipping the epel task

```
ansible-playbook powerline_install.yml --skip-tags epel
```
