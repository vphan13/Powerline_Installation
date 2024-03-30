#!/bin/bash

powerline_prereq () {
source /etc/os-release
OS_VERS="${ID}"
echo "distro is $OS_VERS"
if [ -f /usr/bin/powerline ] && [ -f /usr/share/fonts/truetype/PowerlineSymbols.otf ] && [ -f /usr/bin/git ] && [ -f /usr/bin/pip3 ]; then
        echo "All Powerline prerequisites are installed";
else
        echo "Installing Powerline prerequisites..."
        source /etc/os-release
        OS_VERS="${ID}"
        VERSION="$REDHAT_SUPPORT_PRODUCT_VERSION"
        case $OS_VERS in
                Fedora)
                  sudo dnf install -y \
                  python3-pip \
                  git \
                  powerline \
                  powerline-fonts
                  ;;
                rhel)
                  echo "distro is $OS_VERS"
                  sudo dnf config-manager --set-enabled crb
                  sudo dnf install -y \
			  https://dl.fedoraproject.org/pub/epel/epel-release-latest-$(echo ${VERSION} | awk -F '.' {'print $1'}).noarch.rpm \
                          https://dl.fedoraproject.org/pub/epel/epel-next-release-latest-$(echo ${VERSION}| awk -F '.' {'print $1'}).noarch.rpm
                  sudo dnf install -y \
                    python3-pip \
                    git \
                    powerline \
                    powerline-fonts
		    ansible-vim
                  ;;
                rocky)
                  echo "distro is $OS_VERS"
                  #sudo dnf config-manager --set-enabled crb
                  sudo dnf install -y \
                    https://dl.fedoraproject.org/pub/epel/epel-release-latest-${VERSION}.noarch.rpm \
                    https://dl.fedoraproject.org/pub/epel/epel-next-release-latest-${VERSION}.noarch.rpm
                  sudo dnf install -y \
                    python3-pip \
                    git \
                    powerline \
                    powerline-fonts
		    ansible-vim
                  ;;
                *)
                  echo "This script only works for rhel/fedora/rocky distros"
                  ;;
        esac
fi
}

powerline_bash () {
echo "Modifying $HOME/.bashrc..."
cat <<'EOF' >> $HOME/.bashrc

TERM=xterm-256color
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
source /usr/share/powerline/bash/powerline.sh

EOF
}

powerline_vim () {
echo "Modifying $HOME/.vimrc"
cat << 'EOF' >> $HOME/.vimrc

python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup

set paste
set nrformats+=alpha
set laststatus=2

EOF
}

powerline_screenrc () {
echo "Modifying $HOME/.screenrc"
cat << 'EOF' >> $HOME/.screenrc

# GNU Screen - main configuration file 
# All other .screenrc files will source this file to inherit settings.

# Allow bold colors - necessary for some reason
attrcolor b ".I"

# Tell screen how to set colors. AB = background, AF=foreground
termcapinfo xterm 'Co#256:AB=\E[48;5;%dm:AF=\E[38;5;%dm'

# Enables use of shift-PgUp and shift-PgDn
termcapinfo xterm|xterms|xs|rxvt ti@:te@

# Erase background with current bg color
defbce "on"

# Enable 256 color term
term xterm-256color

# Cache 30000 lines for scroll back
scrollback 100000
defscrollback 100000

hardstatus alwayslastline
# Very nice tabbed colored hardstatus line
hardstatus string '%{= Kd} %{= Kd}%-w%{= Kr}[%{= KW}%n %t%{= Kr}]%{= Kd}%+w %-= %{KG} %H%{KW}|%{KY}%101`%{KW}|%D %M %d %Y%{= Kc} %C%A%{-}'

# change command character from ctrl-a to ctrl-b (emacs users may want this)
#escape ^Bb

# Hide hardstatus: ctrl-a f 
bind f eval "hardstatus ignore"
# Show hardstatus: ctrl-a F
bind F eval "hardstatus alwayslastline"
bind j focus down
bind k focus up


screen -t bash0
screen -t bash1
screen -t bash2
screen -t bash3
select 0

EOF
}


