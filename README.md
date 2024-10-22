# Powerline_Installation

## Description
Installs powerline rpms, configures bash, vim, and screenrc

# Usage
## Shell script 
If you don't have ansible installed, you can use the powerline_install.sh shell script 
It is meant to be source and the functions run individually

```
source powerline_install.sh
powerline_prereq  #This needs to be run as root/sudo
powerline_bash
powerline_vim
powerline_screenrc
```

## Ansible Playbook
### The ansible playbook depends on the following role if this is a Rocky or RHEL distro
* geerlinguy.epel
* community.collections

Both of the above are installed by the powerline_install.yml

## The playbook requires sudo privileges to install rpms/repos; make sure the user running this is in the sudoers file

```
ansible-playbook powerline_install.yml --ask-become-pass
```

Then run the user_config.yml playbook as a normal user to configure
.bashrc, .vimrc, and .screenrc
```
ansible-playbook user_config.yml
```

## License

[MIT](https://choosealicense.com/licenses/mit/)
