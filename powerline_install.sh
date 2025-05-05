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
                    fzf \
                    git \
                    powerline \
                    powerline-fonts \
                    python3-pip \
 		    vim \
                    vim-ansible \
                    vim-enhanced \
                    wget
                  ;;
                rhel)
                  echo "distro is $OS_VERS"
                  sudo dnf config-manager --set-enabled crb
                  sudo dnf install -y \
			  https://dl.fedoraproject.org/pub/epel/epel-release-latest-$(echo ${VERSION} | awk -F '.' {'print $1'}).noarch.rpm \
                          https://dl.fedoraproject.org/pub/epel/epel-next-release-latest-$(echo ${VERSION}| awk -F '.' {'print $1'}).noarch.rpm
                  sudo dnf install -y \
                    fzf \
                    git \
                    powerline \
                    powerline-fonts \
                    python3-pip \
 		    vim \
                    vim-ansible \
                    vim-enhanced \
		    wget
                  ;;
                rocky)
                  echo "distro is $OS_VERS"
                  #sudo dnf config-manager --set-enabled crb
                  sudo dnf install -y \
                    https://dl.fedoraproject.org/pub/epel/epel-release-latest-${VERSION}.noarch.rpm \
                    https://dl.fedoraproject.org/pub/epel/epel-next-release-latest-${VERSION}.noarch.rpm
                  sudo dnf install -y \
                    fzf \
                    git \
                    powerline \
                    powerline-fonts \
                    python3-pip \
 		    vim \
                    vim-ansible \
                    vim-enhanced \
                    wget
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

deploy_plugins () {
mkdir -p $HOME/.vim/autoload
chmod 750 $HOME/.vim/autoload
mkdir -p $HOME/.vim/bundle
chmod 750 $HOME/.vim/bundle
cd $HOME/.vim/autoload/ && \
wget https://tpo.pe/pathogen.vim 
git clone https://github.com/vim-airline/vim-airline $HOME/.vim/bundle/vim-airline
git clone https://github.com/preservim/nerdtree $HOME/.vim/bundle/nerdtree
git clone https://github.com/junegunn/fzf.vim $HOME/.vim/bundle/fzf-vim
git clone https://github.com/airblade/vim-gitgutter $HOME/.vim/bundle/vim-gitgutter
git clone https://github.com/tpope/vim-fugitive $HOME/.vim/bundle/vim-fugitive
git clone https://github.com/voldikss/vim-floaterm $HOME/.vim/bundle/vim-floaterm

}

powerline_vim () {
echo "Modifying $HOME/.vimrc"
cat << 'EOF' >> $HOME/.vimrc

execute pathogen#infect()
syntax on
filetype plugin indent on

colo darkblue

" Configuration vim Airline
set laststatus=2

let g:airline#extensions#tabline#enabled=1
let g:airline_powerline_fonts=1

" Configuration NERDTree
map <F5> :NERDTreeToggle<CR>

" Configuration floaterm
let g:floaterm_keymap_toggle = '<F12>'
let g:floaterm_width = 0.9
let g:floaterm_height = 0.9

" Configuration Vim.FZF
let g:fzf_preview_window = 'right:50%'
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6  }  }

set paste
set nrformats+=alpha
set laststatus=2

EOF
}

powerline_screenrc () {
echo "Modifying $HOME/.screenrc"
cat << 'EOF' >> $HOME/.screenrc

# GNU Screen - main configuration file 
# Bll other .screenrc files will source this file to inherit settings.

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


# powerline_prereq
# powerline_bash
# deploy_plugins
# powerline_vim
# powerline_screenrc
